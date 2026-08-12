# BALSONS ERP & PAYROLL 2026: DETAILED TAB-BY-TAB SYSTEM SPECIFICATION

This technical specification details the structural design, data bindings, user interactions, and functional behavior of each individual tab within the **Balsons ERP & Payroll 2026** portal, operating under the locked Zero-CSV, direct Excel-to-HTML architecture.

---

## 1. Dashboard Tab (`#dashboard`)

* **Purpose:** Provides an executive, at-a-glance overview of workforce status, aggregate financial liabilities, and operational metrics.
* **Layout & Components:**
* **Top KPI Metric Cards:**
* *Employees:* Displays active workforce count dynamically alongside total records.
* *Payroll Cost:* Aggregates and displays the exact total net payable in Indian Rupees (₹).
* *Attendance:* Calculates and displays overall attendance efficiency as a percentage.
* *OT Summary:* Sums total cumulative overtime hours logged across active employees.
* *PF & ESIC Summary:* Computes total statutory deductions combined.

* **Interactive Visual Analytics:**
* *Payroll Trend (Last 12 Months):* A responsive bar chart rendering monthly cost trajectories.
* *Department-wise Setup:* A doughnut distribution chart breaking down personnel allocation across `MECH`, `ELE`, `HELPER`, and `ADMIN` units.

---

## 2. Employee Master Tab (`#employee-master`)

* **Purpose:** Serves as the central interface for managing personnel files, tracking active/inactive employment statuses, and editing full demographic profiles.
* **Layout & Components:**
* **Top Control Bar:** Features an instant search bar indexing employee codes, names, and designations, alongside a real-time record counter and an "+ Add Employee" button.
* **Data Table:** Renders columns for Emp Code, Name, Designation, Mobile, and Status (styled with dynamic active/inactive badges), complete with individual edit actions.
* **Expanded Profile Modal (`#employeeModal`):** A comprehensive multi-column form mapped directly to the Excel `EMPLOYEE DATABASE` sheet. It captures:
* *Basic Info:* Emp Code, Full Name, Designation.
* *Employment & Contact:* Date of Joining (DOJ), Mobile Number, Employment Status (`Active` / `Inactive`).
* *Demographics:* Gender, Date of Birth (DOB), Marital Status, Father's Name, Physically Challenged status.
* *Address & Statutory:* Permanent Address, City, State, Postal Code, PF Number, ESI Number, Aadhar Card Number, and Gross Salary.
---

## 3. Attendance Management Tab (`#attendance`)

* **Purpose:** Manages monthly attendance tracking mapped directly to individual month sheets in the Excel workbook.
* **Layout & Components:**
* **Month Sheet Selector:** Automatically populates a dropdown list discovering all active month sheets from the Excel file (e.g., `MAY-26`, `JUNE 26`). Selecting a month strictly binds the grid data to that specific worksheet.
* **Sheet Generation Tool:** Includes a "+ New Month Sheet" trigger allowing administrators to instantiate new operating month sheets conforming to established structural templates.
* **Interactive Grid:** Displays only active employees, providing input fields for Present Days, Weekly Offs (WO), Paid Leaves (PL), Overtime (OT) Hours, and Advances (₹).
* **Persistence Control:** A "Save to Excel" action that commits grid inputs directly back to the active workbook sheet.
---

## 4. Process Payroll Tab (`#payroll`)

* **Purpose:** Executes live financial calculations and renders comprehensive wage registers without intermediary CSV files.
* **Layout & Components:**
* **Execution Header:** Contains a target month selector and a "Compute Payroll" trigger button.
* **Automation Engine:** Instructs the Excel backend to evaluate underlying calculation formulas (Basic, HRA, DA, Gross Earnings, PF, ESIC, Advances, Total Deductions, and Net Payable).
* **Payroll Register Preview:** A structured, horizontally scrollable data table displaying exact calculated line items per employee:
* *Columns:* Emp Code, Name, Payable Days, Basic, HRA, DA, Total Earnings, PF, ESIC, Advance, Total Deductions, and NET PAYABLE.

---

## 5. HR Documents Generator Tab (`#documents`)

* **Purpose:** Generates professional, compliant statutory and administrative documents and certificates on demand.
* **Layout & Components:**
* **Parameter Control Panel:**
* *Generation Mode:* Toggle between "Individual" (single employee selection) and "Bulk (All Active)" batch printing.
* *Document Type Selector:* Supports Appointment Letters, Joining Letters, Annual CTC Annexure-I, Salary Slips, Experience Letters, Relieving Letters, No Due Certificates, and Employee ID Cards.
* *Salary Month Selector:* Dynamically appears when generating Salary Slips.


* **Interactive Document Preview Pane (`#documentPrintArea`):**
* Renders live-stitched document layouts using official company headers and employee-specific parameters.
* **Full Editing Support:** Built with `contenteditable="true"`, allowing administrative adjustments directly on-screen prior to final printing or PDF saving.

---

## 6. Reports & Analytics Tab (`#reports`)

* **Purpose:** Compiles and visualizes specific operational and financial registers for auditing and management review.
* **Layout & Components:**
* **Report Selector:** Supports Attendance Registers, Wage Registers, Salary Registers, Employee Lists, OT Reports, Advance Reports, and PF & ESIC Reports.
* **Month Filter:** Dynamically adjusts visibility based on whether the report requires a temporal focus.
* **Live Report Preview Area:** Instantly renders the requested report table on-screen with clean formatting, omitting all CSV export requirements in favor of direct browser-native PDF printing.
---

## 7. System Settings Tab (`#settings`)

* **Purpose:** Manages overarching corporate identity and statutory configurations.
* **Layout & Components:**
* **Company Profile Configuration:** Form fields managing Company Name, Registered Address, Contact Telephone, and Email.
* **Statutory Setup:** Placeholders for GSTIN, PAN, PF Code, and ESIC Code integration.



BALSONS ERP & PAYROLL 2026: HTML & CSS DESIGN & UI/UX SPECIFICATION
This specification outlines the visual design system, layout framework, responsiveness rules, and UI/UX components implemented within the portal.html frontend of the Balsons ERP system.

1. Design Philosophy & Aesthetic Framework
Glassmorphism Style: The interface utilizes semi-transparent glass panels (.glass-panel) with backdrop blur filters (backdrop-filter: blur(12px)) layered over a dynamic, modern background color scheme. This creates depth and separation between the workspace and navigation components.

Corporate Brand Identity:

Primary Accent: Balsons Teal (#0096a6) — used for active tab indicators, primary buttons, headers, and key data highlights.

Secondary Accent: Balsons Red (#e03c42) — used for critical warning borders, section divider lines, and primary callout highlights.

Theme Switching Engine: Features a seamless, persistent light and dark mode toggle (data-theme="light" vs data-theme="dark"). Theme preferences are stored in the browser's localStorage for continuity across sessions.

2. Layout & Structural Architecture
Fixed Sidebar Navigation (.sidebar):

Width: Fixed at 260px on desktop viewports.

Contains the corporate logo image (BALSONS LOGO MAIN NEW.png), scrollable module navigation links, and the dark/light mode toggle button at the base.

Incorporates subtle active-state border highlights (border-left: 4px solid var(--balsons-red)).

Responsive Main Workspace (.main-content):

Margin-left: Padded dynamically to clear the fixed sidebar (260px).

Padding: Consistent 40px inner spacing for breathing room.

Transition Effects: Smooth fade-in and vertical slide animations (@keyframes fadeInUp) when switching between application modules.

Mobile Adaptability (@media (max-width: 991px)):

The sidebar collapses off-screen (transform: translateX(-100%)).

A fixed mobile header bar appears featuring a hamburger menu toggle (☰) to slide the navigation drawer in and out seamlessly.

3. UI Component Library & Tab Design Details
A. Typography & Dividers
Headings (h2): Styled in bold Balsons Teal (font-weight: 800).

Section Dividers (hr): Styled with a custom width (60px) and colored in Balsons Red (border-top: 3px solid var(--balsons-red); opacity: 1; border-radius: 3px;).

B. Cards & Metric Displays (.glass-panel)
Used extensively on the Dashboard and throughout module filters.

Features soft box shadows (box-shadow: var(--shadow)), rounded corners (border-radius: 16px), and hover elevation effects (transform: translateY(-3px)).

C. Data Tables (.table)
Styling: Transparent backgrounds (--bs-table-bg: transparent) with custom hover states (--bs-table-hover-bg: var(--hover-bg)).

Sticky Table Headers: Applied in Attendance and Payroll register views (position: sticky; top: 0; z-index: 1) to ensure column headings remain visible during vertical scrolling of large employee lists.

Form Inputs within Tables (.att-input): Compact, center-aligned input boxes optimized for rapid data entry without disrupting table row heights.

D. Modals & Forms (.modal)
Employee Profile Modal (#employeeModal): Built on an extra-large modal dialog (modal-xl) with a centered vertical alignment.

Grid Layout: Form fields are structured using a 12-column Bootstrap grid (row g-3) to cleanly group basic information, contact details, personal demographics, permanent address lines, and statutory registration numbers.

E. Document Preview & Editing Pane (#documentPrintArea)
Simulated Paper Layout: Styled to mimic an 842px minimum-height A4/Letter white paper sheet centered against a neutral grey backdrop container.

Live Content Editing: Enabled via contenteditable="true", allowing administrators to directly click and modify text on-screen before triggering browser print or PDF export.

# SYSTEM MANDATORY OPERATIONAL INSTRUCTIONS

**Project:** BALSONS ERP & PAYROLL 2026

**Operating Standard:** Zero-CSV, Direct Excel-to-HTML Synchronization

---

## 1. Directory Structure & File Integrity Rules

1. **File Placement:** The HTML frontend (`portal.html`), the company logo asset (`BALSONS LOGO MAIN NEW.png`), the data bridge file (`balsons_data.js`), and the master Excel workbook (`BALSONS ERP & PAYROLL 2026.xlsm`) **must** reside together in the exact same local folder directory.
2. **Zero-CSV Policy:** Under no circumstances should intermediary text exports or CSV files be generated or parsed. All data movement between the spreadsheet and the web browser occurs exclusively via the native JavaScript data bridge (`balsons_data.js`).
---
## 2. Master Excel Database Maintenance Rules

1. **Sheet Naming Conventions:**
* The master personnel sheet **must** be precisely named `EMPLOYEE DATABASE`.
* Active monthly attendance/salary sheets **must** include year identifiers (e.g., `MAY-26`, `JUNE 26`) to ensure automated dynamic discovery by the VBA engine.

2. **Header & Column Rigidity:**
* Do not alter or shift column positions in the `EMPLOYEE DATABASE` sheet. Column A must remain *Emp Code*, Column B *Name*, Column C *Designation*, Column D *DOJ*, Column E *Mobile*, and Column AZ (Index 52) *Status*.

3. **Macro Security Settings:**
* Excel Macro Security must be configured to *Enable VBA Macros* or the workbook must be saved within a designated Trusted Folder to allow the bridge macro execution.

---
## 3. Execution & Workflow Sequence

1. **Database Updates:** Whenever personnel records, statutory numbers, or salary structures are modified inside Excel, the synchronization macro (`ExportPortalDataDirectly`) **must** be executed via `ALT + F8`.
2. **Browser Refresh:** Following macro execution, refresh the `portal.html` browser page to load the updated `balsons_data.js` script and refresh UI DOM elements.
3. **Print & PDF Standards:** All document generation and reporting modules rely on the browser's native print-to-PDF engine (`window.print()`). Verify that page scaling is set to "Default" or "100%" when generating official statutory certificates or salary slips.


MANDATORY EXCEL SHEET REFERENCE & DATA BINDING INSTRUCTIONS
Project: BALSONS ERP & PAYROLL 2026

System Rule: Strict Excel Sheet-to-HTML Data Binding & Zero-CSV Policy

1. Primary Sheet Mapping & Structural Reference
The HTML frontend strictly relies on the exact sheet names and column layouts configured within your master Excel workbook (BALSONS ERP & PAYROLL 2026.xlsm). Any structural deviation will break data synchronization.

A. The Master Employee Sheet (EMPLOYEE DATABASE)
Mandatory Sheet Name: Must be spelled and formatted precisely as EMPLOYEE DATABASE.

Exact Column Binding Reference:

Column A: Employee Code (e.g., BAL-EMP001)

Column B: Full Name

Column C: Designation (MECH, ELE, HELPER, ADMIN)

Column D: Date of Joining (DOJ)

Column E: Mobile Number

Columns F to Q: Personal and Statutory Demographics (Gender, DOB, Marital Status, Father's Name, Physically Challenged, Address, City, State, Postal Code, PF Number, ESI Number, Aadhar Card No, Gross Salary)

Column AZ (Index 52): Employment Status (Active / Inactive)

B. Monthly Operating Sheets (e.g., MAY-26, JUNE 26)
Mandatory Naming Rule: Monthly attendance and salary computation sheets must include year identifiers (25 or 26) so the VBA bridge can dynamically discover them.

Strict Data Dependency: When a user selects a month (e.g., MAY-26) in the portal's Attendance, Payroll, or Reports tabs, the interface strictly reads and populates values corresponding directly to that named sheet in Excel.

2. VBA Bridge Synchronization Protocol
To enforce strict referencing without CSV files, the VBA engine (modBridgeEngine) reads the cells of these referenced sheets directly:

Cell Range Parsing: The VBA script scans row 2 down to the last active row (LastRow) of the EMPLOYEE DATABASE sheet.

Dynamic Script Generation: It compiles these exact cell values into JavaScript objects within balsons_data.js.

Execution Command: Whenever records are updated in Excel, you must run the synchronization macro (ExportPortalDataDirectly) via ALT + F8 to push the exact sheet state into the portal.

3. Mandatory Compliance Rules
No Manual Frontend Database Alterations: Employee additions or modifications saved through the portal modal interface must sync directly back to the EMPLOYEE DATABASE sheet rows.

Header Integrity: Never rename, delete, or reorder the column headers in the EMPLOYEE DATABASE or monthly salary sheets, as the JavaScript and VBA mapping engines rely on these exact positional coordinates.