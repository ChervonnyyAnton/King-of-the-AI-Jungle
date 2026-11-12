#!/usr/bin/env python3
"""
King of the AI Jungle — Individual Growth Report Generator

Reads pre-workshop self-assessment data and post-workshop judging scores
to generate individual growth reports for each participant.

Usage:
    python3 generate-growth-report.py \
        --pre-dir <pre_assessment_dir> \
        --post-dir <post_scores_dir> \
        --output-dir <output_dir> \
        --workshop-date <YYYY-MM-DD>
"""

import argparse
import json
import os
import sys
from datetime import datetime, timezone
from pathlib import Path


def load_json_file(filepath):
    """Load and return a JSON file, or None if it doesn't exist."""
    try:
        with open(filepath, "r", encoding="utf-8") as f:
            return json.load(f)
    except (FileNotFoundError, json.JSONDecodeError):
        return None


def load_pre_assessments(pre_dir):
    """Load all pre-workshop self-assessment JSON files."""
    pre_path = Path(pre_dir)
    if not pre_path.is_dir():
        return []
    return [load_json_file(str(f)) for f in sorted(pre_path.glob("*.json")) if load_json_file(str(f))]


def load_post_scores(post_dir):
    """Load post-workshop judging score data (JSON or directory of JSON files)."""
    post_path = Path(post_dir)
    results = []

    # Check if it's a single JSON file
    if post_path.is_file() and post_path.suffix == ".json":
        data = load_json_file(str(post_path))
        if isinstance(data, list):
            results = data
        elif isinstance(data, dict) and "participants" in data:
            results = data["participants"]
        elif data:
            results = [data]
    # Check if it's a directory
    elif post_path.is_dir():
        results = [load_json_file(str(f)) for f in sorted(post_path.glob("*.json")) if load_json_file(str(f))]

    return results


def compute_delta(pre_val, post_val):
    """Compute skill delta between pre and post scores."""
    if pre_val is None or post_val is None:
        return None, "—"
    delta = post_val - pre_val
    direction = "+" if delta > 0 else ("—" if delta == 0 else "")
    return delta, direction


def get_rubric_level(score):
    """Get rubric level label for a judging score."""
    levels = {
        1: "Unsatisfactory", 2: "Below Expectations", 3: "Meets Expectations",
        4: "Above Expectations", 5: "Exemplary"
    }
    return levels.get(int(score), "Unknown")


def generate_recommendations(path_id, delta_ai, delta_qa, delta_risk):
    """Generate personalized recommendations based on growth pattern."""
    recommendations = []

    # Path-group specific recommendations
    path_group = path_id[0] if path_id else "X"
    if path_group in ("A", "B", "C"):
        recommendations.append(
            f"Continue building your {path_id} foundation: explore AI-generated test case "
            f"techniques and practice ISTQB boundary value analysis on real project code."
        )
    elif path_group in ("D", "E"):
        recommendations.append(
            f"As a {path_id} path participant, deepen your AI-assisted automation skills "
            f"by building a self-healing test framework with AI-generated selector recovery."
        )
    elif path_group == "F":
        recommendations.append(
            f"As a {path_id} path participant, develop your token economy model further "
            f"by creating a multi-agent ROI calculator for your team's QA workflow."
        )

    # Delta-driven recommendations
    if delta_ai is not None and delta_ai > 0:
        recommendations.append(
            f"Great AI maturity growth (+{delta_ai} levels)! Continue advancing by "
            f"experimenting with multi-agent orchestration and prompt versioning."
        )
    elif delta_qa is not None and delta_qa > 0:
        recommendations.append(
            f"Solid QA fundamentals growth (+{delta_qa}). Focus on risk quantification "
            f"and AI-driven risk modeling with likelihood/impact scoring."
        )

    if len(recommendations) < 3:
        recommendations.append(
            f"Join the 'Jungle Alumni' community channel for ongoing AI-in-QA discussion "
            f"and access the 30-Day AI QA Challenge calendar."
        )

    return recommendations[:3]


def generate_report(pre_data, post_data, output_dir, workshop_date):
    """Generate individual growth reports for all participants."""
    # Match pre and post data by name or path_id
    output_dir_path = Path(output_dir)
    output_dir_path.mkdir(parents=True, exist_ok=True)

    matched = []
    for pre in pre_data:
        pre_name = pre.get("participant_name", "").lower()
        pre_path = pre.get("path_id", "")
        for post in post_data:
            post_name = post.get("participant_name", post.get("name", "")).lower()
            post_path = post.get("path_id", post.get("path_id", ""))
            if pre_name == post_name or (pre_path and pre_path == post_path):
                matched.append((pre, post))
                break

    if not matched and pre_data and post_data:
        # Fallback: match by index
        for i, pre in enumerate(pre_data):
            post = post_data[i] if i < len(post_data) else {}
            matched.append((pre, post))

    reports = []
    for pre, post in matched:
        # Extract data
        name = pre.get("participant_name", post.get("participant_name", post.get("name", "Unknown")))
        path_id = pre.get("path_id", post.get("path_id", post.get("path_id", "Unknown")))
        jungle_title = post.get("jungle_title", post.get("jungle_title", ""))

        pre_qa = pre.get("qa_fundamentals")
        pre_ai = pre.get("ai_awareness")
        pre_tooling = pre.get("tooling_skills")
        pre_test = pre.get("test_design")
        pre_risk = pre.get("risk_analysis")

        # Post scores (use judging scores if available, otherwise map from path)
        post_ai = post.get("ai_usage", post.get("AI_Usage"))
        post_risk = post.get("risk_analysis", post.get("Risk_Analysis"))
        post_plan = post.get("test_plan", post.get("Test_Plan"))
        post_budget = post.get("budget_tracking", post.get("Budget_Tracking"))
        post_peer = post.get("peer_review", post.get("Peer_Review"))
        post_qa = post.get("qa_fundamentals")  # inferred from overall judging
        post_tooling = post.get("tooling_skills")
        post_test = post.get("test_design")

        # Compute deltas
        delta_ai_val, delta_ai_dir = compute_delta(pre_ai, post_ai)
        delta_qa_val, delta_qa_dir = compute_delta(pre_qa, post_qa)
        delta_risk_val, delta_risk_dir = compute_delta(pre_risk, post_risk)

        # Overall delta
        pre_vals = [v for v in [pre_qa, pre_ai, pre_tooling, pre_test, pre_risk] if v is not None]
        post_vals = [v for v in [post_qa, post_ai, post_tooling, post_test, post_risk] if v is not None]
        overall_delta = (sum(post_vals) / len(post_vals)) - (sum(pre_vals) / len(pre_vals)) if pre_vals and post_vals else None
        overall_delta_pct = round((overall_delta / sum(pre_vals) * len(pre_vals)) * 100, 1) if overall_delta and pre_vals else None

        # Recommendations
        recommendations = generate_recommendations(path_id, delta_ai_val, delta_qa_val, delta_risk_val)

        # Build report
        report = {
            "metadata": {
                "generated_at": datetime.now(timezone.utc).isoformat(),
                "workshop_date": workshop_date
            },
            "participant": name,
            "path_id": path_id,
            "jungle_title": jungle_title,
            "pre": {
                "qa_fundamentals": pre_qa,
                "ai_awareness": pre_ai,
                "tooling_skills": pre_tooling,
                "test_design": pre_test,
                "risk_analysis": pre_risk
            },
            "post": {
                "ai_usage": post_ai,
                "risk_analysis": post_risk,
                "test_plan": post_plan,
                "budget_tracking": post_budget,
                "peer_review": post_peer
            },
            "deltas": {
                "ai": {"delta": delta_ai_val, "direction": delta_ai_dir},
                "qa": {"delta": delta_qa_val, "direction": delta_qa_dir},
                "risk": {"delta": delta_risk_val, "direction": delta_risk_dir}
            },
            "overall_growth": {
                "delta": overall_delta,
                "delta_pct": overall_delta_pct
            },
            "recommendations": recommendations
        }

        # Save individual report
        safe_name = name.replace(" ", "_").replace("/", "_").lower()
        report_file = output_dir_path / f"growth-{safe_name}.json"
        with open(report_file, "w", encoding="utf-8") as f:
            json.dump(report, f, indent=2, ensure_ascii=False)

        reports.append(report)

    return reports


def main():
    parser = argparse.ArgumentParser(
        description="Generate individual growth reports for King of the AI Jungle workshop participants."
    )
    parser.add_argument(
        "--pre-dir",
        required=True,
        help="Directory containing pre-workshop self-assessment JSON files"
    )
    parser.add_argument(
        "--post-dir",
        required=True,
        help="Directory containing post-workshop judging score JSON files (or a single JSON file)"
    )
    parser.add_argument(
        "--output-dir",
        default="growth-reports",
        help="Output directory for individual growth reports (default: growth-reports/)"
    )
    parser.add_argument(
        "--workshop-date",
        required=True,
        help="Workshop date in YYYY-MM-DD format"
    )

    args = parser.parse_args()

    pre_data = load_pre_assessments(args.pre_dir)
    post_data = load_post_scores(args.post_dir)

    if not pre_data:
        print("No pre-workshop assessment data found.", file=sys.stderr)
        sys.exit(1)
    if not post_data:
        print("No post-workshop score data found.", file=sys.stderr)
        sys.exit(1)

    reports = generate_report(pre_data, post_data, args.output_dir, args.workshop_date)

    print(f"✅ Generated {len(reports)} individual growth report(s)")
    for r in reports:
        print(f"   - {r['participant']} ({r['path_id']}): "
              f"AI growth {r['deltas']['ai']['direction']}{r['deltas']['ai']['delta']}, "
              f"Overall growth {r['overall_growth']['delta'] or '—'}")


if __name__ == "__main__":
    main()
