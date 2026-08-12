# BALSONS ERP & PAYROLL 2026 — Project Charter

| Field | Value |
|---|---|
| Document ID | BAL-CHR-001 |
| Version | 0.1.0-DRAFT |
| Status | DRAFT |

---

## 1. Project Name

**BALSONS ERP & PAYROLL 2026**

## 2. Vision

Deliver a BEDS v3.0-compliant, offline-first, Excel-native enterprise ERP & Payroll application that is secure, modular, auditable, testable, performant, maintainable, and formally releasable.

## 3. Problem Statement

Payroll operations require a browser-based enterprise UI while retaining Microsoft Excel as the authoritative payroll data source, with controlled VBA synchronization, zero-CSV exchange, and rigorous governance.

## 4. Objectives

1. Excel-authoritative payroll with VBA bridge (`ExportPortalDataDirectly` → `balsons_data.js`)
2. Modular HTML5/Vanilla JS application under approved technology lock
3. RBAC, audit, payroll lifecycle lock/unlock
4. Offline operation with local vendors
5. Full documentation, testing, UAT, and release approval per BEDS

## 5. In Scope

Command Center, Workforce (Employee, Attendance, Payroll, Slips, HR Docs), Statutory (PF/ESIC/Compliance), Reports, Administration, System modules — as architecture-defined.

## 6. Out of Scope (initial)

- Cloud multi-tenant SaaS rewrite
- Disallowed frameworks/databases without BEDS exception
- Replacing Excel as payroll SoR
- Inventing payroll formulas independent of workbook

## 7. Success Criteria

- Workbook structure preserved (exact sheets/columns)
- Sync without CSV
- Security/performance/offline/UAT gates passed
- BEDS compliance evidence for release controls
- Formal release approval recorded

## 8. Constraints

- Tech lock (HTML5/CSS3/Vanilla JS/SheetJS/IndexedDB/Chart.js/VBA/Excel)
- Offline-first
- Documentation-first / architecture-first
- Greenfield repo currently missing authoritative source files

## 9. Key Stakeholders

| Role | Responsibility |
|---|---|
| Product Owner | Priorities, acceptance |
| Payroll Owner | Formula/workbook authority |
| Security Engineer | AuthZ/audit gates |
| QA Architect | Test/UAT gates |
| Lead Solution Architect | Architecture integrity |

## 10. Delivery Approach

```text
Initialization → Architecture Review → Technical Design → Implementation
→ Verification → UAT → Formal Release
```

Implementation must not start automatically from this charter alone.
