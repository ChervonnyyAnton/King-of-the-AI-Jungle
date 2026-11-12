# 📂 Sandbox Project Documentation

## 🏗 Project Architecture
The "Configurable PDF Generator" is a lightweight, client-side web application designed to demonstrate configuration management and dynamic content rendering.

### Tech Stack
*   **Frontend:** Vanilla HTML5, CSS3, ES6 JavaScript.
*   **State Management:** DOM-based (Direct manipulation).
*   **Persistence:** In-memory (Session only). No local storage or backend.
*   **Data Format:** JSON (for Import/Export).

### Folder Structure
*   `/mock/`: The deployed application (`index.html`).
*   `/docs/`: Project documentation, tickets, and requirements.

---

## 🚀 Deployment
This is a static site. It can be deployed to any static hosting provider (GitHub Pages, Netlify, Vercel) or run locally via `npx serve` or simply by opening the file in a browser.

```bash
# To run locally
npx serve mock/
```

---

## ⚠️ Known Limitations
1.  **Security:** JSON import is client-side only. In a production environment, the parsing logic must be strictly sanitized to prevent XSS attacks.
2.  **Performance:** Large bodies of text (>10MB) may cause UI freezing in the Preview pane.
3.  **Browser Compatibility:** CSS `@media print` is used for PDF generation. Compatibility is high (Chrome, Firefox, Safari), but Edge may require specific print settings.
