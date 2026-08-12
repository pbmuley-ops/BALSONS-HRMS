# BALSONS ERP & PAYROLL 2026 — Software Requirements Specification (SRS)

| Field | Value |
|---|---|
| Document ID | BAL-SRS-001 |
| Version | 0.1.0-DRAFT |
| Status | DRAFT — workbook/spec files pending |

---

## 1. Product Perspective

Browser-based offline enterprise application integrated with a local Microsoft Excel master workbook via VBA bridge and `balsons_data.js`.

## 2. Functional Requirements

### 2.1 Command Center
- FR-CC-01 Dashboard KPIs and period status  
- FR-CC-02 Action Center queue  
- FR-CC-03 Notifications  

### 2.2 Workforce
- FR-WF-01 Employee CRUD via services + Excel mapping  
- FR-WF-02 Attendance entry/review for month sheets  
- FR-WF-03 Payroll calculation review (workbook-driven)  
- FR-WF-04 Salary slip generation from `PAYLIP TEMPLATE` mapping  
- FR-WF-05 HR document generation  

### 2.3 Statutory
- FR-ST-01 PF views/reports  
- FR-ST-02 ESIC views/reports  
- FR-ST-03 Compliance checklist/reporting  

### 2.4 Reports
- FR-RP-01..07 Attendance, Payroll, Salary, OT, Advances, PF/ESIC, Management Analytics  

### 2.5 Administration
- FR-AD-01 Users  
- FR-AD-02 Roles / permissions  
- FR-AD-03 Configuration  
- FR-AD-04 Excel Sync controls  
- FR-AD-05 Audit viewer  
- FR-AD-06 Backup / Restore  

### 2.6 System
- FR-SY-01 Global search  
- FR-SY-02 Help  
- FR-SY-03 About  

### 2.7 Bridge & Validation
- FR-BR-01 Load/validate `balsons_data.js`  
- FR-BR-02 Employee/Month/Payroll sync  
- FR-BR-03 Authorized write-back + verification  
- FR-VAL-01 Reusable validation engine covering required/type/range/duplicate/xref/structure/payroll/config rules  

### 2.8 Payroll lifecycle
- FR-PL-01 States: OPEN → … → MONTH CLOSED  
- FR-PL-02 Finalize lock  
- FR-PL-03 Unlock with USER/ROLE/TIMESTAMP/MONTH/REASON/ACTION audit  

## 3. Data Requirements

See `DATA_DICTIONARY.md` and `EXCEL_MAPPING.md`.

## 4. External Interfaces

- VBA / Excel workbook  
- Browser print subsystem  
- Local filesystem for backup packages (policy-bound)  

## 5. Constraints

Technology lock; zero-CSV; exact Excel names/columns; no invented formulas; BEDS gates.

## 6. Requirement Status Legend

Many FRs remain **UNSPECIFIED IN DETAIL** until workbook and SYSTEM SPECIFICATION files are ingested.
