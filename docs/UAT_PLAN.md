# BALSONS ERP & PAYROLL 2026 — UAT Plan

| Field | Value |
|---|---|
| Document ID | BAL-UAT-001 |
| Version | 0.1.0-DRAFT |
| Status | PROPOSED |

---

## 1. Purpose

Formal User Acceptance Testing by business owners before production release (BEDS-GOV / BEDS-SDLC).

---

## 2. Participants (roles)

| Role | UAT focus |
|---|---|
| HR Manager | Employee master, HR documents, attendance |
| Payroll Manager | Payroll lifecycle, slips, statutory |
| Manager / Supervisor | Reviews, limited approvals |
| System Administrator | Users, roles, sync, backup |
| Auditor | Audit trail readability / completeness |
| Product Owner | Overall acceptance |

---

## 3. UAT Environment

- Offline-capable workstation
- Authoritative workbook **copy** (never UAT directly on sole production file without backup)
- Application build from `release/` candidate
- Local vendor assets present
- Test users for each required role

---

## 4. UAT Scenarios

| ID | Scenario | Pass criteria |
|---|---|---|
| UAT-01 | Login as each role; verify module visibility | Matches RBAC matrix |
| UAT-02 | Sync from Excel export | Employees/months load correctly |
| UAT-03 | Create/update employee in approved flow | Reflects in workbook after write-back/sync |
| UAT-04 | Enter attendance for test month | Values correct; validation blocks bad data |
| UAT-05 | Run payroll review using workbook logic | Totals match Excel |
| UAT-06 | Approve + finalize month | Month locked |
| UAT-07 | Attempt unlock without permission | Denied |
| UAT-08 | Unlock with permission + reason | Audited correctly |
| UAT-09 | Generate & print salary slip | A4; fields match Excel/template |
| UAT-10 | PF/ESIC reports | Accepted by statutory owner |
| UAT-11 | Backup then restore drill | Restored state usable |
| UAT-12 | Offline operation | Core flows work without internet |
| UAT-13 | Theme + navigation usability | Accepted by operators |

---

## 5. Defect Severity for UAT

| Severity | Definition | Release impact |
|---|---|---|
| Critical | Data loss, wrong net pay, security bypass | Block |
| High | Major workflow broken | Block |
| Medium | Workaround exists | Conditional |
| Low | Cosmetic | Optional |

---

## 6. Sign-off

| Gate | Owner | Signature / Date |
|---|---|---|
| HR acceptance | | PENDING |
| Payroll acceptance | | PENDING |
| Admin/security acceptance | | PENDING |
| Product Owner release | | PENDING |

**No production release without UAT sign-off.**
