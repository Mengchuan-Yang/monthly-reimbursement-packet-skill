# Monthly Reimbursement Packet Skill

`monthly-reimbursement-packet` is a production-grade monthly reimbursement workflow skill.

It turns raw spending notes and evidence files into a complete deliverable set:

1. Monthly reimbursement Excel sheet (cleaned and structured).
2. Proof PPT (screenshots first, invoices after).
3. Final printable merged PDF (`Excel first page + PPT proof pages`).

## Trigger Conditions

Use this skill when the request includes one or more of these goals:

1. Build monthly reimbursement from natural-language expense records.
2. Fill or update reimbursement Excel by cleaned data.
3. Build proof PPT from screenshots and invoices.
4. Append invoice pages from image/PDF evidence.
5. Validate invoice total against reimbursement total.
6. Export one final printable PDF package.

## One-Line Trigger

```text
用 $monthly-reimbursement-packet 跑本月报销打包流程。我先给你自然语言消费记录，请你先清洗并回填Excel。
```

## Input Contract

Required:

1. `month_label` (for example `2026年6月`)
2. `expense_text_records` (natural-language spending records)
3. `sheet_name` (for example `2026年6月`)
4. `screenshot_source` (folder or zip)
5. `invoice_source` (folder or zip)

Optional:

1. `excel_template_path` (if omitted, create a new workbook)
2. `excel_output_path`
3. `base_ppt_path` (continue editing an existing proof deck)
4. `supplemental_invoice_source` (additional invoices)

## Recommended Monthly Request Template

```text
用 $monthly-reimbursement-packet 跑本月报销打包流程。

month_label: 2026年6月
expense_text_records:
- 6月2日在XX购买……
- 6月5日打车……
sheet_name: 2026年6月
screenshot_source: C:\path\报销凭证2026年6月.zip
invoice_source: C:\path\发票2026年6月.zip
excel_template_path: C:\path\报销模板.xlsx
excel_output_path: C:\path\杨孟川费用报销——2026年06月.xlsx
base_ppt_path: 无
supplemental_invoice_source: 无
```

## Mandatory Validation Gate (Blocking)

Before final generation, the skill must validate all checks below.

1. Expense rows parse successfully into structured fields.
2. Screenshot mapping is complete (`01..N` or explicit mapping).
3. Invoice mapping is complete (direct or merged invoices).
4. `invoice_total >= reimbursement_total`.

If any check fails, the skill must stop and request supplemental data, including:

1. Missing screenshot IDs.
2. Missing invoice mappings.
3. Current reimbursement total, invoice total, and shortfall.

No final PPT/PDF delivery is allowed before this gate passes.

## Execution Workflow

1. Parse and clean `expense_text_records`.
2. Normalize fields (date, quantity, unit price, total, remarks).
3. Fill/update monthly Excel worksheet.
4. Run mandatory validation gate.
5. Build screenshot pages in PPT (A4 portrait, 3x2 grid).
6. Normalize invoice files:
   1. unzip archives
   2. ignore `__MACOSX` and `._*`
   3. convert invoice PDFs to images
7. Append invoice pages after screenshot pages (one page, one invoice).
8. Export:
   1. Excel page 1 as A4 landscape single page
   2. PPT proof pages as A4 PDF
   3. merged final PDF

## Output Contract

Expected outputs in the working directory:

1. `...月.xlsx`
2. `...-报销凭证.pptx`
3. `...-清单页.pdf`
4. `...-凭证页.pdf`
5. `...-完整报销资料.pdf`

The skill must always report:

1. Final PDF page count.
2. Reimbursement total.
3. Invoice total.
4. Gap or surplus amount.
5. Validation gate result.

## Evidence Layout Rules

1. Screenshot pages:
   1. A4 portrait
   2. 3 columns × 2 rows per page
   3. equal image size, no overlap
2. Invoice pages:
   1. A4 portrait
   2. one invoice per page
   3. full-width placement, vertically centered
3. Final merged PDF:
   1. page 1: Excel sheet (A4 landscape)
   2. remaining pages: proof pages (A4 portrait)

## Versioning and Release

This repository follows semantic versioning:

1. Major: breaking input/workflow contract changes.
2. Minor: backward-compatible feature additions.
3. Patch: bugfixes and documentation improvements.

Files:

1. Current version: [`VERSION`](./VERSION)
2. Change history: [`CHANGELOG.md`](./CHANGELOG.md)
3. Release procedure: [`RELEASE.md`](./RELEASE.md)

## License

MIT License. See [`LICENSE`](./LICENSE).
