# BALSONS ERP & PAYROLL 2026

BEDS v3.0-compliant offline-first HTML5 enterprise application, with **Excel as the authoritative payroll data source**, VBA as the controlled Excel bridge, IndexedDB for local application state/cache/drafts only, Vanilla JS service architecture, configurable payroll rules, RBAC, audit, backup/recovery, and reporting.

## Current status

**Initialization / Architecture phase.** Documentation is under `docs/`. Application runtime is **not** implemented yet.

Start here:

- [`docs/PROJECT_INITIALIZATION_REPORT.md`](docs/PROJECT_INITIALIZATION_REPORT.md)
- [`docs/SYSTEM_SPECIFICATION.md`](docs/SYSTEM_SPECIFICATION.md) (authoritative tab/Excel binding instructions)

## Authoritative references

| Reference | Status |
|---|---|
| SYSTEM SPECIFICATION / Instructions | Ingested → `docs/SYSTEM_SPECIFICATION.md` |
| BEDS v3.0 | Still required |
| Workbook `BALSONS ERP & PAYROLL 2026.xlsm` | Still required |
| Logo `BALSONS LOGO MAIN NEW.png` | Still required |

## Technology lock

HTML5 · CSS3 · Vanilla JavaScript ES6+ · SheetJS · IndexedDB · Chart.js · JSON · HTML/CSS Print · VBA · Microsoft Excel

Bootstrap is **not** approved unless a formal BEDS exception is granted (SYSTEM SPEC mentions Bootstrap patterns; architecture prefers native CSS Grid/Flexbox).

## Documentation

See `docs/` for Architecture, Excel Mapping, Security Design, BEDS Compliance Matrix, Test/UAT plans, and manuals.
