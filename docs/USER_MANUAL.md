# BALSONS ERP & PAYROLL 2026 — User Manual

| Field | Value |
|---|---|
| Document ID | BAL-UM-001 |
| Version | 0.1.0-DRAFT |
| Status | OUTLINE — application UI not built yet |

---

## 1. Introduction

This manual will guide business users through Command Center, Workforce, Statutory, Reports, and System features of BALSONS ERP & PAYROLL 2026.

## 2. Getting Started (planned)

1. Ensure Excel export has been run (`ExportPortalDataDirectly`).  
2. Open `index.html` via approved installation method.  
3. Sign in with your assigned role.  
4. Confirm sync status on Dashboard.

## 3. Common Tasks (to be expanded after UI build)

- View dashboard KPIs  
- Search employees  
- Enter / review attendance  
- Review payroll figures (from Excel)  
- Generate salary slips and print to PDF  
- Run standard reports  

## 4. Payroll Status Meanings

See lifecycle in Architecture / Data Dictionary: OPEN → … → MONTH CLOSED.

## 5. Troubleshooting (initial)

| Symptom | Likely cause | Action |
|---|---|---|
| No employee data | Missing/invalid `balsons_data.js` | Run Excel export |
| Cannot finalize | Role or validation failure | Contact Payroll Manager |
| Print clipped | Printer margins | Use A4; check print CSS |

## 6. Note

Detailed screenshots and step lists will be added after UI implementation and UAT.
