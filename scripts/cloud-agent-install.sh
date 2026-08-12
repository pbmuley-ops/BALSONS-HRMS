#!/usr/bin/env bash
# BALSONS ERP & PAYROLL 2026 — Cloud Agent install (idempotent)
# Prepares Excel inspection tooling for workbook audits.
# Application stack remains HTML5/CSS3/Vanilla JS (no Node app runtime).
set -euo pipefail
python3 -m pip install --user openpyxl
python3 -c "import openpyxl; print('openpyxl', openpyxl.__version__)"
