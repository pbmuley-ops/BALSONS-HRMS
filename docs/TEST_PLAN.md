# BALSONS ERP & PAYROLL 2026 — Test Plan

| Field | Value |
|---|---|
| Document ID | BAL-TEST-001 |
| Version | 0.1.0-DRAFT |
| Status | PROPOSED |
| Rule | Full suite re-run every release (regression) |

---

## 1. Objectives

Verify functional correctness, Excel bridge integrity, validation, security, performance, and offline behavior before any production release (BEDS-SDLC).

---

## 2. Test Levels & Folders

| Level | Folder | Focus |
|---|---|---|
| Functional | `tests/functional/` | CRUD and module behaviors |
| Integration | `tests/integration/` | HTML↔bridge↔Excel, slips, reports |
| Validation | `tests/validation/` | Invalid/duplicate/structure cases |
| Security | `tests/security/` | AuthZ, locks, admin protection |
| Performance | `tests/performance/` | NFR targets |
| Offline | `tests/offline/` | No internet / no CDN |
| Regression | `tests/regression/` | Prior defects + full suite wrapper |

**This phase creates strategy and folders only — no fake passing tests.**

---

## 3. Functional Tests

| ID | Area | Scenario |
|---|---|---|
| F-EMP-01 | Employee | Create valid employee → appears after sync |
| F-EMP-02 | Employee | Update fields without shifting columns |
| F-EMP-03 | Employee | Soft status change via column AZ |
| F-ATT-01 | Attendance | Enter attendance for open month |
| F-ATT-02 | Attendance | Review workflow transition |
| F-PAY-01 | Payroll | Calculation reflects workbook values/formulas |
| F-PAY-02 | Payroll | Review → approval → finalize |
| F-PAY-03 | Payroll | Unlock requires auth + reason |
| F-SLIP-01 | Salary slips | Generate slip from template mapping |
| F-SLIP-02 | Salary slips | Print A4 / PDF |
| F-HR-01 | HR documents | Substitution generation |
| F-RPT-01 | Reports | Attendance / payroll / OT / advances / PF / ESIC |
| F-CFG-01 | Settings | Config change audited |

---

## 4. Integration Tests

| ID | Scenario |
|---|---|
| I-01 | HTML loads `balsons_data.js` produced by `ExportPortalDataDirectly` |
| I-02 | Bridge rejects structurally invalid workbook export |
| I-03 | Employee sync round-trip integrity |
| I-04 | Month + payroll sync consistency |
| I-05 | Payroll → salary slip field consistency |
| I-06 | Payroll → statutory reports consistency |
| I-07 | Write-back → re-export → verify |

---

## 5. Validation Tests

| ID | Scenario | Expected |
|---|---|---|
| V-01 | Invalid employee required fields | Reject |
| V-02 | Duplicate employee code | Reject |
| V-03 | Invalid attendance values | Reject |
| V-04 | Invalid OT | Reject |
| V-05 | Invalid advance | Reject |
| V-06 | Invalid / missing workbook structure | Reject sync |
| V-07 | Missing statutory information where required | Reject finalize |
| V-08 | Employee code not in master referenced by month | Reject |

---

## 6. Security Tests

| ID | Scenario |
|---|---|
| S-01 | Unauthenticated access to modules denied |
| S-02 | Viewer cannot finalize payroll |
| S-03 | Operator cannot manage users/roles |
| S-04 | Unlock without reason denied |
| S-05 | Unlock with reason audited (USER/ROLE/TIMESTAMP/MONTH/REASON/ACTION) |
| S-06 | Configuration protected |
| S-07 | Excel write-back permission enforced |
| S-08 | No hardcoded production passwords in repo |

---

## 7. Performance Tests

Measure against NFR targets:

| Metric | Target |
|---|---|
| Startup | ≤ 3s |
| Dashboard | ≤ 2s |
| Module navigation | ≤ 1s |
| Record save | ≤ 2s |
| Search | ≤ 2s |
| Report generation | ≤ 10s |
| Theme change | ≤ 0.5s |
| Excel import 10k rows | ≤ 15s |
| Excel export 10k rows | ≤ 15s |

Also: large employee lists, large month sheets, payroll calculation timing, sync timing.

---

## 8. Offline Tests

| ID | Condition | Expected |
|---|---|---|
| O-01 | Internet ON | Core ops work |
| O-02 | Internet OFF | Core ops work |
| O-03 | Wi-Fi OFF | Core ops work |
| O-04 | External CDN blocked | App still works (local vendors) |
| O-05 | Missing vendor file | Fail closed with clear error |

---

## 9. Regression

Every release:

1. Re-run full suite
2. Add cases for each fixed defect
3. Record results under `release/`

---

## 10. Entry / Exit Criteria

**Entry:** Frozen Excel mapping for scope under test; build under tech lock; test data workbook copy.

**Exit:** Zero open Critical/High defects for release scope; security + performance + offline + UAT gates signed; BEDS release approval recorded.

---

## 11. Traceability

Map each test ID to SRS/BRD requirements and BEDS controls when those documents are finalized against primary sources.
