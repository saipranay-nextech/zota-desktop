# Missing Database Schema — Code vs Schema Mismatch

## Critical — Entire Tables Missing from model.ts & migrations

| Table | Used In | Operations |
|-------|---------|------------|
| `stock_audit_table` | `stockAuditService.ts`, `stockAuditController.ts` | INSERT, SELECT, UPDATE |
| `stock_audit_items_table` | `stockAuditService.ts`, `stockAuditController.ts` | INSERT, SELECT, UPDATE |
| `payment_type_table` | `paymentTypeService.ts` | INSERT, SELECT, UPDATE |

## High — Missing Columns on `customer_details`

| Column | Used In | Impact |
|--------|---------|--------|
| `cmr_acquired_source` | `taxController.ts:1487`, `customerService.ts:195,1006` | **Runtime crash** — used in WHERE clause |
| `cmr_currency` | `customerService.ts:194,1005` | Returns `undefined` silently |
| `cmr_shipping_method` | `customerService.ts:198,1009` | Returns `undefined` silently |
| `cmr_doctor_name` | `pdfhelper.ts:602` | PDF shows "-" instead of value |
| `cmr_gst_number` | `pdfhelper.ts:603` | PDF shows "-" instead of value |

## Notes
- The 3 missing tables will crash whenever stock audit or payment type features are used
- `cmr_acquired_source` is the only column that causes a hard crash (SQL WHERE clause)
- Other missing columns come from `SELECT *` results and silently return `undefined`
- These are all present in production databases but missing from the migration/model files
