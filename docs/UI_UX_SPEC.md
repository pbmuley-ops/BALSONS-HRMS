# BALSONS ERP & PAYROLL 2026 — UI / UX Specification

| Field | Value |
|---|---|
| Document ID | BAL-UI-001 |
| Version | 0.2.0-DRAFT |
| Status | PROPOSED — enriched from SYSTEM SPECIFICATION |
| Layout system | Native CSS Grid / Flexbox (BEDS tech lock) |
| Spec frontend name | `portal.html` |

---

## 1. Brand

| Token | Value |
|---|---|
| Primary Teal | `#0096A6` / `#0096a6` |
| Secondary Red | `#E03C42` / `#e03c42` |
| Logo asset | `BALSONS LOGO MAIN NEW.png` |
| Application name | BALSONS ERP & PAYROLL 2026 |

---

## 2. Design Philosophy (from SYSTEM SPECIFICATION)

- Glassmorphism panels: `.glass-panel` with `backdrop-filter: blur(12px)` over themed backgrounds
- Depth between sidebar and workspace
- Theme engine: `data-theme="light"` | `data-theme="dark"` with persistent preference
- Motion: limited fade/slide (`fadeInUp`) on module switch — do not overuse animation

### Preference persistence note

SYSTEM SPECIFICATION mentions `localStorage` for theme. BEDS architecture forbids **UI code from directly accessing IndexedDB**; localStorage for theme may be acceptable if routed through a small preference/state service (not ad-hoc DOM modules writing storage). Final pattern: Presentation/state service owns persistence.

---

## 3. Shell Layout

| Element | Spec |
|---|---|
| Sidebar `.sidebar` | Fixed 260px desktop; logo; module nav; theme toggle at base |
| Active nav | `border-left: 4px solid var(--balsons-red)` |
| Main `.main-content` | `margin-left: 260px`; padding ~40px |
| Mobile `max-width: 991px` | Sidebar off-canvas; hamburger header |

Also support (BEDS mandate): breadcrumbs, global search, quick actions where they fit without cluttering the first operational viewport.

---

## 4. Tab / Route Map (SYSTEM SPECIFICATION)

| Tab hash | Title | Module group |
|---|---|---|
| `#dashboard` | Dashboard | Command Center |
| `#employee-master` | Employee Master | Workforce |
| `#attendance` | Attendance Management | Workforce |
| `#payroll` | Process Payroll | Workforce |
| `#documents` | HR Documents Generator | Workforce |
| `#reports` | Reports & Analytics | Reports |
| `#settings` | System Settings | Administration |

### Alignment with approved enterprise module map

BEDS module map also includes Statutory, Users/Roles, Excel Sync, Audit, Backup, Search, Help, About. Those remain in architecture as Administration/System modules even if not named as top-level tabs in the tab-by-tab spec — implement as settings subsections or additional nav entries without collapsing security controls.

---

## 5. Component Patterns

| Pattern | Spec detail |
|---|---|
| KPI cards | Dashboard metrics in `.glass-panel` |
| Charts | Chart.js — payroll trend (12m bar), department doughnut |
| Tables | Sticky headers; transparent themed hover |
| Attendance inputs | `.att-input` compact centered |
| Employee modal | `#employeeModal` multi-section form |
| Document pane | `#documentPrintArea` A4-like (~842px min-height), `contenteditable="true"` |
| Dividers | Short red `hr` accent under headings |
| Headings | Bold teal |

---

## 6. Bootstrap Conflict (CRITICAL DECISION)

SYSTEM SPECIFICATION UI section references Bootstrap constructs:

- 12-column Bootstrap grid (`row g-3`)
- Bootstrap table CSS variables (`--bs-table-bg`, `--bs-table-hover-bg`)
- `modal-xl` modal pattern

**BEDS / project tech lock forbids Bootstrap** unless a formal exception is approved. Architecture decision:

| Option | Choice |
|---|---|
| A — Adopt Bootstrap (exception) | Requires documented BEDS exception |
| B — Implement equivalent layouts with native CSS Grid/Flexbox | **Default recommended** — preserve visual intent without Bootstrap dependency |

**Status:** Prefer **Option B** until Product Owner approves an exception. Do not add Bootstrap CDN or packages in implementation without that exception.

---

## 7. Accessibility

- Keyboard navigation for nav, tables, dialogs
- Visible focus states
- Contrast in light and dark themes
- Labelled form fields
- Status not by color alone (Active/Inactive badges include text)

---

## 8. Print / PDF

| Artifact | Mechanism |
|---|---|
| Salary slips & HR documents | `#documentPrintArea` + `window.print()` |
| Reports | On-screen table + browser print |
| Scale | Default / 100% |

CSS: future `css/print.css`. No CSV export path.

---

## 9. CSS File Plan (implementation phase)

| File | Role |
|---|---|
| `tokens.css` | Brand + theme variables (no Bootstrap) |
| `base.css` | Reset, typography |
| `layout.css` | Sidebar / main / mobile drawer |
| `components.css` | Buttons, tables, forms, glass panels, modals |
| `modules.css` | Tab-specific hooks |
| `print.css` | A4 documents/reports |

Vendored fonts only — no runtime CDN.

---

## 10. Explicit Non-Goals Until Implementation Gate

- Building final UI
- Placeholder screens with fake payroll numbers
- Introducing Bootstrap without exception
