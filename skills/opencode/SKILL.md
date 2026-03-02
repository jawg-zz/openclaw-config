---
name: opencode
description: 'Use OpenCode (opencode.ai) for coding tasks. OpenCode is an AI coding agent with free models. Use when: (1) building/creating features, (2) refactoring, (3) code reviews, (4) debugging, (5) any coding task. It has built-in free models. NOT for: simple edits (use edit tool), or non-coding tasks.'
metadata:
  {
    "openclaw": {
      "emoji": "💻",
      "requires": { "bins": ["opencode"] }
    },
  }
---

# OpenCode Skill

Use **OpenCode** for coding tasks. OpenCode is an AI coding agent with built-in free models that works without requiring API keys.

## Installation

```bash
npm install -g opencode-ai
```

## Quick Start

```bash
# One-shot task in current directory
opencode run "Your task here"

# In a specific project
opencode run --model opencode/minimax-m2.5-free "Your task"

# Using the free model (already default)
opencode run "Add a login form"
```

## Available Models

### Free Models (No API Key Required)
- `opencode/minimax-m2.5-free` - MiniMax M2.5 (default, fast)
- `opencode/trinity-large-preview-free` - Trinity Large (better reasoning)
- `opencode/big-pickle` - Big Pickle (larger context)

### Paid Models (Require API Key)
- `opencode/claude-opus-4-6` - Claude Opus 4.6
- `opencode/gemini-3-pro` - Gemini 3 Pro
- `opencode/glm-5` - GLM-5

## Usage Examples

### Build a Feature
```bash
opencode run "Add a dark mode toggle to the React app"
```

### Create New Project
```bash
opencode run "Create a new Next.js app with TypeScript and Tailwind"
```

### Code Review
```bash
opencode run "Review this PR and suggest improvements"
```

### Refactor
```bash
opencode run "Refactor the auth module to use JWT tokens"
```

### Debug
```bash
opencode run "Fix the login error: Cannot read property 'user' of undefined"
```

### Add Tests
```bash
opencode run "Write unit tests for the user authentication module"
```

## Advanced Usage

### With PTY (Recommended for interactive tasks)

When running interactively or monitoring output:

```bash
# With PTY for proper terminal output
bash pty:true command:"opencode run 'Your task'"

# Background with PTY
bash pty:true background:true command:"opencode run 'Build a REST API'"
```

### OpenCode Serve (Headless Server)

Start a server for remote connections:

```bash
opencode serve --port 3456
```

Then attach from anywhere:

```bash
opencode attach http://127.0.0.1:3456
```

### Interactive Mode

```bash
# Start interactive session
opencode

# Or in a project directory
opencode /path/to/project
```

## Configuration

### Set Default Model

In your shell profile:
```bash
export OPENCODE_DEFAULT_MODEL="opencode/minimax-m2.5-free"
```

### Check Available Models
```bash
opencode models          # All available models
opencode models opencode # OpenCode built-in models
opencode models openrouter # OpenRouter models (need API key)
```

## Best Practices

1. **Be Specific** - The more details you provide, the better results
   - ❌ "Fix the app"
   - ✅ "Fix the login button on line 45 that's not calling the auth API"

2. **Use PTY** - Always use PTY mode for better output handling

3. **Workdir Matters** - Specify the project directory to focus context
   ```bash
   opencode run --directory /path/to/project "Your task"
   ```

4. **Review Changes** - Always review what opencode changes before committing

5. **Combine with Git** - Use in git repositories for best results
   ```bash
   cd your-project && opencode run "Your task"
   ```

## Troubleshooting

### Agent Hangs
- Use Ctrl+C to interrupt
- Try with shorter prompts
- Use `--model opencode/minimax-m2.5-free` for faster responses

### Permission Issues
```bash
# Install globally without sudo
npm install -g opencode-ai --unsafe-perm=true
```

### Check Version
```bash
opencode --version
```

## Notes

- OpenCode has free built-in models - no API key needed for basic use
- Works best with git repositories
- Can read, edit, create, and delete files autonomously
- Supports multiple programming languages
- Has built-in code review capabilities
- Integrates well with VS Code and other editors

## Integration with OpenClaw

The default model is set in OpenClaw config:
- Config location: `/data/.openclaw/openclaw.json`
- Default model: `opencode/minimax-m2.5-free`

To spawn opencode as a sub-agent:
```bash
# Use sessions_spawn with runtime:"acp" if configured
```
