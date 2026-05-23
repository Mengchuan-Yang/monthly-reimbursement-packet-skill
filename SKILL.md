---
name: monthly-reimbursement-packet
description: End-to-end monthly reimbursement packaging workflow for one month of expenses. Use when the user needs to (1) update or validate a monthly reimbursement worksheet, (2) build/append screenshot and invoice proof slides in PPT, (3) convert invoice PDFs to images, (4) calculate invoice-vs-reimbursement gap, and (5) export one final printable PDF where page 1 is the Excel monthly sheet and remaining pages are proof slides.
---

# Monthly Reimbursement Packet

Run this workflow when the user wants one complete monthly reimbursement package, not a one-off file tweak.
Default to text-first intake: the user can provide raw natural-language spending logs, and the workflow must clean and structure data before writing Excel.

## Intake

Ask for the minimum fixed inputs, then start immediately:

1. `month_label`: for example `2026年5月`.
2. `expense_text_records`: natural-language spending records for this month.
3. `excel_template_path` (optional): template workbook path; if missing, create new workbook with standard columns.
4. `excel_output_path` (optional): final workbook path.
5. `sheet_name`: exact monthly sheet name, for example `2026年5月`.
6. `screenshot_source`: folder or zip of order screenshots.
7. `invoice_source`: folder or zip of invoices (images/PDF).
8. `base_ppt_path` (optional): existing proof PPT to continue editing.
9. `supplemental_invoice_source` (optional): extra invoices to append later.

If the user omits names/order mapping, default to numeric order (`01..N`) and reconcile against the worksheet sequence.

For the user-facing intake question format, read `references/intake-template.md`.

## Mandatory Preflight Gate

Run this validation first. Do not start final file generation before it passes.

Validation checklist:

1. Reimbursement rows are parsed and structured successfully.
2. Screenshot evidence can be mapped to reimbursement order (`01..N` or explicit mapping).
3. Invoice evidence can be mapped to reimbursement items (direct or merged invoices).
4. Invoice total is `>=` reimbursement total.

Blocking behavior:

1. If any check fails, stop.
2. Report exactly what is missing or mismatched:
   1. Missing screenshot IDs.
   2. Missing invoice mappings.
   3. Current reimbursement total vs invoice total and shortfall.
3. Ask the user for supplemental data/files.
4. Resume workflow only after validation passes.

## Workflow

1. If only text records are provided:
   1. Parse each line to structured fields: date, item, quantity, unit, unit price, total, owner/use, remark.
   2. Normalize dates to `yyyy/m/d`.
   3. Resolve ambiguous quantities/prices by preferring explicit total and deriving unit price when needed.
   4. Keep each datatype in its own column; do not mix text/number/date in one cell.
2. Create or update the monthly worksheet from cleaned data.
3. Read worksheet rows in order until `汇总`.
4. Run the Mandatory Preflight Gate and wait until pass.
5. Build or update the screenshot proof PPT.
6. Normalize all evidence files:
   1. Unzip archives.
   2. Ignore `__MACOSX` and `._*` files.
   3. Convert invoice PDFs to PNG.
7. Append invoice pages after screenshot pages:
   1. One page per invoice.
   2. A4 portrait slide size.
   3. Image full-width, vertically centered.
8. Compute totals:
   1. Reimbursement total from sheet rows.
   2. Invoice total from mapped invoices.
   3. Gap (`reimbursement - invoice`) and surplus if negative.
9. Export final print package:
   1. Excel monthly sheet as A4 landscape, fit to one page, include `制表` and `审核`.
   2. PPT proof pages as PDF.
   3. Merge into one final PDF with Excel page first.

## Layout Rules

Use these fixed rules unless the user overrides:

1. Screenshot pages: A4 portrait, `3x2` grid, six equal images per page, no overlap.
2. Invoice pages: A4 portrait, one invoice per page.
3. Final combined PDF:
   1. Page 1: Excel monthly sheet (A4 landscape, one page).
   2. Remaining pages: proof pages from PPT (A4 portrait).

## Output Contract

Place outputs in the same working directory as the month files:

1. `...-报销凭证.pptx` (updated proof deck).
2. `...月.xlsx` (cleaned and updated monthly workbook).
3. `...-清单页.pdf` (Excel first page).
4. `...-凭证页.pdf` (PPT pages).
5. `...-完整报销资料.pdf` (final merged printable file).

Always report:

1. Total pages in final PDF.
2. Invoice total vs reimbursement total.
3. Gap or surplus amount.
4. Preflight validation result and whether supplemental files were required.
