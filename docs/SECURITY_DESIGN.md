# BALSONS ERP & PAYROLL 2026 — Security Design

| Field | Value |
|---|---|
| Document ID | BAL-SEC-001 |
| Version | 0.1.0-DRAFT |
| Status | PROPOSED |
| Governance | BEDS-SEC / security-by-design |

---

## 1. Security Objectives

1. Prevent unauthorized access to payroll, configuration, and Excel write-back.
2. Enforce least privilege via RBAC.
3. Ensure every sensitive action is authorized and audited.
4. Protect secrets — **never hardcode production passwords**.
5. Preserve offline operation without weakening local controls.
6. Maintain integrity of the authoritative Excel workbook.

---

## 2. Control Pipeline

```text
Authentication
     ↓
Session
     ↓
Role
     ↓
Permission
     ↓
Module Access
     ↓
Action Authorization
     ↓
Audit
```

Every protected UI action and service method must pass this pipeline. UI visibility hiding is **not** sufficient authorization.

---

## 3. Required Roles

| Role | Intended scope |
|---|---|
| System Administrator | Full system, users, roles, maintenance, backup |
| HR Manager | Employee master, HR documents, attendance oversight |
| Payroll Manager | Payroll calc/review/finalize/unlock (authorized), statutory |
| Manager | Team reviews, limited reports, approvals as configured |
| Supervisor | Attendance entry/review for assigned scope |
| Operator | Day-to-day data entry within allowed modules |
| Viewer | Read-only modules/reports as permitted |
| Auditor | Read audit logs, compliance reports; no payroll mutate |

Exact permission matrix values are configuration-owned and must be reviewed before go-live.

---

## 4. Permission Model (design)

Permissions are strings of the form `domain:action`.

### Domains (initial)

`users`, `roles`, `config`, `employees`, `attendance`, `payroll`, `slips`, `hrdocs`, `statutory`, `reports`, `excel`, `audit`, `backup`, `system`

### Actions (initial)

`view`, `create`, `update`, `delete`, `approve`, `finalize`, `unlock`, `sync`, `writeback`, `export`, `import`, `restore`, `maintain`

### Protected functions (mandatory elevation)

| Function | Minimum conceptual role | Notes |
|---|---|---|
| User management | System Administrator | |
| Role management | System Administrator | |
| Configuration | System Administrator / Payroll Manager (scoped) | Split sensitive keys |
| Payroll finalization | Payroll Manager | Dual-control optional decision |
| Payroll unlock | Payroll Manager (+ reason required) | Always audited |
| Excel overwrite / write-back | Payroll Manager / Admin | High risk |
| Backup / restore | System Administrator | |
| Import / synchronization | Admin / Payroll Manager | |
| System maintenance | System Administrator | |

---

## 5. Authentication

### Requirements

- Local authentication suitable for offline enterprise use
- Credentials stored using a one-way hash / OS-protected secret store — **decision PENDING** (see Required Decisions)
- Account lockout / retry limits (configurable)
- Password policy configurable (length, complexity) — no default production password in source
- Initial bootstrap admin created via controlled installation procedure, not committed secrets

### Forbidden

```text
const ADMIN_PASSWORD = "admin123"; // FORBIDDEN
```

Any sample credentials in docs/tests must be clearly non-production and excluded from release packages.

---

## 6. Session

| Attribute | Requirement |
|---|---|
| sessionId | Unique per login |
| idle timeout | Configurable |
| absolute timeout | Configurable |
| persistence | Secure local persistence strategy (PENDING design choice) |
| fixation protection | Regenerate session id on login |
| concurrent sessions | Policy configurable |

Logout must clear session state from memory and approved storage.

---

## 7. Module Access

Route/module load checks role → permission → module allow-list.

Denied access:

- Does not render sensitive data
- Records AUDIT result = DENIED
- Shows enterprise-safe denial message (no stack traces)

---

## 8. Action Authorization

Service-layer enforcement examples:

| Action | Extra controls |
|---|---|
| `payroll:finalize` | Month must be in APPROVAL; validation clean |
| `payroll:unlock` | Month FINALIZED/CLOSED; **reason required**; audit mandatory fields |
| `excel:writeback` | Validation pass; confirmation; post-write verification |
| `backup:restore` | Confirmation; integrity check; audit |
| `config:update` | Field-level permission; audit before/after |

---

## 9. Audit Design

### Mandatory unlock record

```text
USER
ROLE
TIMESTAMP
MONTH
REASON
ACTION
```

### General audit fields

See `docs/DATA_DICTIONARY.md` § Audit Entity.

### Integrity

- Append-oriented audit store (APP), optionally mirrored to Excel audit sheet if present
- Tamper-evident strategy PENDING (hash chain recommended)
- Auditor role read access; modification of audit records denied to all operational roles

---

## 10. Excel / Bridge Security

| Risk | Control |
|---|---|
| Malicious `balsons_data.js` | Schema validation + structural checks before state load |
| Accidental overwrite | Validation + confirmation + verification + audit |
| Macro security | Signed/trusted workbook policy in Admin Manual |
| Path traversal on backup/restore | Allow-listed paths only |
| Formula integrity loss | Detect formula cells turned into constants where critical |

---

## 11. Data Protection

- PII (mobile, employee identifiers) minimized in logs
- Screen print of salary slips restricted by role
- Backup packages access-controlled
- No secrets in git, IndexedDB plaintext passwords, or release notes

---

## 12. Offline Security Considerations

Offline does not mean open:

- Local auth still required for non-public modules
- Vendor libraries integrity (checksums in release manifest — recommended)
- Physical access to workstation/workbook remains an operational control (documented in Admin Manual)

---

## 13. Threat Summary (initial)

| Threat | Severity | Mitigation |
|---|---|---|
| Unauthorized payroll unlock | High | RBAC + reason + audit |
| Workbook silent structure change | High | Sync structural validation |
| Hardcoded credentials | High | Ban + secret review gate |
| Privilege escalation via UI-only checks | High | Service-layer AuthZ |
| Tampered sync payload | High | Validate before apply |
| CDN compromise | Medium | No runtime CDN |
| Shoulder-surfing slips | Medium | Role + print controls |

---

## 14. Security Verification (pre-release)

- Unauthorized access tests
- Role restriction matrix tests
- Admin protection tests
- Payroll lock/unlock tests
- Configuration protection tests
- Secret scanning of repository
- Offline auth still enforced

No production release without security verification (BEDS-GOV / BEDS-SEC).

---

## 15. Open Security Decisions

1. Credential storage mechanism for fully offline deployment
2. Whether dual-control is required for finalize/unlock
3. Audit tamper-evidence implementation
4. Workbook macro trust model for end-user PCs
