# 📄 DOC-123: PDF Export Implementation Spec

**Page Type:** Technical Specification  
**Target Audience:** Developers, QA Engineers  

---

## 1. Overview
This document outlines the technical requirements for the PDF Export feature in WieKalk.

## 2. Technical Constraints
- **Library:** Use `react-pdf` for generation.
- **API:** New endpoint `/api/v1/reports/export/pdf` required.
- **Backend:** Use `itext7` (Java) for server-side rendering for large files, or client-side `jspdf` for small files.

## 3. Data Structure
The PDF data is fetched via:
```json
POST /api/v1/reports/export/pdf
{
  "filters": { "dateFrom": "...", "dateTo": "...", "status": "APPROVED" },
  "format": "A4",
  "orientation": "portrait"
}
```

## 4. QA Checklist for Developers
- [ ] Unit tests for the PDF generation service.
- [ ] Integration test for the API endpoint.
- [ ] Verify PDF is not password protected.
