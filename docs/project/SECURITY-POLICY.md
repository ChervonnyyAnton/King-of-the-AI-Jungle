# 🛡️ Security Policy: Sandbox PDF Generator

## ⚠️ Data Handling & Privacy
*   **Client-Side Only:** All data processing happens locally. No data is sent to a server.
*   **Import:** Users can import JSON files. The app must handle malformed JSON gracefully without crashing.
*   **Print:** `window.print()` is used. No data is sent to the browser's print queue (except the visible content).
*   **File Size Limit:** JSON import files should not exceed 5 MB. Large files may freeze the browser tab. The `FileReader` API reads files into memory, so file size directly impacts memory usage.

## 🔐 Security Testing Guidelines (For Risk Analysts)
When auditing `mock/index.html`, consider the following:

### 1. XSS (Cross-Site Scripting)

#### 1.1 Import Feature (MITIGATED)
*   **Risk:** The "Import" feature parses user-uploaded JSON. Historically, this was a concern for XSS if the parsed values were injected into `innerHTML`.
*   **Current Defense:** The import handler uses **explicit type checking** on every field (`typeof raw.header === 'string'`, `Array.isArray(raw.gridData)`) and assigns values via **`.value` on form inputs** (not `innerHTML`). Grid data, when rendered, is escaped via `escapeHtml()`.
*   **Test:** Upload a JSON payload with `<script>alert('XSS')</script>` in the `header` field. Verify the script does NOT execute — it should appear as literal text in the form field.
*   **Status:** ✅ **Mitigated** — type guards + `.value` assignment + `escapeHtml()` on grid rendering.

#### 1.2 Leaderboard Prompt Input (Cycle 215: REMEDIATED)
*   **Risk:** `openAddParticipant()` uses `prompt()` to collect participant name and title. These values were previously rendered directly into `innerHTML` via the leaderboard render function.
*   **Test:** Enter `<img src=x onerror=alert('XSS')>` as a participant name. Verify it renders as literal text, not as executable HTML.
*   **Current Defense:** `escapeHtml()` wraps all participant names and titles in `leaderboardState.render()`.
*   **Status:** ✅ **Remediated in Cycle 215**.

#### 1.3 Collaboration Names (Cycle 215: REMEDIATED)
*   **Risk:** Simulated collaborator names injected via debug mode were rendered directly into `innerHTML`.
*   **Current Defense:** `escapeHtml()` wraps collaborator names in `presenceEl.innerHTML`.
*   **Status:** ✅ **Remediated in Cycle 215**.

#### 1.4 Event History (Cycle 215: REMEDIATED)
*   **Risk:** Session replay event names and timestamps from `recordSessionEvent()` were rendered into `innerHTML` without escaping.
*   **Current Defense:** `escapeHtml()` wraps `e.name` and `e.ts` in `updateHistoryDisplay()`.
*   **Status:** ✅ **Remediated in Cycle 215**.

### 2. Prototype Pollution
*   **Risk:** If the JSON import logic uses a shallow merge (`Object.assign`), a user could pollute `Object.prototype` by importing `{"__proto__": {"isAdmin": true}}`.
*   **Current Defense:** The import handler **does not use** `Object.assign`. It explicitly reads each expected field by name with type checking. Fields not in the expected schema (e.g., `__proto__`) are silently ignored.
*   **Test:** Import a JSON file with `{"__proto__": {"polluted": true}}`. Verify `({}).polluted` is still `undefined`.
*   **Status:** ✅ **Mitigated** — explicit field-by-field extraction, no object spread or merge.

### 3. Content Security Policy (CSP)

#### 3.1 Current CSP Directives (mock/index.html & instructor-dashboard.html)
```
default-src 'self';
script-src 'self' 'unsafe-inline';
style-src 'self' 'unsafe-inline';
img-src 'self' data:;
connect-src 'self';
frame-src 'none';
base-uri 'self';
object-src 'none';
form-action 'self';
```

#### 3.2 Analysis
| Directive | Current | Assessment |
|-----------|---------|------------|
| `default-src` | `'self'` | ✅ Good — blocks all external content by default |
| `script-src` | `'self' 'unsafe-inline'` | ⚠️ `'unsafe-inline'` allows inline `<script>` and `<style>` — needed for no-build-step sandbox but increases XSS surface |
| `style-src` | `'self' 'unsafe-inline'` | ⚠️ Same as above for styles |
| `img-src` | `'self' data:` | ✅ Good — allows inline data URIs for emoji badges |
| `connect-src` | `'self'` | ✅ Good — blocks all external API calls |
| `frame-src` | `'none'` | ✅ Good — prevents iframe injection |
| `base-uri` | `'self'` | ✅ Good — prevents `<base>` tag hijacking |
| `object-src` | `'none'` | ✅ Good — blocks Flash/Java plugins |
| `form-action` | `'self'` | ✅ Good — forms can only submit to same origin |

#### 3.3 Migration Path (Future)
When a build step is added:
1. Generate a nonce for each inline `<script>` block.
2. Replace `'unsafe-inline'` with `'unsafe-inline' 'nonce-{value}'`.
3. Gradually remove `'unsafe-inline'` once all scripts use nonces.

### 4. File Size Limits (New — Cycle 215)
*   **Recommendation:** Enforce a 5 MB file size limit on JSON imports.
*   **Implementation:** Add `if (file.size > 5 * 1024 * 1024) { showToast("File too large. Max 5 MB.", "error"); return; }` in `handleImport()`.
*   **Risk:** Without a limit, a 500 MB JSON file could freeze the browser tab (DoS).
*   **Status:** 📋 Documented — implementation pending.

## 📋 Compliance
*   **GDPR:** No PII (Personally Identifiable Information) is stored. All data remains in-browser (sessionStorage / local state).
*   **Accessibility:** The app uses semantic HTML (`<header>`, `<footer>`) with ARIA labels on dynamic content areas (grid, toasts, leaderboard).
*   **ISO/IEC 27001 A.12.6 (Monitoring):** Debug mode (`?debug=true`) logs session events locally only. No external transmission. Replay data stored in `sessionStorage` and cleared on tab close.
*   **BSI IT-Grundschutz:** Local-only data processing aligns with "client-side only" processing model (COM.1.1.1).
