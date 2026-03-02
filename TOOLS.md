# TOOLS.md - Local Notes

Skills define _how_ tools work. This file is for _your_ specifics — the stuff that's unique to your setup.

## What Goes Here

Things like:

- Camera names and locations
- SSH hosts and aliases
- Preferred voices for TTS
- Speaker/room names
- Device nicknames
- Anything environment-specific

## Examples

```markdown
### Cameras

- living-room → Main area, 180° wide angle
- front-door → Entrance, motion-triggered

### SSH

- home-server → 192.168.1.100, user: admin

### TTS

- Preferred voice: "Nova" (warm, slightly British)
- Default speaker: Kitchen HomePod
```

## Why Separate?

Skills are shared. Your setup is yours. Keeping them apart means you can update skills without losing your notes, and share skills without leaking your infrastructure.

---

Add whatever helps you do your job. This is your cheat sheet.

## Coding Agent

- **opencode** - Use for coding tasks (installed at `/usr/local/bin/opencode`)
- Default model: `opencode/minimax-m2.5-free` (configured in OpenClaw)
- Free models available without API key
- Location: `/data/workspace/skills/opencode/SKILL.md`

## Dokploy

- **url**: https://main.spidmax.win
- **api_key**: xjVgjgfJouKyOtYHwbJfrFCzlcMQsNjCUajbITGXHIOHTaxDEZKvuLZicmSSieMI

## Supabase

- **project_id**: wtyeuqqhlzzjhzqoxput
- **access_token**: sbp_0a0a4e5e72c70be9557bfbd426965e9e692ed101
- **CLI**: /data/workspace/supabase
