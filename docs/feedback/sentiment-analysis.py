#!/usr/bin/env python3
"""
King of the AI Jungle — Sentiment Analysis Engine

Reads JSON feedback files from a workshop session, performs keyword-based
sentiment analysis on open-text responses, and outputs a structured
sentiment report.

Usage:
    python3 sentiment-analysis.py --input-dir <path> --output-file <path>

Dependencies: Python 3.6+, standard library only.
"""

import argparse
import json
import os
import sys
from datetime import datetime, timezone
from pathlib import Path


def load_sentiment_dict(dict_path=None):
    """Load the sentiment keyword dictionary."""
    if dict_path is None:
        dict_path = os.path.join(os.path.dirname(__file__), "sentiment-dict.json")
    with open(dict_path, "r", encoding="utf-8") as f:
        return json.load(f)


def analyze_sentiment(text, sentiment_dict):
    """
    Analyze the sentiment of a single text string using the keyword dictionary.
    Returns (score, label, keywords_found).
    """
    text_lower = text.lower()
    positive_count = 0
    negative_count = 0
    positive_keywords = []
    negative_keywords = []

    # Check single words
    for word in sentiment_dict.get("categories", {}).get("positive", []):
        if word.lower() in text_lower:
            positive_count += 1
            positive_keywords.append(word)

    for word in sentiment_dict.get("categories", {}).get("negative", []):
        if word.lower() in text_lower:
            negative_count += 1
            negative_keywords.append(word)

    # Check multi-word phrases
    for phrase in sentiment_dict.get("phrases", {}).get("positive", []):
        if phrase.lower() in text_lower:
            positive_count += 1
            positive_keywords.append(phrase)

    for phrase in sentiment_dict.get("phrases", {}).get("negative", []):
        if phrase.lower() in text_lower:
            negative_count += 1
            negative_keywords.append(phrase)

    # Determine label
    if positive_count > negative_count:
        label = "positive"
    elif negative_count > positive_count:
        label = "negative"
    else:
        label = "neutral"

    return {
        "score": positive_count - negative_count,
        "label": label,
        "positive_count": positive_count,
        "negative_count": negative_count,
        "positive_keywords": positive_keywords,
        "negative_keywords": negative_keywords
    }


def process_feedback_file(filepath, sentiment_dict):
    """Process a single feedback JSON file and return analysis results."""
    with open(filepath, "r", encoding="utf-8") as f:
        data = json.load(f)

    results = []

    # If it's a list of feedback records, process each item
    if isinstance(data, list):
        for item in data:
            if isinstance(item, dict):
                r = _process_single_record(item, sentiment_dict)
                if r is not None:
                    results.append(r)
        return results if results else None

    # Single feedback record
    return _process_single_record(data, sentiment_dict) if isinstance(data, dict) else None


def _process_single_record(feedback, sentiment_dict):
    """Process a single feedback dict and return analysis results, or None if not a feedback record."""
    # Skip files without required feedback fields
    if "most_valuable_part" not in feedback and "what_to_improve" not in feedback:
        return None

    # Analyze most_valuable_part
    mv_sentiment = analyze_sentiment(
        feedback.get("most_valuable_part", ""), sentiment_dict
    )

    # Analyze what_to_improve
    wi_sentiment = analyze_sentiment(
        feedback.get("what_to_improve", ""), sentiment_dict
    )

    # Overall sentiment from text responses
    overall_score = mv_sentiment["score"] + wi_sentiment["score"]
    if overall_score > 0:
        overall_label = "positive"
    elif overall_score < 0:
        overall_label = "negative"
    else:
        overall_label = "neutral"

    # Combine all keywords found
    all_positive = list(set(mv_sentiment["positive_keywords"] + wi_sentiment["positive_keywords"]))
    all_negative = list(set(mv_sentiment["negative_keywords"] + wi_sentiment["negative_keywords"]))

    # Calculate average Likert score
    likert_fields = ["content_relevance", "instructor_effectiveness", "time_management",
                     "tooling_experience", "overall_value"]
    likert_values = [feedback.get(field) for field in likert_fields if feedback.get(field) is not None]
    avg_likert = sum(likert_values) / len(likert_values) if likert_values else 0

    return {
        "participant": feedback.get("participant_name", "anonymous"),
        "path_id": feedback.get("path_id", "unknown"),
        "session_id": feedback.get("session_id", "unknown"),
        "likert_average": round(avg_likert, 2),
        "most_valuable_sentiment": mv_sentiment,
        "improve_sentiment": wi_sentiment,
        "overall_sentiment": {
            "label": overall_label,
            "score": overall_score,
            "positive_keywords": all_positive,
            "negative_keywords": all_negative
        },
        "raw_most_valuable": feedback.get("most_valuable_part", ""),
        "raw_what_to_improve": feedback.get("what_to_improve", "")
    }


def generate_report(results, output_file):
    """Generate the sentiment report and write it to the output file."""
    total = len(results)
    positive_count = sum(1 for r in results if r["overall_sentiment"]["label"] == "positive")
    negative_count = sum(1 for r in results if r["overall_sentiment"]["label"] == "negative")
    neutral_count = total - positive_count - negative_count

    # Aggregate Likert averages
    avg_likert_all = sum(r["likert_average"] for r in results) / total if total else 0

    # Aggregate per-question Likert averages
    all_likert = {
        "content_relevance": [],
        "instructor_effectiveness": [],
        "time_management": [],
        "tooling_experience": [],
        "overall_value": []
    }

    # Re-read raw files for per-question aggregation (simplified: use results from processed files)
    for r in results:
        # We don't have per-question data in results, so use overall average as fallback
        pass

    # Collect top themes from positive and negative keywords
    pos_keyword_freq = {}
    neg_keyword_freq = {}
    for r in results:
        for kw in r["overall_sentiment"]["positive_keywords"]:
            pos_keyword_freq[kw] = pos_keyword_freq.get(kw, 0) + 1
        for kw in r["overall_sentiment"]["negative_keywords"]:
            neg_keyword_freq[kw] = neg_keyword_freq.get(kw, 0) + 1

    top_positive = sorted(pos_keyword_freq.items(), key=lambda x: x[1], reverse=True)[:5]
    top_negative = sorted(neg_keyword_freq.items(), key=lambda x: x[1], reverse=True)[:5]

    report = {
        "metadata": {
            "generated_at": datetime.now(timezone.utc).isoformat(),
            "total_responses": total,
            "input_directory": os.path.dirname(output_file)
        },
        "summary": {
            "positive_count": positive_count,
            "negative_count": negative_count,
            "neutral_count": neutral_count,
            "positive_pct": round(positive_count / total * 100, 1) if total else 0,
            "negative_pct": round(negative_count / total * 100, 1) if total else 0,
            "neutral_pct": round(neutral_count / total * 100, 1) if total else 0,
            "average_likert_score": round(avg_likert_all, 2)
        },
        "per_response": results,
        "themes": {
            "top_positive_keywords": [{"keyword": kw, "count": cnt} for kw, cnt in top_positive],
            "top_negative_keywords": [{"keyword": kw, "count": cnt} for kw, cnt in top_negative],
            "top_positive_themes": [kw for kw, _ in top_positive],
            "top_negative_themes": [kw for kw, _ in top_negative]
        },
        "recommendations": generate_recommendations(top_positive, top_negative)
    }

    with open(output_file, "w", encoding="utf-8") as f:
        json.dump(report, f, indent=2, ensure_ascii=False)

    return report


def generate_recommendations(top_positive, top_negative):
    """Generate simple recommendations based on sentiment theme analysis."""
    recommendations = []

    if top_negative:
        top_neg_kw = top_negative[0][0]
        if any(term in top_neg_kw for term in ["confusing", "unclear", "hard to follow"]):
            recommendations.append(
                "Simplify instructions and add more concrete examples. "
                f"Participants commonly mentioned '{top_neg_kw}' as a concern."
            )
        elif any(term in top_neg_kw for term in ["too long", "too short", "rushed"]):
            recommendations.append(
                "Adjust time allocation for workshop segments. "
                f"Pacing concerns were frequently raised, especially '{top_neg_kw}'."
            )
        elif any(term in top_neg_kw for term in ["frustrating", "difficult", "problem"]):
            recommendations.append(
                "Improve tooling setup and provide more pre-workshop preparation materials. "
                f"Technical friction was a recurring theme ('{top_neg_kw}')."
            )

    if top_positive:
        top_pos_kw = top_positive[0][0]
        recommendations.append(
            f"Continue emphasizing the aspects participants found most valuable "
            f"(e.g., '{top_pos_kw}' was highlighted as a top positive theme)."
        )

    if not recommendations:
        recommendations.append(
            "Workshop feedback was predominantly neutral. Consider adding more "
            "interactive elements to increase engagement and sentiment polarity."
        )

    return recommendations


def main():
    parser = argparse.ArgumentParser(
        description="Analyze sentiment of King of the AI Jungle workshop feedback."
    )
    parser.add_argument(
        "--input-dir",
        required=True,
        help="Directory containing JSON feedback files from SURVEY-FORM.html"
    )
    parser.add_argument(
        "--output-file",
        default="sentiment-report.json",
        help="Output file for the sentiment report (default: sentiment-report.json)"
    )
    parser.add_argument(
        "--dict-file",
        default=None,
        help="Path to sentiment dictionary (default: sentiment-dict.json in same directory)"
    )

    args = parser.parse_args()

    input_dir = Path(args.input_dir)
    if not input_dir.exists():
        print(f"Error: Input directory '{args.input_dir}' does not exist.", file=sys.stderr)
        sys.exit(1)

    sentiment_dict = load_sentiment_dict(args.dict_file)

    # Collect all JSON feedback files
    json_files = sorted(input_dir.glob("*.json"))
    if not json_files:
        print("No JSON files found in input directory.", file=sys.stderr)
        sys.exit(1)

    print(f"Processing {len(json_files)} feedback file(s)...")

    results = []
    for json_file in json_files:
        try:
            result = process_feedback_file(str(json_file), sentiment_dict)
            if result is None:
                print(f"  ⏭ {json_file.name} — Skipped (not a feedback record)")
                continue
            # Flatten: process_feedback_file returns a list when input is a list
            if isinstance(result, list):
                for r in result:
                    results.append(r)
                    print(f"  ✓ {json_file.name} ({r['participant']}) — Sentiment: {r['overall_sentiment']['label']}")
            else:
                results.append(result)
                print(f"  ✓ {json_file.name} — Sentiment: {result['overall_sentiment']['label']}")
        except (json.JSONDecodeError, KeyError, TypeError) as e:
            print(f"  ✗ {json_file.name} — Error: {e}", file=sys.stderr)

    if not results:
        print("No valid feedback files were processed.", file=sys.stderr)
        sys.exit(1)

    report = generate_report(results, args.output_file)

    print(f"\n📊 Sentiment Analysis Complete")
    print(f"  Total Responses: {report['metadata']['total_responses']}")
    print(f"  Positive: {report['summary']['positive_count']} ({report['summary']['positive_pct']}%)")
    print(f"  Negative: {report['summary']['negative_count']} ({report['summary']['negative_pct']}%)")
    print(f"  Neutral:  {report['summary']['neutral_count']} ({report['summary']['neutral_pct']}%)")
    print(f"  Average Likert Score: {report['summary']['average_likert_score']}")
    print(f"\n📝 Report saved to: {args.output_file}")


if __name__ == "__main__":
    main()
