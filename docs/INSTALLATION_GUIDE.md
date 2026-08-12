# BALSONS ERP & PAYROLL 2026 — Installation Guide

| Field | Value |
|---|---|
| Document ID | BAL-INS-001 |
| Version | 0.1.0-DRAFT |
| Status | OUTLINE — pending build artifacts |

---

## 1. Prerequisites

- Microsoft Excel with VBA/macros policy allowing the master workbook  
- Modern browser with IndexedDB and print support  
- Local copy of application files (no dependency on internet for core ops)  
- Authoritative workbook supplied by Payroll Owner  

## 2. Package Layout (target)

See Architecture project structure (`index.html`, `css/`, `js/`, `assets/vendor/`, `excel/`, `docs/`, etc.).

## 3. Installation Steps (planned)

1. Obtain approved release package from `release/`.  
2. Verify checksums.  
3. Place files on local workstation or controlled internal share.  
4. Place/confirm master workbook path per Admin policy.  
5. Ensure vendor libraries exist under `assets/vendor/` (SheetJS, Chart.js, fonts).  
6. Run Excel `ExportPortalDataDirectly` to generate `balsons_data.js`.  
7. Open `index.html` via approved method (file or local web server policy TBD).  
8. Create/bootstrap admin per SECURITY_DESIGN (no committed password).  
9. Configure roles and users.  
10. Run smoke + offline checks.

## 4. Offline Verification

Disable network and confirm login, navigation, and last-good data views operate.

## 5. Uninstall / Rollback

Restore previous release package + workbook backup; see BACKUP_RECOVERY.

## 6. Open Decisions

- Whether a local static server is required vs `file://` constraints for modules  
- Workbook storage path standard for the organization  
