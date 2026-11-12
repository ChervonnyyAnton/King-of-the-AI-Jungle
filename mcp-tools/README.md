# 🧠 MCP Tools — Knowledge Search Server

> **Second Brain — Option B** | Workshop activity: Participants extend the MCP server with custom tools

## Purpose

The MCP (Model Context Protocol) server exposes knowledge-base search capabilities as MCP tools
that can be called by any MCP-compatible client (VS Code AI Hub, OpenCode, etc.). This is
the server-side counterpart to the client-side search panel (Option A).

## Architecture

```
┌──────────────┐       MCP JSON-RPC        ┌────────────────────┐
│   AI Client  │ ◄──────────────────────►  │  MCP Tools Server  │
│ (AI Hub/OC)  │       over HTTP/SSE       │  (Node.js :3456)   │
└──────────────┘                           └─────────┬──────────┘
                                                     │
                                               ┌─────▼──────┐
                                               │  docs/     │
                                               │  index     │
                                               └────────────┘
```

## Tools

### 1. `search_knowledge`

Full-text search across all indexed markdown documents.

**Parameters:**
| Name | Type | Required | Description |
|------|------|----------|-------------|
| `query` | string | Yes | Search keywords (space-separated for AND logic) |
| `category` | string | No | Filter by category: `tools`, `project`, `requirements`, `feedback`, `simulations`, `strategy`, `templates`, `docs`, or `"all"` |
| `limit` | number | No | Max results (default: 10, max: 50) |
| `snippet_length` | number | No | Snippet character length (default: 120) |

**Returns:** Array of `{ title, path, category, score, snippet }`

### 2. `list_documents`

List all indexed documents, optionally filtered by category.

**Parameters:**
| Name | Type | Required | Description |
|------|------|----------|-------------|
| `category` | string | No | Filter by category (default: `"all"`) |
| `sort` | string | No | Sort order: `"title"`, `"path"`, `"size"` (default: `"path"`) |

**Returns:** Array of `{ path, title, category, size }`

### 3. `get_document`

Retrieve full content of a specific document.

**Parameters:**
| Name | Type | Required | Description |
|------|------|----------|-------------|
| `path` | string | Yes | Relative path from project root (e.g., `docs/tools/CLI-CHEATSHEET.md`) |

**Returns:** `{ path, title, content, category, lineCount }`

## Getting Started

```bash
# 1. Start the server (no dependencies required — uses Node.js stdlib)
node mcp-tools/server.js

# Server starts at http://localhost:3456
# MCP endpoint: http://localhost:3456/mcp
```

## MCP Protocol

The server implements the MCP JSON-RPC 2.0 protocol over HTTP:

- **POST** `/mcp` — JSON-RPC requests (body: `{ jsonrpc: "2.0", method: "...", params: {...}, id: 1 }`)
- **GET** `/mcp` — SSE stream for server-to-client notifications
- **GET** `/health` — Health check

### JSON-RPC Methods

| Method | Description |
|--------|-------------|
| `initialize` | Server initialization handshake |
| `tools/list` | List available tools |
| `tools/call` | Call a tool by name with parameters |

### Example Request

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "method": "tools/call",
  "params": {
    "name": "search_knowledge",
    "arguments": {
      "query": "test strategy",
      "category": "requirements"
    }
  }
}
```

### Example Response

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "result": {
    "content": [
      {
        "type": "text",
        "text": "{\"results\":[{\"title\":\"Test Strategy\",\"path\":\"docs/requirements/test-strategy.md\",\"category\":\"requirements\",\"score\":15,\"snippet\":\"This document defines the **test strategy** for the King of the AI Jungle workshop...\"}]}"
      }
    ],
    "isError": false
  }
}
```

## Workshop Activity: Extend the Server

Participants can add new tools:

1. Open `mcp-tools/server.js`
2. Find the `TOOLS` registry (around line ~100)
3. Add a new tool object with:
   - `name`: Tool identifier (e.g., `find_similar_documents`)
   - `description`: What the tool does
   - `inputSchema`: JSON Schema for parameters
   - `handler`: Async function that returns `{ content: [{ type: "text", text: "..." }] }`
4. Restart the server

### Example: Category Statistics Tool

```javascript
const tools = {
  category_stats: {
    name: 'category_stats',
    description: 'Get statistics about documents in each category',
    inputSchema: {
      type: 'object',
      properties: {}
    },
    handler: async function(args, state) {
      const stats = {};
      for (const file of state.index) {
        const cat = file.category;
        stats[cat] = (stats[cat] || 0) + 1;
      }
      return { content: [{ type: 'text', text: JSON.stringify(stats, null, 2) }] };
    }
  }
};
```

## Integration with VS Code AI Hub

To use the MCP server with VS Code AI Hub:

1. Start the server: `node mcp-tools/server.js`
2. In VS Code AI Hub settings, add MCP endpoint: `http://localhost:3456/mcp`
3. Available tools will appear in the AI assistant's tool palette

## File Structure

```
mcp-tools/
├── README.md           ← You are here
├── server.js           ← MCP server implementation (Node.js, stdlib only)
└── package.json        ← Project metadata (no runtime deps)
```
