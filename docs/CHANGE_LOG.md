# BALSONS ERP & PAYROLL 2026 — Change Log

All notable project changes are recorded here.

## [0.2.0-DRAFT] — 2026-08-12

### Added

- `docs/SYSTEM_SPECIFICATION.md` — ingested from uploaded INSTRUCTIONS (tab-by-tab, UI, ops, Excel binding)

### Changed

- `docs/EXCEL_MAPPING.md` — workbook name, F–Q demographics list, month naming variants, co-location rule, VBA `modBridgeEngine`
- `docs/DATA_DICTIONARY.md` — employee demographics, attendance UI fields, dashboard aggregates, document types
- `docs/ARCHITECTURE.md` — portal tab map, runtime co-location packaging
- `docs/UI_UX_SPEC.md` — glassmorphism/shell from spec; Bootstrap vs tech-lock decision
- `docs/EXCEL_BRIDGE_DESIGN.md` — operator ALT+F8 workflow, row scan rules
- `docs/PROJECT_INITIALIZATION_REPORT.md` — status refresh after spec ingest
- `docs/BEDS_COMPLIANCE_MATRIX.md` — APP/UI statuses adjusted (still 0 PASS)

### Notes

- Workbook binary and BEDS primary text still missing
- Open issue: 13 demographic fields listed for columns F–Q (12 columns)

## [0.1.0-DRAFT] — 2026-08-12

### Added

- `docs/PROJECT_INITIALIZATION_REPORT.md`
- `docs/ARCHITECTURE.md`
- `docs/DATA_DICTIONARY.md`
- `docs/EXCEL_MAPPING.md`
- `docs/SECURITY_DESIGN.md`
- `docs/BEDS_COMPLIANCE_MATRIX.md`
- `docs/EXCEL_BRIDGE_DESIGN.md`
- `docs/UI_UX_SPEC.md`
- `docs/TEST_PLAN.md`
- `docs/UAT_PLAN.md`
- `docs/PROJECT_CHARTER.md`
- `docs/BRD.md`
- `docs/SRS.md`
- `docs/NFR.md`
- `docs/TECHNICAL_DESIGN.md`
- `docs/BACKUP_RECOVERY.md`
- `docs/USER_MANUAL.md`
- `docs/ADMIN_MANUAL.md`
- `docs/DEVELOPER_GUIDE.md`
- `docs/INSTALLATION_GUIDE.md`
- `docs/RELEASE_NOTES.md`
- `docs/CHANGE_LOG.md`
- Scaffold directories: `tests/*`, `excel/`, `assets/`, `backup/`, `reports/`, `release/`
- `scripts/cloud-agent-install.sh`

### Notes

- Workspace audit found greenfield repo (README only).
- Workbook and BEDS primary sources missing — mapping marked PARTIAL/BLOCKED where applicable.
- No PASS claims for BEDS compliance.
