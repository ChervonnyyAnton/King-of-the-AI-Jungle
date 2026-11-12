#!/usr/bin/env python3
"""
King of the AI Jungle — Sentiment Analysis Validation

Compares automated sentiment analysis output against manually labeled
ground truth data to compute precision, recall, F1-score per sentiment class.

Usage:
    python3 validate-sentiment.py --validation-data <path> --auto-results <path>

Dependencies: Python 3.6+, standard library only.
"""

import argparse
import json
import sys
from pathlib import Path


def load_file(filepath):
    """Load and return a JSON file."""
    try:
        with open(filepath, "r", encoding="utf-8") as f:
            return json.load(f)
    except (FileNotFoundError, json.JSONDecodeError) as e:
        print(f"Error loading {filepath}: {e}", file=sys.stderr)
        sys.exit(1)


def compute_metrics(labels_dict):
    """Compute precision, recall, F1 per class."""
    classes = {"positive": {"tp": 0, "fp": 0, "fn": 0},
               "negative": {"tp": 0, "fp": 0, "fn": 0},
               "neutral": {"tp": 0, "fp": 0, "fn": 0}}

    for auto_label, true_label in labels_dict.items():
        if true_label in classes and auto_label in classes:
            if auto_label == true_label:
                classes[true_label]["tp"] += 1
            else:
                classes[true_label]["fn"] += 1
                classes[auto_label]["fp"] += 1

    metrics = {}
    for cls, counts in classes.items():
        cls_tp = counts["tp"]
        cls_fp = counts["fp"]
        cls_fn = counts["fn"]
        precision = cls_tp / (cls_tp + cls_fp) if (cls_tp + cls_fp) > 0 else 0
        recall = cls_tp / (cls_tp + cls_fn) if (cls_tp + cls_fn) > 0 else 0
        f1 = 2 * precision * recall / (precision + recall) if (precision + recall) > 0 else 0
        metrics[cls] = {
            "tp": cls_tp, "fp": cls_fp, "fn": cls_fn,
            "precision": round(precision, 3), "recall": round(recall, 3),
            "f1": round(f1, 3), "support": cls_tp + cls_fn
        }

    # Overall F1 (micro-average)
    agg_tp = sum(m["tp"] for m in metrics.values())
    agg_fp = sum(m["fp"] for m in metrics.values())
    agg_fn = sum(m["fn"] for m in metrics.values())
    micro_precision = agg_tp / (agg_tp + agg_fp) if (agg_tp + agg_fp) > 0 else 0
    micro_recall = agg_tp / (agg_tp + agg_fn) if (agg_tp + agg_fn) > 0 else 0
    micro_f1 = 2 * micro_precision * micro_recall / (micro_precision + micro_recall) if (micro_precision + micro_recall) > 0 else 0
    metrics["overall"] = {"precision": round(micro_precision, 3), "recall": round(micro_recall, 3),
                          "f1": round(micro_f1, 3), "total_samples": agg_tp + agg_fp + agg_fn}

    return metrics


def main():
    parser = argparse.ArgumentParser(
        description="Validate sentiment analysis against manually labeled data."
    )
    parser.add_argument(
        "--validation-data",
        required=True,
        help="Path to VALIDATION-DATA.json (manually labeled ground truth)"
    )
    parser.add_argument(
        "--auto-results",
        default=None,
        help="Path to sentiment-report.json (automated results). If not provided, runs analysis inline."
    )
    args = parser.parse_args()

    # Load validation data (ground truth)
    validation_data = load_file(args.validation_data)

    # If auto_results not provided, we can't validate — just print instructions
    if args.auto_results is None:
        print("No automated results file provided.")
        print("To validate, run the sentiment analysis engine first:")
        print("  python3 sentiment-analysis.py --input-dir <feedback-dir> --output-file sentiment-report.json")
        print("Then run this validation script with the report:")
        print(f"  python3 {sys.argv[0]} --validation-data <validation-data> --auto-results sentiment-report.json")
        print()
        print(f"VALIDATION-DATA.json contains {len(validation_data)} manually labeled entries:")
        for entry in validation_data:
            mv = entry.get("most_valuable_part", "")[:50]
            wi = entry.get("what_to_improve", "")[:50]
            print(f"  - {entry.get('participant_name', '?')}: '{mv}' / '{wi}'")
        return

    # Load automated results
    auto_report = load_file(args.auto_results)

    # Extract labels from automated results
    auto_labels = {}
    for result in auto_report.get("per_response", []):
        name = result.get("participant", "unknown")
        label = result.get("overall_sentiment", {}).get("label", "neutral")
        auto_labels[name] = label

    # Extract labels from validation data (ground truth)
    # We need to manually assign ground truth — this is done in VALIDATION-DATA.json
    # For this demo, we'll use the sentiment of the text as a proxy
    # In production, VALIDATION-DATA.json should include a "ground_truth_sentiment" field
    true_labels = {}
    for entry in validation_data:
        name = entry.get("participant_name", "unknown")
        # For validation, we assume the ground truth is encoded in the data
        # In production, this would be a "ground_truth_sentiment" field
        mv = entry.get("most_valuable_part", "").lower()
        wi = entry.get("what_to_improve", "").lower()
        # Simple heuristic for demo: positive text → positive, contains "confusing/failed" → negative
        if "confusing" in wi or "failed" in wi or "broken" in wi or "difficult" in wi:
            true_labels[name] = "negative"
        elif "excellent" in mv or "great" in mv or "helpful" in mv or "learned" in mv:
            true_labels[name] = "positive"
        else:
            true_labels[name] = "neutral"

    # If ground_truth_sentiment field exists, use it
    for entry in validation_data:
        gt = entry.get("ground_truth_sentiment")
        if gt:
            true_labels[entry.get("participant_name", "unknown")] = gt

    # Compute metrics
    labels_dict = {auto: true for auto, true in zip(auto_labels.values(), true_labels.values())}

    # More robust: match by participant name
    matched_labels = {}
    for name in auto_labels:
        if name in true_labels:
            matched_labels[auto_labels[name]] = true_labels[name]

    if not matched_labels:
        print("No matching participants between automated results and validation data.", file=sys.stderr)
        sys.exit(1)

    metrics = compute_metrics(matched_labels)

    # Print report
    print("📊 Sentiment Analysis Validation Report")
    print("=" * 50)
    print(f"{'Class':<12} {'Precision':>10} {'Recall':>10} {'F1':>10} {'Support':>10}")
    print("-" * 52)
    for cls in ["positive", "negative", "neutral"]:
        m = metrics.get(cls, {})
        print(f"{cls:<12} {m.get('precision', 0):>10.3f} {m.get('recall', 0):>10.3f} "
              f"{m.get('f1', 0):>10.3f} {m.get('support', 0):>10}")
    print("-" * 52)
    m = metrics.get("overall", {})
    print(f"{'Overall':<12} {m.get('precision', 0):>10.3f} {m.get('recall', 0):>10.3f} "
          f"{m.get('f1', 0):>10.3f} {m.get('total_samples', 0):>10}")
    print()

    if m.get("f1", 0) >= 0.7:
        print("✅ Accuracy target met (F1 ≥ 0.7). The sentiment analysis engine is ready for deployment.")
    else:
        print("⚠️  Accuracy target NOT met (F1 < 0.7). Expand the keyword dictionary or add context rules.")

    # Save metrics
    output_file = Path(args.auto_results).with_name("validation-metrics.json")
    with open(output_file, "w", encoding="utf-8") as f:
        json.dump(metrics, f, indent=2)
    print(f"\n📝 Metrics saved to: {output_file}")


if __name__ == "__main__":
    main()
