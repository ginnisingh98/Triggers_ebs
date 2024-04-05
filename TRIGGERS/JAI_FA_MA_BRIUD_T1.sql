--------------------------------------------------------
--  DDL for Trigger JAI_FA_MA_BRIUD_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_FA_MA_BRIUD_T1" 
BEFORE INSERT OR UPDATE OR DELETE ON "FA"."FA_MASS_ADDITIONS"
FOR EACH ROW
DECLARE
  t_old_rec             FA_MASS_ADDITIONS%rowtype ;
  t_new_rec             FA_MASS_ADDITIONS%rowtype ;
  lv_return_message     VARCHAR2(2000);
  lv_return_code        VARCHAR2(100) ;
  le_error              EXCEPTION     ;
  lv_action             VARCHAR2(20)  ;

  /*
  || rchandan for bug#4454657 commented the above and added the following cursor
  */
  cursor c_ap_invoice_lines_all
  (p_invoice_id number, p_line_number  number) is
    select  line_type_lookup_code,
            po_distribution_id,
            rcv_transaction_id,
            set_of_books_id
    from    ap_invoice_lines_all /*rchandan for bug#4428980*/
    where   invoice_id = p_invoice_id
    and     line_number = p_line_number;

  r_ap_invoice_lines_all  c_ap_invoice_lines_all%ROWTYPE ;

  /*
  || Here initialising the pr_new record type in the inline procedure
  ||
  */

  PROCEDURE populate_new IS
  BEGIN

    t_new_rec.MASS_ADDITION_ID                         := :new.MASS_ADDITION_ID                              ;
    t_new_rec.ASSET_NUMBER                             := :new.ASSET_NUMBER                                  ;
    t_new_rec.TAG_NUMBER                               := :new.TAG_NUMBER                                    ;
    t_new_rec.DESCRIPTION                              := :new.DESCRIPTION                                   ;
    t_new_rec.ASSET_CATEGORY_ID                        := :new.ASSET_CATEGORY_ID                             ;
    t_new_rec.MANUFACTURER_NAME                        := :new.MANUFACTURER_NAME                             ;
    t_new_rec.SERIAL_NUMBER                            := :new.SERIAL_NUMBER                                 ;
    t_new_rec.MODEL_NUMBER                             := :new.MODEL_NUMBER                                  ;
    t_new_rec.BOOK_TYPE_CODE                           := :new.BOOK_TYPE_CODE                                ;
    t_new_rec.DATE_PLACED_IN_SERVICE                   := :new.DATE_PLACED_IN_SERVICE                        ;
    t_new_rec.FIXED_ASSETS_COST                        := :new.FIXED_ASSETS_COST                             ;
    t_new_rec.PAYABLES_UNITS                           := :new.PAYABLES_UNITS                                ;
    t_new_rec.FIXED_ASSETS_UNITS                       := :new.FIXED_ASSETS_UNITS                            ;
    t_new_rec.PAYABLES_CODE_COMBINATION_ID             := :new.PAYABLES_CODE_COMBINATION_ID                  ;
    t_new_rec.EXPENSE_CODE_COMBINATION_ID              := :new.EXPENSE_CODE_COMBINATION_ID                   ;
    t_new_rec.LOCATION_ID                              := :new.LOCATION_ID                                   ;
    t_new_rec.ASSIGNED_TO                              := :new.ASSIGNED_TO                                   ;
    t_new_rec.FEEDER_SYSTEM_NAME                       := :new.FEEDER_SYSTEM_NAME                            ;
    t_new_rec.CREATE_BATCH_DATE                        := :new.CREATE_BATCH_DATE                             ;
    t_new_rec.CREATE_BATCH_ID                          := :new.CREATE_BATCH_ID                               ;
    t_new_rec.LAST_UPDATE_DATE                         := :new.LAST_UPDATE_DATE                              ;
    t_new_rec.LAST_UPDATED_BY                          := :new.LAST_UPDATED_BY                               ;
    t_new_rec.REVIEWER_COMMENTS                        := :new.REVIEWER_COMMENTS                             ;
    t_new_rec.INVOICE_NUMBER                           := :new.INVOICE_NUMBER                                ;
    t_new_rec.VENDOR_NUMBER                            := :new.VENDOR_NUMBER                                 ;
    t_new_rec.PO_VENDOR_ID                             := :new.PO_VENDOR_ID                                  ;
    t_new_rec.PO_NUMBER                                := :new.PO_NUMBER                                     ;
    t_new_rec.POSTING_STATUS                           := :new.POSTING_STATUS                                ;
    t_new_rec.QUEUE_NAME                               := :new.QUEUE_NAME                                    ;
    t_new_rec.INVOICE_DATE                             := :new.INVOICE_DATE                                  ;
    t_new_rec.INVOICE_CREATED_BY                       := :new.INVOICE_CREATED_BY                            ;
    t_new_rec.INVOICE_UPDATED_BY                       := :new.INVOICE_UPDATED_BY                            ;
    t_new_rec.PAYABLES_COST                            := :new.PAYABLES_COST                                 ;
    t_new_rec.INVOICE_ID                               := :new.INVOICE_ID                                    ;
    t_new_rec.PAYABLES_BATCH_NAME                      := :new.PAYABLES_BATCH_NAME                           ;
    t_new_rec.DEPRECIATE_FLAG                          := :new.DEPRECIATE_FLAG                               ;
    t_new_rec.PARENT_MASS_ADDITION_ID                  := :new.PARENT_MASS_ADDITION_ID                       ;
    t_new_rec.PARENT_ASSET_ID                          := :new.PARENT_ASSET_ID                               ;
    t_new_rec.SPLIT_MERGED_CODE                        := :new.SPLIT_MERGED_CODE                             ;
    t_new_rec.AP_DISTRIBUTION_LINE_NUMBER              := :new.AP_DISTRIBUTION_LINE_NUMBER                   ;
    t_new_rec.POST_BATCH_ID                            := :new.POST_BATCH_ID                                 ;
    t_new_rec.ADD_TO_ASSET_ID                          := :new.ADD_TO_ASSET_ID                               ;
    t_new_rec.AMORTIZE_FLAG                            := :new.AMORTIZE_FLAG                                 ;
    t_new_rec.NEW_MASTER_FLAG                          := :new.NEW_MASTER_FLAG                               ;
    t_new_rec.ASSET_KEY_CCID                           := :new.ASSET_KEY_CCID                                ;
    t_new_rec.ASSET_TYPE                               := :new.ASSET_TYPE                                    ;
    t_new_rec.DEPRN_RESERVE                            := :new.DEPRN_RESERVE                                 ;
    t_new_rec.YTD_DEPRN                                := :new.YTD_DEPRN                                     ;
    t_new_rec.BEGINNING_NBV                            := :new.BEGINNING_NBV                                 ;
    t_new_rec.CREATED_BY                               := :new.CREATED_BY                                    ;
    t_new_rec.CREATION_DATE                            := :new.CREATION_DATE                                 ;
    t_new_rec.LAST_UPDATE_LOGIN                        := :new.LAST_UPDATE_LOGIN                             ;
    t_new_rec.SALVAGE_VALUE                            := :new.SALVAGE_VALUE                                 ;
    t_new_rec.ACCOUNTING_DATE                          := :new.ACCOUNTING_DATE                               ;
    t_new_rec.ATTRIBUTE1                               := :new.ATTRIBUTE1                                    ;
    t_new_rec.ATTRIBUTE2                               := :new.ATTRIBUTE2                                    ;
    t_new_rec.ATTRIBUTE3                               := :new.ATTRIBUTE3                                    ;
    t_new_rec.ATTRIBUTE4                               := :new.ATTRIBUTE4                                    ;
    t_new_rec.ATTRIBUTE5                               := :new.ATTRIBUTE5                                    ;
    t_new_rec.ATTRIBUTE6                               := :new.ATTRIBUTE6                                    ;
    t_new_rec.ATTRIBUTE7                               := :new.ATTRIBUTE7                                    ;
    t_new_rec.ATTRIBUTE8                               := :new.ATTRIBUTE8                                    ;
    t_new_rec.ATTRIBUTE9                               := :new.ATTRIBUTE9                                    ;
    t_new_rec.ATTRIBUTE10                              := :new.ATTRIBUTE10                                   ;
    t_new_rec.ATTRIBUTE11                              := :new.ATTRIBUTE11                                   ;
    t_new_rec.ATTRIBUTE12                              := :new.ATTRIBUTE12                                   ;
    t_new_rec.ATTRIBUTE13                              := :new.ATTRIBUTE13                                   ;
    t_new_rec.ATTRIBUTE14                              := :new.ATTRIBUTE14                                   ;
    t_new_rec.ATTRIBUTE15                              := :new.ATTRIBUTE15                                   ;
    t_new_rec.ATTRIBUTE_CATEGORY_CODE                  := :new.ATTRIBUTE_CATEGORY_CODE                       ;
    t_new_rec.FULLY_RSVD_REVALS_COUNTER                := :new.FULLY_RSVD_REVALS_COUNTER                     ;
    t_new_rec.MERGE_INVOICE_NUMBER                     := :new.MERGE_INVOICE_NUMBER                          ;
    t_new_rec.MERGE_VENDOR_NUMBER                      := :new.MERGE_VENDOR_NUMBER                           ;
    t_new_rec.PRODUCTION_CAPACITY                      := :new.PRODUCTION_CAPACITY                           ;
    t_new_rec.REVAL_AMORTIZATION_BASIS                 := :new.REVAL_AMORTIZATION_BASIS                      ;
    t_new_rec.REVAL_RESERVE                            := :new.REVAL_RESERVE                                 ;
    t_new_rec.UNIT_OF_MEASURE                          := :new.UNIT_OF_MEASURE                               ;
    t_new_rec.UNREVALUED_COST                          := :new.UNREVALUED_COST                               ;
    t_new_rec.YTD_REVAL_DEPRN_EXPENSE                  := :new.YTD_REVAL_DEPRN_EXPENSE                       ;
    t_new_rec.ATTRIBUTE16                              := :new.ATTRIBUTE16                                   ;
    t_new_rec.ATTRIBUTE17                              := :new.ATTRIBUTE17                                   ;
    t_new_rec.ATTRIBUTE18                              := :new.ATTRIBUTE18                                   ;
    t_new_rec.ATTRIBUTE19                              := :new.ATTRIBUTE19                                   ;
    t_new_rec.ATTRIBUTE20                              := :new.ATTRIBUTE20                                   ;
    t_new_rec.ATTRIBUTE21                              := :new.ATTRIBUTE21                                   ;
    t_new_rec.ATTRIBUTE22                              := :new.ATTRIBUTE22                                   ;
    t_new_rec.ATTRIBUTE23                              := :new.ATTRIBUTE23                                   ;
    t_new_rec.ATTRIBUTE24                              := :new.ATTRIBUTE24                                   ;
    t_new_rec.ATTRIBUTE25                              := :new.ATTRIBUTE25                                   ;
    t_new_rec.ATTRIBUTE26                              := :new.ATTRIBUTE26                                   ;
    t_new_rec.ATTRIBUTE27                              := :new.ATTRIBUTE27                                   ;
    t_new_rec.ATTRIBUTE28                              := :new.ATTRIBUTE28                                   ;
    t_new_rec.ATTRIBUTE29                              := :new.ATTRIBUTE29                                   ;
    t_new_rec.ATTRIBUTE30                              := :new.ATTRIBUTE30                                   ;
    t_new_rec.MERGED_CODE                              := :new.MERGED_CODE                                   ;
    t_new_rec.SPLIT_CODE                               := :new.SPLIT_CODE                                    ;
    t_new_rec.MERGE_PARENT_MASS_ADDITIONS_ID           := :new.MERGE_PARENT_MASS_ADDITIONS_ID                ;
    t_new_rec.SPLIT_PARENT_MASS_ADDITIONS_ID           := :new.SPLIT_PARENT_MASS_ADDITIONS_ID                ;
    t_new_rec.PROJECT_ASSET_LINE_ID                    := :new.PROJECT_ASSET_LINE_ID                         ;
    t_new_rec.PROJECT_ID                               := :new.PROJECT_ID                                    ;
    t_new_rec.TASK_ID                                  := :new.TASK_ID                                       ;
    t_new_rec.SUM_UNITS                                := :new.SUM_UNITS                                     ;
    t_new_rec.DIST_NAME                                := :new.DIST_NAME                                     ;
    t_new_rec.GLOBAL_ATTRIBUTE1                        := :new.GLOBAL_ATTRIBUTE1                             ;
    t_new_rec.GLOBAL_ATTRIBUTE2                        := :new.GLOBAL_ATTRIBUTE2                             ;
    t_new_rec.GLOBAL_ATTRIBUTE3                        := :new.GLOBAL_ATTRIBUTE3                             ;
    t_new_rec.GLOBAL_ATTRIBUTE4                        := :new.GLOBAL_ATTRIBUTE4                             ;
    t_new_rec.GLOBAL_ATTRIBUTE5                        := :new.GLOBAL_ATTRIBUTE5                             ;
    t_new_rec.GLOBAL_ATTRIBUTE6                        := :new.GLOBAL_ATTRIBUTE6                             ;
    t_new_rec.GLOBAL_ATTRIBUTE7                        := :new.GLOBAL_ATTRIBUTE7                             ;
    t_new_rec.GLOBAL_ATTRIBUTE8                        := :new.GLOBAL_ATTRIBUTE8                             ;
    t_new_rec.GLOBAL_ATTRIBUTE9                        := :new.GLOBAL_ATTRIBUTE9                             ;
    t_new_rec.GLOBAL_ATTRIBUTE10                       := :new.GLOBAL_ATTRIBUTE10                            ;
    t_new_rec.GLOBAL_ATTRIBUTE11                       := :new.GLOBAL_ATTRIBUTE11                            ;
    t_new_rec.GLOBAL_ATTRIBUTE12                       := :new.GLOBAL_ATTRIBUTE12                            ;
    t_new_rec.GLOBAL_ATTRIBUTE13                       := :new.GLOBAL_ATTRIBUTE13                            ;
    t_new_rec.GLOBAL_ATTRIBUTE14                       := :new.GLOBAL_ATTRIBUTE14                            ;
    t_new_rec.GLOBAL_ATTRIBUTE15                       := :new.GLOBAL_ATTRIBUTE15                            ;
    t_new_rec.GLOBAL_ATTRIBUTE16                       := :new.GLOBAL_ATTRIBUTE16                            ;
    t_new_rec.GLOBAL_ATTRIBUTE17                       := :new.GLOBAL_ATTRIBUTE17                            ;
    t_new_rec.GLOBAL_ATTRIBUTE18                       := :new.GLOBAL_ATTRIBUTE18                            ;
    t_new_rec.GLOBAL_ATTRIBUTE19                       := :new.GLOBAL_ATTRIBUTE19                            ;
    t_new_rec.GLOBAL_ATTRIBUTE20                       := :new.GLOBAL_ATTRIBUTE20                            ;
    t_new_rec.GLOBAL_ATTRIBUTE_CATEGORY                := :new.GLOBAL_ATTRIBUTE_CATEGORY                     ;
    t_new_rec.CONTEXT                                  := :new.CONTEXT                                       ;
    t_new_rec.INVENTORIAL                              := :new.INVENTORIAL                                   ;
    t_new_rec.SHORT_FISCAL_YEAR_FLAG                   := :new.SHORT_FISCAL_YEAR_FLAG                        ;
    t_new_rec.CONVERSION_DATE                          := :new.CONVERSION_DATE                               ;
    t_new_rec.ORIGINAL_DEPRN_START_DATE                := :new.ORIGINAL_DEPRN_START_DATE                     ;
    t_new_rec.GROUP_ASSET_ID                           := :new.GROUP_ASSET_ID                                ;
    t_new_rec.CUA_PARENT_HIERARCHY_ID                  := :new.CUA_PARENT_HIERARCHY_ID                       ;
    t_new_rec.UNITS_TO_ADJUST                          := :new.UNITS_TO_ADJUST                               ;
    t_new_rec.BONUS_YTD_DEPRN                          := :new.BONUS_YTD_DEPRN                               ;
    t_new_rec.BONUS_DEPRN_RESERVE                      := :new.BONUS_DEPRN_RESERVE                           ;
    t_new_rec.AMORTIZE_NBV_FLAG                        := :new.AMORTIZE_NBV_FLAG                             ;
    t_new_rec.AMORTIZATION_START_DATE                  := :new.AMORTIZATION_START_DATE                       ;
    t_new_rec.TRANSACTION_TYPE_CODE                    := :new.TRANSACTION_TYPE_CODE                         ;
    t_new_rec.TRANSACTION_DATE                         := :new.TRANSACTION_DATE                              ;
    t_new_rec.WARRANTY_ID                              := :new.WARRANTY_ID                                   ;
    t_new_rec.LEASE_ID                                 := :new.LEASE_ID                                      ;
    t_new_rec.LESSOR_ID                                := :new.LESSOR_ID                                     ;
    t_new_rec.PROPERTY_TYPE_CODE                       := :new.PROPERTY_TYPE_CODE                            ;
    t_new_rec.PROPERTY_1245_1250_CODE                  := :new.PROPERTY_1245_1250_CODE                       ;
    t_new_rec.IN_USE_FLAG                              := :new.IN_USE_FLAG                                   ;
    t_new_rec.OWNED_LEASED                             := :new.OWNED_LEASED                                  ;
    t_new_rec.NEW_USED                                 := :new.NEW_USED                                      ;
    t_new_rec.ASSET_ID                                 := :new.ASSET_ID                                      ;
    t_new_rec.MATERIAL_INDICATOR_FLAG                  := :new.MATERIAL_INDICATOR_FLAG                       ;
    t_new_rec.DEPRN_METHOD_CODE                        := :new.DEPRN_METHOD_CODE                             ;
    t_new_rec.LIFE_IN_MONTHS                           := :new.LIFE_IN_MONTHS                                ;
    t_new_rec.BASIC_RATE                               := :new.BASIC_RATE                                    ;
    t_new_rec.ADJUSTED_RATE                            := :new.ADJUSTED_RATE                                 ;
    t_new_rec.PRORATE_CONVENTION_CODE                  := :new.PRORATE_CONVENTION_CODE                       ;
    t_new_rec.BONUS_RULE                               := :new.BONUS_RULE                                    ;
    t_new_rec.SALVAGE_TYPE                             := :new.SALVAGE_TYPE                                  ;
    t_new_rec.PERCENT_SALVAGE_VALUE                    := :new.PERCENT_SALVAGE_VALUE                         ;
    t_new_rec.DEPRN_LIMIT_TYPE                         := :new.DEPRN_LIMIT_TYPE                              ;
    t_new_rec.ALLOWED_DEPRN_LIMIT                      := :new.ALLOWED_DEPRN_LIMIT                           ;
    t_new_rec.ALLOWED_DEPRN_LIMIT_AMOUNT               := :new.ALLOWED_DEPRN_LIMIT_AMOUNT                    ;
    t_new_rec.WARRANTY_NUMBER                          := :new.WARRANTY_NUMBER                               ;
    t_new_rec.INVOICE_LINE_NUMBER                      := :new.INVOICE_LINE_NUMBER                           ;
    t_new_rec.INVOICE_DISTRIBUTION_ID                  := :new.INVOICE_DISTRIBUTION_ID                       ;
    t_new_rec.PO_DISTRIBUTION_ID                       := :new.PO_DISTRIBUTION_ID                            ;
    t_new_rec.ASSET_KEY_SEGMENT1                       := :new.ASSET_KEY_SEGMENT1                            ;
    t_new_rec.ASSET_KEY_SEGMENT2                       := :new.ASSET_KEY_SEGMENT2                            ;
    t_new_rec.ASSET_KEY_SEGMENT3                       := :new.ASSET_KEY_SEGMENT3                            ;
    t_new_rec.ASSET_KEY_SEGMENT4                       := :new.ASSET_KEY_SEGMENT4                            ;
    t_new_rec.ASSET_KEY_SEGMENT5                       := :new.ASSET_KEY_SEGMENT5                            ;
    t_new_rec.ASSET_KEY_SEGMENT6                       := :new.ASSET_KEY_SEGMENT6                            ;
    t_new_rec.ASSET_KEY_SEGMENT7                       := :new.ASSET_KEY_SEGMENT7                            ;
    t_new_rec.ASSET_KEY_SEGMENT8                       := :new.ASSET_KEY_SEGMENT8                            ;
    t_new_rec.ASSET_KEY_SEGMENT9                       := :new.ASSET_KEY_SEGMENT9                            ;
    t_new_rec.ASSET_KEY_SEGMENT10                      := :new.ASSET_KEY_SEGMENT10                           ;
  END populate_new ;

  PROCEDURE populate_old IS
  BEGIN
    t_old_rec.MASS_ADDITION_ID                         := :old.MASS_ADDITION_ID                              ;
    t_old_rec.ASSET_NUMBER                             := :old.ASSET_NUMBER                                  ;
    t_old_rec.TAG_NUMBER                               := :old.TAG_NUMBER                                    ;
    t_old_rec.DESCRIPTION                              := :old.DESCRIPTION                                   ;
    t_old_rec.ASSET_CATEGORY_ID                        := :old.ASSET_CATEGORY_ID                             ;
    t_old_rec.MANUFACTURER_NAME                        := :old.MANUFACTURER_NAME                             ;
    t_old_rec.SERIAL_NUMBER                            := :old.SERIAL_NUMBER                                 ;
    t_old_rec.MODEL_NUMBER                             := :old.MODEL_NUMBER                                  ;
    t_old_rec.BOOK_TYPE_CODE                           := :old.BOOK_TYPE_CODE                                ;
    t_old_rec.DATE_PLACED_IN_SERVICE                   := :old.DATE_PLACED_IN_SERVICE                        ;
    t_old_rec.FIXED_ASSETS_COST                        := :old.FIXED_ASSETS_COST                             ;
    t_old_rec.PAYABLES_UNITS                           := :old.PAYABLES_UNITS                                ;
    t_old_rec.FIXED_ASSETS_UNITS                       := :old.FIXED_ASSETS_UNITS                            ;
    t_old_rec.PAYABLES_CODE_COMBINATION_ID             := :old.PAYABLES_CODE_COMBINATION_ID                  ;
    t_old_rec.EXPENSE_CODE_COMBINATION_ID              := :old.EXPENSE_CODE_COMBINATION_ID                   ;
    t_old_rec.LOCATION_ID                              := :old.LOCATION_ID                                   ;
    t_old_rec.ASSIGNED_TO                              := :old.ASSIGNED_TO                                   ;
    t_old_rec.FEEDER_SYSTEM_NAME                       := :old.FEEDER_SYSTEM_NAME                            ;
    t_old_rec.CREATE_BATCH_DATE                        := :old.CREATE_BATCH_DATE                             ;
    t_old_rec.CREATE_BATCH_ID                          := :old.CREATE_BATCH_ID                               ;
    t_old_rec.LAST_UPDATE_DATE                         := :old.LAST_UPDATE_DATE                              ;
    t_old_rec.LAST_UPDATED_BY                          := :old.LAST_UPDATED_BY                               ;
    t_old_rec.REVIEWER_COMMENTS                        := :old.REVIEWER_COMMENTS                             ;
    t_old_rec.INVOICE_NUMBER                           := :old.INVOICE_NUMBER                                ;
    t_old_rec.VENDOR_NUMBER                            := :old.VENDOR_NUMBER                                 ;
    t_old_rec.PO_VENDOR_ID                             := :old.PO_VENDOR_ID                                  ;
    t_old_rec.PO_NUMBER                                := :old.PO_NUMBER                                     ;
    t_old_rec.POSTING_STATUS                           := :old.POSTING_STATUS                                ;
    t_old_rec.QUEUE_NAME                               := :old.QUEUE_NAME                                    ;
    t_old_rec.INVOICE_DATE                             := :old.INVOICE_DATE                                  ;
    t_old_rec.INVOICE_CREATED_BY                       := :old.INVOICE_CREATED_BY                            ;
    t_old_rec.INVOICE_UPDATED_BY                       := :old.INVOICE_UPDATED_BY                            ;
    t_old_rec.PAYABLES_COST                            := :old.PAYABLES_COST                                 ;
    t_old_rec.INVOICE_ID                               := :old.INVOICE_ID                                    ;
    t_old_rec.PAYABLES_BATCH_NAME                      := :old.PAYABLES_BATCH_NAME                           ;
    t_old_rec.DEPRECIATE_FLAG                          := :old.DEPRECIATE_FLAG                               ;
    t_old_rec.PARENT_MASS_ADDITION_ID                  := :old.PARENT_MASS_ADDITION_ID                       ;
    t_old_rec.PARENT_ASSET_ID                          := :old.PARENT_ASSET_ID                               ;
    t_old_rec.SPLIT_MERGED_CODE                        := :old.SPLIT_MERGED_CODE                             ;
    t_old_rec.AP_DISTRIBUTION_LINE_NUMBER              := :old.AP_DISTRIBUTION_LINE_NUMBER                   ;
    t_old_rec.POST_BATCH_ID                            := :old.POST_BATCH_ID                                 ;
    t_old_rec.ADD_TO_ASSET_ID                          := :old.ADD_TO_ASSET_ID                               ;
    t_old_rec.AMORTIZE_FLAG                            := :old.AMORTIZE_FLAG                                 ;
    t_old_rec.NEW_MASTER_FLAG                          := :old.NEW_MASTER_FLAG                               ;
    t_old_rec.ASSET_KEY_CCID                           := :old.ASSET_KEY_CCID                                ;
    t_old_rec.ASSET_TYPE                               := :old.ASSET_TYPE                                    ;
    t_old_rec.DEPRN_RESERVE                            := :old.DEPRN_RESERVE                                 ;
    t_old_rec.YTD_DEPRN                                := :old.YTD_DEPRN                                     ;
    t_old_rec.BEGINNING_NBV                            := :old.BEGINNING_NBV                                 ;
    t_old_rec.CREATED_BY                               := :old.CREATED_BY                                    ;
    t_old_rec.CREATION_DATE                            := :old.CREATION_DATE                                 ;
    t_old_rec.LAST_UPDATE_LOGIN                        := :old.LAST_UPDATE_LOGIN                             ;
    t_old_rec.SALVAGE_VALUE                            := :old.SALVAGE_VALUE                                 ;
    t_old_rec.ACCOUNTING_DATE                          := :old.ACCOUNTING_DATE                               ;
    t_old_rec.ATTRIBUTE1                               := :old.ATTRIBUTE1                                    ;
    t_old_rec.ATTRIBUTE2                               := :old.ATTRIBUTE2                                    ;
    t_old_rec.ATTRIBUTE3                               := :old.ATTRIBUTE3                                    ;
    t_old_rec.ATTRIBUTE4                               := :old.ATTRIBUTE4                                    ;
    t_old_rec.ATTRIBUTE5                               := :old.ATTRIBUTE5                                    ;
    t_old_rec.ATTRIBUTE6                               := :old.ATTRIBUTE6                                    ;
    t_old_rec.ATTRIBUTE7                               := :old.ATTRIBUTE7                                    ;
    t_old_rec.ATTRIBUTE8                               := :old.ATTRIBUTE8                                    ;
    t_old_rec.ATTRIBUTE9                               := :old.ATTRIBUTE9                                    ;
    t_old_rec.ATTRIBUTE10                              := :old.ATTRIBUTE10                                   ;
    t_old_rec.ATTRIBUTE11                              := :old.ATTRIBUTE11                                   ;
    t_old_rec.ATTRIBUTE12                              := :old.ATTRIBUTE12                                   ;
    t_old_rec.ATTRIBUTE13                              := :old.ATTRIBUTE13                                   ;
    t_old_rec.ATTRIBUTE14                              := :old.ATTRIBUTE14                                   ;
    t_old_rec.ATTRIBUTE15                              := :old.ATTRIBUTE15                                   ;
    t_old_rec.ATTRIBUTE_CATEGORY_CODE                  := :old.ATTRIBUTE_CATEGORY_CODE                       ;
    t_old_rec.FULLY_RSVD_REVALS_COUNTER                := :old.FULLY_RSVD_REVALS_COUNTER                     ;
    t_old_rec.MERGE_INVOICE_NUMBER                     := :old.MERGE_INVOICE_NUMBER                          ;
    t_old_rec.MERGE_VENDOR_NUMBER                      := :old.MERGE_VENDOR_NUMBER                           ;
    t_old_rec.PRODUCTION_CAPACITY                      := :old.PRODUCTION_CAPACITY                           ;
    t_old_rec.REVAL_AMORTIZATION_BASIS                 := :old.REVAL_AMORTIZATION_BASIS                      ;
    t_old_rec.REVAL_RESERVE                            := :old.REVAL_RESERVE                                 ;
    t_old_rec.UNIT_OF_MEASURE                          := :old.UNIT_OF_MEASURE                               ;
    t_old_rec.UNREVALUED_COST                          := :old.UNREVALUED_COST                               ;
    t_old_rec.YTD_REVAL_DEPRN_EXPENSE                  := :old.YTD_REVAL_DEPRN_EXPENSE                       ;
    t_old_rec.ATTRIBUTE16                              := :old.ATTRIBUTE16                                   ;
    t_old_rec.ATTRIBUTE17                              := :old.ATTRIBUTE17                                   ;
    t_old_rec.ATTRIBUTE18                              := :old.ATTRIBUTE18                                   ;
    t_old_rec.ATTRIBUTE19                              := :old.ATTRIBUTE19                                   ;
    t_old_rec.ATTRIBUTE20                              := :old.ATTRIBUTE20                                   ;
    t_old_rec.ATTRIBUTE21                              := :old.ATTRIBUTE21                                   ;
    t_old_rec.ATTRIBUTE22                              := :old.ATTRIBUTE22                                   ;
    t_old_rec.ATTRIBUTE23                              := :old.ATTRIBUTE23                                   ;
    t_old_rec.ATTRIBUTE24                              := :old.ATTRIBUTE24                                   ;
    t_old_rec.ATTRIBUTE25                              := :old.ATTRIBUTE25                                   ;
    t_old_rec.ATTRIBUTE26                              := :old.ATTRIBUTE26                                   ;
    t_old_rec.ATTRIBUTE27                              := :old.ATTRIBUTE27                                   ;
    t_old_rec.ATTRIBUTE28                              := :old.ATTRIBUTE28                                   ;
    t_old_rec.ATTRIBUTE29                              := :old.ATTRIBUTE29                                   ;
    t_old_rec.ATTRIBUTE30                              := :old.ATTRIBUTE30                                   ;
    t_old_rec.MERGED_CODE                              := :old.MERGED_CODE                                   ;
    t_old_rec.SPLIT_CODE                               := :old.SPLIT_CODE                                    ;
    t_old_rec.MERGE_PARENT_MASS_ADDITIONS_ID           := :old.MERGE_PARENT_MASS_ADDITIONS_ID                ;
    t_old_rec.SPLIT_PARENT_MASS_ADDITIONS_ID           := :old.SPLIT_PARENT_MASS_ADDITIONS_ID                ;
    t_old_rec.PROJECT_ASSET_LINE_ID                    := :old.PROJECT_ASSET_LINE_ID                         ;
    t_old_rec.PROJECT_ID                               := :old.PROJECT_ID                                    ;
    t_old_rec.TASK_ID                                  := :old.TASK_ID                                       ;
    t_old_rec.SUM_UNITS                                := :old.SUM_UNITS                                     ;
    t_old_rec.DIST_NAME                                := :old.DIST_NAME                                     ;
    t_old_rec.GLOBAL_ATTRIBUTE1                        := :old.GLOBAL_ATTRIBUTE1                             ;
    t_old_rec.GLOBAL_ATTRIBUTE2                        := :old.GLOBAL_ATTRIBUTE2                             ;
    t_old_rec.GLOBAL_ATTRIBUTE3                        := :old.GLOBAL_ATTRIBUTE3                             ;
    t_old_rec.GLOBAL_ATTRIBUTE4                        := :old.GLOBAL_ATTRIBUTE4                             ;
    t_old_rec.GLOBAL_ATTRIBUTE5                        := :old.GLOBAL_ATTRIBUTE5                             ;
    t_old_rec.GLOBAL_ATTRIBUTE6                        := :old.GLOBAL_ATTRIBUTE6                             ;
    t_old_rec.GLOBAL_ATTRIBUTE7                        := :old.GLOBAL_ATTRIBUTE7                             ;
    t_old_rec.GLOBAL_ATTRIBUTE8                        := :old.GLOBAL_ATTRIBUTE8                             ;
    t_old_rec.GLOBAL_ATTRIBUTE9                        := :old.GLOBAL_ATTRIBUTE9                             ;
    t_old_rec.GLOBAL_ATTRIBUTE10                       := :old.GLOBAL_ATTRIBUTE10                            ;
    t_old_rec.GLOBAL_ATTRIBUTE11                       := :old.GLOBAL_ATTRIBUTE11                            ;
    t_old_rec.GLOBAL_ATTRIBUTE12                       := :old.GLOBAL_ATTRIBUTE12                            ;
    t_old_rec.GLOBAL_ATTRIBUTE13                       := :old.GLOBAL_ATTRIBUTE13                            ;
    t_old_rec.GLOBAL_ATTRIBUTE14                       := :old.GLOBAL_ATTRIBUTE14                            ;
    t_old_rec.GLOBAL_ATTRIBUTE15                       := :old.GLOBAL_ATTRIBUTE15                            ;
    t_old_rec.GLOBAL_ATTRIBUTE16                       := :old.GLOBAL_ATTRIBUTE16                            ;
    t_old_rec.GLOBAL_ATTRIBUTE17                       := :old.GLOBAL_ATTRIBUTE17                            ;
    t_old_rec.GLOBAL_ATTRIBUTE18                       := :old.GLOBAL_ATTRIBUTE18                            ;
    t_old_rec.GLOBAL_ATTRIBUTE19                       := :old.GLOBAL_ATTRIBUTE19                            ;
    t_old_rec.GLOBAL_ATTRIBUTE20                       := :old.GLOBAL_ATTRIBUTE20                            ;
    t_old_rec.GLOBAL_ATTRIBUTE_CATEGORY                := :old.GLOBAL_ATTRIBUTE_CATEGORY                     ;
    t_old_rec.CONTEXT                                  := :old.CONTEXT                                       ;
    t_old_rec.INVENTORIAL                              := :old.INVENTORIAL                                   ;
    t_old_rec.SHORT_FISCAL_YEAR_FLAG                   := :old.SHORT_FISCAL_YEAR_FLAG                        ;
    t_old_rec.CONVERSION_DATE                          := :old.CONVERSION_DATE                               ;
    t_old_rec.ORIGINAL_DEPRN_START_DATE                := :old.ORIGINAL_DEPRN_START_DATE                     ;
    t_old_rec.GROUP_ASSET_ID                           := :old.GROUP_ASSET_ID                                ;
    t_old_rec.CUA_PARENT_HIERARCHY_ID                  := :old.CUA_PARENT_HIERARCHY_ID                       ;
    t_old_rec.UNITS_TO_ADJUST                          := :old.UNITS_TO_ADJUST                               ;
    t_old_rec.BONUS_YTD_DEPRN                          := :old.BONUS_YTD_DEPRN                               ;
    t_old_rec.BONUS_DEPRN_RESERVE                      := :old.BONUS_DEPRN_RESERVE                           ;
    t_old_rec.AMORTIZE_NBV_FLAG                        := :old.AMORTIZE_NBV_FLAG                             ;
    t_old_rec.AMORTIZATION_START_DATE                  := :old.AMORTIZATION_START_DATE                       ;
    t_old_rec.TRANSACTION_TYPE_CODE                    := :old.TRANSACTION_TYPE_CODE                         ;
    t_old_rec.TRANSACTION_DATE                         := :old.TRANSACTION_DATE                              ;
    t_old_rec.WARRANTY_ID                              := :old.WARRANTY_ID                                   ;
    t_old_rec.LEASE_ID                                 := :old.LEASE_ID                                      ;
    t_old_rec.LESSOR_ID                                := :old.LESSOR_ID                                     ;
    t_old_rec.PROPERTY_TYPE_CODE                       := :old.PROPERTY_TYPE_CODE                            ;
    t_old_rec.PROPERTY_1245_1250_CODE                  := :old.PROPERTY_1245_1250_CODE                       ;
    t_old_rec.IN_USE_FLAG                              := :old.IN_USE_FLAG                                   ;
    t_old_rec.OWNED_LEASED                             := :old.OWNED_LEASED                                  ;
    t_old_rec.NEW_USED                                 := :old.NEW_USED                                      ;
    t_old_rec.ASSET_ID                                 := :old.ASSET_ID                                      ;
    t_old_rec.MATERIAL_INDICATOR_FLAG                  := :old.MATERIAL_INDICATOR_FLAG                       ;
    t_old_rec.DEPRN_METHOD_CODE                        := :old.DEPRN_METHOD_CODE                             ;
    t_old_rec.LIFE_IN_MONTHS                           := :old.LIFE_IN_MONTHS                                ;
    t_old_rec.BASIC_RATE                               := :old.BASIC_RATE                                    ;
    t_old_rec.ADJUSTED_RATE                            := :old.ADJUSTED_RATE                                 ;
    t_old_rec.PRORATE_CONVENTION_CODE                  := :old.PRORATE_CONVENTION_CODE                       ;
    t_old_rec.BONUS_RULE                               := :old.BONUS_RULE                                    ;
    t_old_rec.SALVAGE_TYPE                             := :old.SALVAGE_TYPE                                  ;
    t_old_rec.PERCENT_SALVAGE_VALUE                    := :old.PERCENT_SALVAGE_VALUE                         ;
    t_old_rec.DEPRN_LIMIT_TYPE                         := :old.DEPRN_LIMIT_TYPE                              ;
    t_old_rec.ALLOWED_DEPRN_LIMIT                      := :old.ALLOWED_DEPRN_LIMIT                           ;
    t_old_rec.ALLOWED_DEPRN_LIMIT_AMOUNT               := :old.ALLOWED_DEPRN_LIMIT_AMOUNT                    ;
    t_old_rec.WARRANTY_NUMBER                          := :old.WARRANTY_NUMBER                               ;
    t_old_rec.INVOICE_LINE_NUMBER                      := :old.INVOICE_LINE_NUMBER                           ;
    t_old_rec.INVOICE_DISTRIBUTION_ID                  := :old.INVOICE_DISTRIBUTION_ID                       ;
    t_old_rec.PO_DISTRIBUTION_ID                       := :old.PO_DISTRIBUTION_ID                            ;
    t_old_rec.ASSET_KEY_SEGMENT1                       := :old.ASSET_KEY_SEGMENT1                            ;
    t_old_rec.ASSET_KEY_SEGMENT2                       := :old.ASSET_KEY_SEGMENT2                            ;
    t_old_rec.ASSET_KEY_SEGMENT3                       := :old.ASSET_KEY_SEGMENT3                            ;
    t_old_rec.ASSET_KEY_SEGMENT4                       := :old.ASSET_KEY_SEGMENT4                            ;
    t_old_rec.ASSET_KEY_SEGMENT5                       := :old.ASSET_KEY_SEGMENT5                            ;
    t_old_rec.ASSET_KEY_SEGMENT6                       := :old.ASSET_KEY_SEGMENT6                            ;
    t_old_rec.ASSET_KEY_SEGMENT7                       := :old.ASSET_KEY_SEGMENT7                            ;
    t_old_rec.ASSET_KEY_SEGMENT8                       := :old.ASSET_KEY_SEGMENT8                            ;
    t_old_rec.ASSET_KEY_SEGMENT9                       := :old.ASSET_KEY_SEGMENT9                            ;
    t_old_rec.ASSET_KEY_SEGMENT10                      := :old.ASSET_KEY_SEGMENT10                           ;
  END populate_old ;

    /*
  || Populate new with t_new_rec returned values
  */

  PROCEDURE populate_t_new_rec IS
  BEGIN

    :new.MASS_ADDITION_ID                         := t_new_rec.MASS_ADDITION_ID                              ;
    :new.ASSET_NUMBER                             := t_new_rec.ASSET_NUMBER                                  ;
    :new.TAG_NUMBER                               := t_new_rec.TAG_NUMBER                                    ;
    :new.DESCRIPTION                              := t_new_rec.DESCRIPTION                                   ;
    :new.ASSET_CATEGORY_ID                        := t_new_rec.ASSET_CATEGORY_ID                             ;
    :new.MANUFACTURER_NAME                        := t_new_rec.MANUFACTURER_NAME                             ;
    :new.SERIAL_NUMBER                            := t_new_rec.SERIAL_NUMBER                                 ;
    :new.MODEL_NUMBER                             := t_new_rec.MODEL_NUMBER                                  ;
    :new.BOOK_TYPE_CODE                           := t_new_rec.BOOK_TYPE_CODE                                ;
    :new.DATE_PLACED_IN_SERVICE                   := t_new_rec.DATE_PLACED_IN_SERVICE                        ;
    :new.FIXED_ASSETS_COST                        := t_new_rec.FIXED_ASSETS_COST                             ;
    :new.PAYABLES_UNITS                           := t_new_rec.PAYABLES_UNITS                                ;
    :new.FIXED_ASSETS_UNITS                       := t_new_rec.FIXED_ASSETS_UNITS                            ;
    :new.PAYABLES_CODE_COMBINATION_ID             := t_new_rec.PAYABLES_CODE_COMBINATION_ID                  ;
    :new.EXPENSE_CODE_COMBINATION_ID              := t_new_rec.EXPENSE_CODE_COMBINATION_ID                   ;
    :new.LOCATION_ID                              := t_new_rec.LOCATION_ID                                   ;
    :new.ASSIGNED_TO                              := t_new_rec.ASSIGNED_TO                                   ;
    :new.FEEDER_SYSTEM_NAME                       := t_new_rec.FEEDER_SYSTEM_NAME                            ;
    :new.CREATE_BATCH_DATE                        := t_new_rec.CREATE_BATCH_DATE                             ;
    :new.CREATE_BATCH_ID                          := t_new_rec.CREATE_BATCH_ID                               ;
    :new.LAST_UPDATE_DATE                         := t_new_rec.LAST_UPDATE_DATE                              ;
    :new.LAST_UPDATED_BY                          := t_new_rec.LAST_UPDATED_BY                               ;
    :new.REVIEWER_COMMENTS                        := t_new_rec.REVIEWER_COMMENTS                             ;
    :new.INVOICE_NUMBER                           := t_new_rec.INVOICE_NUMBER                                ;
    :new.VENDOR_NUMBER                            := t_new_rec.VENDOR_NUMBER                                 ;
    :new.PO_VENDOR_ID                             := t_new_rec.PO_VENDOR_ID                                  ;
    :new.PO_NUMBER                                := t_new_rec.PO_NUMBER                                     ;
    :new.POSTING_STATUS                           := t_new_rec.POSTING_STATUS                                ;
    :new.QUEUE_NAME                               := t_new_rec.QUEUE_NAME                                    ;
    :new.INVOICE_DATE                             := t_new_rec.INVOICE_DATE                                  ;
    :new.INVOICE_CREATED_BY                       := t_new_rec.INVOICE_CREATED_BY                            ;
    :new.INVOICE_UPDATED_BY                       := t_new_rec.INVOICE_UPDATED_BY                            ;
    :new.PAYABLES_COST                            := t_new_rec.PAYABLES_COST                                 ;
    :new.INVOICE_ID                               := t_new_rec.INVOICE_ID                                    ;
    :new.PAYABLES_BATCH_NAME                      := t_new_rec.PAYABLES_BATCH_NAME                           ;
    :new.DEPRECIATE_FLAG                          := t_new_rec.DEPRECIATE_FLAG                               ;
    :new.PARENT_MASS_ADDITION_ID                  := t_new_rec.PARENT_MASS_ADDITION_ID                       ;
    :new.PARENT_ASSET_ID                          := t_new_rec.PARENT_ASSET_ID                               ;
    :new.SPLIT_MERGED_CODE                        := t_new_rec.SPLIT_MERGED_CODE                             ;
    :new.AP_DISTRIBUTION_LINE_NUMBER              := t_new_rec.AP_DISTRIBUTION_LINE_NUMBER                   ;
    :new.POST_BATCH_ID                            := t_new_rec.POST_BATCH_ID                                 ;
    :new.ADD_TO_ASSET_ID                          := t_new_rec.ADD_TO_ASSET_ID                               ;
    :new.AMORTIZE_FLAG                            := t_new_rec.AMORTIZE_FLAG                                 ;
    :new.NEW_MASTER_FLAG                          := t_new_rec.NEW_MASTER_FLAG                               ;
    :new.ASSET_KEY_CCID                           := t_new_rec.ASSET_KEY_CCID                                ;
    :new.ASSET_TYPE                               := t_new_rec.ASSET_TYPE                                    ;
    :new.DEPRN_RESERVE                            := t_new_rec.DEPRN_RESERVE                                 ;
    :new.YTD_DEPRN                                := t_new_rec.YTD_DEPRN                                     ;
    :new.BEGINNING_NBV                            := t_new_rec.BEGINNING_NBV                                 ;
    :new.CREATED_BY                               := t_new_rec.CREATED_BY                                    ;
    :new.CREATION_DATE                            := t_new_rec.CREATION_DATE                                 ;
    :new.LAST_UPDATE_LOGIN                        := t_new_rec.LAST_UPDATE_LOGIN                             ;
    :new.SALVAGE_VALUE                            := t_new_rec.SALVAGE_VALUE                                 ;
    :new.ACCOUNTING_DATE                          := t_new_rec.ACCOUNTING_DATE                               ;
    :new.ATTRIBUTE1                               := t_new_rec.ATTRIBUTE1                                    ;
    :new.ATTRIBUTE2                               := t_new_rec.ATTRIBUTE2                                    ;
    :new.ATTRIBUTE3                               := t_new_rec.ATTRIBUTE3                                    ;
    :new.ATTRIBUTE4                               := t_new_rec.ATTRIBUTE4                                    ;
    :new.ATTRIBUTE5                               := t_new_rec.ATTRIBUTE5                                    ;
    :new.ATTRIBUTE6                               := t_new_rec.ATTRIBUTE6                                    ;
    :new.ATTRIBUTE7                               := t_new_rec.ATTRIBUTE7                                    ;
    :new.ATTRIBUTE8                               := t_new_rec.ATTRIBUTE8                                    ;
    :new.ATTRIBUTE9                               := t_new_rec.ATTRIBUTE9                                    ;
    :new.ATTRIBUTE10                              := t_new_rec.ATTRIBUTE10                                   ;
    :new.ATTRIBUTE11                              := t_new_rec.ATTRIBUTE11                                   ;
    :new.ATTRIBUTE12                              := t_new_rec.ATTRIBUTE12                                   ;
    :new.ATTRIBUTE13                              := t_new_rec.ATTRIBUTE13                                   ;
    :new.ATTRIBUTE14                              := t_new_rec.ATTRIBUTE14                                   ;
    :new.ATTRIBUTE15                              := t_new_rec.ATTRIBUTE15                                   ;
    :new.ATTRIBUTE_CATEGORY_CODE                  := t_new_rec.ATTRIBUTE_CATEGORY_CODE                       ;
    :new.FULLY_RSVD_REVALS_COUNTER                := t_new_rec.FULLY_RSVD_REVALS_COUNTER                     ;
    :new.MERGE_INVOICE_NUMBER                     := t_new_rec.MERGE_INVOICE_NUMBER                          ;
    :new.MERGE_VENDOR_NUMBER                      := t_new_rec.MERGE_VENDOR_NUMBER                           ;
    :new.PRODUCTION_CAPACITY                      := t_new_rec.PRODUCTION_CAPACITY                           ;
    :new.REVAL_AMORTIZATION_BASIS                 := t_new_rec.REVAL_AMORTIZATION_BASIS                      ;
    :new.REVAL_RESERVE                            := t_new_rec.REVAL_RESERVE                                 ;
    :new.UNIT_OF_MEASURE                          := t_new_rec.UNIT_OF_MEASURE                               ;
    :new.UNREVALUED_COST                          := t_new_rec.UNREVALUED_COST                               ;
    :new.YTD_REVAL_DEPRN_EXPENSE                  := t_new_rec.YTD_REVAL_DEPRN_EXPENSE                       ;
    :new.ATTRIBUTE16                              := t_new_rec.ATTRIBUTE16                                   ;
    :new.ATTRIBUTE17                              := t_new_rec.ATTRIBUTE17                                   ;
    :new.ATTRIBUTE18                              := t_new_rec.ATTRIBUTE18                                   ;
    :new.ATTRIBUTE19                              := t_new_rec.ATTRIBUTE19                                   ;
    :new.ATTRIBUTE20                              := t_new_rec.ATTRIBUTE20                                   ;
    :new.ATTRIBUTE21                              := t_new_rec.ATTRIBUTE21                                   ;
    :new.ATTRIBUTE22                              := t_new_rec.ATTRIBUTE22                                   ;
    :new.ATTRIBUTE23                              := t_new_rec.ATTRIBUTE23                                   ;
    :new.ATTRIBUTE24                              := t_new_rec.ATTRIBUTE24                                   ;
    :new.ATTRIBUTE25                              := t_new_rec.ATTRIBUTE25                                   ;
    :new.ATTRIBUTE26                              := t_new_rec.ATTRIBUTE26                                   ;
    :new.ATTRIBUTE27                              := t_new_rec.ATTRIBUTE27                                   ;
    :new.ATTRIBUTE28                              := t_new_rec.ATTRIBUTE28                                   ;
    :new.ATTRIBUTE29                              := t_new_rec.ATTRIBUTE29                                   ;
    :new.ATTRIBUTE30                              := t_new_rec.ATTRIBUTE30                                   ;
    :new.MERGED_CODE                              := t_new_rec.MERGED_CODE                                   ;
    :new.SPLIT_CODE                               := t_new_rec.SPLIT_CODE                                    ;
    :new.MERGE_PARENT_MASS_ADDITIONS_ID           := t_new_rec.MERGE_PARENT_MASS_ADDITIONS_ID                ;
    :new.SPLIT_PARENT_MASS_ADDITIONS_ID           := t_new_rec.SPLIT_PARENT_MASS_ADDITIONS_ID                ;
    :new.PROJECT_ASSET_LINE_ID                    := t_new_rec.PROJECT_ASSET_LINE_ID                         ;
    :new.PROJECT_ID                               := t_new_rec.PROJECT_ID                                    ;
    :new.TASK_ID                                  := t_new_rec.TASK_ID                                       ;
    :new.SUM_UNITS                                := t_new_rec.SUM_UNITS                                     ;
    :new.DIST_NAME                                := t_new_rec.DIST_NAME                                     ;
    :new.GLOBAL_ATTRIBUTE1                        := t_new_rec.GLOBAL_ATTRIBUTE1                             ;
    :new.GLOBAL_ATTRIBUTE2                        := t_new_rec.GLOBAL_ATTRIBUTE2                             ;
    :new.GLOBAL_ATTRIBUTE3                        := t_new_rec.GLOBAL_ATTRIBUTE3                             ;
    :new.GLOBAL_ATTRIBUTE4                        := t_new_rec.GLOBAL_ATTRIBUTE4                             ;
    :new.GLOBAL_ATTRIBUTE5                        := t_new_rec.GLOBAL_ATTRIBUTE5                             ;
    :new.GLOBAL_ATTRIBUTE6                        := t_new_rec.GLOBAL_ATTRIBUTE6                             ;
    :new.GLOBAL_ATTRIBUTE7                        := t_new_rec.GLOBAL_ATTRIBUTE7                             ;
    :new.GLOBAL_ATTRIBUTE8                        := t_new_rec.GLOBAL_ATTRIBUTE8                             ;
    :new.GLOBAL_ATTRIBUTE9                        := t_new_rec.GLOBAL_ATTRIBUTE9                             ;
    :new.GLOBAL_ATTRIBUTE10                       := t_new_rec.GLOBAL_ATTRIBUTE10                            ;
    :new.GLOBAL_ATTRIBUTE11                       := t_new_rec.GLOBAL_ATTRIBUTE11                            ;
    :new.GLOBAL_ATTRIBUTE12                       := t_new_rec.GLOBAL_ATTRIBUTE12                            ;
    :new.GLOBAL_ATTRIBUTE13                       := t_new_rec.GLOBAL_ATTRIBUTE13                            ;
    :new.GLOBAL_ATTRIBUTE14                       := t_new_rec.GLOBAL_ATTRIBUTE14                            ;
    :new.GLOBAL_ATTRIBUTE15                       := t_new_rec.GLOBAL_ATTRIBUTE15                            ;
    :new.GLOBAL_ATTRIBUTE16                       := t_new_rec.GLOBAL_ATTRIBUTE16                            ;
    :new.GLOBAL_ATTRIBUTE17                       := t_new_rec.GLOBAL_ATTRIBUTE17                            ;
    :new.GLOBAL_ATTRIBUTE18                       := t_new_rec.GLOBAL_ATTRIBUTE18                            ;
    :new.GLOBAL_ATTRIBUTE19                       := t_new_rec.GLOBAL_ATTRIBUTE19                            ;
    :new.GLOBAL_ATTRIBUTE20                       := t_new_rec.GLOBAL_ATTRIBUTE20                            ;
    :new.GLOBAL_ATTRIBUTE_CATEGORY                := t_new_rec.GLOBAL_ATTRIBUTE_CATEGORY                     ;
    :new.CONTEXT                                  := t_new_rec.CONTEXT                                       ;
    :new.INVENTORIAL                              := t_new_rec.INVENTORIAL                                   ;
    :new.SHORT_FISCAL_YEAR_FLAG                   := t_new_rec.SHORT_FISCAL_YEAR_FLAG                        ;
    :new.CONVERSION_DATE                          := t_new_rec.CONVERSION_DATE                               ;
    :new.ORIGINAL_DEPRN_START_DATE                := t_new_rec.ORIGINAL_DEPRN_START_DATE                     ;
    :new.GROUP_ASSET_ID                           := t_new_rec.GROUP_ASSET_ID                                ;
    :new.CUA_PARENT_HIERARCHY_ID                  := t_new_rec.CUA_PARENT_HIERARCHY_ID                       ;
    :new.UNITS_TO_ADJUST                          := t_new_rec.UNITS_TO_ADJUST                               ;
    :new.BONUS_YTD_DEPRN                          := t_new_rec.BONUS_YTD_DEPRN                               ;
    :new.BONUS_DEPRN_RESERVE                      := t_new_rec.BONUS_DEPRN_RESERVE                           ;
    :new.AMORTIZE_NBV_FLAG                        := t_new_rec.AMORTIZE_NBV_FLAG                             ;
    :new.AMORTIZATION_START_DATE                  := t_new_rec.AMORTIZATION_START_DATE                       ;
    :new.TRANSACTION_TYPE_CODE                    := t_new_rec.TRANSACTION_TYPE_CODE                         ;
    :new.TRANSACTION_DATE                         := t_new_rec.TRANSACTION_DATE                              ;
    :new.WARRANTY_ID                              := t_new_rec.WARRANTY_ID                                   ;
    :new.LEASE_ID                                 := t_new_rec.LEASE_ID                                      ;
    :new.LESSOR_ID                                := t_new_rec.LESSOR_ID                                     ;
    :new.PROPERTY_TYPE_CODE                       := t_new_rec.PROPERTY_TYPE_CODE                            ;
    :new.PROPERTY_1245_1250_CODE                  := t_new_rec.PROPERTY_1245_1250_CODE                       ;
    :new.IN_USE_FLAG                              := t_new_rec.IN_USE_FLAG                                   ;
    :new.OWNED_LEASED                             := t_new_rec.OWNED_LEASED                                  ;
    :new.NEW_USED                                 := t_new_rec.NEW_USED                                      ;
    :new.ASSET_ID                                 := t_new_rec.ASSET_ID                                      ;
    :new.MATERIAL_INDICATOR_FLAG                  := t_new_rec.MATERIAL_INDICATOR_FLAG                       ;
    :new.DEPRN_METHOD_CODE                        := t_new_rec.DEPRN_METHOD_CODE                             ;
    :new.LIFE_IN_MONTHS                           := t_new_rec.LIFE_IN_MONTHS                                ;
    :new.BASIC_RATE                               := t_new_rec.BASIC_RATE                                    ;
    :new.ADJUSTED_RATE                            := t_new_rec.ADJUSTED_RATE                                 ;
    :new.PRORATE_CONVENTION_CODE                  := t_new_rec.PRORATE_CONVENTION_CODE                       ;
    :new.BONUS_RULE                               := t_new_rec.BONUS_RULE                                    ;
    :new.SALVAGE_TYPE                             := t_new_rec.SALVAGE_TYPE                                  ;
    :new.PERCENT_SALVAGE_VALUE                    := t_new_rec.PERCENT_SALVAGE_VALUE                         ;
    :new.DEPRN_LIMIT_TYPE                         := t_new_rec.DEPRN_LIMIT_TYPE                              ;
    :new.ALLOWED_DEPRN_LIMIT                      := t_new_rec.ALLOWED_DEPRN_LIMIT                           ;
    :new.ALLOWED_DEPRN_LIMIT_AMOUNT               := t_new_rec.ALLOWED_DEPRN_LIMIT_AMOUNT                    ;
    :new.WARRANTY_NUMBER                          := t_new_rec.WARRANTY_NUMBER                               ;
    :new.INVOICE_LINE_NUMBER                      := t_new_rec.INVOICE_LINE_NUMBER                           ;
    :new.INVOICE_DISTRIBUTION_ID                  := t_new_rec.INVOICE_DISTRIBUTION_ID                       ;
    :new.PO_DISTRIBUTION_ID                       := t_new_rec.PO_DISTRIBUTION_ID                            ;
    :new.ASSET_KEY_SEGMENT1                       := t_new_rec.ASSET_KEY_SEGMENT1                            ;
    :new.ASSET_KEY_SEGMENT2                       := t_new_rec.ASSET_KEY_SEGMENT2                            ;
    :new.ASSET_KEY_SEGMENT3                       := t_new_rec.ASSET_KEY_SEGMENT3                            ;
    :new.ASSET_KEY_SEGMENT4                       := t_new_rec.ASSET_KEY_SEGMENT4                            ;
    :new.ASSET_KEY_SEGMENT5                       := t_new_rec.ASSET_KEY_SEGMENT5                            ;
    :new.ASSET_KEY_SEGMENT6                       := t_new_rec.ASSET_KEY_SEGMENT6                            ;
    :new.ASSET_KEY_SEGMENT7                       := t_new_rec.ASSET_KEY_SEGMENT7                            ;
    :new.ASSET_KEY_SEGMENT8                       := t_new_rec.ASSET_KEY_SEGMENT8                            ;
    :new.ASSET_KEY_SEGMENT9                       := t_new_rec.ASSET_KEY_SEGMENT9                            ;
    :new.ASSET_KEY_SEGMENT10                      := t_new_rec.ASSET_KEY_SEGMENT10                           ;
  END populate_t_new_rec ;


BEGIN

  /*
  || assign the new values depending upon the triggering event.
  */
  IF UPDATING OR INSERTING THEN
     populate_new;
  END IF;


  /*
  || assign the old values depending upon the triggering event.
  */

  IF UPDATING OR DELETING THEN
     populate_old;
  END IF;


  open c_ap_invoice_lines_all
      (:new.invoice_id, :new.invoice_line_number);
  fetch c_ap_invoice_lines_all into r_ap_invoice_lines_all;
  close c_ap_invoice_lines_all;


  /*
  || make a call to the INR check package.
  */
  IF jai_cmn_utils_pkg.check_jai_exists(P_CALLING_OBJECT => 'JAI_FA_MA_ARIUD_T1', P_SET_OF_BOOKS_ID => r_ap_invoice_lines_all.set_of_books_id ) = FALSE THEN
       RETURN;
  END IF;

  /*
  || check for action in trigger and pass the same to the procedure
  */
  IF    INSERTING THEN
        lv_action := jai_constants.inserting ;
  ELSIF UPDATING THEN
        lv_action := jai_constants.updating ;
  ELSIF DELETING THEN
        lv_action := jai_constants.deleting ;
  END IF ;

  IF INSERTING THEN

      JAI_FA_MA_TRIGGER_PKG.BRI_T1 (
                        pr_old            =>  t_old_rec         ,
                        pr_new            =>  t_new_rec         ,
                        pv_action         =>  lv_action         ,
                        pv_return_code    =>  lv_return_code    ,
                        pv_return_message =>  lv_return_message
                      );

      IF lv_return_code <> jai_constants.successful   then
             RAISE le_error;
      END IF;

  END IF ;

  /*
  || assign the new record values depending upon the triggering event.
  */
  IF UPDATING OR INSERTING THEN
     populate_t_new_rec;
  END IF;

EXCEPTION

  WHEN le_error THEN

     app_exception.raise_exception (
                                     EXCEPTION_TYPE  => 'APP'  ,
                                     EXCEPTION_CODE  => -20110 ,
                                     EXCEPTION_TEXT  => lv_return_message
                                   );

  WHEN OTHERS THEN

      app_exception.raise_exception (
                                      EXCEPTION_TYPE  => 'APP',
                                      EXCEPTION_CODE  => -20110 ,
                                      EXCEPTION_TEXT  => 'Encountered the error in trigger JAI_FA_MA_BRIUD_T1' || substr(sqlerrm,1,1900)
                                    );

END JAI_FA_MA_BRIUD_T1 ;


/
ALTER TRIGGER "APPS"."JAI_FA_MA_BRIUD_T1" DISABLE;
