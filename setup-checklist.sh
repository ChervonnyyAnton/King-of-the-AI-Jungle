#!/bin/bash
# 🦁 King of the AI Jungle - Environment Check
# Verifies all prerequisites for the workshop.
# Usage: ./setup-checklist.sh  (requires bash or zsh — not POSIX sh)
# For sh compatibility: bash setup-checklist.sh

echo "🌴 Checking environment for the King of the AI Jungle..."
echo "-----------------------------------------------"

PASS=0
FAIL=0

# Check Git (optional — recommended for tracking changes)
if command -v git &> /dev/null; then
    echo "✅ Git is installed: $(git --version)"
    ((PASS++))
else
    echo "⚠️  Git is not found. Optional for basic workshop use but recommended for tracking changes."
fi

# Check Node.js
if command -v node &> /dev/null; then
    echo "✅ Node.js is installed: $(node --version)"
    ((PASS++))
    # Check npm
    if command -v npm &> /dev/null; then
        echo "✅ npm is installed: $(npm --version)"
        ((PASS++))
    else
        echo "❌ npm is missing. Reinstall Node.js from https://nodejs.org/"
        ((FAIL++))
    fi
else
    echo "❌ Node.js is missing. npx commands won't work. Install from https://nodejs.org/"
    ((FAIL++))
fi

# Check AI Hub configuration in VS Code (file is named opencode.json)
if [ -f "opencode.json" ]; then
    if python3 -m json.tool opencode.json > /dev/null 2>&1; then
        echo "✅ AI Hub configuration in VS Code is valid"
        ((PASS++))
    else
        echo "❌ AI Hub configuration file has syntax errors. Fix trailing commas: python3 -m json.tool opencode.json"
        ((FAIL++))
    fi
elif [ -f ".vscode/opencode.json" ]; then
    if python3 -m json.tool .vscode/opencode.json > /dev/null 2>&1; then
        echo "✅ AI Hub configuration in VS Code is valid"
        ((PASS++))
    else
        echo "❌ AI Hub configuration file has syntax errors."
        ((FAIL++))
    fi
else
    echo "❌ AI Hub configuration file not found. Copy opencode.json.template and fill in your API keys."
    ((FAIL++))
fi

# Check mock/index.html exists
if [ -f "mock/index.html" ]; then
    echo "✅ mock/index.html exists"
    ((PASS++))
else
    echo "❌ mock/index.html not found. Verify you opened the King-of-the-AI-Jungle folder."
    ((FAIL++))
fi

# Check Playwright (optional — engineer paths)
if command -v npx &> /dev/null; then
    if npx playwright --version &> /dev/null; then
        PW_VERSION=$(npx playwright --version 2>/dev/null | head -1)
        echo "✅ Playwright is installed: $PW_VERSION"
        ((PASS++))
    else
        echo "⚠️  Playwright not installed. Engineers: run 'npx playwright install'"
        # Not a failure for non-engineer paths
    fi
fi

# VS Code AI extension (visual check — informational)
echo ""
echo "📝 Manual check: Make sure VS Code is installed and open."
echo "   1. Open the 'King-of-the-AI-Jungle' folder in VS Code"
echo "   2. Verify the AI extension is active (look for the 🤖 icon)"
echo "   3. Ask the AI: 'Hello, are you connected?'"
echo ""
echo "-----------------------------------------------"
echo "Results: $PASS passed, $FAIL failed"

if [ "$FAIL" -eq 0 ]; then
    echo "🚀 All checks passed! Ready for the workshop!"
elif [ "$FAIL" -eq 1 ]; then
    echo "⚠️  One check failed (likely non-critical). Fix before starting if possible."
else
    echo "🛑 Too many failures ($FAIL). Consult the instructor or INSTRUCTOR-QUICK-REF.md before proceeding."
    exit 1
fi
