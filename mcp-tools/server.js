#!/usr/bin/env node
/**
 * MCP Tools Server — Knowledge Search Backend
 * 
 * Lightweight MCP (Model Context Protocol) server for Second Brain knowledge search.
 * Uses only Node.js stdlib — no npm dependencies required.
 * 
 * Usage: node mcp-tools/server.js [--port 3456]
 */

const http = require('http');
const fs = require('fs');
const path = require('path');
const url = require('url');

// ── Configuration ──
const PORT = (() => {
    // Support both --port 3457 and --port=3457 styles
    for (let i = 2; i < process.argv.length; i++) {
        const arg = process.argv[i];
        if (arg === '--port' && process.argv[i + 1]) return parseInt(process.argv[++i], 10);
        if (arg.startsWith('--port=')) return parseInt(arg.split('=')[1], 10);
    }
    return parseInt(process.env.PORT || '3456', 10);
})();
const PROJECT_ROOT = path.resolve(__dirname, '..');
const DOCS_ROOT = path.join(PROJECT_ROOT, 'docs');

// ── Knowledge Index ──
const index = [];
const categories = {
    tools:        ['tools'],
    project:      ['project', 'project/TICKETS'],
    requirements: ['requirements', 'requirements/TICKETS', 'requirements/MOCK-API'],
    feedback:     ['feedback'],
    simulations:  ['simulations'],
    strategy:     ['strategy'],
    templates:    ['templates'],
    docs:         ['docs', 'dev', 'ci'],
};

/** Scan docs/ and build the in-memory index */
async function buildIndex() {
    const files = new Set();
    
    // Recursively find all .md files under docs/
    function scanDir(dir) {
        if (!fs.existsSync(dir)) return;
        const entries = fs.readdirSync(dir, { withFileTypes: true });
        for (const entry of entries) {
            const fullPath = path.join(dir, entry.name);
            if (entry.isDirectory()) {
                scanDir(fullPath);
            } else if (entry.isFile() && entry.name.endsWith('.md')) {
                // Compute relative path from project root
                const relPath = path.relative(PROJECT_ROOT, fullPath);
                files.add(relPath);
            }
        }
    }
    
    scanDir(DOCS_ROOT);
    
    // Load file contents
    const loaded = [];
    for (const relPath of files) {
        try {
            const fullPath = path.join(PROJECT_ROOT, relPath);
            const content = fs.readFileSync(fullPath, 'utf-8');
            const title = extractTitle(content) || relPath.split('/').pop().replace(/\.md$/, '').replace(/-/g, ' ');
            const category = detectCategory(relPath);
            
            loaded.push({
                path: relPath,
                category,
                title,
                content,
                lineCount: content.split('\n').length,
            });
        } catch (e) {
            console.warn(`[WARN] Failed to load: ${relPath} — ${e.message}`);
        }
    }
    
    index.length = 0;
    index.push(...loaded);
    console.log(`[MCP] Indexed ${index.length} documents across ${Object.keys(categories).length} categories`);
    return index;
}

/** Extract first H1 heading as document title */
function extractTitle(content) {
    const match = content.match(/^#\s+(.+)$/m);
    return match ? match[1].trim() : null;
}

/** Detect category from file path */
function detectCategory(relPath) {
    const parts = relPath.split('/');
    for (const [cat, prefixes] of Object.entries(categories)) {
        if (prefixes.some(p => parts[0] === p || parts.includes(p))) return cat;
    }
    return 'unknown';
}

// ── Search Engine ──

function searchKnowledge(query, options = {}) {
    const q = query.toLowerCase().trim();
    if (!q) return { results: [], query, count: 0 };
    
    const limit = Math.min(Math.max(parseInt(options.limit) || 10, 1), 50);
    const snippetLen = parseInt(options.snippet_length) || 120;
    const catFilter = options.category || 'all';
    
    const files = catFilter === 'all'
        ? index
        : index.filter(f => f.category === catFilter);
    
    const terms = q.split(/\s+/).filter(Boolean);
    const results = [];
    
    for (const file of files) {
        let score = 0;
        const contentLower = file.content.toLowerCase();
        
        for (const term of terms) {
            // Title match = 10x weight
            if (file.title.toLowerCase().includes(term)) score += 10;
            
            // Count content occurrences
            let count = 0;
            let idx = 0;
            while ((idx = contentLower.indexOf(term, idx)) !== -1) {
                count++;
                idx += term.length;
            }
            if (count > 0) score += count;
        }
        
        if (score > 0) {
            results.push({
                title: file.title,
                path: file.path,
                category: file.category,
                score,
                snippet: extractSnippet(file.content, terms[0], snippetLen),
            });
        }
    }
    
    results.sort((a, b) => b.score - a.score);
    return { results: results.slice(0, limit), query, count: results.length };
}

function extractSnippet(content, term, maxLen) {
    const idx = content.toLowerCase().indexOf(term.toLowerCase());
    if (idx === -1) return content.substring(0, maxLen) + '...';
    
    let start = content.lastIndexOf('\n', idx - maxLen / 2);
    start = start === -1 ? 0 : start + 1;
    
    let end = content.indexOf('\n', idx + maxLen);
    end = end === -1 ? content.length : end;
    
    return content.substring(start, end);
}

function listDocuments(options = {}) {
    const catFilter = options.category || 'all';
    let docs = catFilter === 'all'
        ? index
        : index.filter(f => f.category === catFilter);
    
    const sort = options.sort || 'path';
    if (sort === 'title') docs.sort((a, b) => a.title.localeCompare(b.title));
    else if (sort === 'size') docs.sort((a, b) => b.lineCount - a.lineCount);
    else docs.sort((a, b) => a.path.localeCompare(b.path));
    
    return docs.map(d => ({
        path: d.path,
        title: d.title,
        category: d.category,
        size: d.lineCount,
    }));
}

function getDocument(filePath) {
    const file = index.find(f => f.path === filePath);
    if (!file) return { error: `Document not found: ${filePath}` };
    
    return {
        path: file.path,
        title: file.title,
        content: file.content,
        category: file.category,
        lineCount: file.lineCount,
    };
}

// ── MCP Tools Registry ──

const TOOLS = [
    {
        name: 'search_knowledge',
        description: 'Full-text search across knowledge-base markdown documents. Supports keyword search with category filtering and relevance scoring.',
        inputSchema: {
            type: 'object',
            properties: {
                query: {
                    type: 'string',
                    description: 'Search keywords (space-separated for AND logic)',
                },
                category: {
                    type: 'string',
                    enum: ['all', 'tools', 'project', 'requirements', 'feedback', 'simulations', 'strategy', 'templates', 'docs'],
                    description: 'Filter by document category',
                    default: 'all',
                },
                limit: {
                    type: 'integer',
                    description: 'Maximum number of results (1-50)',
                    default: 10,
                },
                snippet_length: {
                    type: 'integer',
                    description: 'Snippet character length',
                    default: 120,
                },
            },
            required: ['query'],
        },
    },
    {
        name: 'list_documents',
        description: 'List all indexed documents, optionally filtered by category. Useful for browsing the knowledge base.',
        inputSchema: {
            type: 'object',
            properties: {
                category: {
                    type: 'string',
                    enum: ['all', 'tools', 'project', 'requirements', 'feedback', 'simulations', 'strategy', 'templates', 'docs'],
                    description: 'Filter by document category',
                    default: 'all',
                },
                sort: {
                    type: 'string',
                    enum: ['path', 'title', 'size'],
                    description: 'Sort order',
                    default: 'path',
                },
            },
        },
    },
    {
        name: 'get_document',
        description: 'Retrieve the full content of a specific markdown document by its relative path.',
        inputSchema: {
            type: 'object',
            properties: {
                path: {
                    type: 'string',
                    description: 'Relative path from project root (e.g., docs/tools/CLI-CHEATSHEET.md)',
                },
            },
            required: ['path'],
        },
    },
];

// ── JSON-RPC Server ──

const server = http.createServer(async (req, res) => {
    const parsed = url.parse(req.url, true);
    const method = req.method;
    
    // ── Health Check ──
    if (parsed.pathname === '/health') {
        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({
            status: 'ok',
            indexedDocuments: index.length,
            categories: Object.keys(categories).length,
            timestamp: new Date().toISOString(),
        }));
        return;
    }
    
    // ── MCP Endpoint ──
    if (parsed.pathname !== '/mcp') {
        res.writeHead(404, { 'Content-Type': 'text/plain' });
        res.end('MCP Tools Server\nEndpoints: GET /health, POST /mcp');
        return;
    }
    
    // ── Handle POST JSON-RPC requests ──
    if (method !== 'POST') {
        res.writeHead(405, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ jsonrpc: '2.0', id: null, error: { code: -32000, message: 'Method not allowed' } }));
        return;
    }
    
    let body = '';
    for await (const chunk of req) {
        body += chunk;
    }
    
    let request;
    try {
        request = JSON.parse(body);
    } catch (e) {
        res.writeHead(400, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ jsonrpc: '2.0', id: null, error: { code: -32700, message: 'Parse error' } }));
        return;
    }
    
    // ── Route to handler ──
    let result;
    try {
        result = await handleRequest(request);
    } catch (e) {
        result = {
            jsonrpc: '2.0',
            id: request.id,
            error: { code: -32603, message: e.message || 'Internal error' },
        };
    }
    
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify(result));
});

async function handleRequest(request) {
    const { jsonrpc, method, params, id } = request;
    
    switch (method) {
        case 'initialize':
            return {
                jsonrpc: '2.0',
                id,
                result: {
                    protocolVersion: '2024-11-05',
                    capabilities: { tools: {} },
                    serverInfo: { name: 'mcp-knowledge-server', version: '1.0.0' },
                },
            };
        
        case 'tools/list':
            return {
                jsonrpc: '2.0',
                id,
                result: { tools: TOOLS },
            };
        
        case 'tools/call': {
            const { name, arguments: args } = params || {};
            const tool = TOOLS.find(t => t.name === name);
            
            if (!tool) {
                return {
                    jsonrpc: '2.0',
                    id,
                    error: { code: -32601, message: `Tool not found: ${name}` },
                };
            }
            
            // Execute tool handler
            let output;
            switch (name) {
                case 'search_knowledge':
                    output = searchKnowledge(args.query, args || {});
                    break;
                case 'list_documents':
                    output = { documents: listDocuments(args || {}) };
                    break;
                case 'get_document':
                    output = getDocument(args.path);
                    break;
                default:
                    output = { error: `Unknown tool: ${name}` };
            }
            
            return {
                jsonrpc: '2.0',
                id,
                result: {
                    content: [{ type: 'text', text: JSON.stringify(output, null, 2) }],
                    isError: !!output.error,
                },
            };
        }
        
        default:
            return {
                jsonrpc: '2.0',
                id,
                error: { code: -32601, message: `Method not found: ${method}` },
            };
    }
}

// ── Boot ──

async function main() {
    console.log(`[MCP] Starting knowledge search server...`);
    console.log(`[MCP] Project root: ${PROJECT_ROOT}`);
    console.log(`[MCP] Docs root: ${DOCS_ROOT}`);
    
    try {
        await buildIndex();
        
        server.listen(PORT, () => {
            console.log(`[MCP] Server listening on http://localhost:${PORT}`);
            console.log(`[MCP] MCP endpoint: http://localhost:${PORT}/mcp`);
            console.log(`[MCP] Health check: http://localhost:${PORT}/health`);
            console.log(`[MCP] Type Ctrl+C to stop`);
        });
    } catch (e) {
        console.error(`[MCP] Failed to start: ${e.message}`);
        process.exit(1);
    }
}

main();
