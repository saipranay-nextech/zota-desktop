--
-- PostgreSQL database dump
--

\restrict sJIymwXuxOTdWMS3OuNlHC4oeylRvwTicWHp7kehneYpatCJefDaZykxsfVj2bf

-- Dumped from database version 15.17 (Postgres.app)
-- Dumped by pg_dump version 15.17 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.users_table DROP CONSTRAINT IF EXISTS users_table_user_role_id_fkey;
ALTER TABLE IF EXISTS ONLY public.users_permission_table DROP CONSTRAINT IF EXISTS users_permission_table_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.uom_table DROP CONSTRAINT IF EXISTS uom_table_uom_group_id_fkey;
ALTER TABLE IF EXISTS ONLY public.uom_group_item DROP CONSTRAINT IF EXISTS uom_group_item_group_id_fkey;
ALTER TABLE IF EXISTS ONLY public.uom_group_item DROP CONSTRAINT IF EXISTS uom_group_item_base_uom_id_fkey;
ALTER TABLE IF EXISTS ONLY public.terms_and_conditions_table DROP CONSTRAINT IF EXISTS terms_and_conditions_table_store_id_fkey;
ALTER TABLE IF EXISTS ONLY public.tax_combination_item DROP CONSTRAINT IF EXISTS tax_combination_item_tax_type_id_fkey;
ALTER TABLE IF EXISTS ONLY public.tax_combination_item DROP CONSTRAINT IF EXISTS tax_combination_item_tax_combination_id_fkey;
ALTER TABLE IF EXISTS ONLY public.sync_runs DROP CONSTRAINT IF EXISTS sync_runs_sync_rule_id_fkey;
ALTER TABLE IF EXISTS ONLY public.sublevel_table DROP CONSTRAINT IF EXISTS sublevel_table_warehouse_id_fkey;
ALTER TABLE IF EXISTS ONLY public.sublevel_bins DROP CONSTRAINT IF EXISTS sublevel_bins_sublevel_id_fkey;
ALTER TABLE IF EXISTS ONLY public.store_opening_details_table DROP CONSTRAINT IF EXISTS store_opening_details_table_store_id_fkey;
ALTER TABLE IF EXISTS ONLY public.store_infrastructure_details_table DROP CONSTRAINT IF EXISTS store_infrastructure_details_table_store_id_fkey;
ALTER TABLE IF EXISTS ONLY public.store_info_personal_details_table DROP CONSTRAINT IF EXISTS store_info_personal_details_table_store_id_fkey;
ALTER TABLE IF EXISTS ONLY public.store_info_payment_table DROP CONSTRAINT IF EXISTS store_info_payment_table_store_id_fkey;
ALTER TABLE IF EXISTS ONLY public.store_info_firm_details_table DROP CONSTRAINT IF EXISTS store_info_firm_details_table_store_id_fkey;
ALTER TABLE IF EXISTS ONLY public.store_info_drug_license_table DROP CONSTRAINT IF EXISTS store_info_drug_license_table_store_id_fkey;
ALTER TABLE IF EXISTS ONLY public.store_followup_and_history_table DROP CONSTRAINT IF EXISTS store_followup_and_history_table_store_id_fkey;
ALTER TABLE IF EXISTS ONLY public.store_dispatch_details_table DROP CONSTRAINT IF EXISTS store_dispatch_details_table_store_id_fkey;
ALTER TABLE IF EXISTS ONLY public.store_branding_details_table DROP CONSTRAINT IF EXISTS store_branding_details_table_store_id_fkey;
ALTER TABLE IF EXISTS ONLY public.store_branding_and_store_software_details_table DROP CONSTRAINT IF EXISTS store_branding_and_store_software_details_table_store_id_fkey;
ALTER TABLE IF EXISTS ONLY public.store_agreement_table DROP CONSTRAINT IF EXISTS store_agreement_table_store_id_fkey;
ALTER TABLE IF EXISTS ONLY public.store_account_details_table DROP CONSTRAINT IF EXISTS store_account_details_table_store_id_fkey;
ALTER TABLE IF EXISTS ONLY public.stock_audit_items_table DROP CONSTRAINT IF EXISTS stock_audit_items_table_sat_id_fkey;
ALTER TABLE IF EXISTS ONLY public.sales_return_items_list DROP CONSTRAINT IF EXISTS sales_return_items_list_srt_id_fkey;
ALTER TABLE IF EXISTS ONLY public.sales_return_items_batches_list DROP CONSTRAINT IF EXISTS sales_return_items_batches_list_srt_id_fkey;
ALTER TABLE IF EXISTS ONLY public.sales_return_document_list DROP CONSTRAINT IF EXISTS sales_return_document_list_srt_id_fkey;
ALTER TABLE IF EXISTS ONLY public.sales_order_items_list DROP CONSTRAINT IF EXISTS sales_order_items_list_sott_id_fkey;
ALTER TABLE IF EXISTS ONLY public.sales_order_invoice_items_list DROP CONSTRAINT IF EXISTS sales_order_invoice_items_list_soit_id_fkey;
ALTER TABLE IF EXISTS ONLY public.sales_order_invoice_items_batches_list DROP CONSTRAINT IF EXISTS sales_order_invoice_items_batches_list_soit_id_fkey;
ALTER TABLE IF EXISTS ONLY public.sales_order_delivery_transaction_table DROP CONSTRAINT IF EXISTS sales_order_delivery_transaction_table_sott_id_fkey;
ALTER TABLE IF EXISTS ONLY public.sales_credit_items_list_table DROP CONSTRAINT IF EXISTS sales_credit_items_list_table_sct_id_fkey;
ALTER TABLE IF EXISTS ONLY public.sales_credit_items_batches_list DROP CONSTRAINT IF EXISTS sales_credit_items_batches_list_sct_id_fkey;
ALTER TABLE IF EXISTS ONLY public.sale_order_delivery_items_list DROP CONSTRAINT IF EXISTS sale_order_delivery_items_list_sodtt_id_fkey;
ALTER TABLE IF EXISTS ONLY public.sale_order_delivery_items_batches_list DROP CONSTRAINT IF EXISTS sale_order_delivery_items_batches_list_sodtt_id_fkey;
ALTER TABLE IF EXISTS ONLY public.sale_order_delivery_document_list DROP CONSTRAINT IF EXISTS sale_order_delivery_document_list_sodtt_id_fkey;
ALTER TABLE IF EXISTS ONLY public.purchase_return_items_list DROP CONSTRAINT IF EXISTS purchase_return_items_list_prt_id_fkey;
ALTER TABLE IF EXISTS ONLY public.purchase_return_items_batches_list DROP CONSTRAINT IF EXISTS purchase_return_items_batches_list_prt_id_fkey;
ALTER TABLE IF EXISTS ONLY public.purchase_order_items_list DROP CONSTRAINT IF EXISTS purchase_order_items_list_pot_id_fkey;
ALTER TABLE IF EXISTS ONLY public.purchase_order_invoice_items_list DROP CONSTRAINT IF EXISTS purchase_order_invoice_items_list_poit_id_fkey;
ALTER TABLE IF EXISTS ONLY public.purchase_order_invoice_items_batches_list DROP CONSTRAINT IF EXISTS purchase_order_invoice_items_batches_list_poit_id_fkey;
ALTER TABLE IF EXISTS ONLY public.purchase_credit_items_list_table DROP CONSTRAINT IF EXISTS purchase_credit_items_list_table_pct_id_fkey;
ALTER TABLE IF EXISTS ONLY public.purchase_credit_items_batches_list DROP CONSTRAINT IF EXISTS purchase_credit_items_batches_list_pct_id_fkey;
ALTER TABLE IF EXISTS ONLY public.price_list_items_table DROP CONSTRAINT IF EXISTS price_list_items_table_price_list_id_fkey;
ALTER TABLE IF EXISTS ONLY public.period_volume_discount_table DROP CONSTRAINT IF EXISTS period_volume_discount_table_price_list_id_fkey;
ALTER TABLE IF EXISTS ONLY public.period_volume_discount_items_table DROP CONSTRAINT IF EXISTS period_volume_discount_items_table_price_list_id_fkey;
ALTER TABLE IF EXISTS ONLY public.payment_out_modes_table DROP CONSTRAINT IF EXISTS payment_out_modes_table_pot_id_fkey;
ALTER TABLE IF EXISTS ONLY public.payment_out_document_list_table DROP CONSTRAINT IF EXISTS payment_out_document_list_table_pot_id_fkey;
ALTER TABLE IF EXISTS ONLY public.payment_modes_table DROP CONSTRAINT IF EXISTS payment_modes_table_pit_id_fkey;
ALTER TABLE IF EXISTS ONLY public.payment_in_document_list_table DROP CONSTRAINT IF EXISTS payment_in_document_list_table_pit_id_fkey;
ALTER TABLE IF EXISTS ONLY public.order_items_list DROP CONSTRAINT IF EXISTS order_items_list_sot_id_fkey;
ALTER TABLE IF EXISTS ONLY public.module_table DROP CONSTRAINT IF EXISTS module_table_main_module_id_fkey;
ALTER TABLE IF EXISTS ONLY public.manufactures_group_discount_group_table DROP CONSTRAINT IF EXISTS manufactures_group_discount_group_table_discount_group_id_fkey;
ALTER TABLE IF EXISTS ONLY public.journal_entry_rows_table DROP CONSTRAINT IF EXISTS journal_entry_rows_table_transcation_id_fkey;
ALTER TABLE IF EXISTS ONLY public.items_volume_validity_table DROP CONSTRAINT IF EXISTS items_volume_validity_table_period_validity_id_fkey;
ALTER TABLE IF EXISTS ONLY public.items_group_discount_group_table DROP CONSTRAINT IF EXISTS items_group_discount_group_table_discount_group_id_fkey;
ALTER TABLE IF EXISTS ONLY public.items_discount_group_table DROP CONSTRAINT IF EXISTS items_discount_group_table_discount_group_id_fkey;
ALTER TABLE IF EXISTS ONLY public.item_uom_group_table DROP CONSTRAINT IF EXISTS item_uom_group_table_item_id_fkey;
ALTER TABLE IF EXISTS ONLY public.item_sales_table DROP CONSTRAINT IF EXISTS item_sales_table_item_id_fkey;
ALTER TABLE IF EXISTS ONLY public.item_restriction_table DROP CONSTRAINT IF EXISTS item_restriction_table_item_id_fkey;
ALTER TABLE IF EXISTS ONLY public.item_remarks_table DROP CONSTRAINT IF EXISTS item_remarks_table_item_id_fkey;
ALTER TABLE IF EXISTS ONLY public.item_purchasing_table DROP CONSTRAINT IF EXISTS item_purchasing_table_item_id_fkey;
ALTER TABLE IF EXISTS ONLY public.item_planning_table DROP CONSTRAINT IF EXISTS item_planning_table_item_id_fkey;
ALTER TABLE IF EXISTS ONLY public.item_packing_information_table DROP CONSTRAINT IF EXISTS item_packing_information_table_item_id_fkey;
ALTER TABLE IF EXISTS ONLY public.item_molecule_composition_table DROP CONSTRAINT IF EXISTS item_molecule_composition_table_item_id_fkey;
ALTER TABLE IF EXISTS ONLY public.item_min_max_for_pos_inventory DROP CONSTRAINT IF EXISTS item_min_max_for_pos_inventory_item_id_fkey;
ALTER TABLE IF EXISTS ONLY public.item_invetory_table DROP CONSTRAINT IF EXISTS item_invetory_table_item_id_fkey;
ALTER TABLE IF EXISTS ONLY public.item_group DROP CONSTRAINT IF EXISTS item_group_default_uom_id_fkey;
ALTER TABLE IF EXISTS ONLY public.item_discount_and_scheme_table DROP CONSTRAINT IF EXISTS item_discount_and_scheme_table_item_id_fkey;
ALTER TABLE IF EXISTS ONLY public.item_barcode_table DROP CONSTRAINT IF EXISTS item_barcode_table_item_id_fkey;
ALTER TABLE IF EXISTS ONLY public.invoice_credit_note_item_list DROP CONSTRAINT IF EXISTS invoice_credit_note_item_list_icn_id_fkey;
ALTER TABLE IF EXISTS ONLY public.inventory_transfer_rows_table DROP CONSTRAINT IF EXISTS inventory_transfer_rows_table_itt_id_fkey;
ALTER TABLE IF EXISTS ONLY public.inventory_transfer_item_batches_table DROP CONSTRAINT IF EXISTS inventory_transfer_item_batches_table_itt_id_fkey;
ALTER TABLE IF EXISTS ONLY public.inventory_status_item_list_table DROP CONSTRAINT IF EXISTS inventory_status_item_list_table_is_id_fkey;
ALTER TABLE IF EXISTS ONLY public.inventory_status_condition_table DROP CONSTRAINT IF EXISTS inventory_status_condition_table_is_id_fkey;
ALTER TABLE IF EXISTS ONLY public.good_order_receipt_items_list DROP CONSTRAINT IF EXISTS good_order_receipt_items_list_gort_id_fkey;
ALTER TABLE IF EXISTS ONLY public.good_order_receipt_items_batches_list DROP CONSTRAINT IF EXISTS good_order_receipt_items_batches_list_gort_id_fkey;
ALTER TABLE IF EXISTS ONLY public.document_numbering_series_table DROP CONSTRAINT IF EXISTS document_numbering_series_table_transaction_doc_id_fkey;
ALTER TABLE IF EXISTS ONLY public.document_numbering_series DROP CONSTRAINT IF EXISTS document_numbering_series_document_numbering_id_fkey;
ALTER TABLE IF EXISTS ONLY public.document_custom_numbering_series_table DROP CONSTRAINT IF EXISTS document_custom_numbering_series_table_transaction_doc_id_fkey;
ALTER TABLE IF EXISTS ONLY public.discount_group_table DROP CONSTRAINT IF EXISTS discount_group_table_discount_type_id_fkey;
ALTER TABLE IF EXISTS ONLY public.discount_group_table DROP CONSTRAINT IF EXISTS discount_group_table_customer_group_id_fkey;
ALTER TABLE IF EXISTS ONLY public.customer_ship_to_address DROP CONSTRAINT IF EXISTS customer_ship_to_address_cmr_id_fkey;
ALTER TABLE IF EXISTS ONLY public.customer_payment_terms_table DROP CONSTRAINT IF EXISTS customer_payment_terms_table_cmr_id_fkey;
ALTER TABLE IF EXISTS ONLY public.customer_pay_to_address DROP CONSTRAINT IF EXISTS customer_pay_to_address_cmr_id_fkey;
ALTER TABLE IF EXISTS ONLY public.customer_contact_persons DROP CONSTRAINT IF EXISTS customer_contact_persons_cmr_id_fkey;
ALTER TABLE IF EXISTS ONLY public.customer_bank_details DROP CONSTRAINT IF EXISTS customer_bank_details_cmr_id_fkey;
ALTER TABLE IF EXISTS ONLY public.customer_accounting_table DROP CONSTRAINT IF EXISTS customer_accounting_table_cmr_id_fkey;
ALTER TABLE IF EXISTS ONLY public.credit_note_invoice_payment_modes DROP CONSTRAINT IF EXISTS credit_note_invoice_payment_modes_icn_id_fkey;
ALTER TABLE IF EXISTS ONLY public.bin_location_table DROP CONSTRAINT IF EXISTS bin_location_table_warehouse_id_fkey;
ALTER TABLE IF EXISTS ONLY public.billing_invoice_payment_modes DROP CONSTRAINT IF EXISTS billing_invoice_payment_modes_sot_id_fkey;
ALTER TABLE IF EXISTS ONLY public.approval_stages DROP CONSTRAINT IF EXISTS approval_stages_approval_flow_id_fkey;
ALTER TABLE IF EXISTS ONLY public.approval_requests DROP CONSTRAINT IF EXISTS approval_requests_approval_flow_id_fkey;
ALTER TABLE IF EXISTS ONLY public.approval_request_stages DROP CONSTRAINT IF EXISTS approval_request_stages_request_id_fkey;
ALTER TABLE IF EXISTS ONLY public.approval_originators DROP CONSTRAINT IF EXISTS approval_originators_approval_flow_id_fkey;
ALTER TABLE IF EXISTS ONLY public.approval_document_terms DROP CONSTRAINT IF EXISTS approval_document_terms_approval_flow_id_fkey;
DROP TRIGGER IF EXISTS update_item_selling_price ON public.price_list_table;
DROP TRIGGER IF EXISTS tregger_update_margin_factor ON public.price_list_table;
DROP TRIGGER IF EXISTS sales_order_insert_trigger ON public.sales_order;
DROP TRIGGER IF EXISTS order_items_list_insert_trigger ON public.order_items_list;
DROP TRIGGER IF EXISTS item_selling_price_change ON public.price_list_items_table;
DROP TRIGGER IF EXISTS customer_details_trigger ON public.customer_details;
DROP INDEX IF EXISTS public.idx_sync_runs_status;
DROP INDEX IF EXISTS public.idx_sync_runs_rule_id;
DROP INDEX IF EXISTS public.idx_sync_runs_created_date;
DROP INDEX IF EXISTS public.idx_sync_rules_sync_status;
DROP INDEX IF EXISTS public.idx_sync_rules_status;
DROP INDEX IF EXISTS public.idx_sync_rules_next_sync;
DROP INDEX IF EXISTS public.idx_server_ips_server_name;
DROP INDEX IF EXISTS public.idx_server_ips_ip_address;
DROP INDEX IF EXISTS public.idx_server_ips_created_date;
DROP INDEX IF EXISTS public.idx_lower_item_name;
DROP INDEX IF EXISTS public.idx_item_name;
ALTER TABLE IF EXISTS ONLY public.whatsapp_config DROP CONSTRAINT IF EXISTS whatsapp_config_pkey;
ALTER TABLE IF EXISTS ONLY public.warehouses_table DROP CONSTRAINT IF EXISTS warehouses_table_pkey;
ALTER TABLE IF EXISTS ONLY public.users_table DROP CONSTRAINT IF EXISTS users_table_pkey;
ALTER TABLE IF EXISTS ONLY public.users_permission_table DROP CONSTRAINT IF EXISTS users_permission_table_pkey;
ALTER TABLE IF EXISTS ONLY public.user_column_preferences DROP CONSTRAINT IF EXISTS user_column_preferences_pkey;
ALTER TABLE IF EXISTS ONLY public.uom_table DROP CONSTRAINT IF EXISTS uom_table_pkey;
ALTER TABLE IF EXISTS ONLY public.uom_group_table DROP CONSTRAINT IF EXISTS uom_group_table_pkey;
ALTER TABLE IF EXISTS ONLY public.uom_group DROP CONSTRAINT IF EXISTS uom_group_pkey;
ALTER TABLE IF EXISTS ONLY public.uom_group_item DROP CONSTRAINT IF EXISTS uom_group_item_pkey;
ALTER TABLE IF EXISTS ONLY public.items_batch_no_table DROP CONSTRAINT IF EXISTS unquiee_condition;
ALTER TABLE IF EXISTS ONLY public.store_inventory_item_location_table DROP CONSTRAINT IF EXISTS unqiuee;
ALTER TABLE IF EXISTS ONLY public.unit_of_measure DROP CONSTRAINT IF EXISTS unit_of_measure_pkey;
ALTER TABLE IF EXISTS ONLY public.print_preferences DROP CONSTRAINT IF EXISTS unique_type;
ALTER TABLE IF EXISTS ONLY public.pos_items_batch_no_table DROP CONSTRAINT IF EXISTS unique_condition1122;
ALTER TABLE IF EXISTS ONLY public.pos_store_inventory_item_location_table DROP CONSTRAINT IF EXISTS unique_condition11;
ALTER TABLE IF EXISTS ONLY public.pos_items_batch_no_table DROP CONSTRAINT IF EXISTS unique_condition;
ALTER TABLE IF EXISTS ONLY public.terms_and_conditions_table DROP CONSTRAINT IF EXISTS terms_and_conditions_table_pkey;
ALTER TABLE IF EXISTS ONLY public.tds_table DROP CONSTRAINT IF EXISTS tds_table_tds_name_key;
ALTER TABLE IF EXISTS ONLY public.tds_table DROP CONSTRAINT IF EXISTS tds_table_pkey;
ALTER TABLE IF EXISTS ONLY public.tcs_table DROP CONSTRAINT IF EXISTS tcs_table_tcs_name_key;
ALTER TABLE IF EXISTS ONLY public.tcs_table DROP CONSTRAINT IF EXISTS tcs_table_pkey;
ALTER TABLE IF EXISTS ONLY public.tax_type DROP CONSTRAINT IF EXISTS tax_type_pkey;
ALTER TABLE IF EXISTS ONLY public.tax_table DROP CONSTRAINT IF EXISTS tax_table_pkey;
ALTER TABLE IF EXISTS ONLY public.tax_combination DROP CONSTRAINT IF EXISTS tax_combination_pkey;
ALTER TABLE IF EXISTS ONLY public.tax_combination_item DROP CONSTRAINT IF EXISTS tax_combination_item_pkey;
ALTER TABLE IF EXISTS ONLY public.sync_runs DROP CONSTRAINT IF EXISTS sync_runs_pkey;
ALTER TABLE IF EXISTS ONLY public.sync_rules DROP CONSTRAINT IF EXISTS sync_rules_pkey;
ALTER TABLE IF EXISTS ONLY public.sublevel_table DROP CONSTRAINT IF EXISTS sublevel_table_pkey;
ALTER TABLE IF EXISTS ONLY public.sublevel_bins DROP CONSTRAINT IF EXISTS sublevel_bins_pkey;
ALTER TABLE IF EXISTS ONLY public.sub_specialization_table DROP CONSTRAINT IF EXISTS sub_specialization_table_pkey;
ALTER TABLE IF EXISTS ONLY public.stripe_config DROP CONSTRAINT IF EXISTS stripe_config_pkey;
ALTER TABLE IF EXISTS ONLY public.store_opening_details_table DROP CONSTRAINT IF EXISTS store_opening_details_table_pkey;
ALTER TABLE IF EXISTS ONLY public.store_inventory_table DROP CONSTRAINT IF EXISTS store_inventory_table_pkey;
ALTER TABLE IF EXISTS ONLY public.store_infrastructure_details_table DROP CONSTRAINT IF EXISTS store_infrastructure_details_table_pkey;
ALTER TABLE IF EXISTS ONLY public.store_information_for_user_table DROP CONSTRAINT IF EXISTS store_information_for_user_table_pkey;
ALTER TABLE IF EXISTS ONLY public.store_info_personal_details_table DROP CONSTRAINT IF EXISTS store_info_personal_details_table_pkey;
ALTER TABLE IF EXISTS ONLY public.store_info_payment_table DROP CONSTRAINT IF EXISTS store_info_payment_table_pkey;
ALTER TABLE IF EXISTS ONLY public.store_info_firm_details_table DROP CONSTRAINT IF EXISTS store_info_firm_details_table_pkey;
ALTER TABLE IF EXISTS ONLY public.store_info_drug_license_table DROP CONSTRAINT IF EXISTS store_info_drug_license_table_pkey;
ALTER TABLE IF EXISTS ONLY public.store_info_address_table DROP CONSTRAINT IF EXISTS store_info_address_table_pkey;
ALTER TABLE IF EXISTS ONLY public.store_dispatch_details_table DROP CONSTRAINT IF EXISTS store_dispatch_details_table_pkey;
ALTER TABLE IF EXISTS ONLY public.store_branding_details_table DROP CONSTRAINT IF EXISTS store_branding_details_table_pkey;
ALTER TABLE IF EXISTS ONLY public.store_branding_and_store_software_details_table DROP CONSTRAINT IF EXISTS store_branding_and_store_software_details_table_pkey;
ALTER TABLE IF EXISTS ONLY public.store_app_user_number_table DROP CONSTRAINT IF EXISTS store_app_user_number_table_pkey;
ALTER TABLE IF EXISTS ONLY public.store_agreement_table DROP CONSTRAINT IF EXISTS store_agreement_table_pkey;
ALTER TABLE IF EXISTS ONLY public.store_account_details_table DROP CONSTRAINT IF EXISTS store_account_details_table_pkey;
ALTER TABLE IF EXISTS ONLY public.stock_request_table DROP CONSTRAINT IF EXISTS stock_request_table_pkey;
ALTER TABLE IF EXISTS ONLY public.stock_in_out_table DROP CONSTRAINT IF EXISTS stock_in_out_table_pkey;
ALTER TABLE IF EXISTS ONLY public.stock_audit_table DROP CONSTRAINT IF EXISTS stock_audit_table_pkey;
ALTER TABLE IF EXISTS ONLY public.stock_audit_items_table DROP CONSTRAINT IF EXISTS stock_audit_items_table_pkey;
ALTER TABLE IF EXISTS ONLY public.state_table DROP CONSTRAINT IF EXISTS state_table_pkey;
ALTER TABLE IF EXISTS ONLY public.specialization_table DROP CONSTRAINT IF EXISTS specialization_table_pkey;
ALTER TABLE IF EXISTS ONLY public.socket_connection_id_table DROP CONSTRAINT IF EXISTS socket_connection_id_table_pkey;
ALTER TABLE IF EXISTS ONLY public.smtp_config DROP CONSTRAINT IF EXISTS smtp_config_pkey;
ALTER TABLE IF EXISTS ONLY public.sms_config DROP CONSTRAINT IF EXISTS sms_config_pkey;
ALTER TABLE IF EXISTS ONLY public.shipping_type DROP CONSTRAINT IF EXISTS shipping_type_pkey;
ALTER TABLE IF EXISTS ONLY public.server_ips DROP CONSTRAINT IF EXISTS server_ips_pkey;
ALTER TABLE IF EXISTS ONLY public.sales_return_table DROP CONSTRAINT IF EXISTS sales_return_table_pkey;
ALTER TABLE IF EXISTS ONLY public.sales_return_document_list DROP CONSTRAINT IF EXISTS sales_return_document_list_sct_id_key;
ALTER TABLE IF EXISTS ONLY public.sales_order_transaction_table DROP CONSTRAINT IF EXISTS sales_order_transaction_table_pkey;
ALTER TABLE IF EXISTS ONLY public.sales_order DROP CONSTRAINT IF EXISTS sales_order_pkey;
ALTER TABLE IF EXISTS public.sales_order_items_list DROP CONSTRAINT IF EXISTS sales_order_items_list_item_to_be_delivered;
ALTER TABLE IF EXISTS public.sales_order_items_list DROP CONSTRAINT IF EXISTS sales_order_items_list_item_invoice_remaining_quantity;
ALTER TABLE IF EXISTS public.sales_order_invoice_table DROP CONSTRAINT IF EXISTS sales_order_invoice_table_soit_due_amount;
ALTER TABLE IF EXISTS ONLY public.sales_order_invoice_table DROP CONSTRAINT IF EXISTS sales_order_invoice_table_pkey;
ALTER TABLE IF EXISTS ONLY public.sales_order_delivery_transaction_table DROP CONSTRAINT IF EXISTS sales_order_delivery_transaction_table_pkey;
ALTER TABLE IF EXISTS ONLY public.sales_credit_table DROP CONSTRAINT IF EXISTS sales_credit_table_pkey;
ALTER TABLE IF EXISTS ONLY public.sales_account_allocation_table DROP CONSTRAINT IF EXISTS sales_account_allocation_table_pkey;
ALTER TABLE IF EXISTS ONLY public.roles_table DROP CONSTRAINT IF EXISTS roles_table_role_name_key;
ALTER TABLE IF EXISTS ONLY public.roles_table DROP CONSTRAINT IF EXISTS roles_table_pkey;
ALTER TABLE IF EXISTS ONLY public.reporttags DROP CONSTRAINT IF EXISTS reporttags_pkey;
ALTER TABLE IF EXISTS ONLY public.reporttags DROP CONSTRAINT IF EXISTS reporttags_name_key;
ALTER TABLE IF EXISTS ONLY public.relationship_table DROP CONSTRAINT IF EXISTS relationship_table_pkey;
ALTER TABLE IF EXISTS ONLY public.region_table DROP CONSTRAINT IF EXISTS region_table_pkey;
ALTER TABLE IF EXISTS ONLY public.razorpay_config DROP CONSTRAINT IF EXISTS razorpay_config_pkey;
ALTER TABLE IF EXISTS ONLY public.purchase_return_table DROP CONSTRAINT IF EXISTS purchase_return_table_pkey;
ALTER TABLE IF EXISTS ONLY public.purchase_order_transaction_table DROP CONSTRAINT IF EXISTS purchase_order_transaction_table_pkey;
ALTER TABLE IF EXISTS ONLY public.purchase_order_invoice_table DROP CONSTRAINT IF EXISTS purchase_order_invoice_table_pkey;
ALTER TABLE IF EXISTS ONLY public.purchase_credit_table DROP CONSTRAINT IF EXISTS purchase_credit_table_pkey;
ALTER TABLE IF EXISTS ONLY public.purchase_credit_of_invoice DROP CONSTRAINT IF EXISTS purchase_credit_of_invoice_pkey;
ALTER TABLE IF EXISTS ONLY public.purchase_credit_of_grn DROP CONSTRAINT IF EXISTS purchase_credit_of_grn_pkey;
ALTER TABLE IF EXISTS ONLY public.purchase_account_allocation_table DROP CONSTRAINT IF EXISTS purchase_account_allocation_table_pkey;
ALTER TABLE IF EXISTS ONLY public.product_schedule_table DROP CONSTRAINT IF EXISTS product_schedule_table_pkey;
ALTER TABLE IF EXISTS ONLY public.print_preferences DROP CONSTRAINT IF EXISTS print_preferences_type_key;
ALTER TABLE IF EXISTS ONLY public.print_preferences DROP CONSTRAINT IF EXISTS print_preferences_pkey;
ALTER TABLE IF EXISTS ONLY public.print_preference DROP CONSTRAINT IF EXISTS print_preference_pkey;
ALTER TABLE IF EXISTS ONLY public.print_prefer DROP CONSTRAINT IF EXISTS print_prefer_pkey;
ALTER TABLE IF EXISTS ONLY public.price_list_table DROP CONSTRAINT IF EXISTS price_list_table_price_list_name_key;
ALTER TABLE IF EXISTS ONLY public.price_list_table DROP CONSTRAINT IF EXISTS price_list_table_pkey;
ALTER TABLE IF EXISTS ONLY public.pine_labs_config DROP CONSTRAINT IF EXISTS pine_labs_config_pkey;
ALTER TABLE IF EXISTS ONLY public.phonepe_config DROP CONSTRAINT IF EXISTS phonepe_config_pkey;
ALTER TABLE IF EXISTS ONLY public.period_volume_discount_table DROP CONSTRAINT IF EXISTS period_volume_discount_table_pkey;
ALTER TABLE IF EXISTS ONLY public.period_volume_discount_items_table DROP CONSTRAINT IF EXISTS period_volume_discount_items_table_pkey;
ALTER TABLE IF EXISTS ONLY public.paytm_config DROP CONSTRAINT IF EXISTS paytm_config_pkey;
ALTER TABLE IF EXISTS ONLY public.payment_type_table DROP CONSTRAINT IF EXISTS payment_type_table_pkey;
ALTER TABLE IF EXISTS ONLY public.payment_terms_table DROP CONSTRAINT IF EXISTS payment_terms_table_pkey;
ALTER TABLE IF EXISTS ONLY public.payment_out_table DROP CONSTRAINT IF EXISTS payment_out_table_pkey;
ALTER TABLE IF EXISTS ONLY public.payment_out_modes_table DROP CONSTRAINT IF EXISTS payment_out_modes_table_pkey;
ALTER TABLE IF EXISTS ONLY public.payment_in_table DROP CONSTRAINT IF EXISTS payment_in_table_pkey;
ALTER TABLE IF EXISTS ONLY public.party_type_table DROP CONSTRAINT IF EXISTS party_type_table_pkey;
ALTER TABLE IF EXISTS ONLY public.party_group_table DROP CONSTRAINT IF EXISTS party_group_table_pkey;
ALTER TABLE IF EXISTS ONLY public.party_category_table DROP CONSTRAINT IF EXISTS party_category_table_pkey;
ALTER TABLE IF EXISTS ONLY public.packing_type_table DROP CONSTRAINT IF EXISTS packing_type_table_pkey;
ALTER TABLE IF EXISTS ONLY public.packing_table DROP CONSTRAINT IF EXISTS packing_table_pkey;
ALTER TABLE IF EXISTS ONLY public.notification_triggered_history DROP CONSTRAINT IF EXISTS notification_triggered_history_pkey;
ALTER TABLE IF EXISTS ONLY public.notification_recipient DROP CONSTRAINT IF EXISTS notification_recipient_pkey;
ALTER TABLE IF EXISTS ONLY public.notification DROP CONSTRAINT IF EXISTS notification_pkey;
ALTER TABLE IF EXISTS ONLY public.notification_communication_channel DROP CONSTRAINT IF EXISTS notification_communication_channel_pkey;
ALTER TABLE IF EXISTS ONLY public.module_table DROP CONSTRAINT IF EXISTS module_table_pkey;
ALTER TABLE IF EXISTS ONLY public.module_table DROP CONSTRAINT IF EXISTS module_table_module_name_key;
ALTER TABLE IF EXISTS ONLY public.migrations_history DROP CONSTRAINT IF EXISTS migrations_history_pkey;
ALTER TABLE IF EXISTS ONLY public.migrations_history DROP CONSTRAINT IF EXISTS migrations_history_batch_name_key;
ALTER TABLE IF EXISTS ONLY public.migration_log DROP CONSTRAINT IF EXISTS migration_log_pkey;
ALTER TABLE IF EXISTS ONLY public.manufacturer DROP CONSTRAINT IF EXISTS manufacturer_pkey;
ALTER TABLE IF EXISTS ONLY public.manufacture_group_table DROP CONSTRAINT IF EXISTS manufacture_group_table_pkey;
ALTER TABLE IF EXISTS ONLY public.main_module_table DROP CONSTRAINT IF EXISTS main_module_table_pkey;
ALTER TABLE IF EXISTS ONLY public.main_module_table DROP CONSTRAINT IF EXISTS main_module_table_main_module_name_key;
ALTER TABLE IF EXISTS ONLY public.lead_details DROP CONSTRAINT IF EXISTS lead_details_pkey;
ALTER TABLE IF EXISTS ONLY public.journal_entry_table DROP CONSTRAINT IF EXISTS journal_entry_table_pkey;
ALTER TABLE IF EXISTS ONLY public.items_volume_validity_table DROP CONSTRAINT IF EXISTS items_volume_validity_table_pkey;
ALTER TABLE IF EXISTS ONLY public.items_table DROP CONSTRAINT IF EXISTS items_table_pkey;
ALTER TABLE IF EXISTS ONLY public.items_table DROP CONSTRAINT IF EXISTS items_table_item_code_item_code1_key;
ALTER TABLE IF EXISTS ONLY public.items_period_validity_table DROP CONSTRAINT IF EXISTS items_period_validity_table_pkey;
ALTER TABLE IF EXISTS ONLY public.items_discount_group_table DROP CONSTRAINT IF EXISTS items_discount_group_table_pkey;
ALTER TABLE IF EXISTS ONLY public.item_uom_table DROP CONSTRAINT IF EXISTS item_uom_table_pkey;
ALTER TABLE IF EXISTS ONLY public.item_type DROP CONSTRAINT IF EXISTS item_type_pkey;
ALTER TABLE IF EXISTS ONLY public.item_sales_table DROP CONSTRAINT IF EXISTS item_sales_table_pkey;
ALTER TABLE IF EXISTS ONLY public.item_restrictions DROP CONSTRAINT IF EXISTS item_restrictions_store_id_item_id_key;
ALTER TABLE IF EXISTS ONLY public.item_restrictions DROP CONSTRAINT IF EXISTS item_restrictions_pkey;
ALTER TABLE IF EXISTS ONLY public.item_restriction_table DROP CONSTRAINT IF EXISTS item_restriction_table_pkey;
ALTER TABLE IF EXISTS ONLY public.item_remarks_table DROP CONSTRAINT IF EXISTS item_remarks_table_pkey;
ALTER TABLE IF EXISTS ONLY public.item_regional_restrictions DROP CONSTRAINT IF EXISTS item_regional_restrictions_store_id_item_id_key;
ALTER TABLE IF EXISTS ONLY public.item_regional_restrictions DROP CONSTRAINT IF EXISTS item_regional_restrictions_pkey;
ALTER TABLE IF EXISTS ONLY public.item_purchasing_table DROP CONSTRAINT IF EXISTS item_purchasing_table_pkey;
ALTER TABLE IF EXISTS ONLY public.item_planning_table DROP CONSTRAINT IF EXISTS item_planning_table_pkey;
ALTER TABLE IF EXISTS ONLY public.item_packing_information_table DROP CONSTRAINT IF EXISTS item_packing_information_table_pkey;
ALTER TABLE IF EXISTS ONLY public.item_molecule_name_table DROP CONSTRAINT IF EXISTS item_molecule_name_table_pkey;
ALTER TABLE IF EXISTS ONLY public.item_molecule_composition_table DROP CONSTRAINT IF EXISTS item_molecule_composition_table_pkey;
ALTER TABLE IF EXISTS ONLY public.item_min_max_for_pos_inventory DROP CONSTRAINT IF EXISTS item_min_max_for_pos_inventory_pkey;
ALTER TABLE IF EXISTS ONLY public.item_invetory_table DROP CONSTRAINT IF EXISTS item_invetory_table_pkey;
ALTER TABLE IF EXISTS ONLY public.item_group_table DROP CONSTRAINT IF EXISTS item_group_table_pkey;
ALTER TABLE IF EXISTS ONLY public.item_group DROP CONSTRAINT IF EXISTS item_group_pkey;
ALTER TABLE IF EXISTS ONLY public.item_generic_name_table DROP CONSTRAINT IF EXISTS item_generic_name_table_pkey;
ALTER TABLE IF EXISTS ONLY public.item_discount_and_scheme_table DROP CONSTRAINT IF EXISTS item_discount_and_scheme_table_pkey;
ALTER TABLE IF EXISTS ONLY public.item_composition_table DROP CONSTRAINT IF EXISTS item_composition_table_pkey;
ALTER TABLE IF EXISTS ONLY public.item_category DROP CONSTRAINT IF EXISTS item_category_pkey;
ALTER TABLE IF EXISTS ONLY public.invoice_credit_note DROP CONSTRAINT IF EXISTS invoice_credit_note_pkey;
ALTER TABLE IF EXISTS ONLY public.inventory_transfer_table DROP CONSTRAINT IF EXISTS inventory_transfer_table_pkey;
ALTER TABLE IF EXISTS ONLY public.inventory_status_table DROP CONSTRAINT IF EXISTS inventory_status_table_pkey;
ALTER TABLE IF EXISTS ONLY public.inventory_status_item_list_table DROP CONSTRAINT IF EXISTS inventory_status_item_list_table_pkey;
ALTER TABLE IF EXISTS ONLY public.inventory_status_condition_table DROP CONSTRAINT IF EXISTS inventory_status_condition_table_pkey;
ALTER TABLE IF EXISTS ONLY public.inventory_account_allocation_table DROP CONSTRAINT IF EXISTS inventory_account_allocation_table_pkey;
ALTER TABLE IF EXISTS ONLY public.insurance_provider_table DROP CONSTRAINT IF EXISTS insurance_provider_table_pkey;
ALTER TABLE IF EXISTS ONLY public.industry_sector_table DROP CONSTRAINT IF EXISTS industry_sector_table_pkey;
ALTER TABLE IF EXISTS ONLY public.id_proof_type_table DROP CONSTRAINT IF EXISTS id_proof_type_table_pkey;
ALTER TABLE IF EXISTS ONLY public.group_table DROP CONSTRAINT IF EXISTS group_table_pkey;
ALTER TABLE IF EXISTS ONLY public.goods_order_receipt_table DROP CONSTRAINT IF EXISTS goods_order_receipt_table_pkey;
ALTER TABLE IF EXISTS ONLY public.generic_name_table DROP CONSTRAINT IF EXISTS generic_name_table_pkey;
ALTER TABLE IF EXISTS ONLY public.general_accounts_table DROP CONSTRAINT IF EXISTS general_accounts_table_pkey;
ALTER TABLE IF EXISTS ONLY public.general_account_allocation_table DROP CONSTRAINT IF EXISTS general_account_allocation_table_pkey;
ALTER TABLE IF EXISTS ONLY public.gender_table DROP CONSTRAINT IF EXISTS gender_table_pkey;
ALTER TABLE IF EXISTS ONLY public.favorite DROP CONSTRAINT IF EXISTS favorite_pkey;
ALTER TABLE IF EXISTS ONLY public.excel_import_column_mapping_table DROP CONSTRAINT IF EXISTS excel_import_column_mapping_table_pkey;
ALTER TABLE IF EXISTS ONLY public.document_types DROP CONSTRAINT IF EXISTS document_types_pkey;
ALTER TABLE IF EXISTS ONLY public.document_table DROP CONSTRAINT IF EXISTS document_table_pkey;
ALTER TABLE IF EXISTS ONLY public.document_numbering_series_table DROP CONSTRAINT IF EXISTS document_numbering_series_table_pkey;
ALTER TABLE IF EXISTS ONLY public.document_numbering_series DROP CONSTRAINT IF EXISTS document_numbering_series_pkey;
ALTER TABLE IF EXISTS ONLY public.document_numbering DROP CONSTRAINT IF EXISTS document_numbering_pkey;
ALTER TABLE IF EXISTS ONLY public.document_custom_table DROP CONSTRAINT IF EXISTS document_custom_table_pkey;
ALTER TABLE IF EXISTS ONLY public.document_custom_numbering_series_table DROP CONSTRAINT IF EXISTS document_custom_numbering_series_table_pkey;
ALTER TABLE IF EXISTS ONLY public.doctor_table DROP CONSTRAINT IF EXISTS doctor_table_pkey;
ALTER TABLE IF EXISTS ONLY public.district_table DROP CONSTRAINT IF EXISTS district_table_pkey;
ALTER TABLE IF EXISTS ONLY public.discount_type_table DROP CONSTRAINT IF EXISTS discount_type_table_pkey;
ALTER TABLE IF EXISTS ONLY public.discount_table DROP CONSTRAINT IF EXISTS discount_table_pkey;
ALTER TABLE IF EXISTS ONLY public.discount_group_table DROP CONSTRAINT IF EXISTS discount_group_table_pkey;
ALTER TABLE IF EXISTS ONLY public.department_table DROP CONSTRAINT IF EXISTS department_table_pkey;
ALTER TABLE IF EXISTS ONLY public.department_table DROP CONSTRAINT IF EXISTS department_table_department_name_key;
ALTER TABLE IF EXISTS ONLY public.customer_ship_to_address DROP CONSTRAINT IF EXISTS customer_ship_to_address_pkey;
ALTER TABLE IF EXISTS ONLY public.customer_payment_terms_table DROP CONSTRAINT IF EXISTS customer_payment_terms_table_pkey;
ALTER TABLE IF EXISTS ONLY public.customer_pay_to_address DROP CONSTRAINT IF EXISTS customer_pay_to_address_pkey;
ALTER TABLE IF EXISTS ONLY public.customer_patient_info_table DROP CONSTRAINT IF EXISTS customer_patient_info_table_pkey;
ALTER TABLE IF EXISTS ONLY public.customer_group_table DROP CONSTRAINT IF EXISTS customer_group_table_pkey;
ALTER TABLE IF EXISTS ONLY public.customer_general_details DROP CONSTRAINT IF EXISTS customer_general_details_pkey;
ALTER TABLE IF EXISTS ONLY public.customer_details DROP CONSTRAINT IF EXISTS customer_details_pkey;
ALTER TABLE IF EXISTS ONLY public.customer_contact_persons DROP CONSTRAINT IF EXISTS customer_contact_persons_pkey;
ALTER TABLE IF EXISTS ONLY public.customer_bank_details DROP CONSTRAINT IF EXISTS customer_bank_details_pkey;
ALTER TABLE IF EXISTS ONLY public.customer_accounting_table DROP CONSTRAINT IF EXISTS customer_accounting_table_pkey;
ALTER TABLE IF EXISTS ONLY public.custom_reports DROP CONSTRAINT IF EXISTS custom_reports_pkey;
ALTER TABLE IF EXISTS ONLY public.custom_invoice DROP CONSTRAINT IF EXISTS custom_invoice_pkey;
ALTER TABLE IF EXISTS ONLY public.country_table DROP CONSTRAINT IF EXISTS country_table_pkey;
ALTER TABLE IF EXISTS ONLY public.cmr_master_data_table DROP CONSTRAINT IF EXISTS cmr_master_data_table_pkey;
ALTER TABLE IF EXISTS ONLY public.cmr_insurance_policy_table DROP CONSTRAINT IF EXISTS cmr_insurance_policy_table_pkey;
ALTER TABLE IF EXISTS ONLY public.cmr_family_table DROP CONSTRAINT IF EXISTS cmr_family_table_pkey;
ALTER TABLE IF EXISTS ONLY public.city_table DROP CONSTRAINT IF EXISTS city_table_pkey;
ALTER TABLE IF EXISTS ONLY public.carton_type_table DROP CONSTRAINT IF EXISTS carton_type_table_pkey;
ALTER TABLE IF EXISTS ONLY public.blood_group_table DROP CONSTRAINT IF EXISTS blood_group_table_pkey;
ALTER TABLE IF EXISTS ONLY public.bin_location_table DROP CONSTRAINT IF EXISTS bin_location_table_pkey;
ALTER TABLE IF EXISTS ONLY public.bank_list_table DROP CONSTRAINT IF EXISTS bank_list_table_pkey;
ALTER TABLE IF EXISTS ONLY public.area_table DROP CONSTRAINT IF EXISTS area_table_pkey;
ALTER TABLE IF EXISTS ONLY public.approval_stages DROP CONSTRAINT IF EXISTS approval_stages_pkey;
ALTER TABLE IF EXISTS ONLY public.approval_requests DROP CONSTRAINT IF EXISTS approval_requests_pkey;
ALTER TABLE IF EXISTS ONLY public.approval_request_stages DROP CONSTRAINT IF EXISTS approval_request_stages_pkey;
ALTER TABLE IF EXISTS ONLY public.approval_originators DROP CONSTRAINT IF EXISTS approval_originators_pkey;
ALTER TABLE IF EXISTS ONLY public.approval_flows DROP CONSTRAINT IF EXISTS approval_flows_pkey;
ALTER TABLE IF EXISTS ONLY public.approval_document_terms DROP CONSTRAINT IF EXISTS approval_document_terms_pkey;
ALTER TABLE IF EXISTS ONLY public.alternative_items_table DROP CONSTRAINT IF EXISTS alternative_items_table_pkey;
ALTER TABLE IF EXISTS ONLY public.all_store_details_table DROP CONSTRAINT IF EXISTS all_store_details_table_pkey;
ALTER TABLE IF EXISTS ONLY public.addedfavorite DROP CONSTRAINT IF EXISTS addedfavorite_pkey;
ALTER TABLE IF EXISTS ONLY public.acquried_source_table DROP CONSTRAINT IF EXISTS acquried_source_table_pkey;
ALTER TABLE IF EXISTS ONLY public."Favorite" DROP CONSTRAINT IF EXISTS "Favorite_pkey";
ALTER TABLE IF EXISTS public.print_preferences ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.print_prefer ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.migrations_history ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.item_restrictions ALTER COLUMN restriction_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.document_types ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.approval_stages ALTER COLUMN stages_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.approval_originators ALTER COLUMN originator_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.approval_flows ALTER COLUMN approval_flow_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.approval_document_terms ALTER COLUMN term_id DROP DEFAULT;
DROP TABLE IF EXISTS public.whatsapp_config;
DROP TABLE IF EXISTS public.warehouses_table;
DROP TABLE IF EXISTS public.users_table;
DROP TABLE IF EXISTS public.users_permission_table;
DROP TABLE IF EXISTS public.user_column_preferences_default_values;
DROP TABLE IF EXISTS public.user_column_preferences;
DROP TABLE IF EXISTS public.uom_table;
DROP SEQUENCE IF EXISTS public.uom_number_code_seq;
DROP TABLE IF EXISTS public.uom_group_table;
DROP TABLE IF EXISTS public.uom_group_item;
DROP TABLE IF EXISTS public.uom_group;
DROP TABLE IF EXISTS public.unit_of_measure;
DROP TABLE IF EXISTS public.terms_and_conditions_table;
DROP TABLE IF EXISTS public.tds_table;
DROP TABLE IF EXISTS public.tcs_table;
DROP TABLE IF EXISTS public.tax_type;
DROP TABLE IF EXISTS public.tax_table;
DROP TABLE IF EXISTS public.tax_combination_item;
DROP SEQUENCE IF EXISTS public.tax_combination_code_seq;
DROP TABLE IF EXISTS public.tax_combination;
DROP TABLE IF EXISTS public.sync_runs;
DROP TABLE IF EXISTS public.sync_rules;
DROP TABLE IF EXISTS public.sublevel_table;
DROP TABLE IF EXISTS public.sublevel_bins;
DROP TABLE IF EXISTS public.sub_specialization_table;
DROP TABLE IF EXISTS public.stripe_config;
DROP TABLE IF EXISTS public.store_opening_details_table;
DROP TABLE IF EXISTS public.store_inventory_table;
DROP TABLE IF EXISTS public.store_inventory_item_location_table;
DROP TABLE IF EXISTS public.store_infrastructure_details_table;
DROP TABLE IF EXISTS public.store_information_for_user_table;
DROP TABLE IF EXISTS public.store_info_personal_details_table;
DROP TABLE IF EXISTS public.store_info_payment_table;
DROP TABLE IF EXISTS public.store_info_firm_details_table;
DROP TABLE IF EXISTS public.store_info_drug_license_table;
DROP TABLE IF EXISTS public.store_info_address_table;
DROP TABLE IF EXISTS public.store_followup_and_history_table;
DROP TABLE IF EXISTS public.store_dispatch_details_table;
DROP TABLE IF EXISTS public.store_branding_details_table;
DROP TABLE IF EXISTS public.store_branding_and_store_software_details_table;
DROP TABLE IF EXISTS public.store_app_user_number_table;
DROP TABLE IF EXISTS public.store_agreement_table;
DROP TABLE IF EXISTS public.store_account_details_table;
DROP TABLE IF EXISTS public.stock_request_table;
DROP TABLE IF EXISTS public.stock_in_out_table;
DROP TABLE IF EXISTS public.stock_audit_table;
DROP TABLE IF EXISTS public.stock_audit_items_table;
DROP TABLE IF EXISTS public.state_table;
DROP TABLE IF EXISTS public.specialization_table;
DROP SEQUENCE IF EXISTS public.sott_invoice_number;
DROP SEQUENCE IF EXISTS public.sot_invoice_number;
DROP TABLE IF EXISTS public.socket_connection_id_table;
DROP TABLE IF EXISTS public.smtp_config;
DROP TABLE IF EXISTS public.sms_config;
DROP TABLE IF EXISTS public.shipping_type;
DROP TABLE IF EXISTS public.server_ips;
DROP TABLE IF EXISTS public.sales_return_table;
DROP TABLE IF EXISTS public.sales_return_items_list;
DROP TABLE IF EXISTS public.sales_return_items_batches_list;
DROP TABLE IF EXISTS public.sales_return_document_list;
DROP VIEW IF EXISTS public.sales_report_vw;
DROP TABLE IF EXISTS public.sales_order_transaction_table;
DROP TABLE IF EXISTS public.sales_order_items_list;
DROP TABLE IF EXISTS public.sales_order_invoice_table;
DROP TABLE IF EXISTS public.sales_order_invoice_items_list;
DROP TABLE IF EXISTS public.sales_order_invoice_items_batches_list;
DROP TABLE IF EXISTS public.sales_order_invoice_document_list;
DROP TABLE IF EXISTS public.sales_order_document_list;
DROP TABLE IF EXISTS public.sales_order_delivery_transaction_table;
DROP TABLE IF EXISTS public.sales_order;
DROP TABLE IF EXISTS public.sales_credit_table;
DROP TABLE IF EXISTS public.sales_credit_items_list_table;
DROP TABLE IF EXISTS public.sales_credit_items_batches_list;
DROP TABLE IF EXISTS public.sales_account_allocation_table;
DROP TABLE IF EXISTS public.sale_order_delivery_items_list;
DROP TABLE IF EXISTS public.sale_order_delivery_items_batches_list;
DROP TABLE IF EXISTS public.sale_order_delivery_document_list;
DROP TABLE IF EXISTS public.roles_table;
DROP TABLE IF EXISTS public.reporttags;
DROP TABLE IF EXISTS public.relationship_table;
DROP TABLE IF EXISTS public.region_table;
DROP TABLE IF EXISTS public.razorpay_config;
DROP TABLE IF EXISTS public.purchase_return_table;
DROP TABLE IF EXISTS public.purchase_return_items_list;
DROP TABLE IF EXISTS public.purchase_return_items_batches_list;
DROP TABLE IF EXISTS public.purchase_return_document_list;
DROP TABLE IF EXISTS public.purchase_order_transaction_table;
DROP TABLE IF EXISTS public.purchase_order_items_list;
DROP TABLE IF EXISTS public.purchase_order_invoice_table;
DROP TABLE IF EXISTS public.purchase_order_invoice_items_list;
DROP TABLE IF EXISTS public.purchase_order_invoice_items_batches_list;
DROP TABLE IF EXISTS public.purchase_order_invoice_document_list;
DROP TABLE IF EXISTS public.purchase_order_document_list;
DROP TABLE IF EXISTS public.purchase_credit_table;
DROP TABLE IF EXISTS public.purchase_credit_of_invoice;
DROP TABLE IF EXISTS public.purchase_credit_of_grn;
DROP TABLE IF EXISTS public.purchase_credit_items_list_table;
DROP TABLE IF EXISTS public.purchase_credit_items_batches_list;
DROP TABLE IF EXISTS public.purchase_account_allocation_table;
DROP TABLE IF EXISTS public.product_schedule_table;
DROP SEQUENCE IF EXISTS public.print_preferences_id_seq;
DROP TABLE IF EXISTS public.print_preferences;
DROP TABLE IF EXISTS public.print_preference;
DROP SEQUENCE IF EXISTS public.print_prefer_id_seq;
DROP TABLE IF EXISTS public.print_prefer;
DROP TABLE IF EXISTS public.price_list_table;
DROP TABLE IF EXISTS public.price_list_items_table;
DROP TABLE IF EXISTS public.pos_store_inventory_item_location_table;
DROP TABLE IF EXISTS public.pos_items_batch_no_table;
DROP TABLE IF EXISTS public.pine_labs_config;
DROP TABLE IF EXISTS public.phonepe_config;
DROP TABLE IF EXISTS public.period_volume_discount_table;
DROP TABLE IF EXISTS public.period_volume_discount_items_table;
DROP TABLE IF EXISTS public.paytm_config;
DROP TABLE IF EXISTS public.payment_type_table;
DROP TABLE IF EXISTS public.payment_terms_table;
DROP TABLE IF EXISTS public.payment_out_table;
DROP TABLE IF EXISTS public.payment_out_modes_table;
DROP TABLE IF EXISTS public.payment_out_document_list_table;
DROP TABLE IF EXISTS public.payment_modes_table;
DROP TABLE IF EXISTS public.payment_in_table;
DROP TABLE IF EXISTS public.payment_in_document_list_table;
DROP TABLE IF EXISTS public.party_type_table;
DROP TABLE IF EXISTS public.party_group_table;
DROP TABLE IF EXISTS public.party_category_table;
DROP TABLE IF EXISTS public.packing_type_table;
DROP TABLE IF EXISTS public.packing_table;
DROP TABLE IF EXISTS public.otp_table;
DROP TABLE IF EXISTS public.order_items_list;
DROP TABLE IF EXISTS public.notification_triggered_history;
DROP TABLE IF EXISTS public.notification_recipient;
DROP TABLE IF EXISTS public.notification_communication_channel;
DROP TABLE IF EXISTS public.notification;
DROP TABLE IF EXISTS public.module_table;
DROP TABLE IF EXISTS public.module_setting;
DROP SEQUENCE IF EXISTS public.migrations_history_id_seq;
DROP TABLE IF EXISTS public.migrations_history;
DROP TABLE IF EXISTS public.migration_log;
DROP TABLE IF EXISTS public.manufactures_group_discount_group_table;
DROP SEQUENCE IF EXISTS public.manufacturer_code_seq;
DROP TABLE IF EXISTS public.manufacturer;
DROP TABLE IF EXISTS public.manufacture_group_table;
DROP TABLE IF EXISTS public.main_module_table;
DROP TABLE IF EXISTS public.lead_details;
DROP TABLE IF EXISTS public.journal_entry_table;
DROP TABLE IF EXISTS public.journal_entry_rows_table;
DROP TABLE IF EXISTS public.items_volume_validity_table;
DROP TABLE IF EXISTS public.items_table;
DROP TABLE IF EXISTS public.items_period_validity_table;
DROP TABLE IF EXISTS public.items_group_discount_group_table;
DROP TABLE IF EXISTS public.items_discount_group_table;
DROP TABLE IF EXISTS public.items_batch_no_table;
DROP TABLE IF EXISTS public.item_uom_table;
DROP TABLE IF EXISTS public.item_uom_group_table;
DROP TABLE IF EXISTS public.item_uom_barcode_table;
DROP SEQUENCE IF EXISTS public.item_type_code_seq;
DROP TABLE IF EXISTS public.item_type;
DROP TABLE IF EXISTS public.item_sales_table;
DROP SEQUENCE IF EXISTS public.item_restrictions_restriction_id_seq;
DROP TABLE IF EXISTS public.item_restrictions;
DROP TABLE IF EXISTS public.item_restriction_table;
DROP TABLE IF EXISTS public.item_remarks_table;
DROP TABLE IF EXISTS public.item_regional_restrictions;
DROP TABLE IF EXISTS public.item_purchasing_table;
DROP TABLE IF EXISTS public.item_planning_table;
DROP TABLE IF EXISTS public.item_packing_information_table;
DROP TABLE IF EXISTS public.item_molecule_name_table;
DROP TABLE IF EXISTS public.item_molecule_composition_table;
DROP TABLE IF EXISTS public.item_min_max_for_pos_inventory;
DROP TABLE IF EXISTS public.item_invetory_table;
DROP TABLE IF EXISTS public.item_group_table;
DROP SEQUENCE IF EXISTS public.item_group_code_seq;
DROP TABLE IF EXISTS public.item_group;
DROP TABLE IF EXISTS public.item_generic_name_table;
DROP TABLE IF EXISTS public.item_discount_and_scheme_table;
DROP TABLE IF EXISTS public.item_composition_table;
DROP SEQUENCE IF EXISTS public.item_category_code_seq;
DROP TABLE IF EXISTS public.item_category;
DROP TABLE IF EXISTS public.item_barcode_table;
DROP TABLE IF EXISTS public.invoice_credit_note_item_list;
DROP TABLE IF EXISTS public.invoice_credit_note;
DROP TABLE IF EXISTS public.inventory_transfer_table;
DROP TABLE IF EXISTS public.inventory_transfer_rows_table;
DROP TABLE IF EXISTS public.inventory_transfer_item_batches_table;
DROP TABLE IF EXISTS public.inventory_status_table;
DROP TABLE IF EXISTS public.inventory_status_item_list_table;
DROP TABLE IF EXISTS public.inventory_status_condition_table;
DROP TABLE IF EXISTS public.inventory_account_allocation_table;
DROP TABLE IF EXISTS public.insurance_provider_table;
DROP TABLE IF EXISTS public.industry_sector_table;
DROP TABLE IF EXISTS public.id_proof_type_table;
DROP TABLE IF EXISTS public.group_table;
DROP TABLE IF EXISTS public.goods_order_receipt_table;
DROP TABLE IF EXISTS public.goods_order_document_list;
DROP TABLE IF EXISTS public.good_order_receipt_items_list;
DROP TABLE IF EXISTS public.good_order_receipt_items_batches_list;
DROP TABLE IF EXISTS public.generic_name_table;
DROP TABLE IF EXISTS public.general_accounts_table;
DROP TABLE IF EXISTS public.general_account_allocation_table;
DROP TABLE IF EXISTS public.gender_table;
DROP TABLE IF EXISTS public.favorite;
DROP TABLE IF EXISTS public.excel_import_column_mapping_table;
DROP SEQUENCE IF EXISTS public.document_types_id_seq;
DROP TABLE IF EXISTS public.document_types;
DROP TABLE IF EXISTS public.document_type_table;
DROP TABLE IF EXISTS public.document_table;
DROP TABLE IF EXISTS public.document_numbering_series_table;
DROP TABLE IF EXISTS public.document_numbering_series;
DROP TABLE IF EXISTS public.document_numbering;
DROP TABLE IF EXISTS public.document_custom_table;
DROP TABLE IF EXISTS public.document_custom_numbering_series_table;
DROP TABLE IF EXISTS public.doctor_table;
DROP TABLE IF EXISTS public.district_table;
DROP TABLE IF EXISTS public.discount_type_table;
DROP TABLE IF EXISTS public.discount_table;
DROP TABLE IF EXISTS public.discount_group_table;
DROP TABLE IF EXISTS public.department_table;
DROP TABLE IF EXISTS public.customer_ship_to_address;
DROP TABLE IF EXISTS public.customer_payment_terms_table;
DROP TABLE IF EXISTS public.customer_pay_to_address;
DROP TABLE IF EXISTS public.customer_patient_info_table;
DROP TABLE IF EXISTS public.customer_group_table;
DROP TABLE IF EXISTS public.customer_general_details;
DROP TABLE IF EXISTS public.customer_details;
DROP TABLE IF EXISTS public.customer_contact_persons;
DROP TABLE IF EXISTS public.customer_bank_details;
DROP TABLE IF EXISTS public.customer_accounting_table;
DROP TABLE IF EXISTS public.custom_reports;
DROP TABLE IF EXISTS public.custom_invoice;
DROP TABLE IF EXISTS public.credit_note_invoice_payment_modes;
DROP TABLE IF EXISTS public.country_table;
DROP SEQUENCE IF EXISTS public.cmr_number;
DROP TABLE IF EXISTS public.cmr_master_data_table;
DROP TABLE IF EXISTS public.cmr_insurance_policy_table;
DROP TABLE IF EXISTS public.cmr_family_table;
DROP TABLE IF EXISTS public.city_table;
DROP TABLE IF EXISTS public.carton_type_table;
DROP TABLE IF EXISTS public.blood_group_table;
DROP TABLE IF EXISTS public.bin_location_table;
DROP TABLE IF EXISTS public.billing_invoice_payment_modes;
DROP TABLE IF EXISTS public.bank_list_table;
DROP TABLE IF EXISTS public.area_table;
DROP SEQUENCE IF EXISTS public.approval_stages_stages_id_seq;
DROP TABLE IF EXISTS public.approval_stages;
DROP TABLE IF EXISTS public.approval_requests;
DROP TABLE IF EXISTS public.approval_request_stages;
DROP SEQUENCE IF EXISTS public.approval_originators_originator_id_seq;
DROP TABLE IF EXISTS public.approval_originators;
DROP SEQUENCE IF EXISTS public.approval_flows_approval_flow_id_seq;
DROP TABLE IF EXISTS public.approval_flows;
DROP SEQUENCE IF EXISTS public.approval_document_terms_term_id_seq;
DROP TABLE IF EXISTS public.approval_document_terms;
DROP TABLE IF EXISTS public.alternative_items_table;
DROP SEQUENCE IF EXISTS public.alternative_item_code_seq;
DROP TABLE IF EXISTS public.all_store_details_table;
DROP TABLE IF EXISTS public.addedfavorite;
DROP TABLE IF EXISTS public.acquried_source_table;
DROP TABLE IF EXISTS public."Favorite";
DROP FUNCTION IF EXISTS public.update_selling_price_on_purchase_rate_margin_factor_change();
DROP FUNCTION IF EXISTS public.update_item_selling_price();
DROP FUNCTION IF EXISTS public.notify_sales_order_insert();
DROP FUNCTION IF EXISTS public.notify_price_change();
DROP FUNCTION IF EXISTS public.notify_order_items_list_insert();
DROP FUNCTION IF EXISTS public.notify_event();
DROP FUNCTION IF EXISTS public.generate_uom_number();
DROP FUNCTION IF EXISTS public.generate_tax_combination_number();
DROP FUNCTION IF EXISTS public.generate_sales_orderinvoice_number(store_id character varying);
DROP FUNCTION IF EXISTS public.generate_sale_order_invoice_number(store_id character varying);
DROP FUNCTION IF EXISTS public.generate_manufacturer_number();
DROP FUNCTION IF EXISTS public.generate_item_type_number();
DROP FUNCTION IF EXISTS public.generate_item_group_number();
DROP FUNCTION IF EXISTS public.generate_item_category_number();
DROP FUNCTION IF EXISTS public.generate_invoice_number(store_id character varying);
DROP FUNCTION IF EXISTS public.generate_cmr_number(store_id character varying);
DROP FUNCTION IF EXISTS public.generate_cmr_number();
DROP FUNCTION IF EXISTS public.alternative_item_number();
DROP DOMAIN IF EXISTS public.int_or_uuid;
-- *not* dropping schema, since initdb creates it
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

-- *not* creating schema, since initdb creates it


--
-- Name: int_or_uuid; Type: DOMAIN; Schema: public; Owner: -
--

CREATE DOMAIN public.int_or_uuid AS text
	CONSTRAINT int_or_uuid_check CHECK (((VALUE ~ '^\d+$'::text) OR (VALUE ~* '^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$'::text)));


--
-- Name: alternative_item_number(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.alternative_item_number() RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
  next_code INT;
BEGIN
  next_code := nextval('alternative_item_code_seq');
  RETURN 'ali' || next_code;
END;
$$;


--
-- Name: generate_cmr_number(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.generate_cmr_number() RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
  seq_val INT;
BEGIN
  SELECT nextval('cmr_number') INTO seq_val;
  RETURN 'cmr' || seq_val::TEXT;
END;
$$;


--
-- Name: generate_cmr_number(character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.generate_cmr_number(store_id character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
  DECLARE
    seq_val VARCHAR;
  BEGIN
    SELECT nextval('cmr_number') INTO seq_val;
    RETURN LPAD(store_id::TEXT, 5, '0') || LPAD(seq_val::TEXT, 5, '0');
  END;
  $$;


--
-- Name: generate_invoice_number(character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.generate_invoice_number(store_id character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
seq_val VARCHAR;
current_date_str VARCHAR;
BEGIN
SELECT nextval('sot_invoice_number') INTO seq_val;
SELECT TO_CHAR(CURRENT_DATE, 'YYYYMMDD') INTO current_date_str;

-- Calculate the length of store_id and adjust padding
RETURN 
    CASE 
        WHEN LENGTH(store_id) < 3 THEN store_id || current_date_str || LPAD(seq_val::TEXT, 7, '0')
        ELSE store_id || current_date_str || LPAD(seq_val::TEXT, 5, '0')
    END;
END;
$$;


--
-- Name: generate_item_category_number(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.generate_item_category_number() RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
  next_code INT;
BEGIN
  next_code := nextval('item_category_code_seq');
  RETURN 'ic' || next_code;
END;
$$;


--
-- Name: generate_item_group_number(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.generate_item_group_number() RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
  next_code INT;
BEGIN
  next_code := nextval('item_group_code_seq');
  RETURN 'ig' || next_code; 
END;
$$;


--
-- Name: generate_item_type_number(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.generate_item_type_number() RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
  next_code INT;
BEGIN
  next_code := nextval('item_type_code_seq');
  RETURN 'it' || next_code;
END;
$$;


--
-- Name: generate_manufacturer_number(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.generate_manufacturer_number() RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
  next_code INT;
BEGIN
  next_code := nextval('manufacturer_code_seq');
  RETURN 'mnf' || next_code;
END;
$$;


--
-- Name: generate_sale_order_invoice_number(character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.generate_sale_order_invoice_number(store_id character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
seq_val VARCHAR;
current_date_str VARCHAR;
BEGIN
SELECT nextval('sott_invoice_number') INTO seq_val;
SELECT TO_CHAR(CURRENT_DATE, 'YYYYMMDD') INTO current_date_str;

-- Calculate the length of store_id and adjust padding
RETURN 
    CASE 
        WHEN LENGTH(store_id) < 3 THEN store_id || current_date_str || LPAD(seq_val::TEXT, 7, '0')
        ELSE store_id || current_date_str || LPAD(seq_val::TEXT, 5, '0')
    END;
END;
$$;


--
-- Name: generate_sales_orderinvoice_number(character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.generate_sales_orderinvoice_number(store_id character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
seq_val VARCHAR;
current_date_str VARCHAR;
BEGIN
SELECT nextval('sott_invoice_number') INTO seq_val;
SELECT TO_CHAR(CURRENT_DATE, 'YYYYMMDD') INTO current_date_str;

-- Calculate the length of store_id and adjust padding
RETURN 
    CASE 
        WHEN LENGTH(store_id) < 3 THEN store_id || current_date_str || LPAD(seq_val::TEXT, 7, '0')
        ELSE store_id || current_date_str || LPAD(seq_val::TEXT, 5, '0')
    END;
END;
$$;


--
-- Name: generate_tax_combination_number(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.generate_tax_combination_number() RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
  next_code INT;
BEGIN
  next_code := nextval('tax_combination_code_seq');
  RETURN 'tcn' || next_code;
END;
$$;


--
-- Name: generate_uom_number(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.generate_uom_number() RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
  next_code INT;
BEGIN
  next_code := nextval('uom_number_code_seq');
  RETURN 'uom' || next_code;
END;
$$;


--
-- Name: notify_event(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.notify_event() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
  IF TG_OP = 'DELETE' THEN
    PERFORM pg_notify(
      'customer_details_event',
      json_build_object(
        'action', TG_OP, -- The type of operation
        'data', row_to_json(OLD)
      )::text
    );
  ELSE
    PERFORM pg_notify(
      'customer_details_event',
      json_build_object(
        'action', TG_OP, -- The type of operation
        'data', row_to_json(NEW)
      )::text
    );
  END IF;
  
  RETURN NULL; -- We don't return anything from triggers
END;
$$;


--
-- Name: notify_order_items_list_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.notify_order_items_list_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    payload JSON;
BEGIN
    -- Check if the inserted row is linked to sales_order and is_draft_order is false
    IF EXISTS (
        SELECT 1
        FROM sales_order so
        WHERE so.sot_id = NEW.sot_id
        AND so.is_draft_order = FALSE
    ) THEN
        -- Construct JSON payload with operation type and new row data
        payload := json_build_object(
			'table', TG_TABLE_NAME, 
            'action', TG_OP, -- The type of operation
            'data', row_to_json(NEW) -- The new row data
        );

        -- Notify with JSON payload
        PERFORM pg_notify('order_items_list_insert', payload::text);
    END IF;

    RETURN NEW;
END;
$$;


--
-- Name: notify_price_change(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.notify_price_change() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
      PERFORM pg_notify(
        'price_change_event',
        json_build_object(
          'action', TG_OP, -- The type of operation
          'data', row_to_json(NEW)
        )::text
      );
      RETURN NEW;
    END;
    $$;


--
-- Name: notify_sales_order_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.notify_sales_order_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    payload JSON;
BEGIN
    -- Check if the inserted row meets the conditions
    IF NEW.is_draft_order = FALSE THEN
        -- Construct JSON payload with operation type and new row data
        payload := json_build_object(
			'table', TG_TABLE_NAME, 
            'action', TG_OP, -- The type of operation
            'data', row_to_json(NEW) -- The new row data
        );

        -- Notify with JSON payload
        PERFORM pg_notify('sales_order_insert', payload::text);
    END IF;

    RETURN NEW;
END;
$$;


--
-- Name: update_item_selling_price(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_item_selling_price() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    base_price DECIMAL(10,2);
BEGIN
    SELECT item_base_price INTO base_price
    FROM price_list_items_table
    WHERE price_list_id = NEW.price_list_id
    LIMIT 1;

    IF FOUND THEN
        UPDATE price_list_items_table
        SET item_selling_price = item_base_price * NEW.default_factor
        WHERE price_list_id = NEW.price_list_id;
    END IF;

    RETURN NEW;
END;
$$;


--
-- Name: update_selling_price_on_purchase_rate_margin_factor_change(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_selling_price_on_purchase_rate_margin_factor_change() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Update the selling price for all items in the affected price list
    UPDATE price_list_items_table
    SET item_selling_price = item_batch_final_purchase_rate * NEW.margin_factor
    WHERE price_list_id = NEW.price_list_id;

    -- Return the NEW record
    RETURN NEW;
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Favorite; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Favorite" (
    name character varying(36) NOT NULL,
    query text,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: acquried_source_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.acquried_source_table (
    id character varying(26) NOT NULL,
    name character varying(100) NOT NULL,
    code character varying(26),
    discription text,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: addedfavorite; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.addedfavorite (
    id character varying(1) NOT NULL,
    titles text[]
);


--
-- Name: all_store_details_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.all_store_details_table (
    warehouse_id character varying(255) NOT NULL,
    warehouse_name character varying(255),
    warehouse_ip_address character varying(255),
    warehouse_addresss character varying(255),
    update_sign character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: alternative_item_code_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.alternative_item_code_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: alternative_items_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.alternative_items_table (
    alternative_item_id character varying(255) NOT NULL,
    main_item_id character varying(255),
    alternative_item_code character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    alternative_id character varying(255)
);


--
-- Name: approval_document_terms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.approval_document_terms (
    term_id integer NOT NULL,
    approval_flow_id integer,
    document_category character varying(255),
    document_types character varying(255)[],
    conditions jsonb
);


--
-- Name: approval_document_terms_term_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.approval_document_terms_term_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: approval_document_terms_term_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.approval_document_terms_term_id_seq OWNED BY public.approval_document_terms.term_id;


--
-- Name: approval_flows; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.approval_flows (
    approval_flow_id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    is_active boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


--
-- Name: approval_flows_approval_flow_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.approval_flows_approval_flow_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: approval_flows_approval_flow_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.approval_flows_approval_flow_id_seq OWNED BY public.approval_flows.approval_flow_id;


--
-- Name: approval_originators; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.approval_originators (
    originator_id integer NOT NULL,
    approval_flow_id integer,
    department character varying(255),
    role character varying(255),
    user_ids integer[]
);


--
-- Name: approval_originators_originator_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.approval_originators_originator_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: approval_originators_originator_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.approval_originators_originator_id_seq OWNED BY public.approval_originators.originator_id;


--
-- Name: approval_request_stages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.approval_request_stages (
    request_stage_id character varying(255) NOT NULL,
    request_id character varying(255),
    stage_index character varying(255),
    role character varying(255),
    user_ids character varying(255)[],
    status character varying(50) DEFAULT 'waiting'::character varying,
    actions character varying(255)[],
    approved_by character varying(255)[],
    approved_at timestamp with time zone[],
    comments jsonb
);


--
-- Name: approval_requests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.approval_requests (
    request_id character varying(255) NOT NULL,
    approval_flow_id integer,
    document_details jsonb,
    created_by character varying(50),
    priority character varying(50),
    status character varying(50) DEFAULT 'pending'::character varying,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


--
-- Name: approval_stages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.approval_stages (
    stages_id integer NOT NULL,
    approval_flow_id integer,
    stages jsonb
);


--
-- Name: approval_stages_stages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.approval_stages_stages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: approval_stages_stages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.approval_stages_stages_id_seq OWNED BY public.approval_stages.stages_id;


--
-- Name: area_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.area_table (
    id character varying(26) NOT NULL,
    name character varying(100) NOT NULL,
    code character varying(26),
    discription text,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: bank_list_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bank_list_table (
    bank_id character varying(255) NOT NULL,
    bank_name character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: billing_invoice_payment_modes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.billing_invoice_payment_modes (
    sot_id character varying(255),
    payment_mode_name character varying(255),
    payment_amount numeric(10,2),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    transaction_id character varying(255)
);


--
-- Name: bin_location_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bin_location_table (
    warehouse_id character varying(255) NOT NULL,
    bin_location_code_separator character varying(255),
    default_bin_location character varying(50),
    auto_alloc_on_issue character varying(50),
    auto_alloc_on_receipt character varying(50),
    enable_receiving_bin_location boolean DEFAULT false,
    enforce_default_bin_location boolean DEFAULT false,
    receive_up_to_max_quantity boolean DEFAULT false,
    receive_up_to_max_weight boolean DEFAULT false,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: blood_group_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.blood_group_table (
    id character varying(26) NOT NULL,
    name character varying(100) NOT NULL,
    code character varying(26),
    discription text,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: carton_type_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.carton_type_table (
    id character varying(26) NOT NULL,
    name character varying(100) NOT NULL,
    code character varying(26),
    discription text,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: city_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.city_table (
    id character varying(26) NOT NULL,
    name character varying(100) NOT NULL,
    code character varying(26),
    discription text,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: cmr_family_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cmr_family_table (
    cmr_family_id character varying(26) NOT NULL,
    cmr_id character varying(26) NOT NULL,
    cmr_full_name character varying(255),
    cmr_relationship character varying(100),
    cmr_dob date,
    cmr_phone_number character varying(20),
    cmr_email character varying(255),
    cmr_address text,
    cmr_remarks text,
    cmr_is_default boolean DEFAULT false,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: cmr_insurance_policy_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cmr_insurance_policy_table (
    cmr_policy_id character varying(26) NOT NULL,
    cmr_id character varying(26) NOT NULL,
    cmr_policy_holder_name character varying(255),
    cmr_policy_number character varying(100),
    cmr_insurance_provider character varying(255),
    cmr_policy_period_from date,
    cmr_policy_period_to date,
    cmr_premium_amount numeric(12,2),
    cmr_contact_person character varying(255),
    cmr_coverage_details text,
    cmr_claim_history text,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: cmr_master_data_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cmr_master_data_table (
    cmr_id character varying(255) NOT NULL,
    cmr_code character varying(255),
    cmr_name character varying(255),
    cmr_type character varying(255),
    cmr_dob date,
    cmr_email character varying(255),
    cmr_phone_number character varying(255),
    cmr_group_id character varying(255),
    cmr_pan character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: cmr_number; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cmr_number
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: country_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.country_table (
    id character varying(26) NOT NULL,
    name character varying(100) NOT NULL,
    code character varying(26),
    discription text,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: credit_note_invoice_payment_modes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.credit_note_invoice_payment_modes (
    icn_id character varying(255),
    payment_mode_name character varying(255),
    payment_amount numeric(10,2),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: custom_invoice; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.custom_invoice (
    custom_inv_id uuid DEFAULT gen_random_uuid() NOT NULL,
    inv_type character varying(255),
    html text,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: custom_reports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.custom_reports (
    report_id character varying(36) NOT NULL,
    store_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    sql_query text NOT NULL,
    created_by character varying(255) NOT NULL,
    is_shared boolean DEFAULT false,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: customer_accounting_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.customer_accounting_table (
    cmr_id character varying(255) NOT NULL,
    cmr_business_partner character varying(255),
    cmr_accounts_payable character varying(255),
    cmr_payment_advances character varying(255),
    cmr_connected_customer character varying(255),
    cmr_payment_consolidation boolean,
    cmr_delivery_consolidation boolean,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    cmr_credit_balance numeric(30,2) DEFAULT 0.00,
    cmr_account_id character varying(255)
);


--
-- Name: customer_bank_details; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.customer_bank_details (
    cmr_id character varying(255) NOT NULL,
    cmr_bank_name character varying(255),
    cmr_account_no character varying(255),
    cmr_bank_branch character varying(255),
    cmr_ifsc_code character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    cmr_default_bank_details boolean DEFAULT false,
    cmr_bank_id character varying(255)
);


--
-- Name: customer_contact_persons; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.customer_contact_persons (
    cmr_contact_person_id character varying(255) NOT NULL,
    cmr_id character varying(255),
    contact_person_name character varying(255),
    contact_person_phone character varying(255),
    contact_person_email character varying(255),
    contact_person_country character varying(255),
    contact_person_state character varying(255),
    contact_person_district character varying(255),
    contact_person_city character varying(255),
    contact_person_pincode character varying(255),
    contact_address text,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    cmr_default_contact_persons boolean DEFAULT false
);


--
-- Name: customer_details; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.customer_details (
    cmr_id character varying(255) NOT NULL,
    cmr_code character varying(255),
    cmr_first_name character varying(255),
    cmr_last_name character varying(255),
    cmr_type character varying(255),
    cmr_dob date,
    cmr_phone_number character varying(255),
    cmr_group_id character varying(255),
    cmr_rewards bigint,
    cmr_email character varying(255),
    cmr_active_status boolean,
    cmr_active_from date,
    cmr_inactive_from date,
    cmr_remarks text,
    is_ecommerce_cmr boolean,
    is_vendor_cmr boolean,
    is_corporate_cmr boolean,
    is_store_cmr boolean,
    update_sign character varying(255),
    cmr_country character varying(255),
    cmr_state character varying(255),
    cmr_district character varying(255),
    cmr_city character varying(255),
    cmr_town character varying(255),
    cmr_village character varying(255),
    cmr_street1 character varying(255),
    cmr_street2 character varying(255),
    cmr_pincode character varying(255),
    cmr_address text,
    cmr_company character varying(255),
    price_list_id character varying(255),
    cmr_pan character varying(255),
    cmr_sector character varying(255),
    cmr_gstin character varying(255),
    cmr_tax character varying(255),
    cmr_business_type character varying(255),
    cmr_balance bigint,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    data_synced boolean DEFAULT false,
    inter_company_sync boolean DEFAULT false,
    store_id character varying(255),
    cmr_tcs character varying(255),
    cmr_tds character varying(255),
    cmr_fssai character varying(255),
    cmr_dl_no character varying(255),
    created_by character varying(255),
    updated_by character varying(255),
    cmr_gstin_certificate character varying(255),
    cmr_dl_certificate character varying(255),
    cmr_fssai_certificate character varying(255),
    cmr_latitude character varying(255),
    cmr_longitude character varying(255),
    cmr_party_category character varying(255)
);


--
-- Name: customer_general_details; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.customer_general_details (
    cmr_id character varying(255) NOT NULL,
    cmr_currency character varying(255),
    cmr_acquired_source character varying(255),
    cmr_balance numeric(20,2),
    cmr_payment_terms character varying(255),
    cmr_shipping_method character varying(255),
    cmr_sector character varying(255),
    cmr_gstin character varying(255),
    cmr_tax character varying(255),
    cmr_business_type character varying(255),
    cmr_remarks character varying(255),
    cmr_active_status boolean,
    cmr_inactive_from date,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: customer_group_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.customer_group_table (
    customer_group_id character varying(255) NOT NULL,
    customer_group_name character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: customer_patient_info_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.customer_patient_info_table (
    cmr_id character varying(26) NOT NULL,
    cmr_name character varying(255),
    cmr_gender character varying(50),
    cmr_abha_number character varying(50),
    cmr_blood_group character varying(10),
    cmr_dob date,
    cmr_weight numeric(5,2),
    cmr_height numeric(5,2),
    cmr_primary_doctor character varying(255),
    cmr_id_proof_type character varying(50),
    cmr_id_proof_number character varying(100),
    cmr_medical_history text,
    cmr_allergies text,
    cmr_current_medications text,
    cmr_emergency_contact_name character varying(255),
    cmr_emergency_contact_phone character varying(20),
    is_human boolean DEFAULT false,
    is_pet boolean DEFAULT false,
    cmr_payment_terms character varying(100),
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    cmr_patient_id character varying(255)
);


--
-- Name: customer_pay_to_address; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.customer_pay_to_address (
    cmr_pay_address_id character varying(255) NOT NULL,
    cmr_id character varying(255),
    cmr_pay_address_name character varying(255),
    cmr_pay_address_country character varying(255),
    cmr_pay_address_state character varying(255),
    cmr_pay_address_district character varying(255),
    cmr_pay_address_city character varying(255),
    cmr_pay_address_town character varying(255),
    cmr_pay_address_street character varying(255),
    cmr_pay_address_pincode character varying(255),
    cmr_pay_address_address text,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    cmr_pay_pan character varying(50),
    cmr_pay_gst character varying(50),
    cmr_pay_fssai_no character varying(100),
    cmr_pay_dl_no_20_20b character varying(100),
    cmr_pay_dl_no_21_21b character varying(100),
    cmr_pay_dl_no_21c character varying(100),
    cmr_pay_dl_no_21f character varying(100),
    cmr_default_address boolean DEFAULT false
);


--
-- Name: customer_payment_terms_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.customer_payment_terms_table (
    cmr_id character varying(255) NOT NULL,
    cmr_payment_terms character varying(255),
    cmr_interest_on_arreas_percentage character varying(255),
    cmr_total_discount_percentage character varying(255),
    cmr_credit_limit character varying(255),
    cmr_commitment_limit character varying(255),
    cmr_effective_price character varying(255),
    cmr_price_list character varying(255),
    cmr_discount_group character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    cmr_payment_percentage character varying(255),
    cmr_payment_terms_id character varying(255)
);


--
-- Name: customer_ship_to_address; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.customer_ship_to_address (
    cmr_ship_address_id character varying(255) NOT NULL,
    cmr_id character varying(255),
    cmr_ship_address_name character varying(255),
    cmr_ship_address_country character varying(255),
    cmr_ship_address_state character varying(255),
    cmr_ship_address_district character varying(255),
    cmr_ship_address_city character varying(255),
    cmr_ship_address_town character varying(255),
    cmr_ship_address_street character varying(255),
    cmr_ship_address_pincode character varying(255),
    cmr_ship_address_address text,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    cmr_ship_pan character varying(50),
    cmr_ship_gst character varying(50),
    cmr_ship_fssai_no character varying(100),
    cmr_ship_dl_no_20_20b character varying(100),
    cmr_ship_dl_no_21_21b character varying(100),
    cmr_ship_dl_no_21c character varying(100),
    cmr_ship_dl_no_21f character varying(100),
    cmr_default_address boolean DEFAULT false
);


--
-- Name: department_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.department_table (
    department_id character varying(255) NOT NULL,
    department_name character varying(255),
    description character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    department_code character varying(255),
    created_by character varying(255),
    updated_by character varying(255),
    roles_id text[],
    is_mapping boolean DEFAULT false
);


--
-- Name: discount_group_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.discount_group_table (
    discount_group_id character varying(255) NOT NULL,
    customer_type_id character varying(255),
    customer_group_id character varying(255),
    from_date date,
    to_date date,
    item_group_name character varying(255),
    is_active boolean DEFAULT false,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    customer_category_id character varying(255)
);


--
-- Name: discount_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.discount_table (
    discount_slab_id character varying(255) NOT NULL,
    item_category character varying(255),
    min_order_value numeric(10,2) NOT NULL,
    discount_percentage numeric(10,2) NOT NULL
);


--
-- Name: discount_type_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.discount_type_table (
    discount_type_id character varying(255) NOT NULL,
    discount_type_name character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: district_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.district_table (
    id character varying(26) NOT NULL,
    name character varying(100) NOT NULL,
    code character varying(26),
    discription text,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: doctor_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.doctor_table (
    dr_id character varying(255) NOT NULL,
    dr_name character varying(255),
    dr_specialization character varying(255),
    dr_registration_num character varying(255),
    dr_qualification character varying(255),
    dr_pincode character varying(255),
    dr_state character varying(255),
    dr_city character varying(255),
    dr_street1 character varying(255),
    dr_street2 character varying(255),
    dr_email character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    dr_hospital character varying(255),
    dr_area character varying(255),
    created_by character varying(255),
    updated_by character varying(255)
);


--
-- Name: document_custom_numbering_series_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.document_custom_numbering_series_table (
    series_id character varying(255) NOT NULL,
    series_name character varying(255),
    series_prefix character varying(255),
    series_suffix character varying(255),
    series_first_digit character varying(255),
    series_last_digit character varying(255),
    series_separator character varying(255),
    series_default boolean DEFAULT false,
    series_increment integer,
    series_include_year boolean DEFAULT false,
    series_include_month boolean DEFAULT false,
    series_include_date boolean DEFAULT false,
    series_leading_spaces integer DEFAULT 0,
    series_fyi_year character varying(255),
    transaction_doc_id character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    series_reset_period character varying(255),
    series_current_document_number bigint
);


--
-- Name: document_custom_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.document_custom_table (
    transaction_doc_id character varying(255) NOT NULL,
    transaction_document_name character varying(255),
    current_document_number integer DEFAULT 0,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    last_reset_date timestamp without time zone
);


--
-- Name: document_numbering; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.document_numbering (
    id character varying(255) NOT NULL,
    document character varying(255),
    default_series character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: document_numbering_series; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.document_numbering_series (
    id character varying(255) NOT NULL,
    document_numbering_id character varying(255),
    name character varying(255),
    first_no bigint,
    next_no bigint,
    last_no bigint,
    prefix character varying(255),
    suffix character varying(255),
    period character varying(255),
    cancellation boolean DEFAULT false,
    lock boolean DEFAULT false,
    digital_series boolean DEFAULT false,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: document_numbering_series_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.document_numbering_series_table (
    series_id character varying(255) NOT NULL,
    series_name character varying(255),
    series_prefix character varying(255),
    series_suffix character varying(255),
    series_first_digit character varying(255),
    series_last_digit character varying(255),
    series_separator character varying(255),
    series_default boolean DEFAULT false,
    series_increment integer,
    series_include_year boolean DEFAULT false,
    series_include_month boolean DEFAULT false,
    series_include_date boolean DEFAULT false,
    series_leading_spaces integer DEFAULT 0,
    transaction_doc_id character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    series_fyi_year character varying(255),
    series_reset_period character varying(255),
    series_current_document_number bigint
);


--
-- Name: document_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.document_table (
    transaction_doc_id character varying(255) NOT NULL,
    transaction_document_name character varying(255),
    current_document_number integer DEFAULT 1,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    last_reset_date timestamp without time zone
);


--
-- Name: document_type_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.document_type_table (
    document_id character varying(50),
    document_type_name character varying(50),
    update_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_by character varying(255),
    created_by character varying(255)
);


--
-- Name: document_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.document_types (
    id integer NOT NULL,
    type character varying(25) NOT NULL,
    print boolean DEFAULT true NOT NULL,
    print_copies integer DEFAULT 1 NOT NULL,
    preview boolean DEFAULT false NOT NULL,
    email boolean DEFAULT false NOT NULL,
    whatsapp boolean DEFAULT false NOT NULL,
    sms boolean DEFAULT false NOT NULL,
    export_pdf boolean DEFAULT false NOT NULL,
    export_csv boolean DEFAULT false NOT NULL,
    format integer DEFAULT 1 NOT NULL
);


--
-- Name: document_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.document_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: document_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.document_types_id_seq OWNED BY public.document_types.id;


--
-- Name: excel_import_column_mapping_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.excel_import_column_mapping_table (
    mapping_id character varying(255) NOT NULL,
    cmr_vendor_name character varying(255),
    cmr_vendor_id character varying(255),
    excel_columns jsonb,
    mapped_columns jsonb,
    excel_rows jsonb,
    module_name character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: favorite; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.favorite (
    name character varying(36) NOT NULL,
    query text,
    update_date date,
    created_date date
);


--
-- Name: gender_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gender_table (
    id character varying(26) NOT NULL,
    name character varying(100),
    code character varying(26),
    discription text,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: general_account_allocation_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.general_account_allocation_table (
    gcct_id character varying(255) NOT NULL,
    period_category character varying(255),
    beginning_of_financial_year character varying(255),
    financial_year date,
    posting_date_from date,
    posting_date_to date,
    due_date_from date,
    credit_card_deposit_fee character varying(255),
    rounding_account character varying(255),
    automatic_reconcillation_diff character varying(255),
    period_end_closing_account character varying(255),
    realized_exchange_diff_gain character varying(255),
    realized_exchange_diff_loss character varying(255),
    opening_balance_account character varying(255),
    bank_charges_account character varying(255),
    ex_rate_on_def_tax_account character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: general_accounts_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.general_accounts_table (
    account_id character varying(255) NOT NULL,
    account_code character varying(255),
    account_name character varying(255),
    current_balance numeric(20,2),
    opening_balance numeric(20,2),
    main_group character varying(255),
    account_status boolean DEFAULT false,
    account_level integer,
    account_category character varying(255),
    account_type character varying(255),
    parent_account_key character varying(255),
    external_code character varying(255),
    user_sign character varying(255),
    is_directory boolean DEFAULT false,
    account_title boolean DEFAULT false,
    is_file boolean DEFAULT false,
    capital_account boolean DEFAULT false,
    year_transfer boolean DEFAULT false,
    system_reconciliation_no numeric(20,2),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    is_gl_account boolean DEFAULT true,
    cmr_open_balance numeric(20,2) DEFAULT 0,
    is_transaction_account boolean DEFAULT false,
    data_synced boolean DEFAULT false
);


--
-- Name: generic_name_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.generic_name_table (
    id character varying(26) NOT NULL,
    name character varying(100) NOT NULL,
    code character varying(26),
    discription text,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: good_order_receipt_items_batches_list; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.good_order_receipt_items_batches_list (
    item_id character varying(255),
    gort_id character varying(255),
    item_batch_number character varying(50),
    item_exp_date date,
    item_mfg_date date,
    item_sellable_quantity numeric(10,2),
    item_non_sellable_quantity numeric(10,2),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    from_bin_location character varying(255),
    from_bin_id character varying(255),
    to_bin_id character varying(255),
    to_bin_location character varying(255),
    item_batch_unit_price numeric(10,2),
    item_batch_free_quantity bigint,
    item_batch_purchase_rate numeric(10,2),
    item_batch_discount_amount numeric(10,2),
    item_batch_discount_percentage numeric(10,2),
    item_batch_tax_percentage numeric(10,2),
    item_batch_tax_amount numeric(10,2),
    item_batch_final_purchase_rate numeric(10,2),
    item_batch_total_purchase_rate numeric(10,2),
    prt_id character varying(255),
    item_uom_id character varying(255),
    item_uom character varying(255),
    item_batch_final_purchase_rate_1 character varying(255),
    item_batch_margin_percentage numeric(10,2),
    item_batch_total_effective_qauntity bigint,
    item_batch_for_qauntity bigint,
    item_batch_for_free_qauntity bigint,
    item_batch_scheme_discount_percentage numeric(20,2),
    item_batch_scheme_discount_amount numeric(20,2),
    item_batch_scheme_purchase_rate numeric(20,2),
    item_batch_taxable_amount numeric(20,2),
    item_batch_total_base_purchase_rate numeric(20,2),
    item_batch_discounted_purchase_rate numeric(20,2),
    item_batch_gen_discount_amount numeric(20,2),
    item_batch_purhcase_rate_before_tax numeric(20,2),
    item_batch_cgst_percentage numeric(10,2),
    item_batch_sgst_percentage numeric(10,2),
    item_batch_igst_percentage numeric(10,2),
    item_batch_cgst_amount numeric(10,2),
    item_batch_sgst_amount numeric(10,2),
    item_batch_igst_amount numeric(10,2),
    is_inter_state boolean DEFAULT false,
    item_batch_ptr_amount numeric(20,2),
    item_batch_pts_amount numeric(20,2),
    item_batch_pack_quantity numeric(20,2),
    item_batch_loose_quantity numeric(20,2),
    item_batch_pack_free_quantity numeric(20,2),
    item_batch_loose_free_quantity numeric(20,2)
);


--
-- Name: good_order_receipt_items_list; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.good_order_receipt_items_list (
    item_id character varying(255),
    pot_id character varying(255),
    gort_id character varying(255),
    item_code character varying(255),
    item_generic_name character varying(255),
    item_name character varying(255),
    item_pack_size character varying(50),
    item_unit_price numeric(10,2),
    item_uom character varying(50),
    item_batch_number character varying(50),
    item_quantity integer,
    item_exp_date date,
    base_ref_no character varying(50),
    item_mfg_date date,
    item_rack_location character varying(50),
    item_schedule character varying(255),
    item_discount_amount numeric(10,2),
    item_discount_percentage numeric(10,2),
    item_tax_amount numeric(10,2),
    item_total_tax_percentage numeric(10,2),
    item_total_amount numeric(10,2),
    item_gst numeric(10,2),
    item_sgst numeric(10,2),
    item_cgst numeric(10,2),
    item_igst numeric(10,2),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    item_received_quantity integer,
    item_to_be_received integer,
    item_return_open_quantity integer,
    item_uom_id character varying(255),
    item_free_quantity bigint,
    item_manufacturer_name character varying(255),
    item_manufacturer_id character varying(255),
    item_hsn character varying(255),
    prt_id character varying(255),
    item_quantity_used bigint DEFAULT 0,
    is_item_void_able boolean DEFAULT true,
    created_by character varying(255),
    updated_by character varying(255)
);


--
-- Name: goods_order_document_list; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.goods_order_document_list (
    prt_id character varying(255),
    gort_id character varying(255),
    poit_id character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: goods_order_receipt_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.goods_order_receipt_table (
    cmr_id character varying(255),
    gort_id character varying(255) NOT NULL,
    pot_id character varying(255),
    cmr_phone_number character varying(255),
    cmr_code character varying(255),
    cmr_name character varying(255),
    gort_order_date date,
    gort_document_date date,
    gort_delivery_date date,
    store_id character varying(255),
    gort_invoice_number character varying(255),
    gort_total_gst numeric(10,2),
    gort_total_discount numeric(10,2),
    gort_payment_status character varying(50),
    gort_order_status character varying(50),
    gort_transaction_id character varying(255),
    gort_payment_method character varying(50),
    gort_billing_address text,
    gort_total_amount numeric(10,2),
    remarks character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    gort_sub_total numeric(10,2),
    data_synced boolean DEFAULT false,
    pos_id character varying(255),
    gort_round_off_value numeric(20,2),
    gort_tds_tcs_type character varying(255),
    gort_tcs_or_tds_percentage numeric(10,2),
    gort_tcs_or_tds_percentage_id character varying(255),
    gort_tcs_or_tds_amount numeric(10,2),
    is_draft_order boolean DEFAULT false,
    only_remarks boolean DEFAULT false,
    created_by character varying(255),
    updated_by character varying(255),
    gort_pay_to_address jsonb,
    gort_ship_to_address jsonb,
    inv_no character varying(255),
    gort_invoice_discount numeric(10,2),
    gort_invoice_discount_percentage numeric(10,2),
    gort_is_invoice_dis_percentage boolean DEFAULT false,
    is_gort_voidable boolean DEFAULT true,
    customer_invoice_number character varying(255),
    is_voided boolean DEFAULT false,
    gst_type character varying(26)
);


--
-- Name: group_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_table (
    id character varying(26) NOT NULL,
    name character varying(100) NOT NULL,
    code character varying(26),
    discription text,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: id_proof_type_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.id_proof_type_table (
    id character varying(26) NOT NULL,
    name character varying(100) NOT NULL,
    code character varying(26),
    discription text,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: industry_sector_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.industry_sector_table (
    id character varying(26) NOT NULL,
    name character varying(100) NOT NULL,
    code character varying(26),
    discription text,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: insurance_provider_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.insurance_provider_table (
    id character varying(26) NOT NULL,
    name character varying(100) NOT NULL,
    code character varying(26),
    discription text,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: inventory_account_allocation_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inventory_account_allocation_table (
    gcct_id character varying(255) NOT NULL,
    period_category character varying(255),
    user_signature character varying(255),
    inventory_account character varying(255),
    cost_of_goods_sold_account character varying(255),
    allocation_account character varying(255),
    variance_account character varying(255),
    price_differnce_account character varying(255),
    negative_invetory_adj_acct character varying(255),
    inventory_offset_decr_acct character varying(255),
    inventory_offset_incr_acct character varying(255),
    sales_returns_account character varying(255),
    exhange_rate_differencee_account character varying(255),
    goods_clearing_account character varying(255),
    gl_decrease_account character varying(255),
    gl_increase_account character varying(255),
    wip_inventory_account character varying(255),
    wip_inventory_variance character varying(255),
    wip_offet_p_and_l_account character varying(255),
    inventory_offset_p_and_laccount character varying(255),
    expense_clearing_account character varying(255),
    stock_in_transit_account character varying(255),
    shipped_goods_account character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    tax_account character varying
);


--
-- Name: inventory_status_condition_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inventory_status_condition_table (
    isc_id character varying(255) NOT NULL,
    is_id character varying(255),
    tpos_id character varying(255),
    item_selection_type character varying(50),
    selected_ids text[],
    item_selection_logic character varying(50),
    created_by character varying(255),
    updated_by character varying(255),
    update_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: inventory_status_item_list_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inventory_status_item_list_table (
    isil_id character varying(255) NOT NULL,
    tpos_id character varying(255),
    item_id character varying(255),
    is_id character varying(255),
    item_name character varying(50),
    update_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: inventory_status_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inventory_status_table (
    is_id character varying(255) NOT NULL,
    tpos_id character varying(255),
    time_window_type character varying(50),
    region character varying(50),
    state character varying(50),
    district character varying(50),
    city character varying(50),
    area character varying(50),
    store_id text[],
    fast_moving_thershold integer,
    slow_moving_thershold integer,
    non_moving_thershold integer,
    created_by character varying(255),
    updated_by character varying(255),
    update_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: inventory_transfer_item_batches_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inventory_transfer_item_batches_table (
    itt_id character varying(255),
    item_id character varying(255),
    item_batch_number character varying(255),
    from_bin_location character varying(255),
    to_bin_location character varying(255),
    item_batch_quantity integer,
    update_sign character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    item_exp_date date,
    to_bin_id character varying(255),
    from_bin_id character varying(255),
    item_batch_unit_price numeric(10,2),
    item_batch_free_quantity bigint,
    item_batch_purchase_rate numeric(10,2),
    item_uom_id character varying(255),
    item_uom character varying(255)
);


--
-- Name: inventory_transfer_rows_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inventory_transfer_rows_table (
    itrt_id character varying(255),
    itt_id character varying(255),
    item_id character varying(255),
    item_name character varying(255),
    from_bin_location character varying(255),
    to_bin_location character varying(255),
    item_uom_source character varying(255),
    item_uom_destination character varying(255),
    item_quantity integer,
    update_sign character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    item_uom character varying(255),
    item_code character varying(255),
    to_bin_id character varying(255),
    item_quantity_used bigint,
    is_item_void_able boolean DEFAULT true,
    item_void_status character varying(255) DEFAULT 'success'::character varying,
    item_uom_id character varying(255),
    item_free_quantity bigint,
    created_by character varying(255),
    updated_by character varying(255)
);


--
-- Name: inventory_transfer_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inventory_transfer_table (
    itt_id character varying(255) NOT NULL,
    warehouse_id character varying(255),
    warehouse_name character varying(255),
    transfer_date character varying(255),
    stock_management_action character varying(255),
    posting_date character varying(255),
    from_warehouse_id character varying(255),
    from_warehouse_name character varying(255),
    to_warehouse_id character varying(255),
    to_warehouse_name character varying(255),
    update_sign character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    stock_transfer_doc_number character varying(255),
    stock_transfer_reason character varying(255),
    is_stock_in_void_able boolean DEFAULT true,
    data_synced boolean DEFAULT false,
    stock_transfer_status character varying(255) DEFAULT 'success'::character varying,
    stock_transfer_parent_id character varying(255),
    ist_id character varying(255),
    cmr_tcs numeric(10,2),
    cmr_tds numeric(10,2),
    created_by character varying(255),
    updated_by character varying(255)
);


--
-- Name: invoice_credit_note; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.invoice_credit_note (
    icn_id character varying(255) NOT NULL,
    cmr_phone_number character varying(255),
    store_id character varying(255),
    icn_invoice_number character varying(255),
    icn_total_gst numeric(10,2),
    icn_total_discount numeric(10,2),
    icn_sub_total numeric(10,2),
    icn_payment_status character varying(50),
    icn_order_status character varying(50),
    icn_transaction_id character varying(255),
    icn_payment_method character varying(50),
    icn_billing_address text,
    icn_total_amount numeric(10,2),
    cmr_id character varying(50),
    doctor_name character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    icn_remarks character varying(255),
    data_synced boolean DEFAULT false,
    pos_id character varying(255),
    icn_custom_invoice_number character varying(255),
    icn_custom_invoice_date date,
    icn_return_type character varying(255),
    created_by character varying(255),
    updated_by character varying(255),
    icn_reason text,
    icn_ship_from_address jsonb,
    is_draft_order boolean DEFAULT false,
    icn_invoice_discount_percentage numeric(10,2),
    icn_invoice_discount numeric(10,2),
    icn_is_invoice_dis_percentage boolean
);


--
-- Name: invoice_credit_note_item_list; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.invoice_credit_note_item_list (
    item_id character varying(255),
    sot_id character varying(255),
    icn_id character varying(255),
    item_code character varying(255),
    item_generic_name character varying(255),
    item_price_wiithout_tax numeric(10,2),
    item_name character varying(255),
    item_pack_size character varying(50),
    item_unit_price numeric(10,2),
    item_batch_number character varying(50),
    item_open_quantity integer,
    item_quantity integer,
    item_exp_date date,
    item_mfg_date date,
    item_uom character varying(255),
    item_rack_location character varying(50),
    item_schedule character varying(255),
    item_discount_amount numeric(10,2),
    item_discount_percentage numeric(10,2),
    item_tax_amount numeric(10,2),
    item_total_tax_percentage numeric(10,2),
    item_total_amount numeric(10,2),
    item_gst numeric(10,2),
    item_sgst numeric(10,2),
    item_cgst numeric(10,2),
    item_igst numeric(10,2),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    item_hsn character varying(255),
    item_free_quantity bigint,
    item_manufacturer_id character varying(255),
    item_manufacturer_name character varying(255)
);


--
-- Name: item_barcode_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.item_barcode_table (
    item_id character varying(255),
    item_uom_id character varying(255),
    item_uom character varying(255),
    item_barcode text,
    item_text text,
    item_discription text,
    default_barcode boolean,
    item_number character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: item_category; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.item_category (
    id character varying(255) NOT NULL,
    code character varying(255),
    name character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: item_category_code_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.item_category_code_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: item_composition_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.item_composition_table (
    id character varying(26) NOT NULL,
    name character varying(100) NOT NULL,
    code character varying(26),
    discription text,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: item_discount_and_scheme_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.item_discount_and_scheme_table (
    item_id character varying(255) NOT NULL,
    item_min_discount numeric(20,2),
    item_max_discount numeric(20,2),
    item_on_purchasing_qauntity bigint,
    item_customer_reward_qauntity bigint,
    item_customer_reward_uom_id character varying(255),
    item_on_purchasing_unit_id character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: item_generic_name_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.item_generic_name_table (
    id character varying(26) NOT NULL,
    name character varying(100) NOT NULL,
    code character varying(26),
    discription text,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: item_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.item_group (
    id character varying(255) NOT NULL,
    code character varying(255),
    name character varying(255),
    default_uom_id character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: item_group_code_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.item_group_code_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: item_group_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.item_group_table (
    item_group_id character varying(255) NOT NULL,
    item_group_name character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: item_invetory_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.item_invetory_table (
    item_id character varying(255) NOT NULL,
    item_set_gl_account character varying(255),
    item_uom_name character varying(255),
    item_valuation_method character varying(255),
    item_cost character varying(255),
    item_weight character varying(255),
    item_purchasing_uom character varying(255),
    item_minimun_purchasing character varying(255),
    item_maximum_purchasing character varying(255),
    manage_inventory_by_warehouse boolean,
    is_draft boolean DEFAULT false,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: item_min_max_for_pos_inventory; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.item_min_max_for_pos_inventory (
    id character varying(100) NOT NULL,
    item_id character varying(100) NOT NULL,
    pos_id character varying(100) NOT NULL,
    item_min_quantity bigint DEFAULT 0,
    item_max_quantity bigint DEFAULT 0
);


--
-- Name: item_molecule_composition_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.item_molecule_composition_table (
    molecule_composition_id character varying(26) NOT NULL,
    item_id character varying(100) NOT NULL,
    molecule_name character varying(26),
    molecule_value numeric(20,2),
    molecule_unit character varying(26),
    molecule_id character varying(26),
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: item_molecule_name_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.item_molecule_name_table (
    id character varying(26) NOT NULL,
    name character varying(100) NOT NULL,
    code character varying(26),
    discription text,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: item_packing_information_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.item_packing_information_table (
    item_id character varying(100) NOT NULL,
    item_packing_type character varying(100),
    item_packing character varying(100),
    item_carton_type character varying(100),
    item_primary_pack_size character varying(100),
    item_secondary_pack_size character varying(100),
    item_tertiary_pack_size character varying(100),
    item_baby_box_packing character varying(100),
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: item_planning_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.item_planning_table (
    item_id character varying(255) NOT NULL,
    item_order_interval character varying(255),
    item_order_multiple character varying(255),
    item_minimum_order_quantity character varying(255),
    item_checking_rule character varying(255),
    is_draft boolean DEFAULT false,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: item_purchasing_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.item_purchasing_table (
    item_id character varying(255) NOT NULL,
    item_pur_preferred_vendor character varying(255),
    item_pur_mfg_catalog_no character varying(255),
    item_pur_purchasing_uom_name character varying(255),
    item_pur_per_purchasing_unit character varying(255),
    item_pur_packing_uom_name character varying(255),
    item_pur_quantity_per_package character varying(255),
    item_pur_length character varying(255),
    item_pur_width character varying(255),
    item_pur_height character varying(255),
    item_pur_volume character varying(255),
    item_pur_weight character varying(255),
    item_pur_customs_group character varying(255),
    item_pur_measurement_unit character varying(255),
    item_pur_factor_1 character varying(255),
    item_pur_factor_2 character varying(255),
    item_pur_factor_3 character varying(255),
    item_pur_factor_4 character varying(255),
    is_draft boolean DEFAULT false,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    item_pur_preferred_vendor_id character varying(255),
    item_pur_purchasing_uom_name_id character varying(255),
    item_pur_min_uom_quantity bigint DEFAULT 0,
    item_pur_min_uom character varying(255)
);


--
-- Name: item_regional_restrictions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.item_regional_restrictions (
    restriction_id character varying(255) NOT NULL,
    store_id character varying(255) NOT NULL,
    item_id character varying(255) NOT NULL,
    item_sales_invoice boolean DEFAULT false,
    item_sales_returns boolean DEFAULT false,
    item_purchase_request boolean DEFAULT false,
    item_discontiue boolean DEFAULT false,
    item_purchasing_order boolean DEFAULT false,
    item_credit_note boolean DEFAULT false,
    item_debit_note boolean DEFAULT false,
    item_stock_in boolean DEFAULT false,
    item_stock_out boolean DEFAULT false,
    data_synced boolean DEFAULT false,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: item_remarks_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.item_remarks_table (
    item_id character varying(255) NOT NULL,
    item_remarks text,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: item_restriction_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.item_restriction_table (
    item_id character varying(255) NOT NULL,
    item_sales_invoice boolean,
    item_sales_returns boolean,
    item_purchase_request boolean,
    item_discontiue boolean,
    item_purchasing_order boolean,
    item_credit_note boolean,
    item_debit_note boolean,
    item_stock_in boolean,
    item_stock_out boolean,
    is_draft boolean DEFAULT false,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    item_purchase_credit_note boolean DEFAULT false,
    item_grn boolean DEFAULT false,
    item_payment_out boolean DEFAULT false,
    item_sales_order boolean DEFAULT false,
    item_sales_delivery_note boolean DEFAULT false,
    item_sales_credit_note boolean DEFAULT false,
    item_payment_in boolean DEFAULT false,
    item_return_bill boolean DEFAULT false,
    item_bill boolean DEFAULT false,
    item_stock_transfer boolean DEFAULT false,
    item_purchase_return boolean DEFAULT false,
    item_purchase_invoice boolean DEFAULT false
);


--
-- Name: item_restrictions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.item_restrictions (
    restriction_id integer NOT NULL,
    store_id character varying(255) NOT NULL,
    item_id character varying(255) NOT NULL,
    item_sales_invoice boolean DEFAULT false,
    item_sales_returns boolean DEFAULT false,
    item_purchase_request boolean DEFAULT false,
    item_discontinue boolean DEFAULT false,
    item_purchasing_order boolean DEFAULT false,
    item_credit_note boolean DEFAULT false,
    item_debit_note boolean DEFAULT false,
    item_stock_in boolean DEFAULT false,
    item_stock_out boolean DEFAULT false,
    data_synced boolean DEFAULT false,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: item_restrictions_restriction_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.item_restrictions_restriction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: item_restrictions_restriction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.item_restrictions_restriction_id_seq OWNED BY public.item_restrictions.restriction_id;


--
-- Name: item_sales_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.item_sales_table (
    item_id character varying(255) NOT NULL,
    item_sales_uom_name character varying(255),
    item_sales_packing_uom_name character varying(255),
    item_sales_quantity_per_package character varying(255),
    item_per_sales_unit character varying(255),
    item_sales_length character varying(255),
    item_sales_width character varying(255),
    item_sales_height character varying(255),
    item_sales_volume character varying(255),
    item_sales_weight character varying(255),
    item_sales_measurement_unit character varying(255),
    item_sales_factor_1 character varying(255),
    item_sales_factor_2 character varying(255),
    item_sales_factor_3 character varying(255),
    item_sales_factor_4 character varying(255),
    is_draft boolean DEFAULT false,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    item_sales_uom_name_id character varying(255)
);


--
-- Name: item_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.item_type (
    id character varying(255) NOT NULL,
    code character varying(255),
    name character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: item_type_code_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.item_type_code_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: item_uom_barcode_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.item_uom_barcode_table (
    uom_id character varying(255),
    item_barcode character varying(255),
    free_text character varying(255),
    is_default boolean,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    iubt character varying(255),
    iut_id character varying(255)
);


--
-- Name: item_uom_group_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.item_uom_group_table (
    item_id character varying(255),
    uom_group_name character varying(255),
    item_number character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    iugt_id character varying(255),
    uom_group_id character varying(255)
);


--
-- Name: item_uom_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.item_uom_table (
    iut_id character varying(255) NOT NULL,
    uom_id character varying(255),
    uom_group_id character varying(255),
    uom_name character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    iugt_id character varying(255)
);


--
-- Name: items_batch_no_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.items_batch_no_table (
    item_id character varying(255),
    item_sellable_quantity bigint,
    item_non_sellable_quantity bigint,
    item_exp_date date,
    item_mfg_date date,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    item_batch_number character varying(255),
    pos_id character varying(50),
    item_batch_id character varying(50),
    created_by character varying(255),
    updated_by character varying(255)
);


--
-- Name: items_discount_group_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.items_discount_group_table (
    customer_group_id character varying(255),
    item_id character varying(255) NOT NULL,
    discount_percentage numeric(10,2),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: items_group_discount_group_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.items_group_discount_group_table (
    discount_group_id character varying(255),
    item_group_id character varying(255),
    discount_percentage numeric(10,2),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: items_period_validity_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.items_period_validity_table (
    period_validity_id character varying(255) NOT NULL,
    period_discount_item_id character varying(255),
    from_date date,
    to_date date,
    effective_price numeric(10,2),
    discount_percentage numeric(10,2),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: items_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.items_table (
    item_id character varying(255) NOT NULL,
    item_type character varying(255),
    item_name character varying(255),
    item_category character varying(255),
    item_price_list character varying(255),
    item_price_list_id character varying(255),
    item_generic_name character varying(255),
    item_group character varying(255),
    item_barcode character varying(255),
    item_uom character varying(255),
    item_unit_price numeric(10,2),
    item_description character varying(255),
    manage_item_by character varying(255),
    item_manufacturer character varying(255),
    item_shipping_type character varying(255),
    item_sector character varying(255),
    item_schedule character varying(255),
    item_gstin character varying(255),
    item_exp_date date,
    item_hsn character varying(255),
    item_gst character varying(255),
    item_categeory character varying(255),
    item_remarks character varying(255),
    country character varying(255),
    item_code character varying(255),
    item_active_from date,
    item_inactive_from date,
    is_inventory_item boolean,
    is_purchase_item boolean,
    is_sales_item boolean,
    active_from date,
    active_to date,
    inactive_from date,
    inactive_to date,
    is_active boolean,
    item_tax_category character varying(255),
    is_draft boolean DEFAULT false,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    item_tax_name character varying(255),
    created_by character varying(255),
    updated_by character varying(255),
    is_draft_item boolean DEFAULT false,
    data_synced boolean DEFAULT false,
    is_item_approved boolean DEFAULT false,
    item_uom_id character varying(255),
    item_inter_tax_category character varying(266)
);


--
-- Name: items_volume_validity_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.items_volume_validity_table (
    volume_validity_id character varying(255) NOT NULL,
    period_validity_id character varying(255),
    item_quantity numeric(10,2),
    volume_effective_price numeric(10,2),
    volume_discount_percentage numeric(10,2),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: journal_entry_rows_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.journal_entry_rows_table (
    account_id character varying(255),
    transcation_id character varying(255),
    debit_amount numeric(20,2),
    credit_amount numeric(20,2),
    user_sign character varying(255),
    remarks character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: journal_entry_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.journal_entry_table (
    transcation_id character varying(255) NOT NULL,
    journal_entry_no character varying(255),
    origin_id character varying(255),
    origin_type character varying(255),
    remarks character varying(255),
    batch_num character varying(255),
    user_sign character varying(255),
    trans_curr character varying(255),
    due_date date,
    document_date date,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    data_synced boolean DEFAULT false
);


--
-- Name: lead_details; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lead_details (
    lead_id character varying(36) NOT NULL,
    lead_full_name character varying(255),
    lead_contact_name character varying(255),
    lead_contact_title character varying(100),
    lead_company_name character varying(255),
    lead_company_size character varying(50),
    lead_industry character varying(100),
    lead_source character varying(100),
    lead_phone_number character varying(20),
    lead_email character varying(255),
    lead_website character varying(255),
    lead_state character varying(100),
    lead_city character varying(100),
    lead_pincode character varying(20),
    lead_address text,
    lead_product character varying(255),
    lead_details text,
    lead_quantity integer,
    lead_budget numeric(10,2),
    lead_inquiry_medium character varying(100),
    lead_inquiry_source character varying(100),
    lead_description text,
    lead_keywords text,
    lead_requirements text,
    lead_comp_information text,
    lead_next_steps text,
    lead_notes text,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: main_module_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.main_module_table (
    main_module_id character varying(255) NOT NULL,
    main_module_name character varying(255),
    description character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    parent_main_module_id character varying(255)
);


--
-- Name: manufacture_group_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.manufacture_group_table (
    manufacture_group_id character varying(255) NOT NULL,
    manufacture_group_name character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: manufacturer; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.manufacturer (
    id character varying(255) NOT NULL,
    code character varying(255),
    name character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: manufacturer_code_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.manufacturer_code_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: manufactures_group_discount_group_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.manufactures_group_discount_group_table (
    discount_group_id character varying(255) NOT NULL,
    manufacture_group_id character varying(255),
    discount_percentage numeric(10,2),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: migration_log; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.migration_log (
    name text NOT NULL,
    run_at timestamp without time zone DEFAULT now()
);


--
-- Name: migrations_history; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.migrations_history (
    id integer NOT NULL,
    batch_name character varying(100) NOT NULL,
    version integer NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(50) DEFAULT 'success'::character varying
);


--
-- Name: migrations_history_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.migrations_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: migrations_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.migrations_history_id_seq OWNED BY public.migrations_history.id;


--
-- Name: module_setting; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.module_setting (
    document_name character varying(50),
    document_setting jsonb,
    update_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_by character varying(255),
    created_by character varying(255)
);


--
-- Name: module_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.module_table (
    module_id character varying(255) NOT NULL,
    module_name character varying(255),
    description character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    main_module_id character varying
);


--
-- Name: notification; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notification (
    ntf_id character varying(255) NOT NULL,
    notification_code character varying(50),
    alert_name character varying(50),
    priority character varying(50),
    condition_type character varying(50),
    transaction_type character varying(50),
    table_names text,
    column_condition text,
    frequency character varying(50),
    frequency_accurrence character varying(50),
    frequency_time_gap character varying(50),
    frequency_first_alert character varying(50),
    is_email boolean DEFAULT false,
    is_sms boolean DEFAULT false,
    is_push_notification boolean DEFAULT false,
    is_whatsapp boolean DEFAULT false,
    sql_query text,
    status character varying(50),
    created_by character varying(255),
    updated_by character varying(255),
    start_or_stop boolean DEFAULT false,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: notification_communication_channel; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notification_communication_channel (
    ntfcc_id character varying(255) NOT NULL,
    ntf_id character varying(255),
    template_name character varying(50),
    subject text,
    body text,
    attachments text,
    is_email boolean DEFAULT false,
    is_sms boolean DEFAULT false,
    is_push_notification boolean DEFAULT false,
    is_whatsapp boolean DEFAULT false,
    transaction_status boolean DEFAULT false,
    created_by character varying(255),
    updated_by character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: notification_recipient; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notification_recipient (
    ntfr_id character varying(255) NOT NULL,
    ntf_id character varying(255),
    ntfcc_id character varying(255),
    recipient_group text[],
    recipient_users text[],
    specific_users text[],
    is_email boolean DEFAULT false,
    is_sms boolean DEFAULT false,
    is_push_notification boolean DEFAULT false,
    is_whatsapp boolean DEFAULT false,
    created_by character varying(255),
    updated_by character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: notification_triggered_history; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notification_triggered_history (
    nth_id character varying(255) NOT NULL,
    ntf_id character varying(255),
    status character varying(50),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: order_items_list; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_items_list (
    item_id character varying(255),
    sot_id character varying(255),
    item_code character varying(255),
    item_generic_name character varying(255),
    item_price_wiithout_tax numeric(10,2),
    item_name character varying(255),
    item_pack_size character varying(50),
    item_unit_price numeric(10,2),
    item_batch_number character varying(50),
    item_open_quantity integer,
    item_quantity integer,
    item_exp_date date,
    item_mfg_date date,
    item_uom character varying(255),
    item_rack_location character varying(50),
    item_schedule character varying(255),
    item_discount_amount numeric(10,2),
    item_discount_percentage numeric(10,2),
    item_tax_amount numeric(10,2),
    item_total_tax_percentage numeric(10,2),
    item_total_amount numeric(10,2),
    item_gst numeric(10,2),
    item_sgst numeric(10,2),
    item_cgst numeric(10,2),
    item_igst numeric(10,2),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    stock_in_itt_id character varying(255),
    item_hsn character varying(255),
    item_free_quantity bigint,
    item_manufacturer_id character varying(255),
    item_manufacturer_name character varying(255),
    grn_gort_id character varying(255),
    item_open_free_quantity bigint,
    item_pack_price numeric(10,2),
    is_store_added_item boolean DEFAULT false,
    item_uom_id character varying(255),
    item_pack_qty bigint,
    item_loose_qty bigint,
    item_total_qaunitiy bigint
);


--
-- Name: otp_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.otp_table (
    phone_number character varying(255),
    otp character varying(10) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    expires_at timestamp without time zone NOT NULL
);


--
-- Name: packing_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.packing_table (
    id character varying(26) NOT NULL,
    name character varying(100) NOT NULL,
    code character varying(26),
    discription text,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: packing_type_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.packing_type_table (
    id character varying(26) NOT NULL,
    name character varying(100) NOT NULL,
    code character varying(26),
    discription text,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: party_category_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.party_category_table (
    id character varying(26) NOT NULL,
    name character varying(100) NOT NULL,
    code character varying(26),
    discription text,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: party_group_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.party_group_table (
    id character varying(26) NOT NULL,
    name character varying(100) NOT NULL,
    code character varying(26),
    discription text,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: party_type_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.party_type_table (
    id character varying(26) NOT NULL,
    name character varying(100) NOT NULL,
    code character varying(26),
    discription text,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: payment_in_document_list_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment_in_document_list_table (
    soit_id character varying(255),
    pit_id character varying(255),
    pdt_due_days integer,
    pdt_balance_due numeric(10,2),
    pdt_total_amount numeric(10,2),
    pdt_doc_date date,
    pdt_due_date date,
    update_sign character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    soit_invoice_number character varying,
    pdt_current_payment numeric(10,2),
    pdt_doc_type character varying(255)
);


--
-- Name: payment_in_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment_in_table (
    pit_id character varying(255) NOT NULL,
    cmr_id character varying(255),
    cmr_name character varying(255),
    cmr_code character varying(255),
    pit_posting_date date,
    pit_invoice_number character varying(255),
    pit_order_status character varying(255),
    pit_due_date date,
    pit_doc_date date,
    pit_remarks character varying(500),
    pit_total_amount numeric(10,2),
    pit_add_to_account_amount numeric(10,2),
    payment_journal_remarks character varying(500),
    pit_applied_amount numeric(10,2),
    update_sign character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    pit_current_payment numeric(10,2),
    pit_open_balance numeric(10,2),
    pit_cmr_amount_paid numeric(10,2),
    is_customer boolean,
    created_by character varying(255),
    updated_by character varying(255)
);


--
-- Name: payment_modes_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment_modes_table (
    pmt_id character varying(255),
    pit_id character varying(255),
    pmt_mode_name character varying(255),
    account_id character varying(255),
    account_code character varying(255),
    account_name character varying(255),
    pmt_total_amount numeric(10,2),
    update_sign character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    bank_reference_number character varying(255),
    date_of_transfer date,
    payment_id character varying(255),
    card_number character varying(255),
    expiry_date date,
    cheque_number character varying(255),
    date_of_cheque date,
    upi_referernce character varying(255)
);


--
-- Name: payment_out_document_list_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment_out_document_list_table (
    poit_id character varying(255) NOT NULL,
    poit_invoice_number character varying(255),
    pot_id character varying(255),
    podt_due_days integer,
    podt_balance_due numeric(10,2),
    podt_total_amount numeric(10,2),
    podt_doc_date date,
    podt_due_date date,
    update_sign character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    podt_current_payment numeric(10,2),
    podt_doc_type character varying(255)
);


--
-- Name: payment_out_modes_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment_out_modes_table (
    pmt_id character varying(255) NOT NULL,
    pot_id character varying(255),
    pmt_mode_name character varying(255),
    account_id character varying(255),
    account_code character varying(255),
    account_name character varying(255),
    pmt_total_amount numeric(10,2),
    update_sign character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    bank_reference_number character varying(255),
    date_of_transfer timestamp with time zone,
    upi_reference_number character varying(255),
    card_number character varying(255),
    expiry_date timestamp with time zone,
    date_of_cheque timestamp with time zone,
    item_batch_total_base_purchase_rate numeric(10,2),
    mrp numeric(10,2),
    molecule_name character varying(255)
);


--
-- Name: payment_out_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment_out_table (
    pot_id character varying(255) NOT NULL,
    cmr_id character varying(255),
    cmr_name character varying(255),
    cmr_code character varying(255),
    pot_posting_date date,
    pot_invoice_number character varying(255),
    pot_order_status character varying(255),
    pot_due_date date,
    pot_doc_date date,
    pot_remarks character varying(500),
    pot_total_amount numeric(10,2),
    pot_add_to_account_amount numeric(10,2),
    payment_journal_remarks character varying(500),
    pot_applied_amount numeric(10,2),
    update_sign character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    pot_cmr_amount_paid numeric(10,2),
    pot_open_balance numeric(10,2),
    pot_current_payment numeric(10,2),
    is_customer boolean,
    created_by character varying(255),
    updated_by character varying(255)
);


--
-- Name: payment_terms_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment_terms_table (
    id character varying(26) NOT NULL,
    name character varying(100) NOT NULL,
    code character varying(26),
    discription text,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: payment_type_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment_type_table (
    payment_type_id character varying(36) NOT NULL,
    store_id character varying(36),
    payment_type character varying(255),
    mid character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: paytm_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.paytm_config (
    id character varying(255) NOT NULL,
    merchant_id character varying(255),
    secret_key character varying(255),
    paytm_website character varying(255),
    channel character varying(255),
    industry_type character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: period_volume_discount_items_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.period_volume_discount_items_table (
    period_discount_item_id character varying(255) NOT NULL,
    item_id character varying(255),
    price_list_id character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    item_batch_number character varying(255)
);


--
-- Name: period_volume_discount_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.period_volume_discount_table (
    price_list_id character varying(255) NOT NULL,
    from_date date,
    to_date date,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: phonepe_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.phonepe_config (
    id character varying(255) NOT NULL,
    host_url character varying(255),
    merchant_id character varying(255),
    secret_key character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: pine_labs_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pine_labs_config (
    id character varying(255) NOT NULL,
    host_url character varying(255),
    merchant_id character varying(255),
    secret_key character varying(255),
    access_code character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: pos_items_batch_no_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pos_items_batch_no_table (
    item_id character varying(255),
    item_sellable_quantity bigint,
    item_non_sellable_quantity bigint,
    item_exp_date date,
    item_mfg_date date,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    item_batch_number character varying(255),
    pos_id character varying(50),
    item_batch_id character varying(50)
);


--
-- Name: pos_store_inventory_item_location_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pos_store_inventory_item_location_table (
    item_id character varying(255),
    store_id character varying(255),
    item_code character varying(255),
    item_quantity integer,
    item_batch_number character varying(50),
    item_rack_location character varying(50),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    to_bin_id character varying(255),
    pos_id character varying(50)
);


--
-- Name: price_list_items_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.price_list_items_table (
    item_id character varying(255),
    price_list_id character varying(255),
    is_manual boolean DEFAULT false,
    item_base_price numeric(10,2),
    item_selling_price numeric(10,2),
    item_inventory_uom character varying(255),
    item_pricing_uom character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    item_batch_number character varying(255),
    item_batch_final_purchase_rate numeric(10,2),
    item_mrp_price numeric(10,2),
    item_pricing_uom_id character varying(255),
    item_batch_purhcase_rate_before_tax numeric(20,2) DEFAULT 0.00
);


--
-- Name: price_list_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.price_list_table (
    price_list_id character varying(255) NOT NULL,
    price_list_name character varying(255),
    default_base_price_list_id character varying(255),
    default_factor numeric(10,2),
    rounding_method character varying(255),
    rounding_rule character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    default_base_price_list character varying,
    default_price_list boolean DEFAULT false,
    margin_factor numeric(10,2),
    is_margin_percentage boolean DEFAULT false
);


--
-- Name: print_prefer; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.print_prefer (
    id integer NOT NULL,
    type character varying(25) NOT NULL,
    print boolean DEFAULT true NOT NULL,
    print_copies integer DEFAULT 1 NOT NULL,
    preview boolean DEFAULT false NOT NULL,
    email boolean DEFAULT false NOT NULL,
    whatsapp boolean DEFAULT false NOT NULL,
    sms boolean DEFAULT false NOT NULL,
    export_pdf boolean DEFAULT false NOT NULL,
    export_csv boolean DEFAULT false NOT NULL,
    format integer DEFAULT 1 NOT NULL
);


--
-- Name: print_prefer_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.print_prefer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: print_prefer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.print_prefer_id_seq OWNED BY public.print_prefer.id;


--
-- Name: print_preference; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.print_preference (
    id character varying(255) NOT NULL,
    type character varying(255),
    image_url character varying(255),
    pdf_url character varying(255),
    is_current boolean DEFAULT false,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: print_preferences; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.print_preferences (
    id integer NOT NULL,
    type character varying(25) NOT NULL,
    print boolean DEFAULT true NOT NULL,
    print_copies integer DEFAULT 1 NOT NULL,
    preview boolean DEFAULT false NOT NULL,
    email boolean DEFAULT false NOT NULL,
    whatsapp boolean DEFAULT false NOT NULL,
    sms boolean DEFAULT false NOT NULL,
    export_pdf boolean DEFAULT false NOT NULL,
    export_csv boolean DEFAULT false NOT NULL,
    format integer DEFAULT 1 NOT NULL,
    format_uuid uuid
);


--
-- Name: print_preferences_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.print_preferences_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: print_preferences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.print_preferences_id_seq OWNED BY public.print_preferences.id;


--
-- Name: product_schedule_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_schedule_table (
    id character varying(26) NOT NULL,
    schedule character varying(100) NOT NULL,
    code character varying(26),
    discription text,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: purchase_account_allocation_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.purchase_account_allocation_table (
    gcct_id character varying(255) NOT NULL,
    period_category character varying(255),
    beginning_of_financial_year character varying(255),
    financial_year date,
    posting_date_from date,
    posting_date_to date,
    due_date_from date,
    due_date_to date,
    document_date_from date,
    document_date_to date,
    log_instance character varying(255),
    date_of_update date,
    user_signature character varying(255),
    domestic_accounts_payable character varying(255),
    foreign_accounts_payable character varying(255),
    bank_transfer character varying(255),
    cash_discount character varying(255),
    cash_discount_clearing character varying(255),
    purchase_credit_account character varying(255),
    overpayment_ap_account character varying(255),
    underpayment_ap_account character varying(255),
    payment_advances character varying(255),
    expense_and_inventory_account character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    realized_exchange_diff_gain character varying(255),
    realized_exchange_diff_loss character varying(255),
    expense_account character varying(255)
);


--
-- Name: purchase_credit_items_batches_list; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.purchase_credit_items_batches_list (
    item_id character varying(255),
    pct_id character varying(255),
    item_batch_number character varying(50),
    item_sellable_quantity numeric(10,2),
    item_non_sellable_quantity numeric(10,2),
    item_exp_date date,
    item_mfg_date date,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    item_batch_unit_price numeric(10,2),
    item_batch_free_quantity bigint,
    item_batch_purchase_rate numeric(10,2),
    item_batch_discount_amount numeric(10,2),
    item_batch_discount_percentage numeric(10,2),
    item_batch_tax_percentage numeric(10,2),
    item_batch_tax_amount numeric(10,2),
    item_batch_final_purchase_rate numeric(10,2),
    item_batch_total_purchase_rate numeric(10,2),
    to_bin_location character varying(255),
    to_bin_id character varying(255),
    item_batch_margin_percentage numeric(10,2),
    item_batch_total_effective_qauntity bigint,
    item_batch_for_qauntity bigint,
    item_batch_for_free_qauntity bigint,
    item_batch_scheme_discount_percentage numeric(20,2),
    item_batch_scheme_discount_amount numeric(20,2),
    item_batch_scheme_purchase_rate numeric(20,2),
    item_batch_taxable_amount numeric(20,2),
    item_batch_total_base_purchase_rate numeric(20,2),
    item_batch_gen_discount_amount numeric(20,2),
    item_batch_discounted_purchase_rate numeric(20,2),
    item_batch_purhcase_rate_before_tax numeric(20,2),
    item_batch_cgst_percentage numeric(10,2),
    item_batch_sgst_percentage numeric(10,2),
    item_batch_igst_percentage numeric(10,2),
    item_batch_cgst_amount numeric(10,2),
    item_batch_sgst_amount numeric(10,2),
    item_batch_igst_amount numeric(10,2),
    is_inter_state boolean DEFAULT false,
    item_batch_ptr_amount numeric(20,2),
    item_batch_pts_amount numeric(20,2),
    item_batch_pack_quantity numeric(20,2),
    item_batch_loose_quantity numeric(20,2),
    item_batch_pack_free_quantity numeric(20,2),
    item_batch_loose_free_quantity numeric(20,2),
    item_batch_free_loose_quantity numeric(20,2)
);


--
-- Name: purchase_credit_items_list_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.purchase_credit_items_list_table (
    item_id character varying(255),
    base_ref character varying(255),
    pct_id character varying(255),
    prt_id character varying(255),
    poit_id character varying(255),
    item_code character varying(255),
    item_generic_name character varying(255),
    item_name character varying(255),
    item_pack_size character varying(50),
    item_unit_price numeric(10,2),
    item_batch_number character varying(50),
    item_quantity integer,
    item_credit_quantity integer,
    item_rack_location character varying(50),
    item_schedule character varying(255),
    item_discount_amount numeric(10,2),
    item_discount_percentage numeric(10,2),
    item_tax_amount numeric(10,2),
    item_total_tax_percentage numeric(10,2),
    item_total_amount numeric(10,2),
    item_gst numeric(10,2),
    item_sgst numeric(10,2),
    item_cgst numeric(10,2),
    item_igst numeric(10,2),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    item_uom_id character varying(255),
    item_uom character varying(255),
    item_free_quantity bigint,
    item_manufacturer_name character varying(255),
    item_manufacturer_id character varying(255),
    item_hsn character varying(255),
    created_by character varying(255),
    updated_by character varying(255)
);


--
-- Name: purchase_credit_of_grn; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.purchase_credit_of_grn (
    gort_id character varying(255) NOT NULL,
    invoice_total_amount numeric(12,2),
    invoice_number character varying(50),
    remaining_amount numeric(12,2),
    adjusted_amount numeric(12,2),
    claimed_amount numeric(12,2),
    invoice_date date,
    remarks character varying(50)
);


--
-- Name: purchase_credit_of_invoice; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.purchase_credit_of_invoice (
    poit_id character varying(255) NOT NULL,
    invoice_total_amount numeric(12,2),
    invoice_number character varying(50),
    remaining_amount numeric(12,2),
    adjusted_amount numeric(12,2),
    claimed_amount numeric(12,2),
    invoice_date date,
    remarks character varying(50)
);


--
-- Name: purchase_credit_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.purchase_credit_table (
    pct_id character varying(255) NOT NULL,
    cmr_phone_number character varying(255),
    cmr_code character varying(255),
    cmr_name character varying(255),
    cmr_id character varying(255),
    pct_order_date date,
    pct_document_date date,
    pct_delivery_date date,
    store_id character varying(255),
    pct_invoice_number character varying(255),
    pct_total_gst numeric(10,2),
    pct_total_discount numeric(10,2),
    pct_payment_status character varying(50),
    pct_order_status character varying(50),
    pct_transaction_id character varying(255),
    pct_payment_method character varying(50),
    pct_billing_address text,
    pct_sub_total numeric(10,2),
    pct_total_amount numeric(10,2),
    remarks character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    data_synced boolean DEFAULT false,
    pct_round_off_value numeric(20,2),
    is_draft_order boolean DEFAULT false,
    pct_tds_tcs_type character varying(255),
    pct_tcs_or_tds_percentage numeric(10,2),
    pct_due_amount numeric(20,2) DEFAULT 0.00,
    pct_tcs_or_tds_percentage_id character varying(255),
    pct_tcs_or_tds_amount numeric(10,2),
    created_by character varying(255),
    updated_by character varying(255),
    pct_pay_to_address jsonb,
    pct_ship_to_address jsonb,
    pct_invoice_discount_percentage numeric(10,2),
    pct_invoice_discount numeric(10,2),
    pct_is_invoice_dis_percentage boolean DEFAULT false,
    pct_custom_invoice_number character varying(50),
    is_voided boolean DEFAULT false,
    gst_type character varying(26)
);


--
-- Name: purchase_order_document_list; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.purchase_order_document_list (
    pot_id character varying(255),
    gort_id character varying(255),
    poit_id character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: purchase_order_invoice_document_list; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.purchase_order_invoice_document_list (
    pct_id character varying(255),
    poit_id character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: purchase_order_invoice_items_batches_list; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.purchase_order_invoice_items_batches_list (
    item_id character varying(255),
    poit_id character varying(255),
    item_batch_number character varying(50),
    item_exp_date date,
    item_mfg_date date,
    item_sellable_quantity numeric(10,2),
    item_non_sellable_quantity numeric(10,2),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    item_batch_unit_price numeric(10,2),
    item_batch_free_quantity bigint,
    item_batch_purchase_rate numeric(10,2),
    item_batch_discount_amount numeric(10,2),
    item_batch_discount_percentage numeric(10,2),
    item_batch_tax_percentage numeric(10,2),
    item_batch_tax_amount numeric(10,2),
    item_batch_final_purchase_rate numeric(10,2),
    item_batch_total_purchase_rate numeric(10,2),
    to_bin_location character varying(255),
    to_bin_id character varying(255),
    item_batch_margin_percentage numeric(10,2),
    item_batch_gen_discount_amount numeric(20,2),
    item_batch_total_effective_qauntity bigint,
    item_batch_for_qauntity bigint,
    item_batch_for_free_qauntity bigint,
    item_batch_scheme_discount_percentage numeric(20,2),
    item_batch_scheme_discount_amount numeric(20,2),
    item_batch_scheme_purchase_rate numeric(20,2),
    item_batch_taxable_amount numeric(20,2),
    item_batch_total_base_purchase_rate numeric(20,2),
    item_batch_discounted_purchase_rate numeric(20,2),
    item_batch_cgst_percentage numeric(10,2),
    item_batch_sgst_percentage numeric(10,2),
    item_batch_igst_percentage numeric(10,2),
    item_batch_cgst_amount numeric(10,2),
    item_batch_sgst_amount numeric(10,2),
    item_batch_igst_amount numeric(10,2),
    is_inter_state boolean DEFAULT false,
    item_batch_ptr_amount numeric(20,2),
    item_batch_pts_amount numeric(20,2),
    item_batch_pack_quantity numeric(20,2),
    item_batch_loose_quantity numeric(20,2),
    item_batch_pack_free_quantity numeric(20,2),
    item_batch_loose_free_quantity numeric(20,2),
    item_batch_purhcase_rate_before_tax numeric(20,2)
);


--
-- Name: purchase_order_invoice_items_list; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.purchase_order_invoice_items_list (
    item_id character varying(255),
    poit_id character varying(255),
    base_ref character varying(255),
    pot_id character varying(255),
    gort_id character varying(255),
    item_code character varying(255),
    item_generic_name character varying(255),
    item_name character varying(255),
    item_pack_size character varying(50),
    item_unit_price numeric(10,2),
    item_batch_number character varying(50),
    item_quantity integer,
    item_credit_quanity_remaining integer,
    item_exp_date date,
    item_mfg_date date,
    item_rack_location character varying(50),
    item_schedule character varying(255),
    item_discount_amount numeric(10,2),
    item_discount_percentage numeric(10,2),
    item_tax_amount numeric(10,2),
    item_total_tax_percentage numeric(10,2),
    item_total_amount numeric(10,2),
    item_gst numeric(10,2),
    item_sgst numeric(10,2),
    item_cgst numeric(10,2),
    item_igst numeric(10,2),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    item_uom character varying(255),
    item_uom_id character varying(255),
    item_free_quantity bigint,
    item_manufacturer_name character varying(255),
    item_manufacturer_id character varying(255),
    item_hsn character varying(255),
    created_by character varying(255),
    updated_by character varying(255)
);


--
-- Name: purchase_order_invoice_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.purchase_order_invoice_table (
    poit_id character varying(255) NOT NULL,
    cmr_phone_number character varying(255),
    cmr_code character varying(255),
    cmr_name character varying(255),
    cmr_id character varying(255),
    poit_order_date date,
    poit_document_date date,
    poit_delivery_date date,
    store_id character varying(255),
    poit_invoice_number character varying(255),
    poit_total_gst numeric(10,2),
    poit_total_discount numeric(10,2),
    poit_payment_status character varying(50),
    poit_order_status character varying(50),
    poit_transaction_id character varying(255),
    poit_payment_method character varying(50),
    poit_billing_address text,
    poit_sub_total numeric(10,2),
    poit_total_amount numeric(10,2),
    remarks character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    poit_due_amount numeric(10,2),
    data_synced boolean DEFAULT false,
    pos_id character varying(255),
    poit_round_off_value numeric(20,2),
    poit_tds_tcs_type character varying(255),
    poit_due_date date,
    created_by character varying(255),
    updated_by character varying(255),
    poit_tcs_or_tds_percentage numeric(10,2),
    poit_tcs_or_tds_percentage_id character varying(255),
    poit_tcs_or_tds_amount numeric(10,2),
    is_draft_order boolean DEFAULT false,
    only_remarks boolean DEFAULT false,
    is_local_purchase boolean DEFAULT false,
    is_local_data_synced boolean DEFAULT false,
    on_behalf_of_name character varying(255),
    on_behalf_of_id character varying(255),
    poit_pay_to_address jsonb,
    poit_ship_to_address jsonb,
    poit_invoice_discount_percentage numeric(10,2),
    poit_invoice_discount numeric(10,2),
    poit_is_invoice_dis_percentage boolean DEFAULT false,
    customer_invoice_number character varying(255),
    inv_no character varying(255),
    poit_custom_invoice_number character varying(50),
    is_voided boolean DEFAULT false,
    gst_type character varying(26)
);


--
-- Name: purchase_order_items_list; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.purchase_order_items_list (
    item_id character varying(255),
    pot_id character varying(255),
    item_code character varying(255),
    item_generic_name character varying(255),
    item_name character varying(255),
    item_pack_size character varying(50),
    item_unit_price numeric(10,2),
    item_uom character varying(50),
    item_batch_number character varying(50),
    item_quantity integer,
    item_exp_date date,
    item_mfg_date date,
    item_rack_location character varying(50),
    item_schedule character varying(255),
    item_discount_amount numeric(10,2),
    item_discount_percentage numeric(10,2),
    item_tax_amount numeric(10,2),
    item_total_tax_percentage numeric(10,2),
    item_total_amount numeric(10,2),
    item_gst numeric(10,2),
    item_sgst numeric(10,2),
    item_cgst numeric(10,2),
    item_igst numeric(10,2),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    base_ref_no character varying,
    item_to_be_received integer,
    item_invoice_open_quantity integer,
    item_uom_id character varying(255),
    item_manufacturer_name character varying(255),
    item_manufacturer_id character varying(255),
    item_hsn character varying(255),
    item_return_availability character varying(255),
    item_maximum_purchasing character varying(255),
    item_minimun_purchasing character varying(255),
    item_batch_total_base_purchase_rate numeric(10,2),
    mrp numeric(10,2),
    molecule_name character varying(255),
    item_baby_box_packing character varying(255),
    item_packing_baby_box character varying(255)
);


--
-- Name: purchase_order_transaction_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.purchase_order_transaction_table (
    pot_id character varying(255) NOT NULL,
    cmr_phone_number character varying(255),
    cmr_code character varying(255),
    cmr_name character varying(255),
    pot_order_date date,
    pot_document_date date,
    pot_delivery_date date,
    store_id character varying(255),
    pot_invoice_number character varying(255),
    pot_total_gst numeric(10,2),
    pot_total_discount numeric(10,2),
    pot_payment_status character varying(50),
    pot_order_status character varying(50),
    pot_transaction_id character varying(255),
    pot_payment_method character varying(50),
    pot_billing_address text,
    pot_total_amount numeric(10,2),
    remarks character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    cmr_id character varying,
    pot_sub_total numeric(10,2),
    data_synced boolean DEFAULT false,
    pos_id character varying(255),
    pot_round_off_value numeric(20,2),
    updated_by character varying(255),
    pot_pay_to_address jsonb,
    pot_ship_to_address jsonb,
    is_draft_order boolean DEFAULT false,
    customer_invoice_number character varying(255),
    inv_no character varying(255),
    created_by character varying(255),
    pot_expected_delivery_date date,
    is_voided boolean DEFAULT false
);


--
-- Name: purchase_return_document_list; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.purchase_return_document_list (
    prt_id character varying(255),
    pct_id character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: purchase_return_items_batches_list; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.purchase_return_items_batches_list (
    item_id character varying(255),
    prt_id character varying(255),
    item_batch_number character varying(50),
    item_sellable_quantity numeric(10,2),
    item_non_sellable_quantity numeric(10,2),
    item_exp_date date,
    item_mfg_date date,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    item_batch_unit_price numeric(10,2),
    item_batch_free_quantity bigint,
    item_batch_purchase_rate numeric(10,2),
    item_batch_discount_amount numeric(10,2),
    item_batch_discount_percentage numeric(10,2),
    item_batch_tax_percentage numeric(10,2),
    item_batch_tax_amount numeric(10,2),
    item_batch_final_purchase_rate numeric(10,2),
    item_batch_total_purchase_rate numeric(10,2),
    to_bin_location character varying(255),
    to_bin_id character varying(255),
    item_batch_margin_percentage numeric(10,2),
    item_batch_total_effective_qauntity bigint,
    item_batch_total_base_purchase_rate numeric(10,2),
    item_batch_for_qauntity bigint,
    item_batch_for_free_qauntity bigint,
    item_batch_scheme_discount_percentage numeric(20,2),
    item_batch_scheme_discount_amount numeric(20,2),
    item_batch_scheme_purchase_rate numeric(20,2),
    item_batch_taxable_amount numeric(20,2),
    item_batch_gen_discount_amount numeric(20,2),
    item_batch_discounted_purchase_rate numeric(20,2),
    item_batch_purhcase_rate_before_tax numeric(20,2),
    item_uom_id character varying(255),
    item_uom character varying(255),
    item_batch_cgst_percentage numeric(10,2),
    item_batch_sgst_percentage numeric(10,2),
    item_batch_igst_percentage numeric(10,2),
    item_batch_cgst_amount numeric(10,2),
    item_batch_sgst_amount numeric(10,2),
    item_batch_igst_amount numeric(10,2),
    is_inter_state boolean DEFAULT false,
    item_batch_ptr_amount numeric(20,2),
    item_batch_pts_amount numeric(20,2),
    item_batch_pack_quantity numeric(20,2),
    item_batch_loose_quantity numeric(20,2),
    item_batch_pack_free_quantity numeric(20,2),
    item_batch_loose_free_quantity numeric(20,2)
);


--
-- Name: purchase_return_items_list; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.purchase_return_items_list (
    item_id character varying(255),
    base_ref character varying(255),
    prt_id character varying(255),
    item_code character varying(255),
    item_generic_name character varying(255),
    item_name character varying(255),
    item_pack_size character varying(50),
    item_unit_price numeric(10,2),
    item_batch_number character varying(50),
    item_quantity integer,
    item_exp_date date,
    item_mfg_date date,
    item_rack_location character varying(50),
    item_schedule character varying(255),
    item_discount_amount numeric(10,2),
    item_discount_percentage numeric(10,2),
    item_tax_amount numeric(10,2),
    item_total_tax_percentage numeric(10,2),
    item_total_amount numeric(10,2),
    item_gst numeric(10,2),
    item_sgst numeric(10,2),
    item_cgst numeric(10,2),
    item_igst numeric(10,2),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    gort_id character varying,
    item_credit_quanity_remaining integer,
    item_uom_id character varying(255),
    item_uom character varying(255),
    item_free_quantity bigint,
    item_manufacturer_name character varying(255),
    item_manufacturer_id character varying(255),
    item_hsn character varying(255),
    created_by character varying(255),
    updated_by character varying(255)
);


--
-- Name: purchase_return_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.purchase_return_table (
    prt_id character varying(255) NOT NULL,
    cmr_phone_number character varying(255),
    cmr_code character varying(255),
    cmr_name character varying(255),
    cmr_id character varying(255),
    sort_order_date date,
    prt_document_date date,
    prt_delivery_date date,
    store_id character varying(255),
    prt_invoice_number character varying(255),
    prt_total_gst numeric(10,2),
    prt_total_discount numeric(10,2),
    prt_payment_status character varying(50),
    prt_order_status character varying(50),
    prt_transaction_id character varying(255),
    prt_payment_method character varying(50),
    prt_billing_address text,
    prt_sub_total numeric(10,2),
    prt_total_amount numeric(10,2),
    remarks character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    data_synced boolean DEFAULT false,
    prt_round_off_value numeric(20,2),
    is_draft_order boolean DEFAULT false,
    prt_tds_tcs_type character varying(255),
    prt_tcs_or_tds_percentage numeric(10,2),
    prt_tcs_or_tds_percentage_id character varying(255),
    prt_tcs_or_tds_amount numeric(10,2),
    created_by character varying(255),
    updated_by character varying(255),
    prt_pay_to_address jsonb,
    prt_ship_to_address jsonb,
    prt_invoice_discount_percentage numeric(10,2),
    prt_invoice_discount numeric(10,2),
    prt_is_invoice_dis_percentage boolean DEFAULT false,
    is_voided boolean DEFAULT false,
    gst_type character varying(26)
);


--
-- Name: razorpay_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.razorpay_config (
    id character varying(255) NOT NULL,
    key_id character varying(255),
    key_secret character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: region_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.region_table (
    id character varying(26) NOT NULL,
    name character varying(100) NOT NULL,
    code character varying(26),
    discription text,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: relationship_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.relationship_table (
    id character varying(26) NOT NULL,
    name character varying(100) NOT NULL,
    code character varying(26),
    discription text,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: reporttags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reporttags (
    tag_id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(255),
    reports character varying(255)[] DEFAULT (ARRAY[]::character varying[])::character varying(255)[],
    color integer,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: roles_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.roles_table (
    role_id character varying(255) NOT NULL,
    role_name character varying(255),
    description character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    role_code character varying(255),
    created_by character varying(255),
    updated_by character varying(255)
);


--
-- Name: sale_order_delivery_document_list; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sale_order_delivery_document_list (
    sodtt_id character varying(255),
    srt_id character varying(255),
    soit_id character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: sale_order_delivery_items_batches_list; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sale_order_delivery_items_batches_list (
    item_id character varying(255),
    sodtt_id character varying(255),
    item_batch_number character varying(50),
    item_batch_quantity integer,
    item_exp_date date,
    item_mfg_date date,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    item_batch_unit_price numeric(10,2),
    item_batch_free_quantity bigint,
    item_batch_purchase_rate numeric(10,2),
    from_bin_location character varying(255),
    from_bin_id character varying(255),
    item_batch_discount_amount numeric(10,2),
    item_batch_discount_percentage numeric(10,2),
    item_batch_tax_percentage numeric(10,2),
    item_batch_tax_amount numeric(10,2),
    item_batch_final_sales_rate numeric(10,2),
    item_batch_total_sales_rate numeric(10,2),
    item_batch_sales_rate numeric(10,2),
    item_uom character varying(255),
    item_uom_id character varying(255),
    item_batch_total_base_sales_rate numeric(10,2),
    item_batch_discounted_sales_rate numeric(10,2)
);


--
-- Name: sale_order_delivery_items_list; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sale_order_delivery_items_list (
    item_id character varying(255),
    sodtt_id character varying(255),
    sott_id character varying(255),
    item_code character varying(255),
    item_generic_name character varying(255),
    item_name character varying(255),
    item_pack_size character varying(50),
    item_unit_price numeric(10,2),
    item_batch_number character varying(50),
    item_quantity integer,
    item_delivered_quantity integer,
    item_exp_date date,
    item_mfg_date date,
    item_rack_location character varying(50),
    item_schedule character varying(255),
    item_discount_amount numeric(10,2),
    item_discount_percentage numeric(10,2),
    item_tax_amount numeric(10,2),
    item_total_tax_percentage numeric(10,2),
    item_total_amount numeric(10,2),
    item_gst numeric(10,2),
    item_sgst numeric(10,2),
    item_cgst numeric(10,2),
    item_igst numeric(10,2),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    is_item_invoice_created boolean DEFAULT false,
    item_to_be_delivered integer,
    item_return_open_quantity integer,
    item_uom_id character varying(255),
    item_uom character varying(255),
    item_free_quantity bigint,
    item_manufacturer_name character varying(255),
    item_manufacturer_id character varying(255),
    item_hsn character varying(255),
    pot_id character varying(255),
    pos_id character varying(255),
    srt_id character varying(255),
    created_by character varying(255),
    updated_by character varying(255)
);


--
-- Name: sales_account_allocation_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sales_account_allocation_table (
    gcct_id character varying(255) NOT NULL,
    period_category character varying(255),
    beginning_of_financial_year character varying(255),
    financial_year date,
    posting_date_from date,
    posting_date_to date,
    due_date_from date,
    due_date_to date,
    document_date_from date,
    document_date_to date,
    log_instance character varying(255),
    date_of_update date,
    user_signature character varying(255),
    domestic_accounts_receivable character varying(255),
    checks_received character varying(255),
    cash_on_hand character varying(255),
    foreign_accounts_receivable character varying(255),
    overpayment_ar_account character varying(255),
    underpayment_ar_account character varying(255),
    payment_advances character varying(255),
    realized_exchange_diff_gain character varying(255),
    realized_exchange_diff_loss character varying(255),
    cash_discount character varying(255),
    revenue_account character varying(255),
    sales_credit_account character varying(255),
    dunning_interest character varying(255),
    dunning_fee character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: sales_credit_items_batches_list; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sales_credit_items_batches_list (
    item_id character varying(255),
    sct_id character varying(255),
    item_batch_number character varying(50),
    item_batch_quantity integer,
    item_exp_date date,
    item_mfg_date date,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    from_bin_location character varying(255),
    from_bin_id character varying(255),
    item_batch_free_quantity bigint,
    item_batch_discount_amount numeric(10,2),
    item_batch_discount_percentage numeric(10,2),
    item_batch_tax_percentage numeric(10,2),
    item_batch_tax_amount numeric(10,2),
    item_batch_final_sales_rate numeric(10,2),
    item_batch_total_sales_rate numeric(10,2),
    item_batch_sales_rate numeric(10,2),
    item_batch_unit_price numeric(10,2),
    item_batch_total_base_sales_rate numeric(10,2),
    item_batch_discounted_sales_rate numeric(10,2)
);


--
-- Name: sales_credit_items_list_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sales_credit_items_list_table (
    item_id character varying(255),
    base_ref character varying(255),
    sct_id character varying(255),
    srt_id character varying(255),
    item_code character varying(255),
    item_generic_name character varying(255),
    item_name character varying(255),
    item_pack_size character varying(50),
    item_unit_price numeric(10,2),
    item_batch_number character varying(50),
    item_quantity integer,
    item_credit_quantity integer,
    item_rack_location character varying(50),
    item_schedule character varying(255),
    item_discount_amount numeric(10,2),
    item_discount_percentage numeric(10,2),
    item_tax_amount numeric(10,2),
    item_total_tax_percentage numeric(10,2),
    item_total_amount numeric(10,2),
    item_gst numeric(10,2),
    item_sgst numeric(10,2),
    item_cgst numeric(10,2),
    item_igst numeric(10,2),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    soit_id character varying(255),
    item_uom_id character varying(255),
    item_uom character varying(255),
    item_free_quantity bigint,
    item_manufacturer_name character varying(255),
    item_manufacturer_id character varying(255),
    item_hsn character varying(255),
    pot_id character varying(255),
    item_batch_discounted_sales_rate numeric(10,2),
    pos_id character varying(50),
    created_by character varying(255),
    updated_by character varying(255)
);


--
-- Name: sales_credit_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sales_credit_table (
    sct_id character varying(255) NOT NULL,
    cmr_phone_number character varying(255),
    cmr_code character varying(255),
    cmr_name character varying(255),
    cmr_id character varying(255),
    sct_order_date date,
    sct_document_date date,
    sct_delivery_date date,
    store_id character varying(255),
    sct_invoice_number character varying(255),
    sct_total_gst numeric(10,2),
    sct_total_discount numeric(10,2),
    sct_payment_status character varying(50),
    sct_order_status character varying(50),
    sct_transaction_id character varying(255),
    sct_payment_method character varying(50),
    sct_billing_address text,
    sct_sub_total numeric(10,2),
    sct_total_amount numeric(10,2),
    remarks character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    data_synced boolean DEFAULT false,
    sct_round_off_value numeric(20,2),
    pct_id character varying,
    sct_tds_tcs_type character varying(255),
    sct_tcs_or_tds_percentage numeric(10,2),
    sct_tcs_or_tds_percentage_id character varying(255),
    sct_tcs_or_tds_amount numeric(10,2),
    sct_pay_to_address jsonb,
    sct_ship_to_address jsonb,
    is_draft_order boolean DEFAULT false,
    sct_invoice_discount_percentage numeric(10,2),
    sct_invoice_discount numeric(10,2),
    sct_is_invoice_dis_percentage boolean DEFAULT false,
    inv_no character varying(255),
    sct_custom_invoice_number character varying(50),
    created_by character varying(255),
    updated_by character varying(255),
    is_voided boolean DEFAULT false,
    pot_id character varying(50),
    pos_id character varying(50)
);


--
-- Name: sales_order; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sales_order (
    sot_id character varying(255) NOT NULL,
    sot_return_status character varying(255),
    cmr_phone_number character varying(255),
    store_id character varying(255),
    sot_invoice_number character varying(255),
    sot_total_gst numeric(10,2),
    sot_total_discount numeric(10,2),
    sot_sub_total numeric(10,2),
    sot_payment_status character varying(50),
    sot_order_status character varying(50),
    sot_transaction_id character varying(255),
    sot_payment_method character varying(50),
    sot_billing_address text,
    sot_total_amount numeric(10,2),
    doctor_name character varying(255),
    cmr_id character varying(50),
    is_draft_order boolean DEFAULT false,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    sot_remarks character varying(255),
    data_synced boolean DEFAULT false,
    sot_round_off_value numeric(20,2),
    sot_invoice_pdf text,
    created_by character varying(255),
    updated_by character varying(255),
    sot_margin_percentage numeric(10,2),
    user_id character varying(255),
    sot_invoice_discount_percentage numeric(10,2),
    sot_invoice_discount numeric(10,2),
    sot_is_store_pick_up boolean,
    sot_is_invoice_dis_percentage boolean,
    sot_prescription jsonb DEFAULT '[]'::jsonb,
    sot_custom_invoice_number character varying(255),
    sot_custom_invoice_date date,
    sot_pay_to_address jsonb,
    sot_ship_to_address jsonb,
    doctor_id character varying(255)
);


--
-- Name: sales_order_delivery_transaction_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sales_order_delivery_transaction_table (
    sodtt_id character varying(255) NOT NULL,
    cmr_phone_number character varying(255),
    cmr_code character varying(255),
    cmr_name character varying(255),
    sodtt_order_date date,
    sodtt_document_date date,
    sodtt_delivery_date date,
    store_id character varying(255),
    sodtt_invoice_number character varying(255),
    sodtt_total_gst numeric(10,2),
    sodtt_total_discount numeric(10,2),
    sodtt_payment_status character varying(50),
    sodtt_order_status character varying(50),
    sodtt_transaction_id character varying(255),
    sodtt_payment_method character varying(50),
    sodtt_billing_address text,
    sodtt_total_amount numeric(10,2),
    remarks character varying(255),
    sott_id character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    cmr_id character varying(255),
    sodtt_sub_total numeric(10,2),
    is_invoice_created boolean DEFAULT false,
    data_synced boolean DEFAULT false,
    pot_id character varying(255),
    pos_id character varying(255),
    sodtt_round_off_value numeric(20,2),
    sodtt_tds_tcs_type character varying(255),
    sodtt_tcs_or_tds_percentage numeric(10,2),
    sodtt_tcs_or_tds_percentage_id character varying(255),
    sodtt_tcs_or_tds_amount numeric(10,2),
    sodtt_pay_to_address jsonb,
    sodtt_ship_to_address jsonb,
    is_draft_order boolean DEFAULT false,
    sodtt_invoice_discount_percentage numeric(10,2),
    sodtt_invoice_discount numeric(10,2),
    sodtt_is_invoice_dis_percentage boolean DEFAULT false,
    inv_no character varying(255),
    is_voided boolean DEFAULT false,
    created_by character varying(255),
    updated_by character varying(255)
);


--
-- Name: sales_order_document_list; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sales_order_document_list (
    sott_id character varying(255),
    sodtt_id character varying(255),
    soit_id character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: sales_order_invoice_document_list; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sales_order_invoice_document_list (
    soit_id character varying(255),
    sct_id character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: sales_order_invoice_items_batches_list; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sales_order_invoice_items_batches_list (
    item_id character varying(255),
    soit_id character varying(255),
    item_batch_number character varying(50),
    item_batch_quantity integer,
    item_exp_date date,
    item_mfg_date date,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    from_bin_location character varying(255),
    from_bin_id character varying(255),
    item_batch_free_quantity bigint,
    item_batch_discount_amount numeric(10,2),
    item_batch_discount_percentage numeric(10,2),
    item_batch_tax_percentage numeric(10,2),
    item_batch_tax_amount numeric(10,2),
    item_batch_final_sales_rate numeric(10,2),
    item_batch_total_sales_rate numeric(10,2),
    item_batch_sales_rate numeric(10,2),
    item_batch_unit_price numeric(10,2),
    item_batch_total_base_sales_rate numeric(10,2),
    item_batch_discounted_sales_rate numeric(10,2),
    created_by character varying(255),
    updated_by character varying(255)
);


--
-- Name: sales_order_invoice_items_list; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sales_order_invoice_items_list (
    item_id character varying(255),
    soit_id character varying(255),
    item_code character varying(255),
    item_generic_name character varying(255),
    item_name character varying(255),
    item_pack_size character varying(50),
    item_unit_price numeric(10,2),
    item_batch_number character varying(50),
    item_quantity integer,
    item_exp_date date,
    item_mfg_date date,
    item_rack_location character varying(50),
    item_schedule character varying(255),
    item_discount_amount numeric(10,2),
    item_discount_percentage numeric(10,2),
    item_tax_amount numeric(10,2),
    item_total_tax_percentage numeric(10,2),
    item_total_amount numeric(10,2),
    item_gst numeric(10,2),
    item_sgst numeric(10,2),
    item_cgst numeric(10,2),
    item_igst numeric(10,2),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    sott_id character varying,
    sodtt_id character varying,
    item_open_credit_note_quantiy numeric(10,2),
    item_credit_quanity_remaining integer,
    item_due_amount numeric(10,2),
    item_uom_id character varying(255),
    item_uom character varying(255),
    item_free_quantity bigint,
    item_manufacturer_name character varying(255),
    item_manufacturer_id character varying(255),
    item_hsn character varying(255),
    pot_id character varying(255),
    pos_id character varying(255),
    created_by character varying(255),
    updated_by character varying(255)
);


--
-- Name: sales_order_invoice_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sales_order_invoice_table (
    soit_id character varying(255) NOT NULL,
    cmr_phone_number character varying(255),
    cmr_code character varying(255),
    cmr_name character varying(255),
    cmr_id character varying(255),
    soit_order_date date,
    soit_document_date date,
    soit_delivery_date date,
    store_id character varying(255),
    soit_invoice_number character varying(255),
    soit_total_gst numeric(10,2),
    soit_total_discount numeric(10,2),
    soit_payment_status character varying(50),
    soit_order_status character varying(50),
    soit_transaction_id character varying(255),
    soit_payment_method character varying(50),
    soit_billing_address text,
    soit_sub_total numeric(10,2),
    soit_total_amount numeric(10,2),
    remarks character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    soit_due_amount numeric(10,2),
    data_synced boolean DEFAULT false,
    pot_id character varying(255),
    pos_id character varying(255),
    soit_round_off_value numeric(20,2),
    soit_tds_tcs_type character varying(255),
    soit_due_date date,
    created_by character varying(255),
    updated_by character varying(255),
    soit_tcs_or_tds_percentage numeric(10,2),
    soit_tcs_or_tds_percentage_id character varying(255),
    soit_tcs_or_tds_amount numeric(10,2),
    poit_id character varying(255),
    is_local_purchase boolean DEFAULT false,
    is_local_data_synced boolean DEFAULT false,
    on_behalf_of_name character varying(255),
    on_behalf_of_id character varying(255),
    soit_pay_to_address jsonb,
    soit_ship_to_address jsonb,
    is_draft_order boolean DEFAULT false,
    soit_invoice_discount_percentage numeric(10,2),
    soit_invoice_discount numeric(10,2),
    soit_is_invoice_dis_percentage boolean DEFAULT false,
    inv_no character varying(255),
    soit_custom_invoice_number character varying(50),
    is_voided boolean DEFAULT false
);


--
-- Name: sales_order_items_list; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sales_order_items_list (
    item_id character varying(255),
    sott_id character varying(255),
    item_code character varying(255),
    item_generic_name character varying(255),
    item_name character varying(255),
    item_pack_size character varying(50),
    item_unit_price numeric(10,2),
    item_batch_number character varying(50),
    item_quantity integer,
    item_to_be_delivered integer,
    item_exp_date date,
    item_mfg_date date,
    item_rack_location character varying(50),
    item_schedule character varying(255),
    item_discount_amount numeric(10,2),
    item_discount_percentage numeric(10,2),
    item_tax_amount numeric(10,2),
    item_total_tax_percentage numeric(10,2),
    item_total_amount numeric(10,2),
    item_gst numeric(10,2),
    item_sgst numeric(10,2),
    item_cgst numeric(10,2),
    item_igst numeric(10,2),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    item_uom character varying(255),
    item_invoice_open_quantity integer,
    item_uom_id character varying(255),
    item_return_availability character varying(255),
    item_maximum_purchasing character varying(255),
    item_minimun_purchasing character varying(255),
    item_requested_quantity bigint,
    pot_id character varying(255),
    item_manufacturer_name character varying(255),
    item_manufacturer_id character varying(255),
    item_hsn character varying(255),
    pos_id character varying(255),
    mrp numeric(12,2) DEFAULT 0,
    item_batch_total_base_purchase_rate numeric(12,2) DEFAULT 0
);


--
-- Name: sales_order_transaction_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sales_order_transaction_table (
    sott_id character varying(255) NOT NULL,
    cmr_phone_number character varying(255),
    cmr_code character varying(255),
    cmr_name character varying(255),
    sott_order_date date,
    sott_document_date date,
    sott_delivery_date date,
    store_id character varying(255),
    sott_invoice_number character varying(255),
    sott_total_gst numeric(10,2),
    sott_total_discount numeric(10,2),
    sott_payment_status character varying(50),
    sott_order_status character varying(50),
    sott_transaction_id character varying(255),
    sott_payment_method character varying(50),
    sott_billing_address text,
    sott_total_amount numeric(10,2),
    remarks character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    cmr_id character varying,
    data_synced boolean DEFAULT false,
    pot_id character varying(255),
    pos_id character varying(255),
    sott_round_off_value numeric(20,2),
    created_by character varying(255),
    updated_by character varying(255),
    sott_pay_to_address jsonb,
    sott_ship_to_address jsonb,
    is_draft_order boolean DEFAULT false,
    inv_no character varying(255)
);


--
-- Name: sales_report_vw; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.sales_report_vw AS
 SELECT order_items_list.item_id,
    order_items_list.sot_id,
    order_items_list.item_code,
    order_items_list.item_generic_name,
    order_items_list.item_name,
    order_items_list.item_pack_size,
    order_items_list.item_unit_price,
    order_items_list.item_batch_number,
    order_items_list.item_quantity,
    order_items_list.item_exp_date,
    order_items_list.item_mfg_date,
    order_items_list.item_rack_location,
    order_items_list.item_schedule,
    order_items_list.item_discount_amount,
    order_items_list.item_discount_percentage,
    order_items_list.item_tax_amount,
    order_items_list.item_total_tax_percentage,
    order_items_list.item_total_amount,
    order_items_list.item_gst,
    order_items_list.item_sgst,
    order_items_list.item_cgst,
    order_items_list.item_igst,
    order_items_list.update_date,
    order_items_list.created_date,
    order_items_list.item_uom
   FROM public.order_items_list;


--
-- Name: sales_return_document_list; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sales_return_document_list (
    srt_id character varying(255),
    sct_id character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: sales_return_items_batches_list; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sales_return_items_batches_list (
    item_id character varying(255),
    srt_id character varying(255),
    item_batch_number character varying(50),
    item_batch_quantity integer,
    item_exp_date date,
    item_mfg_date date,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    from_bin_location character varying(255),
    from_bin_id character varying(255),
    item_batch_free_quantity bigint,
    item_batch_discount_amount numeric(10,2),
    item_batch_discount_percentage numeric(10,2),
    item_batch_tax_percentage numeric(10,2),
    item_batch_tax_amount numeric(10,2),
    item_batch_final_sales_rate numeric(10,2),
    item_batch_total_sales_rate numeric(10,2),
    item_batch_sales_rate numeric(10,2),
    item_batch_unit_price numeric(10,2),
    item_batch_total_base_sales_rate numeric(10,2),
    item_batch_discounted_sales_rate numeric(10,2)
);


--
-- Name: sales_return_items_list; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sales_return_items_list (
    item_id character varying(255),
    soit_id character varying(255),
    srt_id character varying(255),
    sott_id character varying(255),
    sodtt_id character varying(255),
    item_code character varying(255),
    item_generic_name character varying(255),
    item_name character varying(255),
    item_pack_size character varying(50),
    item_unit_price numeric(10,2),
    item_batch_number character varying(50),
    item_quantity integer,
    item_exp_date date,
    item_mfg_date date,
    item_rack_location character varying(50),
    item_schedule character varying(255),
    item_discount_amount numeric(10,2),
    item_discount_percentage numeric(10,2),
    item_tax_amount numeric(10,2),
    item_total_tax_percentage numeric(10,2),
    item_total_amount numeric(10,2),
    item_gst numeric(10,2),
    item_sgst numeric(10,2),
    item_cgst numeric(10,2),
    item_igst numeric(10,2),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    item_credit_quanity_remaining integer,
    item_uom_id character varying(255),
    item_uom character varying(255),
    item_free_quantity bigint,
    item_manufacturer_name character varying(255),
    item_manufacturer_id character varying(255),
    item_hsn character varying(255),
    pot_id character varying(50),
    pos_id character varying(50),
    created_by character varying(255),
    updated_by character varying(255)
);


--
-- Name: sales_return_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sales_return_table (
    srt_id character varying(255) NOT NULL,
    cmr_phone_number character varying(255),
    cmr_code character varying(255),
    cmr_name character varying(255),
    cmr_id character varying(255),
    sort_order_date date,
    srt_document_date date,
    srt_delivery_date date,
    store_id character varying(255),
    srt_invoice_number character varying(255),
    srt_total_gst numeric(10,2),
    srt_total_discount numeric(10,2),
    srt_payment_status character varying(50),
    srt_order_status character varying(50),
    srt_transaction_id character varying(255),
    srt_payment_method character varying(50),
    srt_billing_address text,
    srt_sub_total numeric(10,2),
    srt_total_amount numeric(10,2),
    remarks character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    data_synced boolean DEFAULT false,
    srt_round_off_value numeric(20,2),
    prt_id character varying,
    srt_tds_tcs_type character varying(255),
    srt_tcs_or_tds_percentage numeric(10,2),
    srt_tcs_or_tds_percentage_id character varying(255),
    srt_tcs_or_tds_amount numeric(10,2),
    created_by character varying(255),
    updated_by character varying(255),
    is_draft_order boolean DEFAULT false,
    srt_pay_to_address jsonb,
    srt_ship_to_address jsonb,
    srt_invoice_discount_percentage numeric(10,2),
    srt_invoice_discount numeric(10,2),
    srt_is_invoice_dis_percentage boolean DEFAULT false,
    inv_no character varying(255),
    is_voided boolean DEFAULT false,
    pot_id character varying(50),
    pos_id character varying(50)
);


--
-- Name: server_ips; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.server_ips (
    server_id character varying(26) NOT NULL,
    server_name character varying(255) NOT NULL,
    ip_address character varying(26),
    created_by character varying(26),
    updated_by character varying(26),
    cmr_id character varying(266),
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: shipping_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shipping_type (
    id character varying(255) NOT NULL,
    name character varying(255),
    carrier character varying(255),
    field_1 character varying(255),
    field_2 character varying(255),
    field_3 character varying(255),
    status boolean DEFAULT false,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: sms_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sms_config (
    id character varying(255) NOT NULL,
    api_key character varying(255),
    api_url character varying(255),
    user_name character varying(255),
    password character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: smtp_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.smtp_config (
    id character varying(255) NOT NULL,
    email character varying(255),
    from_name character varying(255),
    user_name character varying(255),
    host character varying(255),
    password character varying(255),
    port character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: socket_connection_id_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.socket_connection_id_table (
    socket_id character varying(255) NOT NULL,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: sot_invoice_number; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sot_invoice_number
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sott_invoice_number; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sott_invoice_number
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: specialization_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.specialization_table (
    id character varying(26) NOT NULL,
    name character varying(100) NOT NULL,
    code character varying(26),
    discription text,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: state_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.state_table (
    id character varying(26) NOT NULL,
    name character varying(100) NOT NULL,
    code character varying(26),
    discription text,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: stock_audit_items_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stock_audit_items_table (
    sait_id character varying(255) NOT NULL,
    sat_id character varying(50),
    item_id character varying(50),
    item_code character varying(50),
    item_generic_name character varying(255),
    item_name character varying(255),
    item_pack_size character varying(50),
    item_uom character varying(50),
    item_uom_id character varying(255),
    item_batch_number character varying(50),
    item_quantity integer,
    item_exp_date timestamp without time zone,
    item_mfg_date timestamp without time zone,
    item_correction_quantity integer,
    item_total_amount numeric(10,2),
    updated_quantity integer,
    correction character varying(50),
    item_current_amount numeric(10,2),
    item_adjusted_amount numeric(10,2),
    item_current_adjusted_diff numeric(10,2),
    to_bin_id character varying(255),
    item_rack_location character varying(50),
    item_batch_purchase_rate numeric(10,2),
    is_stock_draft boolean DEFAULT false,
    created_by character varying(255),
    updated_by character varying(255),
    update_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: stock_audit_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stock_audit_table (
    sat_id character varying(255) NOT NULL,
    date timestamp without time zone,
    audit_number character varying(255),
    audit_type character varying(50),
    comments text,
    item_quantity integer,
    available_quantity integer,
    mrp_price numeric(10,2),
    total_items_count integer,
    total_matched_item integer,
    total_miss_matched_item integer,
    total_added_item_value numeric(10,2),
    total_removed_item_value numeric(10,2),
    total_item_net_difference numeric(10,2),
    is_stock_draft boolean DEFAULT false,
    created_by character varying(255),
    updated_by character varying(255),
    update_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: stock_in_out_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stock_in_out_table (
    item_id character varying(255) NOT NULL,
    item_code character varying(255),
    from_warehouse_id character varying(255),
    from_warehouse_name character varying(255),
    to_warehouse_id character varying(255),
    to_warehouse_name character varying(255),
    request_status character varying(255),
    item_quantity integer,
    update_sign character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: stock_request_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stock_request_table (
    item_id character varying(255) NOT NULL,
    item_code character varying(255),
    stock_request_warehouse_id character varying(255),
    stock_request_warehouse_name character varying(255),
    stock_request_status character varying(255),
    item_quantity integer,
    stock_requested_warehouse_id character varying(255),
    stock_requested__warehouse_name character varying(255),
    update_sign character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: store_account_details_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.store_account_details_table (
    store_id character varying(255) NOT NULL,
    stock_payment_date date,
    account_details_remark character varying(255),
    stock_payment_receipts text[],
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: store_agreement_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.store_agreement_table (
    store_id character varying(255) NOT NULL,
    agreement_witness character varying(255),
    store_agreement_remarks text,
    store_agreement_is_approve boolean,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    store_agreement_is_reject boolean
);


--
-- Name: store_app_user_number_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.store_app_user_number_table (
    store_app_user_id character varying(255) NOT NULL,
    store_app_use_phone_number character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: store_branding_and_store_software_details_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.store_branding_and_store_software_details_table (
    store_id character varying(255) NOT NULL,
    branding_installation date,
    store_approval_date date,
    dl_submit_date date,
    software_installation_date date,
    software_training_date date,
    complaint_portal_user_and_training_date date,
    software_live_date date,
    brand_pest_images text[],
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: store_branding_details_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.store_branding_details_table (
    store_id character varying(255) NOT NULL,
    site_analysis_date date,
    measurement_recevied_date date,
    final_ppt_approval_date date,
    graphics_work_done_date date,
    shared_link_date date,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: store_dispatch_details_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.store_dispatch_details_table (
    store_id character varying(255) NOT NULL,
    first_kit_generation_date date,
    first_invoice_date date,
    stock_dispatch_date date,
    lr_number date,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: store_followup_and_history_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.store_followup_and_history_table (
    store_id character varying(255),
    followup_date date,
    remarks character varying(255),
    store_execution_tab character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: store_info_address_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.store_info_address_table (
    store_id character varying(255) NOT NULL,
    store_code character varying(255),
    store_type character varying(255),
    relationship_manager character varying(255),
    reapproval_remarks text,
    addres_remarks text,
    shop_address character varying(255),
    shop_area character varying(255),
    shop_landmark character varying(255),
    shop_town_or_village character varying(255),
    shop_city character varying(255),
    shop_state character varying(255),
    shop_pin_code character varying(255),
    shop_country_region character varying(255),
    store_rent_per_month numeric(20,2),
    store_duration_concurrently character varying(255),
    store_sale_per_day bigint,
    store_medicine_sale bigint,
    store_otc_sale bigint,
    store_latitude character varying(255),
    store_longitude character varying(255),
    tab_remarks text,
    shop_images text[],
    shop_image_1 text,
    shop_image_2 text,
    shop_image_3 text,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    is_approve_location boolean,
    is_reject_location boolean,
    shop_region character varying(255),
    created_by character varying(255),
    updated_by character varying(255)
);


--
-- Name: store_info_drug_license_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.store_info_drug_license_table (
    store_id character varying(255) NOT NULL,
    dl_apply_date date,
    dl_chalan_receipt character varying(255),
    dl_is_approve boolean,
    dl_address character varying(255),
    dl_area character varying(255),
    dl_landmark character varying(255),
    dl_town_or_village character varying(255),
    dl_city character varying(255),
    dl_state character varying(255),
    dl_pin_code character varying(255),
    dl_country_region character varying(255),
    dl_valid_upto character varying(255),
    dl_no_20_20b character varying(255),
    dl_no_21_21b character varying(255),
    dl_no_21c character varying(255),
    dl_no_21f character varying(255),
    dl_no_name character varying(255),
    dl_store_sq_ft numeric(20,2),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    is_approve_dl boolean,
    is_reject_dl boolean
);


--
-- Name: store_info_firm_details_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.store_info_firm_details_table (
    store_id character varying(255) NOT NULL,
    firm_name character varying(255),
    firm_type character varying(255),
    firm_authorised_person character varying(255),
    designation character varying(255),
    can_change_firm_name boolean,
    firm_address character varying(255),
    firm_area character varying(255),
    firm_landmark character varying(255),
    firm_town_or_village character varying(255),
    firm_city character varying(255),
    firm_state character varying(255),
    firm_pin_code character varying(255),
    firm_country_region character varying(255),
    firm_agreement_with_davaindia_conditions boolean,
    pan_type character varying(255),
    pan_number character varying(255),
    pan_pic_front character varying(255),
    pan_pic_back character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    firm_district character varying(255)
);


--
-- Name: store_info_payment_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.store_info_payment_table (
    store_id character varying(255) NOT NULL,
    store_type character varying(255),
    payment_method character varying(255),
    amount numeric(20,2),
    transaction_id character varying(255),
    remaining_amount numeric(20,2),
    received_amount numeric(20,2),
    payment_recevie_time date,
    payment_receipt character varying(255),
    payer_name_as_per_bank character varying(255),
    payer_bank_name character varying(255),
    payer_bank_account_no character varying(255),
    payer_remaining_amount character varying(255),
    payee_name_as_per_bank character varying(255),
    payee_bank_name character varying(255),
    payee_bank_account_no character varying(255),
    isfc_code character varying(255),
    extra_payee character varying(255),
    gst_number character varying(255),
    payment_table_remarks text,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    is_payment_terms_approve boolean
);


--
-- Name: store_info_personal_details_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.store_info_personal_details_table (
    store_id character varying(255) NOT NULL,
    store_status character varying(255),
    authorised_person_name character varying(255),
    gender character varying(255),
    phone_number character varying(255),
    qualifications character varying(255),
    experience character varying(255),
    email character varying(255),
    adhar_number character varying(255),
    date_of_birth character varying(255),
    adhar_front_pic character varying(255),
    adhar_back_pic character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: store_information_for_user_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.store_information_for_user_table (
    store_id character varying(255) NOT NULL,
    company character varying(255),
    company_area character varying(255),
    company_landmark character varying(255),
    company_city character varying(255),
    company_state character varying(255),
    company_pincode character varying(255),
    company_address character varying(255),
    company_alias_name character varying(255),
    company_email character varying(255),
    company_telephone1 character varying(255),
    company_telephone2 character varying(255),
    company_gstn character varying(255),
    company_licence character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    company_logo character varying(255),
    pos_id character varying(255),
    cpos_ip_address character varying(255),
    store_code character varying(255),
    dl_no_20_20b character varying(255),
    dl_no_21_21b character varying(255),
    fssai_no character varying(255),
    store_icon character varying(255),
    company_remarks text,
    company_terms_conditions text,
    company_return_policy text,
    dl_no_21c character varying(255),
    dl_no_21f character varying(255),
    pan_number character varying(255),
    store_type character varying(26)
);


--
-- Name: store_infrastructure_details_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.store_infrastructure_details_table (
    store_id character varying(255) NOT NULL,
    completion_date date,
    shop_pics text[],
    colour_pre_applied boolean,
    colour_pics text[],
    furniture_pre_applied boolean,
    furniture_pics text[],
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: store_inventory_item_location_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.store_inventory_item_location_table (
    item_id character varying(255),
    store_id character varying(255),
    item_code character varying(255),
    item_quantity integer,
    item_batch_number character varying(50),
    item_rack_location character varying(50),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    to_bin_id character varying(255),
    pos_id character varying(50)
);


--
-- Name: store_inventory_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.store_inventory_table (
    pot_id character varying(255),
    item_id character varying(255) NOT NULL,
    store_id character varying(255),
    item_code character varying(255),
    item_quantity integer,
    item_generic_name character varying(255),
    item_name character varying(255),
    item_pack_size character varying(50),
    item_schedule character varying(255),
    item_uom character varying(50),
    item_mfg_by character varying(50),
    item_unit_price numeric(10,2),
    item_rack_location character varying(50),
    item_categeory character varying(50),
    item_received_quantity integer,
    item_gst numeric(10,2),
    item_sgst numeric(10,2),
    item_cgst numeric(10,2),
    item_discount numeric(10,2),
    item_discount_amount numeric(10,2),
    item_discount_percentage numeric(10,2),
    item_tax_amount numeric(10,2),
    item_total_tax_percentage numeric(10,2),
    item_total_amount numeric(10,2),
    item_barcode character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_by character varying(255),
    updated_by character varying(255)
);


--
-- Name: store_opening_details_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.store_opening_details_table (
    store_id character varying(255) NOT NULL,
    stock_recevied_date date,
    opening_date date,
    opening_time time without time zone,
    cheif_guest_name character varying(255),
    cheif_guest_desgination character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: stripe_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stripe_config (
    id character varying(255) NOT NULL,
    key_id character varying(255),
    key_secret character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: sub_specialization_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sub_specialization_table (
    id character varying(26) NOT NULL,
    name character varying(100) NOT NULL,
    code character varying(26),
    discription text,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: sublevel_bins; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sublevel_bins (
    bin_no_id character varying(255) NOT NULL,
    sublevel_id character varying(255),
    bin_location_no character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    is_expired_bin_location boolean DEFAULT false,
    is_sellable_bin_location boolean DEFAULT false,
    is_non_sellable_bin_location boolean DEFAULT false
);


--
-- Name: sublevel_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sublevel_table (
    sublevel_id character varying(255) NOT NULL,
    sublevel_no bigint,
    warehouse_id character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: sync_rules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sync_rules (
    sync_rule_id character varying(26) NOT NULL,
    txn_initiated character varying(100) NOT NULL,
    sync_type character varying(100) NOT NULL,
    txn_reflected character varying(100) NOT NULL,
    from_pos character varying(100) NOT NULL,
    to_pos character varying(100) NOT NULL,
    trigger character varying(100) NOT NULL,
    sync_interval_value integer NOT NULL,
    sync_interval_unit character varying(20) DEFAULT 'Min'::character varying NOT NULL,
    status character varying(50) DEFAULT 'Active'::character varying,
    sync_status character varying(50) DEFAULT 'Idle'::character varying,
    last_sync_at timestamp without time zone,
    next_sync_at timestamp without time zone,
    sync_progress integer DEFAULT 0,
    last_error text,
    retry_count integer DEFAULT 0,
    meta jsonb,
    created_by character varying(26),
    updated_by character varying(26),
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: sync_runs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sync_runs (
    sync_run_id character varying(26) NOT NULL,
    sync_rule_id character varying(26) NOT NULL,
    started_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    finished_at timestamp without time zone,
    status character varying(50) DEFAULT 'Idle'::character varying,
    progress integer DEFAULT 0,
    error text,
    run_payload jsonb,
    response jsonb,
    created_by character varying(26),
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: tax_combination; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tax_combination (
    id character varying(255) NOT NULL,
    code character varying(255),
    rate bigint,
    effective_from date,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    is_inter_state boolean DEFAULT false
);


--
-- Name: tax_combination_code_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tax_combination_code_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tax_combination_item; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tax_combination_item (
    id character varying(255) NOT NULL,
    tax_combination_id character varying(255),
    tax_type_id character varying(255),
    percentage numeric(10,2),
    sales_tax_acc character varying(255),
    purchase_tax_acc character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: tax_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tax_table (
    tax_id character varying(255) NOT NULL,
    cgst_rate numeric(5,2),
    sgst_rate numeric(5,2),
    igst_rate numeric(5,2),
    item_category character varying(255)
);


--
-- Name: tax_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tax_type (
    id character varying(255) NOT NULL,
    name character varying(255),
    description text,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    is_inter_state boolean DEFAULT false,
    tax_combination boolean DEFAULT false
);


--
-- Name: tcs_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tcs_table (
    tcs_id character varying(255) NOT NULL,
    tcs_name character varying(255),
    tcs_percentage numeric(10,2),
    tcs_type character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: tds_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tds_table (
    tds_id character varying(255) NOT NULL,
    tds_name character varying(255),
    tds_percentage numeric(10,2),
    tds_type character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: terms_and_conditions_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.terms_and_conditions_table (
    store_id character varying(255) NOT NULL,
    agreement_document character varying(255),
    digital_sign character varying(255),
    firm_agreement_with_davaindia_conditions boolean,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: unit_of_measure; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.unit_of_measure (
    uom_id character varying(255) NOT NULL,
    code character varying(50) NOT NULL,
    name character varying(100) NOT NULL,
    ewb_unit character varying(50),
    length numeric(10,2),
    width numeric(10,2),
    height numeric(10,2),
    volume numeric(15,3),
    volume_uom character varying(50),
    weight numeric(15,3),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: uom_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.uom_group (
    group_id character varying(255) NOT NULL,
    name character varying(255),
    description text,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    group_code character varying(255)
);


--
-- Name: uom_group_item; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.uom_group_item (
    item_id character varying(255) NOT NULL,
    group_id character varying(255),
    alt_quantity numeric,
    alt_uom character varying(255),
    base_quantity numeric,
    base_uom_id character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    sub_uom_id character varying(255),
    sub_uom character varying(255),
    pack_description character varying(255),
    sub_quantity numeric(10,0)
);


--
-- Name: uom_group_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.uom_group_table (
    uom_group_id character varying(255) NOT NULL,
    uom_group_name character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: uom_number_code_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.uom_number_code_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: uom_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.uom_table (
    uom_group_id character varying(255),
    uom_id character varying(255) NOT NULL,
    uom_name character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: user_column_preferences; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_column_preferences (
    id character varying(255) NOT NULL,
    role_id character varying(50),
    document_id character varying(50),
    customization jsonb,
    update_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_by character varying(255),
    created_by character varying(255)
);


--
-- Name: user_column_preferences_default_values; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_column_preferences_default_values (
    document_id character varying(50),
    customization jsonb,
    update_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_by character varying(255),
    created_by character varying(255)
);


--
-- Name: users_permission_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users_permission_table (
    permission_id character varying(255) NOT NULL,
    module_name character varying(255),
    user_id character varying(255),
    "create" boolean DEFAULT false,
    update boolean DEFAULT false,
    delete boolean DEFAULT false,
    print boolean DEFAULT false,
    export boolean DEFAULT false,
    send boolean DEFAULT false,
    read boolean DEFAULT true,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    module_id character varying,
    "all" boolean DEFAULT false,
    clone boolean DEFAULT false
);


--
-- Name: users_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users_table (
    user_id character varying(255) NOT NULL,
    user_name character varying(255),
    user_role_id character varying(255),
    user_role character varying(255),
    user_email character varying(255),
    user_password character varying(255),
    user_store_id character varying(255),
    user_phone_number character varying(255),
    user_department character varying(255),
    change_password_next_login boolean DEFAULT false,
    password_never_expires boolean DEFAULT false,
    password_expiry_date date,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    pos_id character varying(255),
    data_synced boolean DEFAULT false,
    user_max_dis_per numeric(30,2) DEFAULT 0.00,
    user_min_dis_per numeric(30,2) DEFAULT 0.00
);


--
-- Name: warehouses_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.warehouses_table (
    warehouse_id character varying(255) NOT NULL,
    warehouse_code character varying(10),
    warehouse_name character varying(100),
    tax_code character varying(20),
    warehouse_location character varying(100),
    bin_location_enabled boolean DEFAULT false,
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: whatsapp_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.whatsapp_config (
    id character varying(255) NOT NULL,
    api_key character varying(255),
    api_url character varying(255),
    user_name character varying(255),
    password character varying(255),
    number character varying(255),
    update_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: approval_document_terms term_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.approval_document_terms ALTER COLUMN term_id SET DEFAULT nextval('public.approval_document_terms_term_id_seq'::regclass);


--
-- Name: approval_flows approval_flow_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.approval_flows ALTER COLUMN approval_flow_id SET DEFAULT nextval('public.approval_flows_approval_flow_id_seq'::regclass);


--
-- Name: approval_originators originator_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.approval_originators ALTER COLUMN originator_id SET DEFAULT nextval('public.approval_originators_originator_id_seq'::regclass);


--
-- Name: approval_stages stages_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.approval_stages ALTER COLUMN stages_id SET DEFAULT nextval('public.approval_stages_stages_id_seq'::regclass);


--
-- Name: document_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_types ALTER COLUMN id SET DEFAULT nextval('public.document_types_id_seq'::regclass);


--
-- Name: item_restrictions restriction_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_restrictions ALTER COLUMN restriction_id SET DEFAULT nextval('public.item_restrictions_restriction_id_seq'::regclass);


--
-- Name: migrations_history id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migrations_history ALTER COLUMN id SET DEFAULT nextval('public.migrations_history_id_seq'::regclass);


--
-- Name: print_prefer id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.print_prefer ALTER COLUMN id SET DEFAULT nextval('public.print_prefer_id_seq'::regclass);


--
-- Name: print_preferences id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.print_preferences ALTER COLUMN id SET DEFAULT nextval('public.print_preferences_id_seq'::regclass);


--
-- Name: Favorite Favorite_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Favorite"
    ADD CONSTRAINT "Favorite_pkey" PRIMARY KEY (name);


--
-- Name: acquried_source_table acquried_source_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.acquried_source_table
    ADD CONSTRAINT acquried_source_table_pkey PRIMARY KEY (id);


--
-- Name: addedfavorite addedfavorite_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.addedfavorite
    ADD CONSTRAINT addedfavorite_pkey PRIMARY KEY (id);


--
-- Name: all_store_details_table all_store_details_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.all_store_details_table
    ADD CONSTRAINT all_store_details_table_pkey PRIMARY KEY (warehouse_id);


--
-- Name: alternative_items_table alternative_items_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alternative_items_table
    ADD CONSTRAINT alternative_items_table_pkey PRIMARY KEY (alternative_item_id);


--
-- Name: approval_document_terms approval_document_terms_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.approval_document_terms
    ADD CONSTRAINT approval_document_terms_pkey PRIMARY KEY (term_id);


--
-- Name: approval_flows approval_flows_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.approval_flows
    ADD CONSTRAINT approval_flows_pkey PRIMARY KEY (approval_flow_id);


--
-- Name: approval_originators approval_originators_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.approval_originators
    ADD CONSTRAINT approval_originators_pkey PRIMARY KEY (originator_id);


--
-- Name: approval_request_stages approval_request_stages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.approval_request_stages
    ADD CONSTRAINT approval_request_stages_pkey PRIMARY KEY (request_stage_id);


--
-- Name: approval_requests approval_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.approval_requests
    ADD CONSTRAINT approval_requests_pkey PRIMARY KEY (request_id);


--
-- Name: approval_stages approval_stages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.approval_stages
    ADD CONSTRAINT approval_stages_pkey PRIMARY KEY (stages_id);


--
-- Name: area_table area_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.area_table
    ADD CONSTRAINT area_table_pkey PRIMARY KEY (id);


--
-- Name: bank_list_table bank_list_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bank_list_table
    ADD CONSTRAINT bank_list_table_pkey PRIMARY KEY (bank_id);


--
-- Name: bin_location_table bin_location_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bin_location_table
    ADD CONSTRAINT bin_location_table_pkey PRIMARY KEY (warehouse_id);


--
-- Name: blood_group_table blood_group_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blood_group_table
    ADD CONSTRAINT blood_group_table_pkey PRIMARY KEY (id);


--
-- Name: carton_type_table carton_type_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.carton_type_table
    ADD CONSTRAINT carton_type_table_pkey PRIMARY KEY (id);


--
-- Name: city_table city_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.city_table
    ADD CONSTRAINT city_table_pkey PRIMARY KEY (id);


--
-- Name: cmr_family_table cmr_family_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cmr_family_table
    ADD CONSTRAINT cmr_family_table_pkey PRIMARY KEY (cmr_family_id);


--
-- Name: cmr_insurance_policy_table cmr_insurance_policy_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cmr_insurance_policy_table
    ADD CONSTRAINT cmr_insurance_policy_table_pkey PRIMARY KEY (cmr_policy_id);


--
-- Name: cmr_master_data_table cmr_master_data_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cmr_master_data_table
    ADD CONSTRAINT cmr_master_data_table_pkey PRIMARY KEY (cmr_id);


--
-- Name: country_table country_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.country_table
    ADD CONSTRAINT country_table_pkey PRIMARY KEY (id);


--
-- Name: custom_invoice custom_invoice_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_invoice
    ADD CONSTRAINT custom_invoice_pkey PRIMARY KEY (custom_inv_id);


--
-- Name: custom_reports custom_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_reports
    ADD CONSTRAINT custom_reports_pkey PRIMARY KEY (report_id);


--
-- Name: customer_accounting_table customer_accounting_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_accounting_table
    ADD CONSTRAINT customer_accounting_table_pkey PRIMARY KEY (cmr_id);


--
-- Name: customer_bank_details customer_bank_details_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_bank_details
    ADD CONSTRAINT customer_bank_details_pkey PRIMARY KEY (cmr_id);


--
-- Name: customer_contact_persons customer_contact_persons_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_contact_persons
    ADD CONSTRAINT customer_contact_persons_pkey PRIMARY KEY (cmr_contact_person_id);


--
-- Name: customer_details customer_details_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_details
    ADD CONSTRAINT customer_details_pkey PRIMARY KEY (cmr_id);


--
-- Name: customer_general_details customer_general_details_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_general_details
    ADD CONSTRAINT customer_general_details_pkey PRIMARY KEY (cmr_id);


--
-- Name: customer_group_table customer_group_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_group_table
    ADD CONSTRAINT customer_group_table_pkey PRIMARY KEY (customer_group_id);


--
-- Name: customer_patient_info_table customer_patient_info_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_patient_info_table
    ADD CONSTRAINT customer_patient_info_table_pkey PRIMARY KEY (cmr_id);


--
-- Name: customer_pay_to_address customer_pay_to_address_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_pay_to_address
    ADD CONSTRAINT customer_pay_to_address_pkey PRIMARY KEY (cmr_pay_address_id);


--
-- Name: customer_payment_terms_table customer_payment_terms_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_payment_terms_table
    ADD CONSTRAINT customer_payment_terms_table_pkey PRIMARY KEY (cmr_id);


--
-- Name: customer_ship_to_address customer_ship_to_address_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_ship_to_address
    ADD CONSTRAINT customer_ship_to_address_pkey PRIMARY KEY (cmr_ship_address_id);


--
-- Name: department_table department_table_department_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.department_table
    ADD CONSTRAINT department_table_department_name_key UNIQUE (department_name);


--
-- Name: department_table department_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.department_table
    ADD CONSTRAINT department_table_pkey PRIMARY KEY (department_id);


--
-- Name: discount_group_table discount_group_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discount_group_table
    ADD CONSTRAINT discount_group_table_pkey PRIMARY KEY (discount_group_id);


--
-- Name: discount_table discount_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discount_table
    ADD CONSTRAINT discount_table_pkey PRIMARY KEY (discount_slab_id);


--
-- Name: discount_type_table discount_type_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discount_type_table
    ADD CONSTRAINT discount_type_table_pkey PRIMARY KEY (discount_type_id);


--
-- Name: district_table district_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.district_table
    ADD CONSTRAINT district_table_pkey PRIMARY KEY (id);


--
-- Name: doctor_table doctor_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.doctor_table
    ADD CONSTRAINT doctor_table_pkey PRIMARY KEY (dr_id);


--
-- Name: document_custom_numbering_series_table document_custom_numbering_series_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_custom_numbering_series_table
    ADD CONSTRAINT document_custom_numbering_series_table_pkey PRIMARY KEY (series_id);


--
-- Name: document_custom_table document_custom_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_custom_table
    ADD CONSTRAINT document_custom_table_pkey PRIMARY KEY (transaction_doc_id);


--
-- Name: document_numbering document_numbering_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_numbering
    ADD CONSTRAINT document_numbering_pkey PRIMARY KEY (id);


--
-- Name: document_numbering_series document_numbering_series_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_numbering_series
    ADD CONSTRAINT document_numbering_series_pkey PRIMARY KEY (id);


--
-- Name: document_numbering_series_table document_numbering_series_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_numbering_series_table
    ADD CONSTRAINT document_numbering_series_table_pkey PRIMARY KEY (series_id);


--
-- Name: document_table document_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_table
    ADD CONSTRAINT document_table_pkey PRIMARY KEY (transaction_doc_id);


--
-- Name: document_types document_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_types
    ADD CONSTRAINT document_types_pkey PRIMARY KEY (id);


--
-- Name: excel_import_column_mapping_table excel_import_column_mapping_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.excel_import_column_mapping_table
    ADD CONSTRAINT excel_import_column_mapping_table_pkey PRIMARY KEY (mapping_id);


--
-- Name: favorite favorite_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.favorite
    ADD CONSTRAINT favorite_pkey PRIMARY KEY (name);


--
-- Name: gender_table gender_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gender_table
    ADD CONSTRAINT gender_table_pkey PRIMARY KEY (id);


--
-- Name: general_account_allocation_table general_account_allocation_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.general_account_allocation_table
    ADD CONSTRAINT general_account_allocation_table_pkey PRIMARY KEY (gcct_id);


--
-- Name: general_accounts_table general_accounts_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.general_accounts_table
    ADD CONSTRAINT general_accounts_table_pkey PRIMARY KEY (account_id);


--
-- Name: generic_name_table generic_name_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.generic_name_table
    ADD CONSTRAINT generic_name_table_pkey PRIMARY KEY (id);


--
-- Name: goods_order_receipt_table goods_order_receipt_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.goods_order_receipt_table
    ADD CONSTRAINT goods_order_receipt_table_pkey PRIMARY KEY (gort_id);


--
-- Name: group_table group_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_table
    ADD CONSTRAINT group_table_pkey PRIMARY KEY (id);


--
-- Name: id_proof_type_table id_proof_type_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.id_proof_type_table
    ADD CONSTRAINT id_proof_type_table_pkey PRIMARY KEY (id);


--
-- Name: industry_sector_table industry_sector_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.industry_sector_table
    ADD CONSTRAINT industry_sector_table_pkey PRIMARY KEY (id);


--
-- Name: insurance_provider_table insurance_provider_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.insurance_provider_table
    ADD CONSTRAINT insurance_provider_table_pkey PRIMARY KEY (id);


--
-- Name: inventory_account_allocation_table inventory_account_allocation_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_account_allocation_table
    ADD CONSTRAINT inventory_account_allocation_table_pkey PRIMARY KEY (gcct_id);


--
-- Name: inventory_status_condition_table inventory_status_condition_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_status_condition_table
    ADD CONSTRAINT inventory_status_condition_table_pkey PRIMARY KEY (isc_id);


--
-- Name: inventory_status_item_list_table inventory_status_item_list_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_status_item_list_table
    ADD CONSTRAINT inventory_status_item_list_table_pkey PRIMARY KEY (isil_id);


--
-- Name: inventory_status_table inventory_status_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_status_table
    ADD CONSTRAINT inventory_status_table_pkey PRIMARY KEY (is_id);


--
-- Name: inventory_transfer_table inventory_transfer_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_transfer_table
    ADD CONSTRAINT inventory_transfer_table_pkey PRIMARY KEY (itt_id);


--
-- Name: invoice_credit_note invoice_credit_note_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invoice_credit_note
    ADD CONSTRAINT invoice_credit_note_pkey PRIMARY KEY (icn_id);


--
-- Name: item_category item_category_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_category
    ADD CONSTRAINT item_category_pkey PRIMARY KEY (id);


--
-- Name: item_composition_table item_composition_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_composition_table
    ADD CONSTRAINT item_composition_table_pkey PRIMARY KEY (id);


--
-- Name: item_discount_and_scheme_table item_discount_and_scheme_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_discount_and_scheme_table
    ADD CONSTRAINT item_discount_and_scheme_table_pkey PRIMARY KEY (item_id);


--
-- Name: item_generic_name_table item_generic_name_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_generic_name_table
    ADD CONSTRAINT item_generic_name_table_pkey PRIMARY KEY (id);


--
-- Name: item_group item_group_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_group
    ADD CONSTRAINT item_group_pkey PRIMARY KEY (id);


--
-- Name: item_group_table item_group_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_group_table
    ADD CONSTRAINT item_group_table_pkey PRIMARY KEY (item_group_id);


--
-- Name: item_invetory_table item_invetory_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_invetory_table
    ADD CONSTRAINT item_invetory_table_pkey PRIMARY KEY (item_id);


--
-- Name: item_min_max_for_pos_inventory item_min_max_for_pos_inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_min_max_for_pos_inventory
    ADD CONSTRAINT item_min_max_for_pos_inventory_pkey PRIMARY KEY (id);


--
-- Name: item_molecule_composition_table item_molecule_composition_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_molecule_composition_table
    ADD CONSTRAINT item_molecule_composition_table_pkey PRIMARY KEY (molecule_composition_id);


--
-- Name: item_molecule_name_table item_molecule_name_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_molecule_name_table
    ADD CONSTRAINT item_molecule_name_table_pkey PRIMARY KEY (id);


--
-- Name: item_packing_information_table item_packing_information_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_packing_information_table
    ADD CONSTRAINT item_packing_information_table_pkey PRIMARY KEY (item_id);


--
-- Name: item_planning_table item_planning_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_planning_table
    ADD CONSTRAINT item_planning_table_pkey PRIMARY KEY (item_id);


--
-- Name: item_purchasing_table item_purchasing_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_purchasing_table
    ADD CONSTRAINT item_purchasing_table_pkey PRIMARY KEY (item_id);


--
-- Name: item_regional_restrictions item_regional_restrictions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_regional_restrictions
    ADD CONSTRAINT item_regional_restrictions_pkey PRIMARY KEY (restriction_id);


--
-- Name: item_regional_restrictions item_regional_restrictions_store_id_item_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_regional_restrictions
    ADD CONSTRAINT item_regional_restrictions_store_id_item_id_key UNIQUE (store_id, item_id);


--
-- Name: item_remarks_table item_remarks_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_remarks_table
    ADD CONSTRAINT item_remarks_table_pkey PRIMARY KEY (item_id);


--
-- Name: item_restriction_table item_restriction_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_restriction_table
    ADD CONSTRAINT item_restriction_table_pkey PRIMARY KEY (item_id);


--
-- Name: item_restrictions item_restrictions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_restrictions
    ADD CONSTRAINT item_restrictions_pkey PRIMARY KEY (restriction_id);


--
-- Name: item_restrictions item_restrictions_store_id_item_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_restrictions
    ADD CONSTRAINT item_restrictions_store_id_item_id_key UNIQUE (store_id, item_id);


--
-- Name: item_sales_table item_sales_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_sales_table
    ADD CONSTRAINT item_sales_table_pkey PRIMARY KEY (item_id);


--
-- Name: item_type item_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_type
    ADD CONSTRAINT item_type_pkey PRIMARY KEY (id);


--
-- Name: item_uom_table item_uom_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_uom_table
    ADD CONSTRAINT item_uom_table_pkey PRIMARY KEY (iut_id);


--
-- Name: items_discount_group_table items_discount_group_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items_discount_group_table
    ADD CONSTRAINT items_discount_group_table_pkey PRIMARY KEY (item_id);


--
-- Name: items_period_validity_table items_period_validity_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items_period_validity_table
    ADD CONSTRAINT items_period_validity_table_pkey PRIMARY KEY (period_validity_id);


--
-- Name: items_table items_table_item_code_item_code1_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items_table
    ADD CONSTRAINT items_table_item_code_item_code1_key UNIQUE (item_code) INCLUDE (item_code);


--
-- Name: items_table items_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items_table
    ADD CONSTRAINT items_table_pkey PRIMARY KEY (item_id);


--
-- Name: items_volume_validity_table items_volume_validity_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items_volume_validity_table
    ADD CONSTRAINT items_volume_validity_table_pkey PRIMARY KEY (volume_validity_id);


--
-- Name: journal_entry_table journal_entry_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journal_entry_table
    ADD CONSTRAINT journal_entry_table_pkey PRIMARY KEY (transcation_id);


--
-- Name: lead_details lead_details_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lead_details
    ADD CONSTRAINT lead_details_pkey PRIMARY KEY (lead_id);


--
-- Name: main_module_table main_module_table_main_module_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.main_module_table
    ADD CONSTRAINT main_module_table_main_module_name_key UNIQUE (main_module_name);


--
-- Name: main_module_table main_module_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.main_module_table
    ADD CONSTRAINT main_module_table_pkey PRIMARY KEY (main_module_id);


--
-- Name: manufacture_group_table manufacture_group_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manufacture_group_table
    ADD CONSTRAINT manufacture_group_table_pkey PRIMARY KEY (manufacture_group_id);


--
-- Name: manufacturer manufacturer_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manufacturer
    ADD CONSTRAINT manufacturer_pkey PRIMARY KEY (id);


--
-- Name: migration_log migration_log_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migration_log
    ADD CONSTRAINT migration_log_pkey PRIMARY KEY (name);


--
-- Name: migrations_history migrations_history_batch_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migrations_history
    ADD CONSTRAINT migrations_history_batch_name_key UNIQUE (batch_name);


--
-- Name: migrations_history migrations_history_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migrations_history
    ADD CONSTRAINT migrations_history_pkey PRIMARY KEY (id);


--
-- Name: module_table module_table_module_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.module_table
    ADD CONSTRAINT module_table_module_name_key UNIQUE (module_name);


--
-- Name: module_table module_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.module_table
    ADD CONSTRAINT module_table_pkey PRIMARY KEY (module_id);


--
-- Name: notification_communication_channel notification_communication_channel_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notification_communication_channel
    ADD CONSTRAINT notification_communication_channel_pkey PRIMARY KEY (ntfcc_id);


--
-- Name: notification notification_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY (ntf_id);


--
-- Name: notification_recipient notification_recipient_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notification_recipient
    ADD CONSTRAINT notification_recipient_pkey PRIMARY KEY (ntfr_id);


--
-- Name: notification_triggered_history notification_triggered_history_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notification_triggered_history
    ADD CONSTRAINT notification_triggered_history_pkey PRIMARY KEY (nth_id);


--
-- Name: packing_table packing_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.packing_table
    ADD CONSTRAINT packing_table_pkey PRIMARY KEY (id);


--
-- Name: packing_type_table packing_type_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.packing_type_table
    ADD CONSTRAINT packing_type_table_pkey PRIMARY KEY (id);


--
-- Name: party_category_table party_category_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.party_category_table
    ADD CONSTRAINT party_category_table_pkey PRIMARY KEY (id);


--
-- Name: party_group_table party_group_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.party_group_table
    ADD CONSTRAINT party_group_table_pkey PRIMARY KEY (id);


--
-- Name: party_type_table party_type_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.party_type_table
    ADD CONSTRAINT party_type_table_pkey PRIMARY KEY (id);


--
-- Name: payment_in_table payment_in_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_in_table
    ADD CONSTRAINT payment_in_table_pkey PRIMARY KEY (pit_id);


--
-- Name: payment_out_modes_table payment_out_modes_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_out_modes_table
    ADD CONSTRAINT payment_out_modes_table_pkey PRIMARY KEY (pmt_id);


--
-- Name: payment_out_table payment_out_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_out_table
    ADD CONSTRAINT payment_out_table_pkey PRIMARY KEY (pot_id);


--
-- Name: payment_terms_table payment_terms_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_terms_table
    ADD CONSTRAINT payment_terms_table_pkey PRIMARY KEY (id);


--
-- Name: payment_type_table payment_type_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_type_table
    ADD CONSTRAINT payment_type_table_pkey PRIMARY KEY (payment_type_id);


--
-- Name: paytm_config paytm_config_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.paytm_config
    ADD CONSTRAINT paytm_config_pkey PRIMARY KEY (id);


--
-- Name: period_volume_discount_items_table period_volume_discount_items_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.period_volume_discount_items_table
    ADD CONSTRAINT period_volume_discount_items_table_pkey PRIMARY KEY (period_discount_item_id);


--
-- Name: period_volume_discount_table period_volume_discount_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.period_volume_discount_table
    ADD CONSTRAINT period_volume_discount_table_pkey PRIMARY KEY (price_list_id);


--
-- Name: phonepe_config phonepe_config_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.phonepe_config
    ADD CONSTRAINT phonepe_config_pkey PRIMARY KEY (id);


--
-- Name: pine_labs_config pine_labs_config_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pine_labs_config
    ADD CONSTRAINT pine_labs_config_pkey PRIMARY KEY (id);


--
-- Name: price_list_table price_list_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.price_list_table
    ADD CONSTRAINT price_list_table_pkey PRIMARY KEY (price_list_id);


--
-- Name: price_list_table price_list_table_price_list_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.price_list_table
    ADD CONSTRAINT price_list_table_price_list_name_key UNIQUE (price_list_name);


--
-- Name: print_prefer print_prefer_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.print_prefer
    ADD CONSTRAINT print_prefer_pkey PRIMARY KEY (id);


--
-- Name: print_preference print_preference_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.print_preference
    ADD CONSTRAINT print_preference_pkey PRIMARY KEY (id);


--
-- Name: print_preferences print_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.print_preferences
    ADD CONSTRAINT print_preferences_pkey PRIMARY KEY (id);


--
-- Name: print_preferences print_preferences_type_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.print_preferences
    ADD CONSTRAINT print_preferences_type_key UNIQUE (type);


--
-- Name: product_schedule_table product_schedule_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_schedule_table
    ADD CONSTRAINT product_schedule_table_pkey PRIMARY KEY (id);


--
-- Name: purchase_account_allocation_table purchase_account_allocation_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.purchase_account_allocation_table
    ADD CONSTRAINT purchase_account_allocation_table_pkey PRIMARY KEY (gcct_id);


--
-- Name: purchase_credit_of_grn purchase_credit_of_grn_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.purchase_credit_of_grn
    ADD CONSTRAINT purchase_credit_of_grn_pkey PRIMARY KEY (gort_id);


--
-- Name: purchase_credit_of_invoice purchase_credit_of_invoice_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.purchase_credit_of_invoice
    ADD CONSTRAINT purchase_credit_of_invoice_pkey PRIMARY KEY (poit_id);


--
-- Name: purchase_credit_table purchase_credit_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.purchase_credit_table
    ADD CONSTRAINT purchase_credit_table_pkey PRIMARY KEY (pct_id);


--
-- Name: purchase_order_invoice_table purchase_order_invoice_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.purchase_order_invoice_table
    ADD CONSTRAINT purchase_order_invoice_table_pkey PRIMARY KEY (poit_id);


--
-- Name: purchase_order_transaction_table purchase_order_transaction_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.purchase_order_transaction_table
    ADD CONSTRAINT purchase_order_transaction_table_pkey PRIMARY KEY (pot_id);


--
-- Name: purchase_return_table purchase_return_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.purchase_return_table
    ADD CONSTRAINT purchase_return_table_pkey PRIMARY KEY (prt_id);


--
-- Name: razorpay_config razorpay_config_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.razorpay_config
    ADD CONSTRAINT razorpay_config_pkey PRIMARY KEY (id);


--
-- Name: region_table region_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.region_table
    ADD CONSTRAINT region_table_pkey PRIMARY KEY (id);


--
-- Name: relationship_table relationship_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.relationship_table
    ADD CONSTRAINT relationship_table_pkey PRIMARY KEY (id);


--
-- Name: reporttags reporttags_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reporttags
    ADD CONSTRAINT reporttags_name_key UNIQUE (name);


--
-- Name: reporttags reporttags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reporttags
    ADD CONSTRAINT reporttags_pkey PRIMARY KEY (tag_id);


--
-- Name: roles_table roles_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles_table
    ADD CONSTRAINT roles_table_pkey PRIMARY KEY (role_id);


--
-- Name: roles_table roles_table_role_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles_table
    ADD CONSTRAINT roles_table_role_name_key UNIQUE (role_name);


--
-- Name: sales_account_allocation_table sales_account_allocation_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales_account_allocation_table
    ADD CONSTRAINT sales_account_allocation_table_pkey PRIMARY KEY (gcct_id);


--
-- Name: sales_credit_table sales_credit_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales_credit_table
    ADD CONSTRAINT sales_credit_table_pkey PRIMARY KEY (sct_id);


--
-- Name: sales_order_delivery_transaction_table sales_order_delivery_transaction_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales_order_delivery_transaction_table
    ADD CONSTRAINT sales_order_delivery_transaction_table_pkey PRIMARY KEY (sodtt_id);


--
-- Name: sales_order_invoice_table sales_order_invoice_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales_order_invoice_table
    ADD CONSTRAINT sales_order_invoice_table_pkey PRIMARY KEY (soit_id);


--
-- Name: sales_order_invoice_table sales_order_invoice_table_soit_due_amount; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public.sales_order_invoice_table
    ADD CONSTRAINT sales_order_invoice_table_soit_due_amount CHECK ((soit_due_amount >= (0)::numeric)) NOT VALID;


--
-- Name: sales_order_items_list sales_order_items_list_item_invoice_remaining_quantity; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public.sales_order_items_list
    ADD CONSTRAINT sales_order_items_list_item_invoice_remaining_quantity CHECK ((item_invoice_open_quantity >= 0)) NOT VALID;


--
-- Name: sales_order_items_list sales_order_items_list_item_to_be_delivered; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public.sales_order_items_list
    ADD CONSTRAINT sales_order_items_list_item_to_be_delivered CHECK ((item_to_be_delivered >= 0)) NOT VALID;


--
-- Name: sales_order sales_order_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales_order
    ADD CONSTRAINT sales_order_pkey PRIMARY KEY (sot_id);


--
-- Name: sales_order_transaction_table sales_order_transaction_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales_order_transaction_table
    ADD CONSTRAINT sales_order_transaction_table_pkey PRIMARY KEY (sott_id);


--
-- Name: sales_return_document_list sales_return_document_list_sct_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales_return_document_list
    ADD CONSTRAINT sales_return_document_list_sct_id_key UNIQUE (sct_id);


--
-- Name: sales_return_table sales_return_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales_return_table
    ADD CONSTRAINT sales_return_table_pkey PRIMARY KEY (srt_id);


--
-- Name: server_ips server_ips_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.server_ips
    ADD CONSTRAINT server_ips_pkey PRIMARY KEY (server_id);


--
-- Name: shipping_type shipping_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_type
    ADD CONSTRAINT shipping_type_pkey PRIMARY KEY (id);


--
-- Name: sms_config sms_config_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sms_config
    ADD CONSTRAINT sms_config_pkey PRIMARY KEY (id);


--
-- Name: smtp_config smtp_config_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.smtp_config
    ADD CONSTRAINT smtp_config_pkey PRIMARY KEY (id);


--
-- Name: socket_connection_id_table socket_connection_id_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.socket_connection_id_table
    ADD CONSTRAINT socket_connection_id_table_pkey PRIMARY KEY (socket_id);


--
-- Name: specialization_table specialization_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.specialization_table
    ADD CONSTRAINT specialization_table_pkey PRIMARY KEY (id);


--
-- Name: state_table state_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.state_table
    ADD CONSTRAINT state_table_pkey PRIMARY KEY (id);


--
-- Name: stock_audit_items_table stock_audit_items_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stock_audit_items_table
    ADD CONSTRAINT stock_audit_items_table_pkey PRIMARY KEY (sait_id);


--
-- Name: stock_audit_table stock_audit_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stock_audit_table
    ADD CONSTRAINT stock_audit_table_pkey PRIMARY KEY (sat_id);


--
-- Name: stock_in_out_table stock_in_out_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stock_in_out_table
    ADD CONSTRAINT stock_in_out_table_pkey PRIMARY KEY (item_id);


--
-- Name: stock_request_table stock_request_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stock_request_table
    ADD CONSTRAINT stock_request_table_pkey PRIMARY KEY (item_id);


--
-- Name: store_account_details_table store_account_details_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.store_account_details_table
    ADD CONSTRAINT store_account_details_table_pkey PRIMARY KEY (store_id);


--
-- Name: store_agreement_table store_agreement_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.store_agreement_table
    ADD CONSTRAINT store_agreement_table_pkey PRIMARY KEY (store_id);


--
-- Name: store_app_user_number_table store_app_user_number_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.store_app_user_number_table
    ADD CONSTRAINT store_app_user_number_table_pkey PRIMARY KEY (store_app_user_id);


--
-- Name: store_branding_and_store_software_details_table store_branding_and_store_software_details_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.store_branding_and_store_software_details_table
    ADD CONSTRAINT store_branding_and_store_software_details_table_pkey PRIMARY KEY (store_id);


--
-- Name: store_branding_details_table store_branding_details_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.store_branding_details_table
    ADD CONSTRAINT store_branding_details_table_pkey PRIMARY KEY (store_id);


--
-- Name: store_dispatch_details_table store_dispatch_details_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.store_dispatch_details_table
    ADD CONSTRAINT store_dispatch_details_table_pkey PRIMARY KEY (store_id);


--
-- Name: store_info_address_table store_info_address_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.store_info_address_table
    ADD CONSTRAINT store_info_address_table_pkey PRIMARY KEY (store_id);


--
-- Name: store_info_drug_license_table store_info_drug_license_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.store_info_drug_license_table
    ADD CONSTRAINT store_info_drug_license_table_pkey PRIMARY KEY (store_id);


--
-- Name: store_info_firm_details_table store_info_firm_details_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.store_info_firm_details_table
    ADD CONSTRAINT store_info_firm_details_table_pkey PRIMARY KEY (store_id);


--
-- Name: store_info_payment_table store_info_payment_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.store_info_payment_table
    ADD CONSTRAINT store_info_payment_table_pkey PRIMARY KEY (store_id);


--
-- Name: store_info_personal_details_table store_info_personal_details_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.store_info_personal_details_table
    ADD CONSTRAINT store_info_personal_details_table_pkey PRIMARY KEY (store_id);


--
-- Name: store_information_for_user_table store_information_for_user_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.store_information_for_user_table
    ADD CONSTRAINT store_information_for_user_table_pkey PRIMARY KEY (store_id);


--
-- Name: store_infrastructure_details_table store_infrastructure_details_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.store_infrastructure_details_table
    ADD CONSTRAINT store_infrastructure_details_table_pkey PRIMARY KEY (store_id);


--
-- Name: store_inventory_table store_inventory_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.store_inventory_table
    ADD CONSTRAINT store_inventory_table_pkey PRIMARY KEY (item_id);


--
-- Name: store_opening_details_table store_opening_details_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.store_opening_details_table
    ADD CONSTRAINT store_opening_details_table_pkey PRIMARY KEY (store_id);


--
-- Name: stripe_config stripe_config_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stripe_config
    ADD CONSTRAINT stripe_config_pkey PRIMARY KEY (id);


--
-- Name: sub_specialization_table sub_specialization_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sub_specialization_table
    ADD CONSTRAINT sub_specialization_table_pkey PRIMARY KEY (id);


--
-- Name: sublevel_bins sublevel_bins_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sublevel_bins
    ADD CONSTRAINT sublevel_bins_pkey PRIMARY KEY (bin_no_id);


--
-- Name: sublevel_table sublevel_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sublevel_table
    ADD CONSTRAINT sublevel_table_pkey PRIMARY KEY (sublevel_id);


--
-- Name: sync_rules sync_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sync_rules
    ADD CONSTRAINT sync_rules_pkey PRIMARY KEY (sync_rule_id);


--
-- Name: sync_runs sync_runs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sync_runs
    ADD CONSTRAINT sync_runs_pkey PRIMARY KEY (sync_run_id);


--
-- Name: tax_combination_item tax_combination_item_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tax_combination_item
    ADD CONSTRAINT tax_combination_item_pkey PRIMARY KEY (id);


--
-- Name: tax_combination tax_combination_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tax_combination
    ADD CONSTRAINT tax_combination_pkey PRIMARY KEY (id);


--
-- Name: tax_table tax_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tax_table
    ADD CONSTRAINT tax_table_pkey PRIMARY KEY (tax_id);


--
-- Name: tax_type tax_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tax_type
    ADD CONSTRAINT tax_type_pkey PRIMARY KEY (id);


--
-- Name: tcs_table tcs_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tcs_table
    ADD CONSTRAINT tcs_table_pkey PRIMARY KEY (tcs_id);


--
-- Name: tcs_table tcs_table_tcs_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tcs_table
    ADD CONSTRAINT tcs_table_tcs_name_key UNIQUE (tcs_name);


--
-- Name: tds_table tds_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tds_table
    ADD CONSTRAINT tds_table_pkey PRIMARY KEY (tds_id);


--
-- Name: tds_table tds_table_tds_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tds_table
    ADD CONSTRAINT tds_table_tds_name_key UNIQUE (tds_name);


--
-- Name: terms_and_conditions_table terms_and_conditions_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.terms_and_conditions_table
    ADD CONSTRAINT terms_and_conditions_table_pkey PRIMARY KEY (store_id);


--
-- Name: pos_items_batch_no_table unique_condition; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pos_items_batch_no_table
    ADD CONSTRAINT unique_condition UNIQUE (item_id, item_batch_number, pos_id);


--
-- Name: pos_store_inventory_item_location_table unique_condition11; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pos_store_inventory_item_location_table
    ADD CONSTRAINT unique_condition11 UNIQUE (item_id, item_batch_number, item_rack_location, pos_id);


--
-- Name: pos_items_batch_no_table unique_condition1122; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pos_items_batch_no_table
    ADD CONSTRAINT unique_condition1122 UNIQUE (item_id, item_batch_number, pos_id);


--
-- Name: print_preferences unique_type; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.print_preferences
    ADD CONSTRAINT unique_type UNIQUE (type);


--
-- Name: unit_of_measure unit_of_measure_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unit_of_measure
    ADD CONSTRAINT unit_of_measure_pkey PRIMARY KEY (uom_id);


--
-- Name: store_inventory_item_location_table unqiuee; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.store_inventory_item_location_table
    ADD CONSTRAINT unqiuee UNIQUE (item_id, item_batch_number, item_rack_location, pos_id) INCLUDE (item_id, item_batch_number, item_rack_location, pos_id);


--
-- Name: items_batch_no_table unquiee_condition; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items_batch_no_table
    ADD CONSTRAINT unquiee_condition UNIQUE (item_id, item_batch_number, pos_id) INCLUDE (item_id, item_batch_number, pos_id);


--
-- Name: uom_group_item uom_group_item_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.uom_group_item
    ADD CONSTRAINT uom_group_item_pkey PRIMARY KEY (item_id);


--
-- Name: uom_group uom_group_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.uom_group
    ADD CONSTRAINT uom_group_pkey PRIMARY KEY (group_id);


--
-- Name: uom_group_table uom_group_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.uom_group_table
    ADD CONSTRAINT uom_group_table_pkey PRIMARY KEY (uom_group_id);


--
-- Name: uom_table uom_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.uom_table
    ADD CONSTRAINT uom_table_pkey PRIMARY KEY (uom_id);


--
-- Name: user_column_preferences user_column_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_column_preferences
    ADD CONSTRAINT user_column_preferences_pkey PRIMARY KEY (id);


--
-- Name: users_permission_table users_permission_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users_permission_table
    ADD CONSTRAINT users_permission_table_pkey PRIMARY KEY (permission_id);


--
-- Name: users_table users_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users_table
    ADD CONSTRAINT users_table_pkey PRIMARY KEY (user_id);


--
-- Name: warehouses_table warehouses_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.warehouses_table
    ADD CONSTRAINT warehouses_table_pkey PRIMARY KEY (warehouse_id);


--
-- Name: whatsapp_config whatsapp_config_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.whatsapp_config
    ADD CONSTRAINT whatsapp_config_pkey PRIMARY KEY (id);


--
-- Name: idx_item_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_item_name ON public.items_table USING btree (item_name);


--
-- Name: idx_lower_item_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_lower_item_name ON public.items_table USING btree (lower((item_name)::text));


--
-- Name: idx_server_ips_created_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_server_ips_created_date ON public.server_ips USING btree (created_date DESC);


--
-- Name: idx_server_ips_ip_address; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_server_ips_ip_address ON public.server_ips USING btree (ip_address);


--
-- Name: idx_server_ips_server_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_server_ips_server_name ON public.server_ips USING btree (server_name);


--
-- Name: idx_sync_rules_next_sync; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_sync_rules_next_sync ON public.sync_rules USING btree (next_sync_at);


--
-- Name: idx_sync_rules_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_sync_rules_status ON public.sync_rules USING btree (status);


--
-- Name: idx_sync_rules_sync_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_sync_rules_sync_status ON public.sync_rules USING btree (sync_status);


--
-- Name: idx_sync_runs_created_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_sync_runs_created_date ON public.sync_runs USING btree (created_date);


--
-- Name: idx_sync_runs_rule_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_sync_runs_rule_id ON public.sync_runs USING btree (sync_rule_id);


--
-- Name: idx_sync_runs_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_sync_runs_status ON public.sync_runs USING btree (status);


--
-- Name: customer_details customer_details_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER customer_details_trigger AFTER INSERT OR DELETE OR UPDATE ON public.customer_details FOR EACH ROW EXECUTE FUNCTION public.notify_event();


--
-- Name: price_list_items_table item_selling_price_change; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER item_selling_price_change AFTER UPDATE OF item_selling_price ON public.price_list_items_table FOR EACH ROW EXECUTE FUNCTION public.notify_price_change();


--
-- Name: order_items_list order_items_list_insert_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER order_items_list_insert_trigger AFTER INSERT ON public.order_items_list FOR EACH ROW EXECUTE FUNCTION public.notify_order_items_list_insert();


--
-- Name: sales_order sales_order_insert_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER sales_order_insert_trigger AFTER INSERT ON public.sales_order FOR EACH ROW EXECUTE FUNCTION public.notify_sales_order_insert();


--
-- Name: price_list_table tregger_update_margin_factor; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tregger_update_margin_factor AFTER UPDATE OF margin_factor ON public.price_list_table FOR EACH ROW WHEN ((old.margin_factor IS DISTINCT FROM new.margin_factor)) EXECUTE FUNCTION public.update_selling_price_on_purchase_rate_margin_factor_change();


--
-- Name: price_list_table update_item_selling_price; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_item_selling_price AFTER UPDATE OF default_factor ON public.price_list_table FOR EACH ROW EXECUTE FUNCTION public.update_item_selling_price();


--
-- Name: approval_document_terms approval_document_terms_approval_flow_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.approval_document_terms
    ADD CONSTRAINT approval_document_terms_approval_flow_id_fkey FOREIGN KEY (approval_flow_id) REFERENCES public.approval_flows(approval_flow_id) ON DELETE CASCADE;


--
-- Name: approval_originators approval_originators_approval_flow_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.approval_originators
    ADD CONSTRAINT approval_originators_approval_flow_id_fkey FOREIGN KEY (approval_flow_id) REFERENCES public.approval_flows(approval_flow_id) ON DELETE CASCADE;


--
-- Name: approval_request_stages approval_request_stages_request_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.approval_request_stages
    ADD CONSTRAINT approval_request_stages_request_id_fkey FOREIGN KEY (request_id) REFERENCES public.approval_requests(request_id) ON DELETE CASCADE;


--
-- Name: approval_requests approval_requests_approval_flow_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.approval_requests
    ADD CONSTRAINT approval_requests_approval_flow_id_fkey FOREIGN KEY (approval_flow_id) REFERENCES public.approval_flows(approval_flow_id) ON DELETE CASCADE;


--
-- Name: approval_stages approval_stages_approval_flow_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.approval_stages
    ADD CONSTRAINT approval_stages_approval_flow_id_fkey FOREIGN KEY (approval_flow_id) REFERENCES public.approval_flows(approval_flow_id) ON DELETE CASCADE;


--
-- Name: billing_invoice_payment_modes billing_invoice_payment_modes_sot_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.billing_invoice_payment_modes
    ADD CONSTRAINT billing_invoice_payment_modes_sot_id_fkey FOREIGN KEY (sot_id) REFERENCES public.sales_order(sot_id);


--
-- Name: bin_location_table bin_location_table_warehouse_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bin_location_table
    ADD CONSTRAINT bin_location_table_warehouse_id_fkey FOREIGN KEY (warehouse_id) REFERENCES public.warehouses_table(warehouse_id);


--
-- Name: credit_note_invoice_payment_modes credit_note_invoice_payment_modes_icn_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credit_note_invoice_payment_modes
    ADD CONSTRAINT credit_note_invoice_payment_modes_icn_id_fkey FOREIGN KEY (icn_id) REFERENCES public.invoice_credit_note(icn_id);


--
-- Name: customer_accounting_table customer_accounting_table_cmr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_accounting_table
    ADD CONSTRAINT customer_accounting_table_cmr_id_fkey FOREIGN KEY (cmr_id) REFERENCES public.customer_details(cmr_id);


--
-- Name: customer_bank_details customer_bank_details_cmr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_bank_details
    ADD CONSTRAINT customer_bank_details_cmr_id_fkey FOREIGN KEY (cmr_id) REFERENCES public.customer_details(cmr_id);


--
-- Name: customer_contact_persons customer_contact_persons_cmr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_contact_persons
    ADD CONSTRAINT customer_contact_persons_cmr_id_fkey FOREIGN KEY (cmr_id) REFERENCES public.customer_details(cmr_id);


--
-- Name: customer_pay_to_address customer_pay_to_address_cmr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_pay_to_address
    ADD CONSTRAINT customer_pay_to_address_cmr_id_fkey FOREIGN KEY (cmr_id) REFERENCES public.customer_details(cmr_id);


--
-- Name: customer_payment_terms_table customer_payment_terms_table_cmr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_payment_terms_table
    ADD CONSTRAINT customer_payment_terms_table_cmr_id_fkey FOREIGN KEY (cmr_id) REFERENCES public.customer_details(cmr_id);


--
-- Name: customer_ship_to_address customer_ship_to_address_cmr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_ship_to_address
    ADD CONSTRAINT customer_ship_to_address_cmr_id_fkey FOREIGN KEY (cmr_id) REFERENCES public.customer_details(cmr_id);


--
-- Name: discount_group_table discount_group_table_customer_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discount_group_table
    ADD CONSTRAINT discount_group_table_customer_group_id_fkey FOREIGN KEY (customer_group_id) REFERENCES public.customer_group_table(customer_group_id);


--
-- Name: discount_group_table discount_group_table_discount_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discount_group_table
    ADD CONSTRAINT discount_group_table_discount_type_id_fkey FOREIGN KEY (customer_type_id) REFERENCES public.discount_type_table(discount_type_id);


--
-- Name: document_custom_numbering_series_table document_custom_numbering_series_table_transaction_doc_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_custom_numbering_series_table
    ADD CONSTRAINT document_custom_numbering_series_table_transaction_doc_id_fkey FOREIGN KEY (transaction_doc_id) REFERENCES public.document_custom_table(transaction_doc_id);


--
-- Name: document_numbering_series document_numbering_series_document_numbering_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_numbering_series
    ADD CONSTRAINT document_numbering_series_document_numbering_id_fkey FOREIGN KEY (document_numbering_id) REFERENCES public.document_numbering(id);


--
-- Name: document_numbering_series_table document_numbering_series_table_transaction_doc_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_numbering_series_table
    ADD CONSTRAINT document_numbering_series_table_transaction_doc_id_fkey FOREIGN KEY (transaction_doc_id) REFERENCES public.document_table(transaction_doc_id);


--
-- Name: good_order_receipt_items_batches_list good_order_receipt_items_batches_list_gort_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.good_order_receipt_items_batches_list
    ADD CONSTRAINT good_order_receipt_items_batches_list_gort_id_fkey FOREIGN KEY (gort_id) REFERENCES public.goods_order_receipt_table(gort_id);


--
-- Name: good_order_receipt_items_list good_order_receipt_items_list_gort_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.good_order_receipt_items_list
    ADD CONSTRAINT good_order_receipt_items_list_gort_id_fkey FOREIGN KEY (gort_id) REFERENCES public.goods_order_receipt_table(gort_id);


--
-- Name: inventory_status_condition_table inventory_status_condition_table_is_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_status_condition_table
    ADD CONSTRAINT inventory_status_condition_table_is_id_fkey FOREIGN KEY (is_id) REFERENCES public.inventory_status_table(is_id);


--
-- Name: inventory_status_item_list_table inventory_status_item_list_table_is_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_status_item_list_table
    ADD CONSTRAINT inventory_status_item_list_table_is_id_fkey FOREIGN KEY (is_id) REFERENCES public.inventory_status_table(is_id);


--
-- Name: inventory_transfer_item_batches_table inventory_transfer_item_batches_table_itt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_transfer_item_batches_table
    ADD CONSTRAINT inventory_transfer_item_batches_table_itt_id_fkey FOREIGN KEY (itt_id) REFERENCES public.inventory_transfer_table(itt_id);


--
-- Name: inventory_transfer_rows_table inventory_transfer_rows_table_itt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_transfer_rows_table
    ADD CONSTRAINT inventory_transfer_rows_table_itt_id_fkey FOREIGN KEY (itt_id) REFERENCES public.inventory_transfer_table(itt_id);


--
-- Name: invoice_credit_note_item_list invoice_credit_note_item_list_icn_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invoice_credit_note_item_list
    ADD CONSTRAINT invoice_credit_note_item_list_icn_id_fkey FOREIGN KEY (icn_id) REFERENCES public.invoice_credit_note(icn_id);


--
-- Name: item_barcode_table item_barcode_table_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_barcode_table
    ADD CONSTRAINT item_barcode_table_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items_table(item_id);


--
-- Name: item_discount_and_scheme_table item_discount_and_scheme_table_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_discount_and_scheme_table
    ADD CONSTRAINT item_discount_and_scheme_table_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items_table(item_id) ON DELETE CASCADE;


--
-- Name: item_group item_group_default_uom_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_group
    ADD CONSTRAINT item_group_default_uom_id_fkey FOREIGN KEY (default_uom_id) REFERENCES public.unit_of_measure(uom_id);


--
-- Name: item_invetory_table item_invetory_table_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_invetory_table
    ADD CONSTRAINT item_invetory_table_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items_table(item_id) ON DELETE CASCADE;


--
-- Name: item_min_max_for_pos_inventory item_min_max_for_pos_inventory_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_min_max_for_pos_inventory
    ADD CONSTRAINT item_min_max_for_pos_inventory_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items_table(item_id);


--
-- Name: item_molecule_composition_table item_molecule_composition_table_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_molecule_composition_table
    ADD CONSTRAINT item_molecule_composition_table_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items_table(item_id) ON DELETE CASCADE;


--
-- Name: item_packing_information_table item_packing_information_table_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_packing_information_table
    ADD CONSTRAINT item_packing_information_table_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items_table(item_id) ON DELETE CASCADE;


--
-- Name: item_planning_table item_planning_table_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_planning_table
    ADD CONSTRAINT item_planning_table_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items_table(item_id) ON DELETE CASCADE;


--
-- Name: item_purchasing_table item_purchasing_table_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_purchasing_table
    ADD CONSTRAINT item_purchasing_table_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items_table(item_id) ON DELETE CASCADE;


--
-- Name: item_remarks_table item_remarks_table_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_remarks_table
    ADD CONSTRAINT item_remarks_table_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items_table(item_id) ON DELETE CASCADE;


--
-- Name: item_restriction_table item_restriction_table_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_restriction_table
    ADD CONSTRAINT item_restriction_table_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items_table(item_id) ON DELETE CASCADE;


--
-- Name: item_sales_table item_sales_table_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_sales_table
    ADD CONSTRAINT item_sales_table_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items_table(item_id) ON DELETE CASCADE;


--
-- Name: item_uom_group_table item_uom_group_table_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_uom_group_table
    ADD CONSTRAINT item_uom_group_table_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items_table(item_id);


--
-- Name: items_discount_group_table items_discount_group_table_discount_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items_discount_group_table
    ADD CONSTRAINT items_discount_group_table_discount_group_id_fkey FOREIGN KEY (customer_group_id) REFERENCES public.discount_group_table(discount_group_id);


--
-- Name: items_group_discount_group_table items_group_discount_group_table_discount_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items_group_discount_group_table
    ADD CONSTRAINT items_group_discount_group_table_discount_group_id_fkey FOREIGN KEY (discount_group_id) REFERENCES public.discount_group_table(discount_group_id);


--
-- Name: items_volume_validity_table items_volume_validity_table_period_validity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items_volume_validity_table
    ADD CONSTRAINT items_volume_validity_table_period_validity_id_fkey FOREIGN KEY (period_validity_id) REFERENCES public.items_period_validity_table(period_validity_id);


--
-- Name: journal_entry_rows_table journal_entry_rows_table_transcation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journal_entry_rows_table
    ADD CONSTRAINT journal_entry_rows_table_transcation_id_fkey FOREIGN KEY (transcation_id) REFERENCES public.journal_entry_table(transcation_id);


--
-- Name: manufactures_group_discount_group_table manufactures_group_discount_group_table_discount_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manufactures_group_discount_group_table
    ADD CONSTRAINT manufactures_group_discount_group_table_discount_group_id_fkey FOREIGN KEY (discount_group_id) REFERENCES public.discount_group_table(discount_group_id);


--
-- Name: module_table module_table_main_module_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.module_table
    ADD CONSTRAINT module_table_main_module_id_fkey FOREIGN KEY (main_module_id) REFERENCES public.main_module_table(main_module_id) NOT VALID;


--
-- Name: order_items_list order_items_list_sot_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items_list
    ADD CONSTRAINT order_items_list_sot_id_fkey FOREIGN KEY (sot_id) REFERENCES public.sales_order(sot_id);


--
-- Name: payment_in_document_list_table payment_in_document_list_table_pit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_in_document_list_table
    ADD CONSTRAINT payment_in_document_list_table_pit_id_fkey FOREIGN KEY (pit_id) REFERENCES public.payment_in_table(pit_id);


--
-- Name: payment_modes_table payment_modes_table_pit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_modes_table
    ADD CONSTRAINT payment_modes_table_pit_id_fkey FOREIGN KEY (pit_id) REFERENCES public.payment_in_table(pit_id);


--
-- Name: payment_out_document_list_table payment_out_document_list_table_pot_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_out_document_list_table
    ADD CONSTRAINT payment_out_document_list_table_pot_id_fkey FOREIGN KEY (pot_id) REFERENCES public.payment_out_table(pot_id);


--
-- Name: payment_out_modes_table payment_out_modes_table_pot_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_out_modes_table
    ADD CONSTRAINT payment_out_modes_table_pot_id_fkey FOREIGN KEY (pot_id) REFERENCES public.payment_out_table(pot_id);


--
-- Name: period_volume_discount_items_table period_volume_discount_items_table_price_list_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.period_volume_discount_items_table
    ADD CONSTRAINT period_volume_discount_items_table_price_list_id_fkey FOREIGN KEY (price_list_id) REFERENCES public.price_list_table(price_list_id);


--
-- Name: period_volume_discount_table period_volume_discount_table_price_list_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.period_volume_discount_table
    ADD CONSTRAINT period_volume_discount_table_price_list_id_fkey FOREIGN KEY (price_list_id) REFERENCES public.price_list_table(price_list_id);


--
-- Name: price_list_items_table price_list_items_table_price_list_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.price_list_items_table
    ADD CONSTRAINT price_list_items_table_price_list_id_fkey FOREIGN KEY (price_list_id) REFERENCES public.price_list_table(price_list_id);


--
-- Name: purchase_credit_items_batches_list purchase_credit_items_batches_list_pct_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.purchase_credit_items_batches_list
    ADD CONSTRAINT purchase_credit_items_batches_list_pct_id_fkey FOREIGN KEY (pct_id) REFERENCES public.purchase_credit_table(pct_id);


--
-- Name: purchase_credit_items_list_table purchase_credit_items_list_table_pct_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.purchase_credit_items_list_table
    ADD CONSTRAINT purchase_credit_items_list_table_pct_id_fkey FOREIGN KEY (pct_id) REFERENCES public.purchase_credit_table(pct_id);


--
-- Name: purchase_order_invoice_items_batches_list purchase_order_invoice_items_batches_list_poit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.purchase_order_invoice_items_batches_list
    ADD CONSTRAINT purchase_order_invoice_items_batches_list_poit_id_fkey FOREIGN KEY (poit_id) REFERENCES public.purchase_order_invoice_table(poit_id);


--
-- Name: purchase_order_invoice_items_list purchase_order_invoice_items_list_poit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.purchase_order_invoice_items_list
    ADD CONSTRAINT purchase_order_invoice_items_list_poit_id_fkey FOREIGN KEY (poit_id) REFERENCES public.purchase_order_invoice_table(poit_id);


--
-- Name: purchase_order_items_list purchase_order_items_list_pot_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.purchase_order_items_list
    ADD CONSTRAINT purchase_order_items_list_pot_id_fkey FOREIGN KEY (pot_id) REFERENCES public.purchase_order_transaction_table(pot_id);


--
-- Name: purchase_return_items_batches_list purchase_return_items_batches_list_prt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.purchase_return_items_batches_list
    ADD CONSTRAINT purchase_return_items_batches_list_prt_id_fkey FOREIGN KEY (prt_id) REFERENCES public.purchase_return_table(prt_id);


--
-- Name: purchase_return_items_list purchase_return_items_list_prt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.purchase_return_items_list
    ADD CONSTRAINT purchase_return_items_list_prt_id_fkey FOREIGN KEY (prt_id) REFERENCES public.purchase_return_table(prt_id);


--
-- Name: sale_order_delivery_document_list sale_order_delivery_document_list_sodtt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sale_order_delivery_document_list
    ADD CONSTRAINT sale_order_delivery_document_list_sodtt_id_fkey FOREIGN KEY (sodtt_id) REFERENCES public.sales_order_delivery_transaction_table(sodtt_id);


--
-- Name: sale_order_delivery_items_batches_list sale_order_delivery_items_batches_list_sodtt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sale_order_delivery_items_batches_list
    ADD CONSTRAINT sale_order_delivery_items_batches_list_sodtt_id_fkey FOREIGN KEY (sodtt_id) REFERENCES public.sales_order_delivery_transaction_table(sodtt_id);


--
-- Name: sale_order_delivery_items_list sale_order_delivery_items_list_sodtt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sale_order_delivery_items_list
    ADD CONSTRAINT sale_order_delivery_items_list_sodtt_id_fkey FOREIGN KEY (sodtt_id) REFERENCES public.sales_order_delivery_transaction_table(sodtt_id);


--
-- Name: sales_credit_items_batches_list sales_credit_items_batches_list_sct_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales_credit_items_batches_list
    ADD CONSTRAINT sales_credit_items_batches_list_sct_id_fkey FOREIGN KEY (sct_id) REFERENCES public.sales_credit_table(sct_id);


--
-- Name: sales_credit_items_list_table sales_credit_items_list_table_sct_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales_credit_items_list_table
    ADD CONSTRAINT sales_credit_items_list_table_sct_id_fkey FOREIGN KEY (sct_id) REFERENCES public.sales_credit_table(sct_id);


--
-- Name: sales_order_delivery_transaction_table sales_order_delivery_transaction_table_sott_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales_order_delivery_transaction_table
    ADD CONSTRAINT sales_order_delivery_transaction_table_sott_id_fkey FOREIGN KEY (sott_id) REFERENCES public.sales_order_transaction_table(sott_id);


--
-- Name: sales_order_invoice_items_batches_list sales_order_invoice_items_batches_list_soit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales_order_invoice_items_batches_list
    ADD CONSTRAINT sales_order_invoice_items_batches_list_soit_id_fkey FOREIGN KEY (soit_id) REFERENCES public.sales_order_invoice_table(soit_id);


--
-- Name: sales_order_invoice_items_list sales_order_invoice_items_list_soit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales_order_invoice_items_list
    ADD CONSTRAINT sales_order_invoice_items_list_soit_id_fkey FOREIGN KEY (soit_id) REFERENCES public.sales_order_invoice_table(soit_id);


--
-- Name: sales_order_items_list sales_order_items_list_sott_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales_order_items_list
    ADD CONSTRAINT sales_order_items_list_sott_id_fkey FOREIGN KEY (sott_id) REFERENCES public.sales_order_transaction_table(sott_id);


--
-- Name: sales_return_document_list sales_return_document_list_srt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales_return_document_list
    ADD CONSTRAINT sales_return_document_list_srt_id_fkey FOREIGN KEY (srt_id) REFERENCES public.sales_return_table(srt_id);


--
-- Name: sales_return_items_batches_list sales_return_items_batches_list_srt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales_return_items_batches_list
    ADD CONSTRAINT sales_return_items_batches_list_srt_id_fkey FOREIGN KEY (srt_id) REFERENCES public.sales_return_table(srt_id);


--
-- Name: sales_return_items_list sales_return_items_list_srt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales_return_items_list
    ADD CONSTRAINT sales_return_items_list_srt_id_fkey FOREIGN KEY (srt_id) REFERENCES public.sales_return_table(srt_id);


--
-- Name: stock_audit_items_table stock_audit_items_table_sat_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stock_audit_items_table
    ADD CONSTRAINT stock_audit_items_table_sat_id_fkey FOREIGN KEY (sat_id) REFERENCES public.stock_audit_table(sat_id);


--
-- Name: store_account_details_table store_account_details_table_store_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.store_account_details_table
    ADD CONSTRAINT store_account_details_table_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.store_info_address_table(store_id);


--
-- Name: store_agreement_table store_agreement_table_store_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.store_agreement_table
    ADD CONSTRAINT store_agreement_table_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.store_info_address_table(store_id);


--
-- Name: store_branding_and_store_software_details_table store_branding_and_store_software_details_table_store_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.store_branding_and_store_software_details_table
    ADD CONSTRAINT store_branding_and_store_software_details_table_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.store_info_address_table(store_id);


--
-- Name: store_branding_details_table store_branding_details_table_store_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.store_branding_details_table
    ADD CONSTRAINT store_branding_details_table_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.store_info_address_table(store_id);


--
-- Name: store_dispatch_details_table store_dispatch_details_table_store_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.store_dispatch_details_table
    ADD CONSTRAINT store_dispatch_details_table_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.store_info_address_table(store_id);


--
-- Name: store_followup_and_history_table store_followup_and_history_table_store_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.store_followup_and_history_table
    ADD CONSTRAINT store_followup_and_history_table_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.store_info_address_table(store_id);


--
-- Name: store_info_drug_license_table store_info_drug_license_table_store_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.store_info_drug_license_table
    ADD CONSTRAINT store_info_drug_license_table_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.store_info_address_table(store_id);


--
-- Name: store_info_firm_details_table store_info_firm_details_table_store_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.store_info_firm_details_table
    ADD CONSTRAINT store_info_firm_details_table_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.store_info_address_table(store_id);


--
-- Name: store_info_payment_table store_info_payment_table_store_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.store_info_payment_table
    ADD CONSTRAINT store_info_payment_table_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.store_info_address_table(store_id);


--
-- Name: store_info_personal_details_table store_info_personal_details_table_store_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.store_info_personal_details_table
    ADD CONSTRAINT store_info_personal_details_table_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.store_info_address_table(store_id);


--
-- Name: store_infrastructure_details_table store_infrastructure_details_table_store_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.store_infrastructure_details_table
    ADD CONSTRAINT store_infrastructure_details_table_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.store_info_address_table(store_id);


--
-- Name: store_opening_details_table store_opening_details_table_store_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.store_opening_details_table
    ADD CONSTRAINT store_opening_details_table_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.store_info_address_table(store_id);


--
-- Name: sublevel_bins sublevel_bins_sublevel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sublevel_bins
    ADD CONSTRAINT sublevel_bins_sublevel_id_fkey FOREIGN KEY (sublevel_id) REFERENCES public.sublevel_table(sublevel_id);


--
-- Name: sublevel_table sublevel_table_warehouse_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sublevel_table
    ADD CONSTRAINT sublevel_table_warehouse_id_fkey FOREIGN KEY (warehouse_id) REFERENCES public.warehouses_table(warehouse_id);


--
-- Name: sync_runs sync_runs_sync_rule_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sync_runs
    ADD CONSTRAINT sync_runs_sync_rule_id_fkey FOREIGN KEY (sync_rule_id) REFERENCES public.sync_rules(sync_rule_id) ON DELETE CASCADE;


--
-- Name: tax_combination_item tax_combination_item_tax_combination_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tax_combination_item
    ADD CONSTRAINT tax_combination_item_tax_combination_id_fkey FOREIGN KEY (tax_combination_id) REFERENCES public.tax_combination(id);


--
-- Name: tax_combination_item tax_combination_item_tax_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tax_combination_item
    ADD CONSTRAINT tax_combination_item_tax_type_id_fkey FOREIGN KEY (tax_type_id) REFERENCES public.tax_type(id);


--
-- Name: terms_and_conditions_table terms_and_conditions_table_store_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.terms_and_conditions_table
    ADD CONSTRAINT terms_and_conditions_table_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.store_info_address_table(store_id);


--
-- Name: uom_group_item uom_group_item_base_uom_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.uom_group_item
    ADD CONSTRAINT uom_group_item_base_uom_id_fkey FOREIGN KEY (base_uom_id) REFERENCES public.unit_of_measure(uom_id);


--
-- Name: uom_group_item uom_group_item_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.uom_group_item
    ADD CONSTRAINT uom_group_item_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.uom_group(group_id);


--
-- Name: uom_table uom_table_uom_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.uom_table
    ADD CONSTRAINT uom_table_uom_group_id_fkey FOREIGN KEY (uom_group_id) REFERENCES public.uom_group_table(uom_group_id);


--
-- Name: users_permission_table users_permission_table_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users_permission_table
    ADD CONSTRAINT users_permission_table_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users_table(user_id);


--
-- Name: users_table users_table_user_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users_table
    ADD CONSTRAINT users_table_user_role_id_fkey FOREIGN KEY (user_role_id) REFERENCES public.roles_table(role_id);


--
-- PostgreSQL database dump complete
--

\unrestrict sJIymwXuxOTdWMS3OuNlHC4oeylRvwTicWHp7kehneYpatCJefDaZykxsfVj2bf

