# BALSONS ERP & PAYROLL 2026 — Backup & Recovery

| Field | Value |
|---|---|
| Document ID | BAL-BK-001 |
| Version | 0.1.0-DRAFT |
| Status | PROPOSED |

---

## 1. Objectives

Protect the authoritative Excel workbook, application configuration, audit records, and release artifacts against loss or corruption.

---

## 2. What Must Be Backed Up

| Asset | Priority | Notes |
|---|---|---|
| Master Excel workbook (`.xlsx`/`.xlsm`) | Critical | Include VBA |
| `balsons_data.js` last-good export | High | |
| Application configuration | High | |
| Audit logs | High | |
| User/role store | High | |
| Release manifests | Medium | |

---

## 3. Backup Principles

1. Backup before any write-back, unlock, restore, or major sync.  
2. Backup packages written under controlled `backup/` path or admin-selected allow-listed location.  
3. Backup/restore are **protected functions** (System Administrator).  
4. Every backup/restore audited.  
5. Never commit production payroll data backups to public git by default.

---

## 4. Recovery Procedures (outline)

1. Verify backup integrity (checksum).  
2. Confirm authorization.  
3. Quiesce application usage.  
4. Restore workbook + app config + audit as selected.  
5. Re-run `ExportPortalDataDirectly`.  
6. Validate structure + sample payroll totals.  
7. Audit recovery event.  
8. Resume operations.

---

## 5. Drill Requirement

At least one restore drill must pass before production release (UAT-11).

---

## 6. Open Decisions

- Encryption of backup packages  
- Retention schedule  
- Whether backups include IndexedDB export  
