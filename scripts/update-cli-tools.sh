#!/bin/bash
set -e

echo "🔄 Updating CLI tools to latest versions..."
echo ""

echo "📦 Updating Claude Code..."
npm install -g @anthropic-ai/claude-code@latest

echo ""
echo "📦 Updating Codex..."
npm install -g @openai/codex@latest

echo ""
echo "📦 Updating Gemini..."
npm install -g @google/gemini-cli@latest 2>/dev/null || echo "Gemini update failed"

echo ""
echo "📦 Updating GitHub CLI..."
LATEST_GH=$(curl -s https://api.github.com/repos/cli/cli/releases/latest | grep tag_name | cut -d\" -f4 | sed 's/v//')
if [ -n "$LATEST_GH" ]; then
    cd /tmp
    curl -sL "https://github.com/cli/cli/releases/download/v${LATEST_GH}/gh_${LATEST_GH}_linux_amd64.tar.gz" -o gh.tar.gz
    tar -xzf gh.tar.gz
    mkdir -p ~/.local/bin
    cp "gh_${LATEST_GH}_linux_amd64/bin/gh" ~/.local/bin/gh
    rm -rf gh.tar.gz "gh_${LATEST_GH}_linux_amd64"
    echo "gh updated to ${LATEST_GH}"
else
    echo "Failed to fetch latest gh version"
fi

echo ""
echo "✅ Done! Current versions:"
claude --version 2>/dev/null || echo "Claude: not found"
codex --version 2>/dev/null || echo "Codex: not found"
gemini --version 2>/dev/null || echo "Gemini: not found"
~/.local/bin/gh --version 2>/dev/null | head -1 || gh --version 2>/dev/null | head -1 || echo "gh: not found"
