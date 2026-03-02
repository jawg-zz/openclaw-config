---
name: coding
description: |
  Software development tasks in this workspace including writing, debugging, refactoring, 
  and maintaining code. Use for: (1) Reading and understanding existing code, 
  (2) Making edits or fixes, (3) Building and testing, (4) Git operations, 
  (5) Explaining code or technical concepts. NOT for: delegating to external agents 
  (use coding-agent skill instead).
---

# Coding Skill

## Workspace Context

Working directory: `/data/workspace`
Current project: `sda-ai-content` (Next.js app for SDA church content generation)

## OpenCode Models

Use free models from OpenCode for coding tasks:

| Model | Use Case |
|-------|----------|
| `opencode/minimax-m2.5-free` | Quick tasks, simple edits |
| `opencode/gemini-3-flash` | Fast reasoning, general coding |
| `opencode/claude-opus-4-6` | Complex debugging, architecture |

### Running OpenCode

```bash
# Quick task with free model
opencode -m opencode/minimax-m2.5-free run "your task"

# With Gemini flash
opencode -m opencode/gemini-3-flash run "your task"

# Complex task with Opus
opencode -m opencode/claude-opus-4-6 run "your task"
```

## File Operations

- **Read first** - Always read files before editing
- **Edit** - Use exact text matching for precise changes  
- **Write** - For new files or full rewrites

## Build & Deploy

```bash
cd /data/workspace/sda-ai-content
npm run build
npm run dev
```

## Git Workflow

```bash
git add -A
git commit -m "description"
git push origin master
```

## Key Files

- `src/app/page.tsx` - Main page component
- `src/app/components/PDFDocument.tsx` - PDF generation
- `src/app/components/BibleBrowser.tsx` - Bible browser
- `src/app/api/` - API routes

## Common Tasks

| Task | Command |
|------|---------|
| Fix bug | Read → Edit → Build |
| Add feature | Read → Write → Build |
| PDF issues | Check PDFDocument.tsx |
