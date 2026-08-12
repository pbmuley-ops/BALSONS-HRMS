# BALSONS ERP & PAYROLL 2026 — Data Dictionary

| Field | Value |
|---|---|
| Document ID | BAL-DD-001 |
| Version | 0.2.0-DRAFT |
| Status | PARTIAL — enriched from SYSTEM SPECIFICATION; workbook binary PENDING |
| Sources | `docs/SYSTEM_SPECIFICATION.md`, project mandate |
| Rule | Do not invent Excel formulas or unobserved column letters |

---

## 1. Conventions

| Convention | Meaning |
|---|---|
| `PENDING` | Not yet observed in workbook binary |
| `MANDATED` | Required by SYSTEM SPECIFICATION / instructions |
| `APP` | Application-owned (not Excel SoR) |
| `EXCEL` | Authoritative in master workbook |
| `CALC` | Calculated — formula must come from workbook |
| `CONFIG` | Configurable business rule |

Logical names are stable. Physical Excel columns live only in `docs/EXCEL_MAPPING.md` and mapping objects.

---

## 2. Employee Entity

**Excel source sheet (mandated):** `EMPLOYEE DATABASE`

### 2.1 Frozen columns

| Logical Field | Type | Required | Source | Excel Column | Notes |
|---|---|---|---|---|---|
| employeeCode | string | Y | EXCEL | A | e.g. `BAL-EMP001` |
| name | string | Y | EXCEL | B | Full Name |
| designation | string/enum | Y | EXCEL | C | `MECH`, `ELE`, `HELPER`, `ADMIN` |
| dateOfJoining | date | Y | EXCEL | D | DOJ |
| mobile | string | Y | EXCEL | E | |
| status | enum | Y | EXCEL | AZ (52) | `Active` / `Inactive` |

### 2.2 Demographic & statutory fields (F–Q range per specification)

| Logical Field | Type | Required | Source | Excel Column | Notes |
|---|---|---|---|---|---|
| gender | string/enum | TBD | EXCEL | F–Q TBD | |
| dateOfBirth | date | TBD | EXCEL | F–Q TBD | DOB |
| maritalStatus | string/enum | TBD | EXCEL | F–Q TBD | |
| fatherName | string | TBD | EXCEL | F–Q TBD | |
| physicallyChallenged | string/boolean | TBD | EXCEL | F–Q TBD | |
| permanentAddress | string | TBD | EXCEL | F–Q TBD | Address |
| city | string | TBD | EXCEL | F–Q TBD | |
| state | string | TBD | EXCEL | F–Q TBD | |
| postalCode | string | TBD | EXCEL | F–Q TBD | |
| pfNumber | string | TBD | EXCEL | F–Q TBD | |
| esiNumber | string | TBD | EXCEL | F–Q TBD | |
| aadharNumber | string | TBD | EXCEL | F–Q TBD | Aadhar Card No |
| grossSalary | number | TBD | EXCEL | F–Q TBD | |

**Open issue DD-01:** Specification lists **13** demographic/statutory fields for columns **F–Q (12 columns)**. Exact letter assignment is blocked until workbook header inspection.

### 2.3 UI surface

Employee Master tab (`#employee-master`) + modal `#employeeModal` bind to these fields. Portal saves must write back to `EMPLOYEE DATABASE` rows (no CSV).

---

## 3. Monthly Attendance Entity

**Excel source:** discovered month sheets with year identifiers (examples: `MAY-26`, `JUNE 26`)

| Logical Field | Type | Required | Source | UI Binding | Notes |
|---|---|---|---|---|---|
| monthKey | string | Y | EXCEL sheet name | Month selector | Exact name; do not normalize |
| employeeCode | string | Y | EXCEL | Row identity | Active employees in grid |
| presentDays | number | Y | EXCEL | Present Days | |
| weeklyOffs | number | N | EXCEL | WO | |
| paidLeaves | number | N | EXCEL | PL | |
| overtimeHours | number | N | EXCEL | OT Hours | |
| advanceAmount | number | N | EXCEL | Advances (₹) | |
| reviewStatus | enum | APP/EXCEL | PENDING | Lifecycle | |

Full Excel column letters: **PENDING** workbook audit.

---

## 4. Payroll Entity

Computed by Excel formulas when “Compute Payroll” runs. HTML register preview columns:

| Logical Field | Category | Source | Formula Status |
|---|---|---|---|
| employeeCode | Key | EXCEL | |
| name | Display | EXCEL | |
| payableDays | Attendance-derived | EXCEL/CALC | PENDING |
| basic | Earnings | EXCEL/CALC | PENDING |
| hra | Earnings | EXCEL/CALC | PENDING |
| da | Earnings | EXCEL/CALC | PENDING |
| totalEarnings | Aggregate | EXCEL/CALC | PENDING |
| pf | Deduction | EXCEL/CALC | PENDING |
| esic | Deduction | EXCEL/CALC | PENDING |
| advance | Deduction | EXCEL | PENDING |
| totalDeductions | Aggregate | EXCEL/CALC | PENDING |
| netPayable | Aggregate | EXCEL/CALC | PENDING |
| monthKey | Key | EXCEL | |
| payrollStatus | Lifecycle | APP (+ Excel flag if present) | See §8 |

**Rule:** Do not invent formulas where workbook formulas already define business logic.

---

## 5. Dashboard Aggregates (APP derived from Excel data)

| Metric | Definition (spec) |
|---|---|
| employeesActive / total | Active workforce count alongside total records |
| payrollCost | Total net payable (₹) |
| attendanceEfficiency | Overall attendance % |
| otSummary | Cumulative OT hours |
| pfEsicSummary | Combined statutory deductions |
| payrollTrend12m | Last 12 months cost series (Chart.js) |
| departmentDistribution | Counts for MECH / ELE / HELPER / ADMIN |

---

## 6. HR Document Entity

| Logical Field | Type | Source | Notes |
|---|---|---|---|
| documentType | enum | CONFIG | appointment, joining, ctcAnnexure, salarySlip, experience, relieving, noDue, idCard |
| generationMode | enum | APP | Individual / Bulk (All Active) |
| employeeCode | string | Employee | Required for Individual |
| salaryMonth | string | Month sheets | Required for salary slips |
| contentHtml | html | APP template + substitutions | `#documentPrintArea`, `contenteditable` |
| generatedAt | datetime | APP | Audit |
| generatedBy | userId | APP | Audit |

---

## 7. Report Entity

Supported report kinds (spec):

- Attendance Registers
- Wage Registers
- Salary Registers
- Employee Lists
- OT Reports
- Advance Reports
- PF & ESIC Reports

Output: on-screen table + browser-native PDF print — **no CSV**.

---

## 8. Configuration Entity

| Logical Field | Type | Source | Notes |
|---|---|---|---|
| companyName | string | CONFIG | Settings tab |
| registeredAddress | string | CONFIG | |
| contactTelephone | string | CONFIG | |
| contactEmail | string | CONFIG | |
| gstin | string | CONFIG | Statutory placeholder |
| pan | string | CONFIG | |
| pfCode | string | CONFIG | |
| esicCode | string | CONFIG | |
| themeDefault | enum | APP | light/dark via `data-theme` + localStorage preference path |
| rolePermissionMatrix | object | APP | RBAC (BEDS-SEC) |
| syncSettings | object | APP | Bridge paths |

---

## 9. Audit Entity

| Logical Field | Type | Required | Source |
|---|---|---|---|
| auditId | string/uuid | Y | APP |
| timestamp | datetime (ISO) | Y | APP |
| userId | string | Y | Session |
| role | string | Y | Session |
| module | string | Y | APP |
| action | string | Y | APP |
| entityType | string | Y | APP |
| entityKey | string | Y | APP |
| month | string | N | Payroll actions |
| reason | string | Conditional | Unlock required |
| before / after | json | N | Snapshots |
| result | enum | Y | SUCCESS / DENIED / FAILED |
| correlationId | string | Y | Sync / transaction |

Unlock mandatory: USER, ROLE, TIMESTAMP, MONTH, REASON, ACTION.

---

## 10. Sync Payload Entity (`balsons_data.js`)

| Field | Type | Source | Status |
|---|---|---|---|
| employees | array | `EMPLOYEE DATABASE` rows 2..LastRow | Schema PENDING sample |
| months | object/array | Discovered month sheets | PENDING |
| payroll | object/array | Month calc ranges | PENDING |
| config | object | Optional | PENDING |
| meta.exportedAt / version | string | VBA | Recommended |

Generated by `modBridgeEngine` / `ExportPortalDataDirectly`. Zero-CSV.

---

## 11. Month Lifecycle Status Values (APP — BEDS mandate)

| Status | Description |
|---|---|
| OPEN | Month available |
| ATTENDANCE_ENTRY | Entry in progress |
| ATTENDANCE_REVIEW | Under review |
| PAYROLL_CALCULATION | Calculation phase |
| PAYROLL_REVIEW | Review phase |
| APPROVAL | Awaiting approval |
| FINALIZED | Locked; unlock requires authorization |
| SALARY_SLIPS | Slip generation window |
| MONTH_CLOSED | Closed |

---

## 12. Change Control

Any new logical field requires:

1. Update to this dictionary  
2. Update to `EXCEL_MAPPING.md` if Excel-backed  
3. Validation rule  
4. Test case  
5. Changelog entry  

**No silent column shifts.**
