--------------------------------------------------------
--  DDL for Trigger MTL_PARAMETERS_AI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."MTL_PARAMETERS_AI" AFTER INSERT ON "INV"."MTL_PARAMETERS" FOR EACH ROW BEGIN IF fnd_audit_pkg.audit_on THEN MTL_PARAMETERS_AIP(:old.ORGANIZATION_ID,:old.ALLOCATE_SERIAL_FLAG,:old.ALLOW_DIFFERENT_STATUS,:old.AP_ACCRUAL_ACCOUNT,:old.AUTO_DEL_ALLOC_FLAG,:old.AUTO_LOT_ALPHA_PREFIX,:old.AUTO_SERIAL_ALPHA_PREFIX,:old.AVERAGE_COST_VAR_ACCOUNT,:old.AVG_RATES_COST_TYPE_ID,:old.BORRPAY_MATL_VAR_ACCOUNT,:old.BORRPAY_MOH_VAR_ACCOUNT,:old.BORRPAY_OSP_VAR_ACCOUNT,:old.BORRPAY_OVH_VAR_ACCOUNT,:old.BORRPAY_RES_VAR_ACCOUNT,:old.CALENDAR_CODE,:old.CALENDAR_EXCEPTION_SET_ID,:old.CARRIER_MANIFESTING_FLAG,:old.CARTONIZATION_FLAG,:old.CARTONIZE_MANUFACTURING,:old.CARTONIZE_SALES_ORDERS,:old.CHILD_LOT_ALPHA_PREFIX,:old.CHILD_LOT_NUMBER_LENGTH,:old.CHILD_LOT_VALIDATION_FLAG,:old.CHILD_LOT_ZERO_PADDING_FLAG,:old.COMMERCIAL_GOVT_ENTITY_NUMBER,:old.COMPANY_PREFIX,:old.COMPANY_PREFIX_INDEX,:old.CONSIGNED_FLAG,:old.COPY_LOT_ATTRIBUTE_FLAG,:old.COST_CUTOFF_DATE,:old.COST_GROUP_ACCOUNTING,:old.COST_OF_SALES_ACCOUNT,:old.COST_ORGANIZATION_ID,:old.CREATE_LOT_UOM_CONVERSION,:old.CROSSDOCK_FLAG,:old.DEFAULT_ATP_RULE_ID,:old.DEFAULT_CARTON_RULE_ID,:old.DEFAULT_CC_TASK_TYPE_ID,:old.DEFAULT_COST_GROUP_ID,:old.DEFAULT_CROSSDOCK_CRITERIA_ID,:old.DEFAULT_CROSSDOCK_LOCATOR_ID,:old.DEFAULT_CROSSDOCK_SUBINVENTORY,:old.DEFAULT_CYC_COUNT_HEADER_ID,:old.DEFAULT_DEMAND_CLASS,:old.DEFAULT_LOCATOR_ORDER_VALUE,:old.DEFAULT_MATERIAL_COST_ID,:old.DEFAULT_MATL_OVHD_COST_ID,:old.DEFAULT_MOISSUE_TASK_TYPE_ID,:old.DEFAULT_MOXFER_TASK_TYPE_ID,:old.DEFAULT_PICKING_RULE_ID,:old.DEFAULT_PICK_OP_PLAN_ID,:old.DEFAULT_PICK_TASK_TYPE_ID,:old.DEFAULT_PUTAWAY_TASK_TYPE_ID,:old.DEFAULT_PUT_AWAY_RULE_ID,:old.DEFAULT_REPL_TASK_TYPE_ID,:old.DEFAULT_SUBINV_ORDER_VALUE,:old.DEFAULT_WMS_PICKING_RULE_ID,:old.DEFERRED_COGS_ACCOUNT,:old.DEFER_LOGICAL_TRANSACTIONS,:old.DIRECT_SHIPPING_ALLOWED,:old.DISTRIBUTED_ORGANIZATION_FLAG,:old.DISTRIBUTION_ACCOUNT_ID,:old.EAM_ENABLED_FLAG,:old.ENABLE_COSTING_BY_CATEGORY,:old.ENCUMBRANCE_ACCOUNT,:old.ENCUMBRANCE_REVERSAL_FLAG,:old.ENFORCE_LOCATOR_ALIS_UNQ_FLAG,:old.EPC_GENERATION_ENABLED_FLAG,:old.EXPENSE_ACCOUNT,:old.GENEALOGY_FORMULA_SECURITY,:old.GENERAL_LEDGER_UPDATE_CODE,:old.INTERORG_PAYABLES_ACCOUNT,:old.INTERORG_PRICE_VAR_ACCOUNT,:old.INTERORG_RECEIVABLES_ACCOUNT,:old.INTERORG_TRANSFER_CR_ACCOUNT,:old.INTERORG_TRNSFR_CHARGE_PERCENT,:old.INTRANSIT_INV_ACCOUNT,:old.INVOICE_PRICE_VAR_ACCOUNT,:old.LABOR_MANAGEMENT_ENABLED_FLAG,:old.LOT_NUMBER_GENERATION,:old.LOT_NUMBER_LENGTH,:old.LOT_NUMBER_UNIQUENESS,:old.LOT_NUMBER_ZERO_PADDING,:old.LPN_PREFIX,:old.LPN_STARTING_NUMBER,:old.LPN_SUFFIX,:old.MAINTAIN_FIFO_QTY_STACK_TYPE,:old.MAINT_ORGANIZATION_ID,:old.MASTER_ORGANIZATION_ID,:old.MATERIAL_ACCOUNT,:old.MATERIAL_OVERHEAD_ACCOUNT,:old.MATL_INTERORG_TRANSFER_CODE,:old.MATL_OVHD_ABSORPTION_ACCT,:old.MAT_OVHD_COST_TYPE_ID,:old.MAX_CLUSTERS_ALLOWED,:old.MO_APPROVAL_TIMEOUT_ACTION,:old.MO_PICK_CONFIRM_REQUIRED,:old.MO_SOURCE_REQUIRED,:old.NEGATIVE_INV_RECEIPT_CODE,:old.ORGANIZATION_CODE,:old.ORG_MAX_VOLUME,:old.ORG_MAX_VOLUME_UOM_CODE,:old.ORG_MAX_WEIGHT,:old.ORG_MAX_WEIGHT_UOM_CODE,:old.OUTSIDE_PROCESSING_ACCOUNT,:old.OVERHEAD_ACCOUNT,:old.OVPK_TRANSFER_ORDERS_ENABLED,:old.PARENT_CHILD_GENERATION_FLAG,:old.PM_COST_COLLECTION_ENABLED,:old.PREGEN_PUTAWAY_TASKS_FLAG,:old.PRIMARY_COST_METHOD,:old.PRIORITIZE_WIP_JOBS,:old.PROCESS_ENABLED_FLAG,:old.PROCESS_ORGN_CODE,:old.PROGRAM_APPLICATION_ID,:old.PROGRAM_ID,:old.PROGRAM_UPDATE_DATE,:old.PROJECT_CONTROL_LEVEL,:old.PROJECT_COST_ACCOUNT,:old.PROJECT_REFERENCE_ENABLED,:old.PURCHASE_PRICE_VAR_ACCOUNT,:old.QA_SKIPPING_INSP_FLAG,:old.REGENERATION_INTERVAL,:old.REQUEST_ID,:old.RESOURCE_ACCOUNT,:old.RFID_VERIF_PCNT_THRESHOLD,:old.RULES_OVERRIDE_LOT_RESERVATION,:old.SALES_ACCOUNT,:old.SERIAL_NUMBER_GENERATION,:old.SERIAL_NUMBER_TYPE,:old.SKIP_TASK_WAITING_MINUTES,:old.SOURCE_ORGANIZATION_ID,:old.SOURCE_SUBINVENTORY,:old.SOURCE_TYPE,:old.STARTING_REVISION,:old.START_AUTO_SERIAL_NUMBER,:old.STOCK_LOCATOR_CONTROL_CODE,:old.TIMEZONE_ID,:old.TOTAL_LPN_LENGTH,:old.TRADING_PARTNER_ORG_FLAG,:old.TXN_APPROVAL_TIMEOUT_PERIOD,:old.UCC_128_SUFFIX_FLAG,:old.WCS_ENABLED,:old.WIP_OVERPICK_ENABLED,:old.WMS_ENABLED_FLAG,:old.WSM_ENABLED_FLAG,:old.YARD_MANAGEMENT_ENABLED_FLAG,:new.ORGANIZATION_ID,:new.ALLOCATE_SERIAL_FLAG,:new.ALLOW_DIFFERENT_STATUS,:new.AP_ACCRUAL_ACCOUNT,:new.AUTO_DEL_ALLOC_FLAG,:new.AUTO_LOT_ALPHA_PREFIX,:new.AUTO_SERIAL_ALPHA_PREFIX,:new.AVERAGE_COST_VAR_ACCOUNT,:new.AVG_RATES_COST_TYPE_ID,:new.BORRPAY_MATL_VAR_ACCOUNT,:new.BORRPAY_MOH_VAR_ACCOUNT,:new.BORRPAY_OSP_VAR_ACCOUNT,:new.BORRPAY_OVH_VAR_ACCOUNT,:new.BORRPAY_RES_VAR_ACCOUNT,:new.CALENDAR_CODE,:new.CALENDAR_EXCEPTION_SET_ID,:new.CARRIER_MANIFESTING_FLAG,:new.CARTONIZATION_FLAG,:new.CARTONIZE_MANUFACTURING,:new.CARTONIZE_SALES_ORDERS,:new.CHILD_LOT_ALPHA_PREFIX,:new.CHILD_LOT_NUMBER_LENGTH,:new.CHILD_LOT_VALIDATION_FLAG,:new.CHILD_LOT_ZERO_PADDING_FLAG,:new.COMMERCIAL_GOVT_ENTITY_NUMBER,:new.COMPANY_PREFIX,:new.COMPANY_PREFIX_INDEX,:new.CONSIGNED_FLAG,:new.COPY_LOT_ATTRIBUTE_FLAG,:new.COST_CUTOFF_DATE,:new.COST_GROUP_ACCOUNTING,:new.COST_OF_SALES_ACCOUNT,:new.COST_ORGANIZATION_ID,:new.CREATE_LOT_UOM_CONVERSION,:new.CROSSDOCK_FLAG,:new.DEFAULT_ATP_RULE_ID,:new.DEFAULT_CARTON_RULE_ID,:new.DEFAULT_CC_TASK_TYPE_ID,:new.DEFAULT_COST_GROUP_ID,:new.DEFAULT_CROSSDOCK_CRITERIA_ID,:new.DEFAULT_CROSSDOCK_LOCATOR_ID,:new.DEFAULT_CROSSDOCK_SUBINVENTORY,:new.DEFAULT_CYC_COUNT_HEADER_ID,:new.DEFAULT_DEMAND_CLASS,:new.DEFAULT_LOCATOR_ORDER_VALUE,:new.DEFAULT_MATERIAL_COST_ID,:new.DEFAULT_MATL_OVHD_COST_ID,:new.DEFAULT_MOISSUE_TASK_TYPE_ID,:new.DEFAULT_MOXFER_TASK_TYPE_ID,:new.DEFAULT_PICKING_RULE_ID,:new.DEFAULT_PICK_OP_PLAN_ID,:new.DEFAULT_PICK_TASK_TYPE_ID,:new.DEFAULT_PUTAWAY_TASK_TYPE_ID,:new.DEFAULT_PUT_AWAY_RULE_ID,:new.DEFAULT_REPL_TASK_TYPE_ID,:new.DEFAULT_SUBINV_ORDER_VALUE,:new.DEFAULT_WMS_PICKING_RULE_ID,:new.DEFERRED_COGS_ACCOUNT,:new.DEFER_LOGICAL_TRANSACTIONS,:new.DIRECT_SHIPPING_ALLOWED,:new.DISTRIBUTED_ORGANIZATION_FLAG,:new.DISTRIBUTION_ACCOUNT_ID,:new.EAM_ENABLED_FLAG,:new.ENABLE_COSTING_BY_CATEGORY,:new.ENCUMBRANCE_ACCOUNT,:new.ENCUMBRANCE_REVERSAL_FLAG,:new.ENFORCE_LOCATOR_ALIS_UNQ_FLAG,:new.EPC_GENERATION_ENABLED_FLAG,:new.EXPENSE_ACCOUNT,:new.GENEALOGY_FORMULA_SECURITY,:new.GENERAL_LEDGER_UPDATE_CODE,:new.INTERORG_PAYABLES_ACCOUNT,:new.INTERORG_PRICE_VAR_ACCOUNT,:new.INTERORG_RECEIVABLES_ACCOUNT,:new.INTERORG_TRANSFER_CR_ACCOUNT,:new.INTERORG_TRNSFR_CHARGE_PERCENT,:new.INTRANSIT_INV_ACCOUNT,:new.INVOICE_PRICE_VAR_ACCOUNT,:new.LABOR_MANAGEMENT_ENABLED_FLAG,:new.LOT_NUMBER_GENERATION,:new.LOT_NUMBER_LENGTH,:new.LOT_NUMBER_UNIQUENESS,:new.LOT_NUMBER_ZERO_PADDING,:new.LPN_PREFIX,:new.LPN_STARTING_NUMBER,:new.LPN_SUFFIX,:new.MAINTAIN_FIFO_QTY_STACK_TYPE,:new.MAINT_ORGANIZATION_ID,:new.MASTER_ORGANIZATION_ID,:new.MATERIAL_ACCOUNT,:new.MATERIAL_OVERHEAD_ACCOUNT,:new.MATL_INTERORG_TRANSFER_CODE,:new.MATL_OVHD_ABSORPTION_ACCT,:new.MAT_OVHD_COST_TYPE_ID,:new.MAX_CLUSTERS_ALLOWED,:new.MO_APPROVAL_TIMEOUT_ACTION,:new.MO_PICK_CONFIRM_REQUIRED,:new.MO_SOURCE_REQUIRED,:new.NEGATIVE_INV_RECEIPT_CODE,:new.ORGANIZATION_CODE,:new.ORG_MAX_VOLUME,:new.ORG_MAX_VOLUME_UOM_CODE,:new.ORG_MAX_WEIGHT,:new.ORG_MAX_WEIGHT_UOM_CODE,:new.OUTSIDE_PROCESSING_ACCOUNT,:new.OVERHEAD_ACCOUNT,:new.OVPK_TRANSFER_ORDERS_ENABLED,:new.PARENT_CHILD_GENERATION_FLAG,:new.PM_COST_COLLECTION_ENABLED,:new.PREGEN_PUTAWAY_TASKS_FLAG,:new.PRIMARY_COST_METHOD,:new.PRIORITIZE_WIP_JOBS,:new.PROCESS_ENABLED_FLAG,:new.PROCESS_ORGN_CODE,:new.PROGRAM_APPLICATION_ID,:new.PROGRAM_ID,:new.PROGRAM_UPDATE_DATE,:new.PROJECT_CONTROL_LEVEL,:new.PROJECT_COST_ACCOUNT,:new.PROJECT_REFERENCE_ENABLED,:new.PURCHASE_PRICE_VAR_ACCOUNT,:new.QA_SKIPPING_INSP_FLAG,:new.REGENERATION_INTERVAL,:new.REQUEST_ID,:new.RESOURCE_ACCOUNT,:new.RFID_VERIF_PCNT_THRESHOLD,:new.RULES_OVERRIDE_LOT_RESERVATION,:new.SALES_ACCOUNT,:new.SERIAL_NUMBER_GENERATION,:new.SERIAL_NUMBER_TYPE,:new.SKIP_TASK_WAITING_MINUTES,:new.SOURCE_ORGANIZATION_ID,:new.SOURCE_SUBINVENTORY,:new.SOURCE_TYPE,:new.STARTING_REVISION,:new.START_AUTO_SERIAL_NUMBER,:new.STOCK_LOCATOR_CONTROL_CODE,:new.TIMEZONE_ID,:new.TOTAL_LPN_LENGTH,:new.TRADING_PARTNER_ORG_FLAG,:new.TXN_APPROVAL_TIMEOUT_PERIOD,:new.UCC_128_SUFFIX_FLAG,:new.WCS_ENABLED,:new.WIP_OVERPICK_ENABLED,:new.WMS_ENABLED_FLAG,:new.WSM_ENABLED_FLAG,:new.YARD_MANAGEMENT_ENABLED_FLAG);END IF;END;

/
ALTER TRIGGER "APPS"."MTL_PARAMETERS_AI" ENABLE;
