# Monthly Intake Template

Use this short prompt to collect fixed monthly inputs:

1. `month_label`（例如 `2026年5月`）
2. `expense_text_records`（自然语言消费明细）
3. `excel_template_path`（可选；没有就新建）
4. `excel_output_path`（可选）
5. `sheet_name`
6. `screenshot_source`（文件夹或 zip）
7. `invoice_source`（文件夹或 zip）
8. `base_ppt_path`（可选）
9. `supplemental_invoice_source`（可选）

If the user has already provided paths, skip re-asking and proceed.

## Validation-first requirement

Before generating or editing final deliverables, run a preflight validation and block if failed:

1. Report reimbursement total.
2. Report current invoice total.
3. Confirm whether invoice total is `>=` reimbursement total.
4. Report missing screenshot IDs or missing invoice mappings.
5. If failed, ask for supplemental files and stop until user provides them.

## One-line trigger the user can reuse

`用 $monthly-reimbursement-packet 跑本月报销打包流程。我先给你自然语言消费记录，请你先清洗并回填Excel。`
