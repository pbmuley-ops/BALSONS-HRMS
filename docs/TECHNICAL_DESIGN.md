# BALSONS ERP & PAYROLL 2026 — Technical Design

| Field | Value |
|---|---|
| Document ID | BAL-TD-001 |
| Version | 0.1.0-DRAFT |
| Status | DRAFT SKELETON — full TD after Architecture Review + workbook freeze |

---

## 1. Relationship to Architecture

This document will specify concrete module contracts, APIs, IndexedDB schema, event bus, and error model. **Full technical design is intentionally incomplete** until:

1. Architecture Review approval  
2. Workbook binary inspection freezes mappings/formulas  
3. VBA/`balsons_data.js` schema is captured  

---

## 2. Planned JS Packages

| Path | Responsibility |
|---|---|
| `js/core/` | App bootstrap, event bus, logging, error boundaries |
| `js/services/` | Employee, Attendance, Payroll, Slips, Reports, Audit, Config, Backup |
| `js/validation/` | Shared validators + workbook structure rules |
| `js/state/` | In-memory store + persistence adapters (no UI access to IDB) |
| `js/bridge/` | `balsons_data.js` loader, sync orchestration |
| `js/modules/` | Feature orchestration only (no payroll formulas) |
| `js/reports/` | Report builders |
| `js/utilities/` | Pure helpers |

---

## 3. IndexedDB (planned stores)

| Store | Contents | SoR? |
|---|---|---|
| `preferences` | Theme, UI prefs | No |
| `session` | Session metadata | No |
| `drafts` | Uncommitted form drafts | No |
| `cache_sync` | Last-good validated payload snapshot | Cache only |
| `audit_buffer` | Pending audit flush | App audit |

**Not stored as SoR:** employee master, finalized payroll totals.

---

## 4. Service API Shape (illustrative)

```text
EmployeeService.list()
EmployeeService.get(code)
EmployeeService.save(dto) → validate → authz → write → sync → audit

PayrollService.getMonth(monthKey)
PayrollService.transition(monthKey, from, to)
PayrollService.finalize(monthKey)
PayrollService.unlock(monthKey, reason)
```

Illustrative only — finalize after TD workshop.

---

## 5. Error Model (planned)

| Code | Meaning |
|---|---|
| VAL_001 | Validation failure |
| AUTH_001 | Unauthenticated |
| AUTHZ_001 | Unauthorized |
| SYNC_001 | Bridge/payload failure |
| XLS_001 | Workbook structure failure |
| PAY_001 | Illegal payroll state transition |

---

## 6. Next TD Tasks

1. Freeze `EMPLOYEE_COLUMNS` remaining keys  
2. Capture formula catalogue  
3. Document real VBA signatures  
4. Define IDB schema versions + migrations  
5. Define print template binding algorithm  
