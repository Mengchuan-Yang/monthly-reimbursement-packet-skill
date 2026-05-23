# Changelog

All notable changes to this skill are documented in this file.

## [1.0.1] - 2026-05-23

### Changed

1. Expanded `README.md` into a full operating guide.
2. Added explicit trigger conditions and one-line trigger command.
3. Added fixed monthly input template for repeatable usage.
4. Clarified mandatory blocking validation gate behavior.
5. Clarified execution flow, layout rules, and output/report contract.

## [1.0.0] - 2026-05-23

### Added

1. Initial production release of `monthly-reimbursement-packet`.
2. Text-first intake workflow for natural-language expense records.
3. Structured Excel write-back flow for monthly reimbursement sheets.
4. Preflight validation gate with blocking behavior:
   1. Screenshot mapping completeness check.
   2. Invoice mapping completeness check.
   3. Invoice total vs reimbursement total check (`>=` required).
5. Evidence processing workflow:
   1. Screenshot pages first.
   2. Invoice pages appended after screenshots.
   3. PDF invoice to image conversion support.
6. Final packaging flow:
   1. A4 landscape Excel first page.
   2. A4 portrait proof pages.
   3. Merged printable PDF output.
