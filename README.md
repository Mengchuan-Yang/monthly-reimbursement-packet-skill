# Monthly Reimbursement Packet Skill

`monthly-reimbursement-packet` is a production workflow skill for end-to-end monthly reimbursement delivery.

It converts raw natural-language expense notes into a finalized reimbursement package:

1. Cleaned monthly Excel worksheet.
2. Evidence PPT with screenshot pages first and invoice pages after.
3. Final printable merged PDF (`Excel page 1 + proof pages`).

## What This Skill Solves

1. Standardizes monthly reimbursement processing.
2. Enforces a validation gate before final generation.
3. Supports mixed evidence formats (`images + PDF invoices`).
4. Produces a consistent, print-ready deliverable set.

## Key Capability

1. Text-first data intake: parse and normalize natural-language spending logs.
2. Structured Excel write-back: keep date/number/text data types separated.
3. Preflight validation gate (blocking):
   1. Check screenshot mapping completeness.
   2. Check invoice mapping completeness.
   3. Check `invoice_total >= reimbursement_total`.
4. A4-compliant output pipeline:
   1. Excel summary page: A4 landscape, one-page fit.
   2. PPT evidence pages: A4 portrait.
   3. Final merged PDF.

## Trigger

Use:

```text
用 $monthly-reimbursement-packet 跑本月报销打包流程。我先给你自然语言消费记录，请你先清洗并回填Excel。
```

## Required Inputs

1. `month_label` (for example `2026年6月`)
2. `expense_text_records`
3. `sheet_name`
4. `screenshot_source` (folder or zip)
5. `invoice_source` (folder or zip)

Optional:

1. `excel_template_path`
2. `excel_output_path`
3. `base_ppt_path`
4. `supplemental_invoice_source`

## Output Files

1. `...月.xlsx`
2. `...-报销凭证.pptx`
3. `...-清单页.pdf`
4. `...-凭证页.pdf`
5. `...-完整报销资料.pdf`

## Validation Contract

Before final generation, the skill must stop and request more data if any of these fail:

1. Missing screenshot IDs.
2. Missing invoice mapping.
3. `invoice_total < reimbursement_total`.

Only continue after validation passes.

## Versioning

This skill follows semantic versioning:

1. Major: breaking workflow/input contract changes.
2. Minor: backward-compatible features and validations.
3. Patch: fixes and clarifications.

Current version is stored in [`VERSION`](./VERSION).

## Changelog

Release history is maintained in [`CHANGELOG.md`](./CHANGELOG.md).

## License

This repository uses the MIT License. See [`LICENSE`](./LICENSE).

