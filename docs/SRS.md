# BALSONS ERP & PAYROLL 2026 — Software Requirements Specification (SRS)

| Field | Value |
|---|---|
| Document ID | BAL-SRS-001 |
| Version | 0.2.0-DRAFT |
| Status | DRAFT — SYSTEM SPECIFICATION ingested; workbook binary pending |

---

## 1. Product Perspective

Browser-based offline enterprise application integrated with a local Microsoft Excel master workbook via VBA bridge and `balsons_data.js`.

## 2. Functional Requirements

Primary UI entry: `portal.html` (SYSTEM SPECIFICATION).

### 2.1 Command Center / Dashboard (`#dashboard`)
- FR-CC-01 KPI cards: Employees, Payroll Cost (₹), Attendance %, OT Summary, PF & ESIC Summary  
- FR-CC-02 Payroll Trend chart (last 12 months)  
- FR-CC-03 Department doughnut: MECH / ELE / HELPER / ADMIN  
- FR-CC-04 Action Center queue (BEDS — may be dashboard subsection)  
- FR-CC-05 Notifications  

### 2.2 Workforce
- FR-WF-01 Employee Master (`#employee-master`) search, counter, add, table, `#employeeModal`  
- FR-WF-02 Employee fields include A–E, AZ plus demographic/statutory set (F–Q pending letter freeze)  
- FR-WF-03 Attendance (`#attendance`) month discovery, grid (Present/WO/PL/OT/Advance), Save to Excel, New Month Sheet  
- FR-WF-04 Payroll (`#payroll`) Compute Payroll + register columns per SYSTEM SPEC  
- FR-WF-05 Documents (`#documents`) Individual/Bulk modes; document types per DATA_DICTIONARY; `#documentPrintArea` contenteditable  
- FR-WF-06 Salary slips via Documents with month selector  

### 2.3 Statutory
- FR-ST-01 PF views/reports  
- FR-ST-02 ESIC views/reports  
- FR-ST-03 Compliance / settings statutory codes (GSTIN, PAN, PF Code, ESIC Code)  

### 2.4 Reports (`#reports`)
- FR-RP-01..07 Attendance, Wage, Salary, Employee List, OT, Advances, PF/ESIC — on-screen + print PDF, no CSV  

### 2.5 Administration
- FR-AD-01 Users  
- FR-AD-02 Roles / permissions  
- FR-AD-03 Configuration / Settings (`#settings`) company profile + statutory  
- FR-AD-04 Excel Sync controls  
- FR-AD-05 Audit viewer  
- FR-AD-06 Backup / Restore  

### 2.6 System
- FR-SY-01 Global search  
- FR-SY-02 Help  
- FR-SY-03 About  

### 2.7 Bridge & Validation
- FR-BR-01 Load/validate `balsons_data.js` after `ExportPortalDataDirectly`  
- FR-BR-02 Employee scan rows 2..LastRow; month sheets with year ids  
- FR-BR-03 Authorized write-back + verification (portal → Excel)  
- FR-VAL-01 Reusable validation engine  

### 2.8 Payroll lifecycle
- FR-PL-01 States: OPEN → … → MONTH CLOSED  
- FR-PL-02 Finalize lock  
- FR-PL-03 Unlock with USER/ROLE/TIMESTAMP/MONTH/REASON/ACTION audit  

## 3. Data Requirements

See `DATA_DICTIONARY.md`, `EXCEL_MAPPING.md`, and `SYSTEM_SPECIFICATION.md`.

## 4. External Interfaces

- VBA / Excel workbook (`BALSONS ERP & PAYROLL 2026.xlsm`)  
- Browser print subsystem (`window.print()`)  
- Local filesystem for backup packages (policy-bound)  

## 5. Constraints

Technology lock; zero-CSV; exact Excel names/columns; no invented formulas; BEDS gates; runtime co-location of portal + logo + `balsons_data.js` + workbook.

## 6. Requirement Status Legend

FRs detailed from SYSTEM SPECIFICATION. Formula-level and F–Q column letters remain **UNSPECIFIED** until workbook binary inspection.
