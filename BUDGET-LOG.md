# 💰 Budget & Token Management Log

## 🎯 Constraint
- **Per-Participant Budget:** $50.00 USD (matches AGENTS.md Budget & Token Economy section)
- **Models:** Adesso AI Hub (Sovereign & Cloud)
- **Goal:** Maximize quality while staying within budget.

## 📊 Tracking Template

Participants estimate cost based on prompt length and output type (see **Estimation Guide** below). Token counts are NOT displayed in the AI Chat — use the estimation guide to approximate.

| Date | Timestamp | Operator | Role | Task | Model Used | Est. Cost | Re-prompt Count | Cumulative Cost | Status |
|------|-----------|----------|------|------|------------|-----------|-----------------|-----------------|--------|
| MM/DD | 2025-06-15T14:30:00Z | Jane Doe | Analyst | Risk Analysis | Sovereign | ~$0.01 | 0 | ~$0.01 | ✅ |
| MM/DD | 2025-06-15T15:00:00Z | John Smith | SDET | Playwright Gen | Cloud | ~$0.08 | 1 | ~$0.09 | ✅ |
| MM/DD | 2025-06-15T15:30:00Z | Alex Chen | Arch | Research | Sovereign | ~$0.01 | 0 | ~$0.10 | ✅ |

## 📈 Cost per Artifact Summary
| Artifact Type | Count | Total Cost | Avg Cost per Artifact |
|---------------|-------|------------|-----------------------|
| Risk Analysis | — | — | — |
| Test Plan | — | — | — |
| Test Suite | — | — | — |
| Strategy Document | — | — | — |
| **Total** | **0** | **$0.00** | **$0.00** |

*Target: Keep cumulative cost under per-participant budget ($50). If a single task exceeds $1.00, consider optimizing the prompt.*

## 💡 The Token Economy
- **Tokens are Currency:** Every word you type (Input) and every word the AI writes (Output) costs money.
- **Input Optimization:** Be precise. "Write a Playwright test for the Export button" is better than "Can you please help me write a test for the export button, making sure it's good?"
- **Output Control:** Set `max_tokens: 8192`. If the AI is too verbose, ask it to "Be concise" or "Only output the code".
- **Context Pruning:** If the agent gets confused by previous messages, clear the chat and paste only the relevant `AGENTS.md` prompt.

## 📈 Token Cost Reference

### Approximate Cost Per Task
Use this guide to estimate cost since VS Code AI Chat does not display token counts:

| Task Type | Est. Input (chars) | Est. Output (chars) | Est. Cost (Sovereign) | Est. Cost (Cloud) |
|-----------|--------------------|---------------------|-----------------------|-------------------|
| Short prompt (1-2 sentences) | ~50 | ~200 | ~$0.001 | ~$0.01 |
| Medium prompt (read a file + task) | ~500 | ~1,000 | ~$0.003 | ~$0.02 |
| Long prompt (read multiple files + task) | ~2,000 | ~3,000 | ~$0.006 | ~$0.05 |
| Code generation | ~500 | ~2,000 | ~$0.005 | ~$0.04 |
| Research (websearch + analysis) | ~500 | ~1,500 | ~$0.004 | ~$0.03 |

### Model Cost Per 1K Tokens
| Model | Input Cost (per 1k) | Output Cost (per 1k) |
|-------|---------------------|----------------------|
| `qwen-sovereign` | $0.001 | $0.002 |
| `cloud-gpt4` | $0.010 | $0.015 |

**Quick estimate:** For sovereign model, a typical task costs $0.001–$0.01. For cloud model, $0.02–$0.10. Cloud is ~10× more expensive — use it sparingly.

## 💡 Estimation Guide for Participants

**Why estimates instead of token counts?** The VS Code AI Chat doesn't show token usage. Use these rules of thumb:

1. **Count your input characters:** Divide by 1,000 to get input tokens.
2. **Count AI output characters:** Divide by 1,000 to get output tokens.
3. **Multiply by cost per token** from the table above.
4. **Round up** to the nearest $0.001.

**Example:** You type 300 characters ("Read JIRA-102.md and list 5 risks") and the AI returns 800 characters of output:
- Input: 0.3 × $0.001 = $0.0003 → round to $0.001
- Output: 0.8 × $0.002 = $0.0016 → round to $0.002
- **Total: ~$0.003**

**Shortcut:** If you wrote less than 1 paragraph and the AI wrote less than 1 screen of text, log **~$0.003** for sovereign or **~$0.02** for cloud.

## 📋 Audit Trail Requirements
- **Operator:** Every entry must record who performed the task (participant name or role identifier).
- **Timestamp:** Use ISO 8601 format (e.g., `2025-06-15T14:30:00Z`) for precise time tracking.
- **Attribution:** Aggregate costs by operator at the end of the workshop to validate per-path budget recommendations (Scouts $15–25, Engineers $20–35, Architects $30–45).
- **Incident Investigation:** If cost spikes unexpectedly, audit trails enable root-cause analysis: which operator, which model, which task.
- **Retention:** Keep `BUDGET-LOG.md` for 90 days after workshop completion for audit purposes.

## 📊 Analytics Tracking

This section is maintained by the instructor analytics dashboard (`instructor-dashboard.html`). Populate these fields during the workshop for real-time dashboard visibility.

| Team ID | Path Group | Budget Burn Rate | Cumulative (Path Group) | Alert Triggered | Artifact Status |
|---------|------------|-----------------|------------------------|-----------------|-----------------|
| Team A | Scouts | 🟢 23% | — | No | Test Plan ✅, Risk ✅, Budget ✅ |
| Team B | Scouts | 🟡 61% | — | No | Test Plan ✅, Risk ❌, Budget ✅ |
| Team C | Scouts | 🟡 64% | — | Stuck flag | Test Plan ✅, Risk ✅, Budget ✅ |
| Team D | Engineers | 🟢 28% | — | No | Test Plan ✅, Risk ✅, Budget ✅ |
| Team E | Engineers | 🔴 82% | — | Budget alert | Test Plan ❌, Risk ❌, Budget ❌ |
| Team F | Architects | 🟡 45% | — | No | Test Plan ✅, Risk ✅, Budget ✅ |

*Color codes: 🟢 On Track (<50%), 🟡 Monitor (50–80%), 🔴 Intervene (>80%), 🚫 Over Budget.*

## 🛡️ Data Privacy in Analytics

- **No PII in exports:** Analytics exports use only anonymized team IDs. No participant names, emails, or personal identifiers appear in analytics exports.
- **Operator names in BUDGET-LOG.md:** Used for internal cost attribution only. When exported via the dashboard, these fields are redacted.
- **GDPR alignment:** Dashboard complies with GDPR Article 5(1)(c) — Data Minimization. Only team-level activity data is tracked, not personal data.
- **Data retention:** Analytics exports retained for 90 days, then purged.
