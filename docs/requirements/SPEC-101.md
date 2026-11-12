# 📄 SPEC-101: PDF Export Technical Spec

**Page Type:** Technical Specification  
**Target Audience:** Developers, QA Engineers  
**Version:** v2.0

---

## 1. Data Schema (JSON)

```json
{
  "meta": "Sandbox Config v2.0",
  "header": "string (max 100 chars)",
  "body": "string (plain text, supports newlines)",
  "footer": "string (max 80 chars)",
  "layout": "enum: ['corporate', 'startup', 'clean']",
  "gridEnabled": "boolean (default: false)",
  "gridData": "array of objects (optional, only when gridEnabled=true)"
}
```

**Grid Data Schema:**
```json
[
  {
    "Item": "string",
    "Status": "enum: ['Pending', 'In Progress', 'Completed']",
    "Owner": "string"
  }
]
```

## 2. UI Constraints
- **Trigger:** Button located in bottom toolbar.
- **Feedback:** Toast notification on success/error.
- **Error Handling:** Graceful fallback to defaults on import failure.
- **Debug Mode:** Append `?debug=true` to URL to see `data-testid` attributes and DOM structure.

## 3. New Features (v2.0)
- **Data Grid:** Toggle-enabled table component with JSON-based data binding.
- **Error Simulation:** "Simulate Failure" button for testing error handling.
- **Enhanced Debug:** Highlights dynamic elements and shows internal state.

## 4. Test Data
Use the following mock payloads:
- `valid_minimal.json`: Only `header` and `layout`.
- `valid_full.json`: All fields populated.
- `valid_with_grid.json`: All fields + grid data.
- `malformed.json`: Missing brackets, invalid enum.
- `injection.json`: HTML/JS in `body` field.
- `invalid_grid.json`: Grid enabled but malformed JSON data.