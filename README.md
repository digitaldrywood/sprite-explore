# Sprite Explore

Exploring [Sprites.dev](https://sprites.dev/) - notes, scripts, and learnings.

Sprites.dev provides hardware-isolated Firecracker VMs for secure code execution. Each sprite is a persistent Linux environment with up to 8 CPUs and 16GB RAM.

## Pre-installed Tools

Sprites come with AI CLIs pre-installed:
- Claude Code
- Codex (OpenAI)
- Gemini
- GitHub CLI (`gh`)
- Node.js, Go, Python, Git

## Scripts

### `scripts/update-cli-tools.sh`

Updates all CLI tools to their latest versions. Install in a sprite:

```bash
# Copy to sprite
cat scripts/update-cli-tools.sh | sprite exec -s dev -- bash -c 'cat > /usr/local/bin/update-cli-tools && chmod +x /usr/local/bin/update-cli-tools'

# Run it
sprite exec -s dev -- update-cli-tools
```

## Quick Start

```bash
# Install CLI
curl -fsSL https://sprites.dev/install.sh | bash

# Authenticate
sprite auth setup --token "your-token"

# Create a sprite
sprite create dev

# Run commands
sprite exec -s dev -- uname -a

# Interactive shell
sprite console -s dev

# Checkpoint your environment
sprite checkpoint create -s dev

# Restore from checkpoint
sprite restore v1 -s dev
```

## Authentication Flow

AI CLIs (Claude, Codex, Gemini) use OAuth that redirects to your local browser - works seamlessly even from remote sprites.

GitHub CLI needs separate auth:
```bash
sprite console -s dev
gh auth login
```

## Resources

- [Sprites.dev](https://sprites.dev/)
- [Sprites Documentation](https://docs.sprites.dev/)
