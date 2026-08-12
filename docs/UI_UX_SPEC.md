# BALSONS ERP & PAYROLL 2026 — UI / UX Specification

| Field | Value |
|---|---|
| Document ID | BAL-UI-001 |
| Version | 0.1.0-DRAFT |
| Status | PROPOSED — no UI implementation in this phase |
| Layout system | Native CSS Grid / Flexbox only |

---

## 1. Brand

| Token | Value |
|---|---|
| Primary Teal | `#0096A6` |
| Secondary Red | `#E03C42` |
| Application name | BALSONS ERP & PAYROLL 2026 |

Brand must be a clear enterprise signal in the shell (sidebar/header), without overpowering operational density of payroll screens.

---

## 2. Theme

| Mode | Requirement |
|---|---|
| Light mode | Default enterprise light surface |
| Dark mode | Supported |
| Persistence | Theme preference persisted (local preference store via state/local services — not UI→IndexedDB direct) |
| Switch performance | ≤ 0.5 sec target |

Define CSS variables in future `css/tokens.css` for colors, spacing, typography, elevation, focus rings.

Avoid: purple-on-white AI clichés, Bootstrap look, excessive glow, emoji ornamentation.

---

## 3. Information Architecture (shell)

```text
┌──────── Sidebar ────────┬──────── Main ─────────────────────┐
│ Brand / App name        │ Breadcrumbs                       │
│ Nav by module group     │ Page title + Quick actions        │
│                         │ Content (module view)             │
│ Collapse control        │                                   │
└─────────────────────────┴───────────────────────────────────┘
 Global: Search | Notifications | Theme | User menu
```

### Module groups (nav)

1. Command Center  
2. Workforce  
3. Statutory  
4. Reports  
5. Administration  
6. System  

Visibility filtered by RBAC (hide + server/service deny).

---

## 4. Core UX Patterns

| Pattern | Usage |
|---|---|
| KPI cards | Dashboard only — concise metrics |
| Action Center list | Pending approvals / unlocks / sync issues |
| Responsive tables | Employee, attendance, payroll grids; sticky headers |
| Forms | Accessible labels, errors inline, required markers |
| Dialogs | Confirm destructive / finalize / unlock (reason field) |
| Empty states | Clear next action (e.g., “Run Excel export”) |
| Toasts | Non-blocking success/failure; audit-critical errors modal |

Cards: use for interactive containers where needed; avoid decorative card sprawl.

---

## 5. Accessibility

- Keyboard navigation for nav, tables, dialogs
- Visible focus states
- Sufficient contrast in light and dark themes
- Form fields associated with labels
- Do not rely on color alone for status (combine text/icons sparingly)

---

## 6. Typography & Motion

- Purposeful enterprise typography via **local** font files under `assets/vendor/` or `assets/` (no CDN)
- Motion: 2–3 subtle transitions max (theme switch, sidebar collapse, dialog) — no distraction

---

## 7. Print / PDF

| Artifact | Layout |
|---|---|
| Salary slips | A4, `css/print.css` |
| HR documents | A4 |
| Tabular reports | Print-optimized tables |

Mechanism: Browser Print → PDF. Exact slip geometry follows `PAYLIP TEMPLATE` after workbook inspection — **do not invent layout that conflicts with template fields**.

---

## 8. Responsive Behavior

| Viewport | Behavior |
|---|---|
| Desktop | Sidebar expanded default |
| Tablet | Collapsible sidebar |
| Narrow | Priority tables horizontally scroll; sticky first columns where needed |

Must load properly on desktop and mobile for operational viewing; primary payroll entry assumed desktop.

---

## 9. CSS File Plan (future implementation)

| File | Role |
|---|---|
| `tokens.css` | Brand, theme variables |
| `base.css` | Reset, typography, elements |
| `layout.css` | Shell grid, sidebar, breadcrumbs |
| `components.css` | Buttons, tables, forms, dialogs |
| `modules.css` | Module-specific layout hooks |
| `print.css` | A4 slips/reports |

**No Bootstrap. No jQuery UI.**

---

## 10. Charts

Chart.js from local vendor bundle for dashboard/analytics. Defer render until visible. Respect offline requirement.

---

## 11. Explicit Non-Goals This Phase

- Building final UI
- Placeholder screens with fake payroll numbers
- Introducing component frameworks

---

## 12. Acceptance Hooks (for later UAT)

- Brand colors present
- Theme persists across reload
- Sidebar module map matches architecture
- Keyboard reachability of primary actions
- Salary slip prints on A4 without clipping critical fields
- Unauthorized modules not usable
