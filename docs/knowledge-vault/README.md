# 🧠 Knowledge Vault — Personal Knowledge Base

> **Second Brain — Option C** | Workshop activity: Participants create a personal knowledge vault

## Purpose

The Knowledge Vault is a personal, participant-managed collection of markdown notes, insights, and
learnings created during the workshop. It complements the shared knowledge base (`docs/`) with
individual perspectives and reflections.

## Why a Knowledge Vault?

| Shared `docs/` | Personal `knowledge-vault/` |
|----------------|----------------------------|
| Team's collective knowledge | Individual learnings & reflections |
| Curated by instructors | Created by participants |
| Static structure | Evolving during the workshop |
| Reference material | Actionable personal insights |

## Directory Structure

```
docs/knowledge-vault/
├── README.md              ← You are here
├── TEMPLATE.md            ← Template for vault entries
└── <participant-name>/    ← One folder per participant
    ├── NOTES.md            ← Workshop notes
    ├── INSIGHTS.md         ← Key learnings
    └── ACTIONS.md          ← Action items for post-workshop
```

## Creating Your First Entry

1. **Create your folder**: `mkdir docs/knowledge-vault/<your-name>/`
2. **Copy the template**: `cp docs/knowledge-vault/TEMPLATE.md docs/knowledge-vault/<your-name>/NOTES.md`
3. **Start writing**: Document your thoughts, questions, and insights

### Template

```markdown
---
name: <Your Name>
date: <YYYY-MM-DD>
workshop: King of the AI Jungle
session: <Session number if applicable>
---

# Personal Notes

## What I Learned Today

-

## Questions I Still Have

-

## Connections to My Work

-

## Action Items

- [ ]
```

## How to Use During the Workshop

### During the Presentation (30 min)

- Note key concepts in your NOTES.md
- Write down questions that arise
- Identify concepts that connect to your daily work

### During Hands-On Exercises (120 min)

- Record tool configurations that worked well
- Document error patterns you encountered and how you resolved them
- Note AI prompt patterns that produced good/bad results

### During the Presentation (30 min)

- Summarize your top 3 takeaways
- List 2 action items for post-workshop
- Share one insight with the group

## Sharing with the Team

To contribute to the shared knowledge base:

1. Move your best insights from `knowledge-vault/<name>/` to `docs/`
2. Add them as new markdown files in the appropriate category
3. Reference the original vault entry in a comment

## Integrating with the Second Brain

Once your vault entries are written, the Second Brain can index them:

### Option A (Client-side)
The search panel already scans `docs/` recursively. If you add files to `knowledge-vault/`,
they'll be indexed automatically when you click "Scan All Docs."

### Option B (MCP Server)
The MCP server scans `docs/` on startup. Restart the server to index new vault entries:
```bash
node mcp-tools/server.js
```

## Vault Search Queries

Try these in the Second Brain search panel:

| Query | What it finds |
|-------|--------------|
| `workshop lesson` | Key learnings across all vault entries |
| `error solution` | Problems encountered and fixes |
| `tool config` | Configuration notes and tips |
| `action item` | Post-workshop commitments |

## Tips for Effective Vault Entries

1. **Be specific**: "Used `npx serve .` from project root" > "Used a web server"
2. **Include context**: "This worked because the CSP allows 'unsafe-inline' for scripts"
3. **Link to sources**: Reference the shared docs where relevant
4. **Use categories**: Tags like `#prompt-engineering`, `#csp`, `#ai-hub`
5. **Update regularly**: The vault is alive — add to it throughout the day

## File Structure

```
docs/knowledge-vault/
├── README.md              ← You are here
├── TEMPLATE.md            ← Template for vault entries
└── <participant-name>/    ← One folder per participant
    ├── NOTES.md            ← Workshop notes
    ├── INSIGHTS.md         ← Key learnings
    └── ACTIONS.md          ← Action items for post-workshop
```
