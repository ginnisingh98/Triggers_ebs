--------------------------------------------------------
--  DDL for Trigger PA_TRANSACTION_INTERFACE_T3
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PA_TRANSACTION_INTERFACE_T3" 
/* $Header: PAXTRXT3.pls 120.4 2005/12/07 16:07:41 aaggarwa noship $ */
  BEFORE UPDATE OF
         TRANSACTION_SOURCE  ,
         BATCH_NAME ,
         EXPENDITURE_ENDING_DATE ,
         EMPLOYEE_NUMBER ,
         ORGANIZATION_NAME ,
         EXPENDITURE_ITEM_DATE ,
         PROJECT_NUMBER ,
         TASK_NUMBER ,
         EXPENDITURE_TYPE ,
         NON_LABOR_RESOURCE ,
         NON_LABOR_RESOURCE_ORG_NAME ,
         QUANTITY ,
         RAW_COST ,
         EXPENDITURE_COMMENT ,
         ORIG_TRANSACTION_REFERENCE ,
         ATTRIBUTE_CATEGORY ,
         ATTRIBUTE1 ,
         ATTRIBUTE2 ,
         ATTRIBUTE3 ,
         ATTRIBUTE4 ,
         ATTRIBUTE5 ,
         ATTRIBUTE6 ,
         ATTRIBUTE7 ,
         ATTRIBUTE8 ,
         ATTRIBUTE9 ,
         ATTRIBUTE10 ,
         RAW_COST_RATE ,
         UNMATCHED_NEGATIVE_TXN_FLAG ,
         DR_CODE_COMBINATION_ID ,
         CR_CODE_COMBINATION_ID ,
         CDL_SYSTEM_REFERENCE1 ,
         CDL_SYSTEM_REFERENCE2 ,
         CDL_SYSTEM_REFERENCE3 ,
         GL_DATE ,
         BURDENED_COST ,
         BURDENED_COST_RATE ,
         SYSTEM_LINKAGE ,
         USER_TRANSACTION_SOURCE ,
  	 RECEIPT_CURRENCY_AMOUNT,
	 RECEIPT_CURRENCY_CODE,
	 RECEIPT_EXCHANGE_RATE,
	 DENOM_CURRENCY_CODE,
	 DENOM_RAW_COST,
	 DENOM_BURDENED_COST,
	 ACCT_RATE_DATE,
	 ACCT_RATE_TYPE,
	 ACCT_EXCHANGE_RATE,
	 ACCT_RAW_COST,
	 ACCT_BURDENED_COST,
	 ACCT_EXCHANGE_ROUNDING_LIMIT,
	 PROJECT_CURRENCY_CODE,
	 PROJECT_RATE_DATE,
	 PROJECT_RATE_TYPE,
	 PROJECT_EXCHANGE_RATE,
    -- Trx_import enhancement:
    -- Since these new columns are added
    -- into forms' folder blocks, we need
    -- to add them here
    ORIG_EXP_TXN_REFERENCE1,
    ORIG_USER_EXP_TXN_REFERENCE,
    VENDOR_NUMBER,
    ORIG_EXP_TXN_REFERENCE2,
    ORIG_EXP_TXN_REFERENCE3,
    OVERRIDE_TO_ORGANIZATION_NAME,
    -- PA-K: Added all missing and new columns
    REVERSED_ORIG_TXN_REFERENCE,
    BILLABLE_FLAG,
    PERSON_BUSINESS_GROUP_NAME,
    PROJFUNC_CURRENCY_CODE,
    PROJFUNC_COST_RATE_TYPE,
    PROJFUNC_COST_RATE_DATE,
    PROJFUNC_COST_EXCHANGE_RATE,
    PROJECT_RAW_COST,
    PROJECT_BURDENED_COST,
    ASSIGNMENT_NAME,
    WORK_TYPE_NAME,
    CDL_SYSTEM_REFERENCE4,
    ACCRUAL_FLAG,
    PROJECT_ID,
    TASK_ID,
    PERSON_ID,
    ORGANIZATION_ID,
    NON_LABOR_RESOURCE_ORG_ID ,
    VENDOR_ID,
    OVERRIDE_TO_ORGANIZATION_ID,
    ASSIGNMENT_ID,
    WORK_TYPE_ID,
    PERSON_BUSINESS_GROUP_ID,
--  PA.M cwk : Added the below columns
    Po_Number,
    Po_Header_Id,
    Po_Line_Num,
    Po_Line_Id,
    Person_Type,
    Po_Price_Type,
    Wip_Resource_Id,
    Inventory_Item_Id,
    Unit_Of_Measure,
    /* R12 AP Lines */
    cdl_system_reference5,
    FC_DOCUMENT_TYPE,
    ADJUSTED_EXPENDITURE_ITEM_ID,
    DOCUMENT_TYPE,
    DOCUMENT_DISTRIBUTION_TYPE,
    SI_ASSETS_ADDITION_FLAG,
    ADJUSTED_TXN_INTERFACE_ID,
    NET_ZERO_ADJUSTMENT_FLAG,
    SC_XFER_CODE
    /* R12 AP Lines */
  ON "PA"."PA_TRANSACTION_INTERFACE_ALL"
  FOR EACH ROW

DECLARE
X_trx_src            varchar2(30) ;
x_system_linkage     VARCHAR2(3)  ;

-- If a valid trx_src is found
--    update rejection_code and status_code with null

  PROCEDURE get_trx_source
  AS
  BEGIN

     If (pa_txn_int_trig_ctl.G_UserTrxSrc3 = :NEW.user_transaction_source) then

        X_trx_src := pa_txn_int_trig_ctl.G_TrxSrc4;

     Else

     X_trx_src := NULL ;
     SELECT transaction_source
       INTO X_trx_src
       FROM pa_transaction_sources
      WHERE user_transaction_source = :NEW.user_transaction_source ;

        pa_txn_int_trig_ctl.G_TrxSrc4 := X_trx_src;
        pa_txn_int_trig_ctl.G_UserTrxSrc3 := :NEW.user_transaction_source;

     End If;

      :NEW.transaction_rejection_code := NULL ;
      :NEW.transaction_status_code    := 'P' ;
  EXCEPTION
    WHEN  NO_DATA_FOUND  THEN
         :NEW.transaction_rejection_code := 'INVALID_TRX_SOURCE' ;
         :NEW.transaction_status_code    := 'R' ;
         X_system_linkage := NULL ;
  END get_trx_source ;

-- If a valid system_linkage is found
--    update rejection_code and status_code with null

  PROCEDURE get_system_linkage
  AS
  BEGIN

     If pa_txn_int_trig_ctl.G_TrxSrc5 = :NEW.transaction_source Then

        X_system_linkage := pa_txn_int_trig_ctl.G_SysLink2;

     Else

     X_system_linkage := NULL ;
     SELECT system_linkage_function
       INTO X_system_linkage
       FROM pa_transaction_sources
      WHERE transaction_source = :NEW.transaction_source ;

        pa_txn_int_trig_ctl.G_SysLink2 := X_system_linkage;
        pa_txn_int_trig_ctl.G_TrxSrc5 := :NEW.transaction_source;

     End If;

      :NEW.transaction_rejection_code := NULL ;
      :NEW.transaction_status_code    := 'P' ;
  EXCEPTION
    WHEN  NO_DATA_FOUND  THEN
         :NEW.transaction_rejection_code := 'INVALID_TRX_SOURCE' ;
         :NEW.transaction_status_code    := 'R' ;
         X_system_linkage := NULL ;
  END get_system_linkage ;

BEGIN


-- If user_transaction_source is changed update the transaction_source ;

IF (:NEW.user_transaction_source is NOT NULL and
      (:old.user_transaction_source <>  :NEW.user_transaction_source)) THEN
     get_trx_source ;
     :NEW.transaction_source := nvl(X_trx_src,:NEW.transaction_source) ;
END IF ;

-- If system_linkage is null get system_linkage from transaction_source

IF :NEW.system_linkage is NULL THEN
      get_system_linkage;
      :NEW.system_linkage := X_system_linkage ;
END IF ;

-- If the system_linkage is changed then validate it

IF (nvl(:OLD.system_linkage,'0') <> :NEW.system_linkage) THEN
    IF pa_utils.GetETypeClassCode(:NEW.system_linkage) IS NULL  THEN
            :NEW.transaction_rejection_code := 'INVALID_EXP_TYPE_CLASS' ;
            :NEW.transaction_status_code    := 'R' ;
    END IF ;
END IF ;


INSERT into pa_txn_interface_audit (
                 TRANSACTION_SOURCE  ,
                 BATCH_NAME ,
                 EXPENDITURE_ENDING_DATE ,
                 EMPLOYEE_NUMBER ,
                 ORGANIZATION_NAME ,
                 EXPENDITURE_ITEM_DATE ,
                 PROJECT_NUMBER ,
                 TASK_NUMBER ,
                 EXPENDITURE_TYPE ,
                 NON_LABOR_RESOURCE ,
                 NON_LABOR_RESOURCE_ORG_NAME ,
                 QUANTITY ,
                 RAW_COST ,
                 EXPENDITURE_COMMENT ,
                 TRANSACTION_STATUS_CODE ,
                 TRANSACTION_REJECTION_CODE ,
                 ORIG_TRANSACTION_REFERENCE ,
                 ATTRIBUTE_CATEGORY ,
                 ATTRIBUTE1 ,
                 ATTRIBUTE2 ,
                 ATTRIBUTE3 ,
                 ATTRIBUTE4 ,
                 ATTRIBUTE5 ,
                 ATTRIBUTE6 ,
                 ATTRIBUTE7 ,
                 ATTRIBUTE8 ,
                 ATTRIBUTE9 ,
                 ATTRIBUTE10 ,
                 RAW_COST_RATE ,
                 UNMATCHED_NEGATIVE_TXN_FLAG ,
                 DR_CODE_COMBINATION_ID ,
                 CR_CODE_COMBINATION_ID ,
                 CDL_SYSTEM_REFERENCE1 ,
                 CDL_SYSTEM_REFERENCE2 ,
                 CDL_SYSTEM_REFERENCE3 ,
                 GL_DATE ,
                 BURDENED_COST ,
                 BURDENED_COST_RATE ,
                 SYSTEM_LINKAGE ,
                 TXN_INTERFACE_ID ,
                 USER_TRANSACTION_SOURCE ,
                 BEFORE_AFTER_FLAG ,
                 UPDATED_BY,
                 UPDATE_DATE,
    	         RECEIPT_CURRENCY_AMOUNT,
    	         RECEIPT_CURRENCY_CODE,
	         RECEIPT_EXCHANGE_RATE,
	         DENOM_CURRENCY_CODE,
	         DENOM_RAW_COST,
	         DENOM_BURDENED_COST,
	         ACCT_RATE_DATE,
	         ACCT_RATE_TYPE,
	         ACCT_EXCHANGE_RATE,
	         ACCT_RAW_COST,
	         ACCT_BURDENED_COST,
	         ACCT_EXCHANGE_ROUNDING_LIMIT,
	         PROJECT_CURRENCY_CODE,
	         PROJECT_RATE_DATE,
	         PROJECT_RATE_TYPE,
	         PROJECT_EXCHANGE_RATE,
                 ORIG_EXP_TXN_REFERENCE1,
                 ORIG_USER_EXP_TXN_REFERENCE,
                 VENDOR_NUMBER,
                 ORIG_EXP_TXN_REFERENCE2,
                 ORIG_EXP_TXN_REFERENCE3,
                 OVERRIDE_TO_ORGANIZATION_NAME,
                 -- PA-K: Added all missing and new columns
                 REVERSED_ORIG_TXN_REFERENCE,
                 BILLABLE_FLAG,
                 PERSON_BUSINESS_GROUP_NAME,
                 PROJFUNC_CURRENCY_CODE,
                 PROJFUNC_COST_RATE_TYPE,
                 PROJFUNC_COST_RATE_DATE,
                 PROJFUNC_COST_EXCHANGE_RATE,
                 PROJECT_RAW_COST,
                 PROJECT_BURDENED_COST,
                 ASSIGNMENT_NAME,
                 WORK_TYPE_NAME,
                 CDL_SYSTEM_REFERENCE4,
                 ACCRUAL_FLAG,
                 PROJECT_ID,
                 TASK_ID,
                 PERSON_ID,
                 ORGANIZATION_ID,
                 NON_LABOR_RESOURCE_ORG_ID ,
                 VENDOR_ID,
                 OVERRIDE_TO_ORGANIZATION_ID,
                 ASSIGNMENT_ID,
                 WORK_TYPE_ID,
                 PERSON_BUSINESS_GROUP_ID,
               --PA.M : Added the below columns
	         PO_NUMBER,
                 PO_HEADER_ID,
                 PO_LINE_NUM,
                 PO_LINE_ID,
                 PERSON_TYPE,
                 PO_PRICE_TYPE,
                 WIP_RESOURCE_ID,
                 INVENTORY_ITEM_ID,
                 UNIT_OF_MEASURE,
		 --REL12 AP Lines Uptake
		 CDL_SYSTEM_REFERENCE5,
		 FC_DOCUMENT_TYPE,
		 ADJUSTED_EXPENDITURE_ITEM_ID,
		 DOCUMENT_TYPE,
		 DOCUMENT_DISTRIBUTION_TYPE,
		 SI_ASSETS_ADDITION_FLAG,
		 -- REL12 AP Lines Uptake
                 ORG_ID, -- MOAC Changes
                 ADJUSTED_TXN_INTERFACE_ID,
                 NET_ZERO_ADJUSTMENT_FLAG,
                 SC_XFER_CODE
 )

VALUES (
         :OLD.transaction_source ,
         :OLD.batch_name ,
         :OLD.expenditure_ending_date ,
         :OLD.employee_number ,
         :OLD.organization_name ,
         :OLD.expenditure_item_date ,
         :OLD.project_number ,
         :OLD.task_number ,
         :OLD.expenditure_type ,
         :OLD.non_labor_resource ,
         :OLD.non_labor_resource_org_name ,
         :OLD.quantity ,
         :OLD.raw_cost ,
         :OLD.expenditure_comment ,
         :OLD.transaction_status_code ,
         :OLD.transaction_rejection_code ,
         :OLD.orig_transaction_reference ,
         :OLD.attribute_category ,
         :OLD.attribute1 ,
         :OLD.attribute2 ,
         :OLD.attribute3 ,
         :OLD.attribute4 ,
         :OLD.attribute5 ,
         :OLD.attribute6 ,
         :OLD.attribute7 ,
         :OLD.attribute8 ,
         :OLD.attribute9 ,
         :OLD.attribute10 ,
         :OLD.raw_cost_rate ,
         :OLD.unmatched_negative_txn_flag ,
         :OLD.dr_code_combination_id ,
         :OLD.cr_code_combination_id ,
         :OLD.cdl_system_reference1 ,
         :OLD.cdl_system_reference2 ,
         :OLD.cdl_system_reference3 ,
         :OLD.gl_date ,
         :OLD.burdened_cost ,
         :OLD.burdened_cost_rate ,
         :OLD.system_linkage ,
         :OLD.txn_interface_id	,
         :OLD.user_transaction_source,
         'B' ,
         nvl(:OLD.last_updated_by,-1),
          sysdate,
	:OLD.receipt_currency_amount,
	:OLD.receipt_currency_code,
	:OLD.receipt_exchange_rate,
	:OLD.denom_currency_code,
	:OLD.denom_raw_cost,
	:OLD.denom_burdened_cost,
	:OLD.acct_rate_date,
	:OLD.acct_rate_type,
	:OLD.acct_exchange_rate,
	:OLD.acct_raw_cost,
	:OLD.acct_burdened_cost,
	:OLD.acct_exchange_rounding_limit,
	:OLD.project_currency_code,
	:OLD.project_rate_date,
	:OLD.project_rate_type,
	:OLD.project_exchange_rate,
         -- Trx_import enhancement
        :OLD.ORIG_EXP_TXN_REFERENCE1,
        :OLD.ORIG_USER_EXP_TXN_REFERENCE,
        :OLD.VENDOR_NUMBER,
        :OLD.ORIG_EXP_TXN_REFERENCE2,
        :OLD.ORIG_EXP_TXN_REFERENCE3,
        :OLD.OVERRIDE_TO_ORGANIZATION_NAME,
        -- PA-K: Added all missing and new columns
        :OLD.REVERSED_ORIG_TXN_REFERENCE,
        :OLD.BILLABLE_FLAG,
        :OLD.PERSON_BUSINESS_GROUP_NAME,
        :OLD.PROJFUNC_CURRENCY_CODE,
        :OLD.PROJFUNC_COST_RATE_TYPE,
        :OLD.PROJFUNC_COST_RATE_DATE,
        :OLD.PROJFUNC_COST_EXCHANGE_RATE,
        :OLD.PROJECT_RAW_COST,
        :OLD.PROJECT_BURDENED_COST,
        :OLD.ASSIGNMENT_NAME,
        :OLD.WORK_TYPE_NAME,
        :OLD.CDL_SYSTEM_REFERENCE4,
        :OLD.ACCRUAL_FLAG,
        :OLD.PROJECT_ID,
        :OLD.TASK_ID,
        :OLD.PERSON_ID,
        :OLD.ORGANIZATION_ID,
        :OLD.NON_LABOR_RESOURCE_ORG_ID ,
        :OLD.VENDOR_ID,
        :OLD.OVERRIDE_TO_ORGANIZATION_ID,
        :OLD.ASSIGNMENT_ID,
        :OLD.WORK_TYPE_ID,
        :OLD.PERSON_BUSINESS_GROUP_ID,
      --PA.M : Added the below columns
        :OLD.PO_NUMBER,
        :OLD.PO_HEADER_ID,
        :OLD.PO_LINE_NUM,
        :OLD.PO_LINE_ID,
        :OLD.PERSON_TYPE,
        :OLD.PO_PRICE_TYPE,
        :OLD.WIP_RESOURCE_ID,
        :OLD.INVENTORY_ITEM_ID,
        :OLD.UNIT_OF_MEASURE,
	/* R12 AP lines uptake */
        :OLD.CDL_SYSTEM_REFERENCE5,
	:OLD.FC_DOCUMENT_TYPE,
	:OLD.ADJUSTED_EXPENDITURE_ITEM_ID,
	:OLD.DOCUMENT_TYPE,
	:OLD.DOCUMENT_DISTRIBUTION_TYPE,
	:OLD.SI_ASSETS_ADDITION_FLAG,
	/* R12 AP lines uptake */
	:OLD.ORG_ID, -- MOAC Changes.
        :OLD.ADJUSTED_TXN_INTERFACE_ID,
        :OLD.NET_ZERO_ADJUSTMENT_FLAG,
        :OLD.SC_XFER_CODE
   ) ;

INSERT INTO pa_txn_interface_audit (
                 TRANSACTION_SOURCE  ,
                 BATCH_NAME ,
                 EXPENDITURE_ENDING_DATE ,
                 EMPLOYEE_NUMBER ,
                 ORGANIZATION_NAME ,
                 EXPENDITURE_ITEM_DATE ,
                 PROJECT_NUMBER ,
                 TASK_NUMBER ,
                 EXPENDITURE_TYPE ,
                 NON_LABOR_RESOURCE ,
                 NON_LABOR_RESOURCE_ORG_NAME ,
                 QUANTITY ,
                 RAW_COST ,
                 EXPENDITURE_COMMENT ,
                 TRANSACTION_STATUS_CODE ,
                 TRANSACTION_REJECTION_CODE ,
                 ORIG_TRANSACTION_REFERENCE ,
                 ATTRIBUTE_CATEGORY ,
                 ATTRIBUTE1 ,
                 ATTRIBUTE2 ,
                 ATTRIBUTE3 ,
                 ATTRIBUTE4 ,
                 ATTRIBUTE5 ,
                 ATTRIBUTE6 ,
                 ATTRIBUTE7 ,
                 ATTRIBUTE8 ,
                 ATTRIBUTE9 ,
                 ATTRIBUTE10 ,
                 RAW_COST_RATE ,
                 UNMATCHED_NEGATIVE_TXN_FLAG ,
                 DR_CODE_COMBINATION_ID ,
                 CR_CODE_COMBINATION_ID ,
                 CDL_SYSTEM_REFERENCE1 ,
                 CDL_SYSTEM_REFERENCE2 ,
                 CDL_SYSTEM_REFERENCE3 ,
                 GL_DATE ,
                 BURDENED_COST ,
                 BURDENED_COST_RATE ,
                 SYSTEM_LINKAGE ,
                 TXN_INTERFACE_ID ,
                 USER_TRANSACTION_SOURCE ,
                 BEFORE_AFTER_FLAG,
                 UPDATED_BY,
                 UPDATE_DATE,
  	         RECEIPT_CURRENCY_AMOUNT,
	         RECEIPT_CURRENCY_CODE,
	         RECEIPT_EXCHANGE_RATE,
	         DENOM_CURRENCY_CODE,
	         DENOM_RAW_COST,
	         DENOM_BURDENED_COST,
	         ACCT_RATE_DATE,
	         ACCT_RATE_TYPE,
	         ACCT_EXCHANGE_RATE,
	         ACCT_RAW_COST,
	         ACCT_BURDENED_COST,
	         ACCT_EXCHANGE_ROUNDING_LIMIT,
	         PROJECT_CURRENCY_CODE,
	         PROJECT_RATE_DATE,
	         PROJECT_RATE_TYPE,
	         PROJECT_EXCHANGE_RATE,
                 -- Trx_import enhancement
                 ORIG_EXP_TXN_REFERENCE1,
                 ORIG_USER_EXP_TXN_REFERENCE,
                 VENDOR_NUMBER,
                 ORIG_EXP_TXN_REFERENCE2,
                 ORIG_EXP_TXN_REFERENCE3,
                 OVERRIDE_TO_ORGANIZATION_NAME ,
                 -- PA-K: Added all missing and new columns
                 REVERSED_ORIG_TXN_REFERENCE,
                 BILLABLE_FLAG,
                 PERSON_BUSINESS_GROUP_NAME,
                 PROJFUNC_CURRENCY_CODE,
                 PROJFUNC_COST_RATE_TYPE,
                 PROJFUNC_COST_RATE_DATE,
                 PROJFUNC_COST_EXCHANGE_RATE,
                 PROJECT_RAW_COST,
                 PROJECT_BURDENED_COST,
                 ASSIGNMENT_NAME,
                 WORK_TYPE_NAME,
                 CDL_SYSTEM_REFERENCE4,
                 ACCRUAL_FLAG,
                 PROJECT_ID,
                 TASK_ID,
                 PERSON_ID,
                 ORGANIZATION_ID,
                 NON_LABOR_RESOURCE_ORG_ID ,
                 VENDOR_ID,
                 OVERRIDE_TO_ORGANIZATION_ID,
                 ASSIGNMENT_ID,
                 WORK_TYPE_ID,
                 PERSON_BUSINESS_GROUP_ID,
               --PA.M : Added the below columns
	         PO_NUMBER,
                 PO_HEADER_ID,
                 PO_LINE_NUM,
                 PO_LINE_ID,
                 PERSON_TYPE,
                 PO_PRICE_TYPE,
                 WIP_RESOURCE_ID,
                 INVENTORY_ITEM_ID,
                 UNIT_OF_MEASURE,
		 CDL_SYSTEM_REFERENCE5,
		 FC_DOCUMENT_TYPE,
		 ADJUSTED_EXPENDITURE_ITEM_ID,
		 DOCUMENT_TYPE,
		 DOCUMENT_DISTRIBUTION_TYPE,
		 SI_ASSETS_ADDITION_FLAG,
		 ORG_ID,
                 ADJUSTED_TXN_INTERFACE_ID,
                 NET_ZERO_ADJUSTMENT_FLAG,
                 SC_XFER_CODE
 )

VALUES (
         :NEW.transaction_source ,
         :NEW.batch_name ,
         :NEW.expenditure_ending_date ,
         :NEW.employee_number ,
         :NEW.organization_name ,
         :NEW.expenditure_item_date ,
         :NEW.project_number ,
         :NEW.task_number ,
         :NEW.expenditure_type ,
         :NEW.non_labor_resource ,
         :NEW.non_labor_resource_org_name ,
         :NEW.quantity ,
         :NEW.raw_cost ,
         :NEW.expenditure_comment ,
         :NEW.transaction_status_code ,
         :NEW.transaction_rejection_code ,
         :NEW.orig_transaction_reference ,
         :NEW.attribute_category ,
         :NEW.attribute1 ,
         :NEW.attribute2 ,
         :NEW.attribute3 ,
         :NEW.attribute4 ,
         :NEW.attribute5 ,
         :NEW.attribute6 ,
         :NEW.attribute7 ,
         :NEW.attribute8 ,
         :NEW.attribute9 ,
         :NEW.attribute10 ,
         :NEW.raw_cost_rate ,
         :NEW.unmatched_negative_txn_flag ,
         :NEW.dr_code_combination_id ,
         :NEW.cr_code_combination_id ,
         :NEW.cdl_system_reference1 ,
         :NEW.cdl_system_reference2 ,
         :NEW.cdl_system_reference3 ,
         :NEW.gl_date ,
         :NEW.burdened_cost ,
         :NEW.burdened_cost_rate ,
         :NEW.system_linkage ,
         :NEW.txn_interface_id	,
         :NEW.user_transaction_source ,
         'A',
         nvl(:NEW.last_updated_by,-1) ,
          sysdate ,
	:NEW.receipt_currency_amount,
	:NEW.receipt_currency_code,
	:NEW.receipt_exchange_rate,
	:NEW.denom_currency_code,
	:NEW.denom_raw_cost,
	:NEW.denom_burdened_cost,
	:NEW.acct_rate_date,
	:NEW.acct_rate_type,
	:NEW.acct_exchange_rate,
	:NEW.acct_raw_cost,
	:NEW.acct_burdened_cost,
	:NEW.acct_exchange_rounding_limit,
	:NEW.project_currency_code,
	:NEW.project_rate_date,
	:NEW.project_rate_type,
	:NEW.project_exchange_rate,
        -- Trx_import enhancement
        :NEW.ORIG_EXP_TXN_REFERENCE1,
        :NEW.ORIG_USER_EXP_TXN_REFERENCE,
        :NEW.VENDOR_NUMBER,
        :NEW.ORIG_EXP_TXN_REFERENCE2,
        :NEW.ORIG_EXP_TXN_REFERENCE3,
        :NEW.OVERRIDE_TO_ORGANIZATION_NAME,
        -- PA-K: Added all missing and new columns
        :NEW.REVERSED_ORIG_TXN_REFERENCE,
        :NEW.BILLABLE_FLAG,
        :NEW.PERSON_BUSINESS_GROUP_NAME,
        :NEW.PROJFUNC_CURRENCY_CODE,
        :NEW.PROJFUNC_COST_RATE_TYPE,
        :NEW.PROJFUNC_COST_RATE_DATE,
        :NEW.PROJFUNC_COST_EXCHANGE_RATE,
        :NEW.PROJECT_RAW_COST,
        :NEW.PROJECT_BURDENED_COST,
        :NEW.ASSIGNMENT_NAME,
        :NEW.WORK_TYPE_NAME,
        :NEW.CDL_SYSTEM_REFERENCE4,
        :NEW.ACCRUAL_FLAG,
        :NEW.PROJECT_ID,
        :NEW.TASK_ID,
        :NEW.PERSON_ID,
        :NEW.ORGANIZATION_ID,
        :NEW.NON_LABOR_RESOURCE_ORG_ID ,
        :NEW.VENDOR_ID,
        :NEW.OVERRIDE_TO_ORGANIZATION_ID,
        :NEW.ASSIGNMENT_ID,
        :NEW.WORK_TYPE_ID,
        :NEW.PERSON_BUSINESS_GROUP_ID,
      --PA.M : Added the below columns
        :NEW.PO_NUMBER,
        :NEW.PO_HEADER_ID,
        :NEW.PO_LINE_NUM,
        :NEW.PO_LINE_ID,
        :NEW.PERSON_TYPE,
        :NEW.PO_PRICE_TYPE,
        :NEW.WIP_RESOURCE_ID,
        :NEW.INVENTORY_ITEM_ID,
        :NEW.UNIT_OF_MEASURE,
	/* R12 AP Lines uptake */
        :NEW.CDL_SYSTEM_REFERENCE5,
	:NEW.FC_DOCUMENT_TYPE,
	:NEW.ADJUSTED_EXPENDITURE_ITEM_ID,
	:NEW.DOCUMENT_TYPE,
	:NEW.DOCUMENT_DISTRIBUTION_TYPE,
	:NEW.SI_ASSETS_ADDITION_FLAG,
	/* R12 AP Lines uptake */
	:NEW.ORG_ID,
	-- MOAC Changes
        :NEW.ADJUSTED_TXN_INTERFACE_ID,
        :NEW.NET_ZERO_ADJUSTMENT_FLAG,
        :NEW.SC_XFER_CODE
 ) ;

   --Bug 4686388,4552319)
   pa_txn_int_trig_ctl.batch_name_tbl(pa_txn_int_trig_ctl.idx) := :OLD.batch_name;
   pa_txn_int_trig_ctl.expenditure_id(pa_txn_int_trig_ctl.idx) := :OLD.expenditure_id ;
   pa_txn_int_trig_ctl.idx := pa_txn_int_trig_ctl.idx+1 ;

END;


/
ALTER TRIGGER "APPS"."PA_TRANSACTION_INTERFACE_T3" ENABLE;
