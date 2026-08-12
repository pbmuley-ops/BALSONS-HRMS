# BALSONS ERP & PAYROLL 2026 — Non-Functional Requirements (NFR)

| Field | Value |
|---|---|
| Document ID | BAL-NFR-001 |
| Version | 0.1.0-DRAFT |
| Status | PROPOSED |

---

## 1. Performance Targets (must be tested)

| Metric | Target |
|---|---|
| Application startup | ≤ 3 sec |
| Dashboard load | ≤ 2 sec |
| Module navigation | ≤ 1 sec |
| Record save | ≤ 2 sec |
| Search | ≤ 2 sec |
| Report generation | ≤ 10 sec |
| Theme change | ≤ 0.5 sec |
| Excel import 10,000 rows | ≤ 15 sec |
| Excel export 10,000 rows | ≤ 15 sec |

These are **targets**, not assumptions of compliance.

---

## 2. Availability / Offline

- Core operations must work without internet.
- No runtime CDN dependency for required JS/CSS/fonts.
- Test matrix: Internet ON/OFF, Wi-Fi OFF, external resources unavailable.

---

## 3. Security NFRs

- Authentication, session, RBAC, action authz, audit (see SECURITY_DESIGN).
- No hardcoded production passwords.
- Protected functions enforced at service layer.

---

## 4. Usability

- Enterprise shell with sidebar, breadcrumbs, search, quick actions.
- Light/dark themes with persistence.
- Accessible forms, keyboard navigation, focus states.
- A4 print layouts for slips/documents.

---

## 5. Maintainability

- Layered modular structure
- Centralized Excel mapping objects
- Documentation package under `docs/`
- Change log and release notes

---

## 6. Reliability

- Invalid data never committed
- Sync structural validation
- Backup/restore capability
- Verification after write-back

---

## 7. Compatibility

- Modern evergreen browsers supporting ES6+, IndexedDB, print CSS
- Microsoft Excel with VBA for bridge operations (version matrix PENDING)

---

## 8. Capacity (initial planning assumptions — validate in perf tests)

- Employee volumes up to at least 10,000 rows for import/export timing tests
- Multiple month sheets concurrent in workbook

Exact production volume targets PENDING business confirmation.
