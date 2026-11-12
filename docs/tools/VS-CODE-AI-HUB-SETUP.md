# 🛠️ VS Code & Adesso AI Hub Setup Guide

## 🎯 Goal
Configure VS Code to use the **Adesso AI Hub** with explicit model routing, cost controls, and fallback logic.

---

## 0. Prerequisites & Installation

Before configuring the AI Hub, ensure you have the following installed:

### 0.1 Install VS Code
- Download from https://code.visualstudio.com/
- Install the stable release (not Insiders, unless your instructor specifies otherwise).

### 0.2 Install Required Extensions
Open VS Code → Click the Extensions icon (🧩) in the sidebar → Search and install:
1. **"Adesso AI Chat"** (or the AI extension your instructor specifies)
2. **GitLens** (optional — helps track file changes)
3. **Playwright Test for VS Code** (engineers only — for running Playwright tests)

### 0.3 Trust the Workspace
When you open the `King-of-the-AI-Jungle` folder in VS Code:
1. VS Code will show a banner: **"The author of this folder hasn't been verified."**
2. Click **"Trust Authors"** → then **"Trust and Continue"**.
3. This allows VS Code to run scripts (like `setup-checklist.sh`) and use the AI extension in this workspace.

> **Why trust?** The workspace contains shell scripts (`setup-checklist.sh`), configuration files (`opencode.json`), and CI pipelines. Trusting the workspace allows these to function correctly.

### 0.4 Verify Installation
1. Open a terminal in VS Code (`Ctrl+`` ` or `Cmd+`` ` on Mac).
2. Run: `./setup-checklist.sh`
3. All checks should pass with green checkmarks (✅).
4. Ask the AI Chat: "Hello, are you connected?" — you should get a response within 10 seconds.

---

## 1. Exact `opencode.json` Configuration
Create or update `.vscode/opencode.json` (or project root):
```json
{
  "project": "King-of-the-AI-Jungle",
  "models": {
    "adesso": {
      "provider": "adesso",
      "models": {
        "qwen-sovereign": {
          "id": "qwen-3.6-35b-sovereign",
          "api_key": "{YOUR_SOVEREIGN_KEY}",
          "url": "{SOVEREIGN_URL}",
          "default": true,
          "max_tokens": 8192
        },
        "cloud-gpt4": {
          "id": "gpt-4-turbo",
          "api_key": "{YOUR_CLOUD_KEY}",
          "url": "{CLOUD_URL}",
          "default": false,
          "max_tokens": 8192,
          "fallback": true
        }
      }
    }
  },
  "routing_rules": {
    "default_model": "qwen-sovereign",
    "fallback_enabled": true,
    "fallback_on_tool_failure": true,
    "max_context_tokens": 8192,
    "auto_prune_long_context": true
  },
  "cost_management": {
    "budget_usd": 50.00,
    "cost_per_1k_input_tokens": {
      "qwen-sovereign": 0.001,
      "cloud-gpt4": 0.01
    },
    "cost_per_1k_output_tokens": {
      "qwen-sovereign": 0.002,
      "cloud-gpt4": 0.015
    },
    "alert_threshold_usd": 45.00,
    "auto_disable_cloud_on_alert": true
  }
}
```

## 🔍 Connectivity Check (Day-0)
Before the workshop, verify your setup:
1.  Open a new terminal in VS Code.
2.  Run: `curl -I {YOUR_SOVEREIGN_URL}`
3.  If you get `200 OK`, your key and URL are correct.
4.  Open VS Code AI Chat and ask: `"Hello, are you connected?"`

## 💰 Token Cost Reference
| Model | Input Tokens | Output Tokens | Approx. Cost per Request (8k ctx) |
|-------|--------------|---------------|-----------------------------------|
| `qwen-sovereign` | ~$0.001 | ~$0.002 | ~$0.005 |
| `cloud-gpt4` | ~$0.010 | ~$0.015 | ~$0.080 |
| **Budget Limit** | **$50.00** | **$50.00** | **≈ 6,000 requests (sov)** or **≈ 600 requests (cloud)** |

## 🔌 Model Routing Rules
1. **Default:** `qwen-sovereign` (handles 90%+ of tasks).
2. **Fallback:** `cloud-gpt4` only when explicit `websearch`/`webfetch` fails or CoT is required.
3. **Context Pruning:** Enabled by default. Long prompts auto-truncate at 8k tokens.
4. **Budget Alert:** VS Code AI extension will disable cloud model at $45.00 spent.

## 🌐 Offline Fallback Protocol
If internet is restricted during the workshop:
- `websearch`/`webfetch` will fail. Agents will automatically use cached knowledge.
- Disable cloud model in `opencode.json` to prevent timeouts.
- Focus on `filesystem` and `playwright` tools for local validation.

## 🆘 Troubleshooting
| Symptom | Fix |
|---------|-----|
| `401 Unauthorized` | Verify `{YOUR_KEY}` and `{URL}` are correct. No trailing spaces. |
| `429 Too Many Requests` | Reduce `max_tokens`, prune context, switch to sovereign. |
| `Tool not found` | Check `SKILLS.md` for exact invocation syntax. Restart AI extension. |
| Budget alert | Cloud model auto-disables. All requests route to sovereign. |

---

## 🔄 CI/CD Integration for Agents

The workshop repo includes a GitLab CI pipeline template that validates agent configurations and sandbox integrity automatically.

### Pipeline Stages

| Stage | Job | Purpose |
|-------|-----|---------|
| `lint` | `validate-agents-md` | Check AGENTS.md has required sections (Budget, CoT, Injection Guard, Fact-Check). |
| `lint` | `validate-opencode-schema` | JSON schema validation of `opencode.json.template`. |
| `security` | `csp-audit` | Verify CSP directives in `mock/index.html` (`connect-src 'self'`, `frame-src 'none'`). |
| `security` | `validate-sandbox-isolation` | Ensure no external API calls exist in the sandbox. |
| `test` | `sandbox-render-check` | Headless Playwright test for sandbox rendering. |
| `report` | `dx-metrics` | Output DX metrics summary (version, budget, docs coverage). |

### Running Locally

To run the pipeline locally (requires GitLab Runner):
```bash
# Install gitlab-runner
brew install gitlab-runner

# Register and run
gitlab-runner register
gitlab-runner run --build-dir /tmp/builds

# Or use Docker directly
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock gitlab/gitlab-runner:latest run
```

### Pre-Commit Hook (Optional)

To run checks before every commit, add a pre-commit hook:
```bash
#!/bin/bash
# .git/hooks/pre-commit
echo "🔍 Running DX validation checks..."
node -e "
  const fs = require('fs');
  const config = JSON.parse(fs.readFileSync('opencode.json.template', 'utf8'));
  if (!config.models || !config.cost_management) {
    console.error('❌ opencode.json.template schema invalid');
    process.exit(1);
  }
  console.log('✅ Schema check passed');
"
git diff --cached --name-only | xargs -I {} sh -c 'echo "  Checking: {}"'
echo "✅ Pre-commit checks passed"
```

---

## 💬 DX Feedback Form

*Help us improve the workshop! Complete this after your first setup session.*

| Question | Response |
|----------|----------|
| Did the connectivity check (`curl -I {YOUR_SOVEREIGN_URL}`) succeed? | ☐ Yes  ☐ No |
| Were all `{YOUR_*}` placeholders clearly documented? | ☐ Yes  ☐ No |
| Did you encounter any errors during model routing setup? | _Text: _____________ |
| Rate onboarding difficulty (1 = easy, 5 = hard): | ☐1 ☐2 ☐3 ☐4 ☐5 |
| What was the most confusing step? | _Text: _____________ |
| Suggested improvements: | _Text: _____________ |

### How to Submit Feedback
- Fill in this form in your local copy of `VS-CODE-AI-HUB-SETUP.md`.
- Save as `FEEDBACK-<YOUR-NAME>.md` in `docs/feedback/`.
- Reference the feedback in your R&R cycle log: *"Feedback Reference: FEEDBACK-<NAME>.md"*

---

*Configure once. Execute efficiently. Stay within budget. Feedback drives improvement.*
