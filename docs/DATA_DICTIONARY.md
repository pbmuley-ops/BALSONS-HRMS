# BALSONS ERP & PAYROLL 2026 — Data Dictionary

| Field | Value |
|---|---|
| Document ID | BAL-DD-001 |
| Version | 0.1.0-DRAFT |
| Status | PARTIAL — workbook fields PENDING verification |
| Rule | Do not invent Excel formulas or unobserved columns |

---

## 1. Conventions

| Convention | Meaning |
|---|---|
| `PENDING` | Not yet observed in workbook |
| `MANDATED` | Required by project instructions; must verify |
| `APP` | Application-owned (not Excel SoR) |
| `EXCEL` | Authoritative in master workbook |
| `CALC` | Calculated — formula must come from workbook |
| `CONFIG` | Configurable business rule |

Logical names are stable. Physical Excel columns are maintained only in `docs/EXCEL_MAPPING.md` and mapping objects (`EMPLOYEE_COLUMNS`, etc.).

---

## 2. Employee Entity

**Excel source sheet (mandated):** `EMPLOYEE DATABASE`

| Logical Field | Type | Required | Source | Excel Column | Notes |
|---|---|---|---|---|---|
| employeeCode | string | Y | EXCEL | A | Unique key |
| name | string | Y | EXCEL | B | |
| designation | string | Y | EXCEL | C | |
| dateOfJoining | date | Y | EXCEL | D | Format PENDING |
| mobile | string | Y | EXCEL | E | Validation rules PENDING |
| status | string/enum | Y | EXCEL | AZ | Active/Inactive values PENDING |
| *(additional master fields)* | mixed | TBD | EXCEL | F–AY, BA+ | **PENDING workbook inspection** |

**Constraints (known):**

- Sheet name exactly `EMPLOYEE DATABASE`
- Columns A–E and AZ positions must not be altered, reordered, renamed, or shifted
- Duplicate `employeeCode` must be rejected by validation engine

---

## 3. Monthly Attendance Entity

**Excel source:** month sheets (examples from instructions: `MAY-26`, `JUNE-26`)

| Logical Field | Type | Required | Source | Mapping | Notes |
|---|---|---|---|---|---|
| monthKey | string | Y | EXCEL sheet name | sheet | Pattern PENDING confirmation |
| employeeCode | string | Y | EXCEL | MONTH_COLUMNS | Must exist in employee master |
| attendanceDays / marks | mixed | Y | EXCEL | PENDING | Structure unknown |
| overtimeUnits | number | N | EXCEL | PENDING | |
| leave / absent markers | mixed | N | EXCEL | PENDING | |
| reviewStatus | enum | APP/EXCEL | PENDING | OPEN→REVIEW pipeline | |

**Status:** Full attribute list **BLOCKED** until workbook inspection.

---

## 4. Payroll Entity

Calculated fields required by specification. **Formulas must be extracted from the workbook — not invented.**

| Logical Field | Category | Source | Formula Status |
|---|---|---|---|
| basic | Earnings | EXCEL/CALC | PENDING extraction |
| hra | Earnings | EXCEL/CALC | PENDING |
| da | Earnings | EXCEL/CALC | PENDING |
| taCa | Earnings | EXCEL/CALC | PENDING |
| oa | Earnings | EXCEL/CALC | PENDING |
| lta | Earnings | EXCEL/CALC | PENDING |
| overtimePay | Earnings | EXCEL/CALC | PENDING |
| grossEarnings | Aggregate | EXCEL/CALC | PENDING |
| pf | Deduction | EXCEL/CALC | PENDING |
| esic | Deduction | EXCEL/CALC | PENDING |
| advance | Deduction | EXCEL | PENDING |
| pt | Deduction | EXCEL/CALC | PENDING |
| totalDeductions | Aggregate | EXCEL/CALC | PENDING |
| netPayable | Aggregate | EXCEL/CALC | PENDING |
| monthKey | Key | EXCEL | |
| employeeCode | Key | EXCEL | |
| payrollStatus | Lifecycle | APP (+ Excel flag if present) | See §8 |

Mapping object: `PAYROLL_FIELDS` (to be frozen post-audit).

---

## 5. Salary Slip Entity

**Template sheet (mandated name):** `PAYLIP TEMPLATE` (exact spelling)

| Logical Field | Type | Source | Status |
|---|---|---|---|
| companyHeader / logo | display | CONFIG + assets | PENDING template audit |
| employeeCode | string | Employee + Payroll | PENDING field cells |
| employeeName | string | Employee | PENDING |
| designation | string | Employee | PENDING |
| monthKey | string | Payroll | PENDING |
| earnings lines | collection | Payroll | PENDING |
| deduction lines | collection | Payroll | PENDING |
| gross / net | number | Payroll | PENDING |
| bank / statutory IDs | string | Employee/Config | PENDING |
| printLayout | A4 | CSS print | Specced in UI_UX |

Mapping object: `PAYSLIP_FIELDS`.

---

## 6. HR Document Entity

| Logical Field | Type | Source | Notes |
|---|---|---|---|
| documentType | enum | CONFIG | Offer, experience, etc. — catalogue PENDING |
| employeeCode | string | Employee | Substitution key |
| templateId | string | CONFIG | |
| substitutions | map | Employee + Config | Tokens resolved at generation |
| generatedAt | datetime | APP | Audit |
| generatedBy | userId | APP | Audit |

---

## 7. Audit Entity

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
| month | string | N | For payroll actions |
| reason | string | Conditional | Required for unlock |
| before | json | N | Snapshot |
| after | json | N | Snapshot |
| result | enum | Y | SUCCESS / DENIED / FAILED |
| correlationId | string | Y | Sync / transaction |

**Unlock-specific mandatory fields:** USER, ROLE, TIMESTAMP, MONTH, REASON, ACTION.

---

## 8. Configuration Entity

| Logical Field | Type | Source | Notes |
|---|---|---|---|
| companyProfile | object | CONFIG/EXCEL | Name, address, logo path |
| themeDefault | enum | APP | light/dark |
| statutoryPf | object | CONFIG | Rates/limits — not hardcoded permanently |
| statutoryEsic | object | CONFIG | |
| statutoryPt | object | CONFIG | Jurisdiction rules PENDING |
| overtimeRules | object | CONFIG/EXCEL | Must align with workbook |
| payrollLifecycleFlags | object | APP | Month status |
| rolePermissionMatrix | object | APP | RBAC |
| syncSettings | object | APP | Bridge paths / verification |
| backupSettings | object | APP | Retention |

All configurable business rules must be editable only by authorized roles and audited.

---

## 9. User / Session Entities (APP)

### User

| Field | Type | Notes |
|---|---|---|
| userId | string | |
| displayName | string | |
| role | enum | See SECURITY_DESIGN |
| status | enum | Active/Disabled |
| passwordHash / secretRef | secret | Never plaintext in code or docs |
| lastLoginAt | datetime | |

### Session

| Field | Type | Notes |
|---|---|---|
| sessionId | string | |
| userId | string | |
| role | string | |
| issuedAt / expiresAt | datetime | |
| theme | enum | persisted preference |

---

## 10. Sync Payload Entity (`balsons_data.js`)

| Field | Type | Source | Status |
|---|---|---|---|
| exportedAt | datetime | VBA | PENDING schema |
| workbookName | string | VBA | PENDING |
| employees | array | EMPLOYEE DATABASE | PENDING |
| months | array/object | Month sheets | PENDING |
| payroll | array/object | Month/payroll ranges | PENDING |
| config | object | Optional | PENDING |
| checksum / version | string | VBA | Recommended |

Exact schema **PENDING** VBA/`balsons_data.js` delivery. Zero-CSV constraint applies.

---

## 11. Month Lifecycle Status Values (APP)

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
