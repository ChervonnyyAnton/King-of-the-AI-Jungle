#!/usr/bin/env python3
"""
King of the AI Jungle — Stakeholder Report Generator

Reads workshop data artifacts (scoring data, feedback JSON, sentiment reports,
budget logs) and generates a comprehensive Workshop Summary Report in Markdown
format.

Usage:
    python3 generate-stakeholder-report.py \
        --data-dir <path> \
        --output <report.md> \
        --workshop-date <YYYY-MM-DD> \
        --instructor <name>
"""

import argparse
import json
import os
import sys
from datetime import datetime, timezone
from pathlib import Path
from textwrap import indent


def load_json_file(filepath):
    """Load and return a JSON file, or None if it doesn't exist."""
    try:
        with open(filepath, "r", encoding="utf-8") as f:
            return json.load(f)
    except (FileNotFoundError, json.JSONDecodeError):
        return None


def load_scores(data_dir):
    """Load participant scoring data."""
    scores_file = os.path.join(data_dir, "scores.json")
    data = load_json_file(scores_file)
    if data is None:
        return []
    if isinstance(data, list):
        return data
    if isinstance(data, dict) and "participants" in data:
        return data["participants"]
    return []


def load_feedback(data_dir):
    """Load all feedback JSON files."""
    feedback_dir = os.path.join(data_dir, "feedback")
    if not os.path.isdir(feedback_dir):
        return []

    files = sorted(Path(feedback_dir).glob("*.json"))
    results = []
    for f in files:
        data = load_json_file(str(f))
        if data:
            results.append(data)
    return results


def load_sentiment_report(data_dir):
    """Load the sentiment analysis report."""
    return load_json_file(os.path.join(data_dir, "sentiment-report.json"))


def load_budget_log(data_dir):
    """Parse the BUDGET-LOG.md file for budget usage data."""
    budget_file = os.path.join(data_dir, "BUDGET-LOG.md")
    if not os.path.isfile(budget_file):
        return None

    with open(budget_file, "r", encoding="utf-8") as f:
        content = f.read()

    # Simple extraction: look for cost amounts in the markdown
    total_spend = 0
    entries = []
    for line in content.split("\n"):
        # Try to extract dollar amounts from budget entries
        import re
        amounts = re.findall(r'\$(\d+\.?\d*)', line)
        if amounts:
            for amt in amounts:
                try:
                    val = float(amt)
                    total_spend += val
                except ValueError:
                    pass
    return {"total_spend": total_spend, "entries": entries}


def compute_likert_averages(feedback_list):
    """Compute average Likert scores from feedback list."""
    fields = ["content_relevance", "instructor_effectiveness", "time_management",
              "tooling_experience", "overall_value"]
    averages = {}
    for field in fields:
        values = [fb.get(field) for fb in feedback_list if fb.get(field) is not None]
        averages[field] = round(sum(values) / len(values), 2) if values else 0
    return averages


def format_score(score):
    """Format a numeric score with appropriate level label."""
    if score is None:
        return "—"
    level = {1: "Unsatisfactory", 2: "Below Expectations", 3: "Meets Expectations",
             4: "Above Expectations", 5: "Exemplary"}.get(int(score), "Unknown")
    return f"{score}/5 ({level})"


def generate_report(data_dir, output_file, workshop_date, instructor_name):
    """Generate the full Workshop Summary Report."""
    participants = load_scores(data_dir)
    feedback_list = load_feedback(data_dir)
    sentiment_report = load_sentiment_report(data_dir)
    budget_data = load_budget_log(data_dir)

    # Likert averages
    likert_avgs = compute_likert_averages(feedback_list) if feedback_list else {}

    # Participant scores table
    score_rows = []
    for p in participants:
        ai = p.get("ai_usage", p.get("AI_Usage", "—"))
        risk = p.get("risk_analysis", p.get("Risk_Analysis", "—"))
        plan = p.get("test_plan", p.get("Test_Plan", "—"))
        budget = p.get("budget_tracking", p.get("Budget_Tracking", "—"))
        peer = p.get("peer_review", p.get("Peer_Review", "—"))
        total = p.get("total", p.get("Total", "—"))
        name = p.get("name", p.get("participant_name", "Unknown"))
        path = p.get("path_id", p.get("path_id", "—"))
        title = p.get("jungle_title", p.get("jungle_title", "—"))
        score_rows.append({
            "name": name, "path": path, "title": title,
            "ai": ai, "risk": risk, "plan": plan,
            "budget": budget, "peer": peer, "total": total
        })

    # Sentiment summary
    sentiment_summary = {}
    if sentiment_report:
        sentiment_summary = sentiment_report.get("summary", {})
        sentiment_themes = sentiment_report.get("themes", {})
    else:
        sentiment_themes = {"top_positive_themes": [], "top_negative_themes": []}

    # Budget summary
    budget_total = budget_data["total_spend"] if budget_data else 0
    budget_pct = round(budget_total / 50 * 100, 1) if budget_total > 0 else 0

    # Average overall score
    overall_scores = [p.get("total", p.get("Total", 0)) for p in participants
                      if isinstance(p.get("total", p.get("Total", 0)), (int, float))]
    avg_score = round(sum(overall_scores) / len(overall_scores), 2) if overall_scores else 0

    # Recommendations
    recommendations = sentiment_report.get("recommendations", []) if sentiment_report else []

    # Build Markdown report
    lines = []
    lines.append("# 🌴 King of the AI Jungle — Workshop Summary Report\n")
    lines.append("## Executive Summary\n")
    lines.append("| Field | Value |")
    lines.append("|-------|-------|")
    lines.append(f"| **Workshop Date** | {workshop_date} |")
    lines.append(f"| **Instructor** | {instructor_name} |")
    lines.append(f"| **Total Participants** | {len(participants)} |")
    lines.append(f"| **Average Overall Score** | {avg_score} / 5 |")
    lines.append(f"| **Total Budget Spent** | ${budget_total:.2f} / $50 ({budget_pct}%) |")
    lines.append(f"| **Feedback Responses** | {len(feedback_list)} |")
    lines.append(f"| **Report Generated** | {datetime.now(timezone.utc).strftime('%Y-%m-%d %H:%M UTC')} |")
    lines.append("")
    lines.append("---\n")

    # Section 1: Participant Scores
    lines.append("## 1. Participant Scores\n")
    lines.append("| Name | Path | Jungle Title | AI Usage | Risk Analysis | Test Plan | Budget | Peer Review | Total |")
    lines.append("|------|------|--------------|----------|---------------|-----------|--------|-------------|-------|")
    for r in score_rows:
        lines.append(f"| {r['name']} | {r['path']} | {r['title']} | {r['ai']} | {r['risk']} | {r['plan']} | {r['budget']} | {r['peer']} | {r['total']} |")
    lines.append("")
    lines.append("**Score Legend:** 1 = Not Demonstrated, 2 = Minimally Demonstrated, 3 = Adequately Demonstrated, 4 = Strongly Demonstrated, 5 = Exemplary\n")
    lines.append("---\n")

    # Section 2: Budget Usage
    lines.append("## 2. Budget Usage\n")
    lines.append(f"**Workshop Total: ${budget_total:.2f} / $50 ({budget_pct}%)**\n")
    if budget_data:
        for entry in budget_data.get("entries", []):
            lines.append(f"- {entry}\n")
    lines.append("---\n")

    # Section 3: Feedback Summary
    lines.append("## 3. Feedback Summary\n")
    lines.append("### Likert Scale Averages (1–5)\n")
    lines.append("| Metric | Average |")
    lines.append("|--------|---------|")
    for key, label in [("content_relevance", "Content Relevance"),
                       ("instructor_effectiveness", "Instructor Effectiveness"),
                       ("time_management", "Time Management"),
                       ("tooling_experience", "Tooling Experience"),
                       ("overall_value", "Overall Value")]:
        val = likert_avgs.get(key, 0)
        lines.append(f"| {label} | {val} |")
    lines.append("")
    lines.append("---\n")

    # Section 4: Sentiment Insights
    lines.append("## 4. Sentiment Insights\n")
    lines.append("| Sentiment | Percentage |")
    lines.append("|-----------|------------|")
    lines.append(f"| **Positive** | {sentiment_summary.get('positive_pct', 'N/A')}% |")
    lines.append(f"| **Negative** | {sentiment_summary.get('negative_pct', 'N/A')}% |")
    lines.append(f"| **Neutral** | {sentiment_summary.get('neutral_pct', 'N/A')}% |")
    lines.append("")
    top_pos = sentiment_themes.get("top_positive_themes", [])
    top_neg = sentiment_themes.get("top_negative_themes", [])
    if top_pos:
        lines.append("**Top Positive Themes:** " + ", ".join(top_pos) + "\n")
    if top_neg:
        lines.append("**Top Negative Themes:** " + ", ".join(top_neg) + "\n")
    lines.append("---\n")

    # Section 5: Recommendations
    lines.append("## 5. Recommendations for Next Iteration\n")
    if recommendations:
        for i, rec in enumerate(recommendations, 1):
            lines.append(f"{i}. {rec}\n")
    else:
        lines.append("No automated recommendations — review sentiment data manually.\n")
    lines.append("---\n")

    # Footer
    lines.append(f"\n*Report generated by `generate-stakeholder-report.py` — {workshop_date}*\n")

    report_content = "\n".join(lines)

    with open(output_file, "w", encoding="utf-8") as f:
        f.write(report_content)

    return report_content


def main():
    parser = argparse.ArgumentParser(
        description="Generate a Workshop Summary Report for King of the AI Jungle."
    )
    parser.add_argument(
        "--data-dir",
        required=True,
        help="Directory containing workshop data (scores.json, BUDGET-LOG.md, feedback/, sentiment-report.json)"
    )
    parser.add_argument(
        "--output",
        default="workshop-summary-report.md",
        help="Output file for the report (default: workshop-summary-report.md)"
    )
    parser.add_argument(
        "--workshop-date",
        required=True,
        help="Workshop date in YYYY-MM-DD format"
    )
    parser.add_argument(
        "--instructor",
        required=True,
        help="Instructor name"
    )

    args = parser.parse_args()
    report = generate_report(args.data_dir, args.output, args.workshop_date, args.instructor)
    print(f"✅ Workshop Summary Report generated: {args.output}")
    print(f"   Participants: {len(load_scores(args.data_dir))}")
    print(f"   Feedback responses: {len(load_feedback(args.data_dir))}")


if __name__ == "__main__":
    main()
