# BALSONS ERP & PAYROLL 2026 — Administrator Manual

| Field | Value |
|---|---|
| Document ID | BAL-ADM-001 |
| Version | 0.1.0-DRAFT |
| Status | OUTLINE |

---

## 1. Administrator Responsibilities

- User and role management  
- Configuration of business/statutory rules  
- Excel sync governance  
- Backup / restore  
- Audit review  
- System maintenance  
- Macro/trust policy for Excel workbook  

## 2. Protected Operations

User/role management, configuration, payroll finalize/unlock oversight, Excel write-back, backup/restore, import/sync, maintenance — require elevated roles (see SECURITY_DESIGN).

## 3. Excel Sync Runbook (planned)

1. Open master workbook.  
2. Ensure structure unchanged.  
3. Run `ExportPortalDataDirectly`.  
4. Confirm `balsons_data.js` refreshed.  
5. Open application; verify sync health.  
6. Investigate validation errors before allowing payroll finalize.

## 4. Unlock Runbook

1. Confirm business necessity.  
2. Ensure actor has permission.  
3. Capture REASON.  
4. Perform unlock.  
5. Verify audit record (USER, ROLE, TIMESTAMP, MONTH, REASON, ACTION).  
6. Re-finalize when complete.

## 5. Backup / Restore

See `BACKUP_RECOVERY.md`.

## 6. Security Hardening Checklist

- No default production passwords  
- Disable unused accounts  
- Review permission matrix quarterly  
- Keep vendor libraries locally and checksummed  
- Restrict access to master workbook file share  

## 7. Note

Expand with environment-specific paths after Installation Guide finalization.
