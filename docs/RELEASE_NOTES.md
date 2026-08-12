# BALSONS ERP & PAYROLL 2026 — Release Notes

| Field | Value |
|---|---|
| Document ID | BAL-REL-001 |
| Version | 0.2.0-DRAFT |
| Status | Documentation update — SYSTEM SPECIFICATION ingested |

---

## Release 0.2.0-DRAFT — 2026-08-12

### Summary

Ingested authoritative SYSTEM SPECIFICATION into `docs/` and refreshed Excel mapping, data dictionary, architecture tab map, UI/UX, and bridge design. **No application runtime implemented.**

### Highlights

- Tab map: Dashboard, Employee Master, Attendance, Payroll, Documents, Reports, Settings
- Workbook name locked: `BALSONS ERP & PAYROLL 2026.xlsm`
- VBA: `modBridgeEngine` / `ExportPortalDataDirectly`
- Open mapping conflict: 13 demographic fields vs columns F–Q (12)
- UI tech decision: prefer native CSS over Bootstrap references in spec

### Still blocked

- Workbook binary
- BEDS v3.0 primary text
- Sample `balsons_data.js` / VBA source
- Logo asset

---

## Release 0.1.0-DRAFT — 2026-08-12

### Summary

Project initialization and architecture documentation package. **No application runtime implemented.**

### Added

- Complete Phase 19 documentation set under `docs/`
- Test category folders under `tests/`
- Reserved directories: `excel/`, `assets/`, `backup/`, `reports/`, `release/`

### Not Included

- UI implementation
- Payroll calculation code
- Fake/placeholder modules

### Next

Architecture Review → Technical Design → Implementation (on instruction)
