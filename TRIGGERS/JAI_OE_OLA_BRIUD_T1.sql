--------------------------------------------------------
--  DDL for Trigger JAI_OE_OLA_BRIUD_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_OE_OLA_BRIUD_T1" 
BEFORE INSERT OR UPDATE OR DELETE ON "ONT"."OE_ORDER_LINES_ALL"
FOR EACH ROW
DECLARE
  t_old_rec             OE_ORDER_LINES_ALL%rowtype ;
  t_new_rec             OE_ORDER_LINES_ALL%rowtype ;
  lv_return_message     VARCHAR2(2000);
  lv_return_code        VARCHAR2(100) ;
  le_error              EXCEPTION     ;
  lv_action             VARCHAR2(20)  ;

  /* Bug 5095812. Added by Lakshmi Gopalsami */
  l_func_curr_det jai_plsql_cache_pkg.func_curr_details;

  /*
  || Here initialising the pr_new record type in the inline procedure
  ||
  */

  PROCEDURE populate_new IS
  BEGIN

    t_new_rec.LINE_ID                                  := :new.LINE_ID                                       ;
    t_new_rec.ORG_ID                                   := :new.ORG_ID                                        ;
    t_new_rec.HEADER_ID                                := :new.HEADER_ID                                     ;
    t_new_rec.LINE_TYPE_ID                             := :new.LINE_TYPE_ID                                  ;
    t_new_rec.LINE_NUMBER                              := :new.LINE_NUMBER                                   ;
    t_new_rec.ORDERED_ITEM                             := :new.ORDERED_ITEM                                  ;
    t_new_rec.REQUEST_DATE                             := :new.REQUEST_DATE                                  ;
    t_new_rec.PROMISE_DATE                             := :new.PROMISE_DATE                                  ;
    t_new_rec.SCHEDULE_SHIP_DATE                       := :new.SCHEDULE_SHIP_DATE                            ;
    t_new_rec.ORDER_QUANTITY_UOM                       := :new.ORDER_QUANTITY_UOM                            ;
    t_new_rec.PRICING_QUANTITY                         := :new.PRICING_QUANTITY                              ;
    t_new_rec.PRICING_QUANTITY_UOM                     := :new.PRICING_QUANTITY_UOM                          ;
    t_new_rec.CANCELLED_QUANTITY                       := :new.CANCELLED_QUANTITY                            ;
    t_new_rec.SHIPPED_QUANTITY                         := :new.SHIPPED_QUANTITY                              ;
    t_new_rec.ORDERED_QUANTITY                         := :new.ORDERED_QUANTITY                              ;
    t_new_rec.FULFILLED_QUANTITY                       := :new.FULFILLED_QUANTITY                            ;
    t_new_rec.SHIPPING_QUANTITY                        := :new.SHIPPING_QUANTITY                             ;
    t_new_rec.SHIPPING_QUANTITY_UOM                    := :new.SHIPPING_QUANTITY_UOM                         ;
    t_new_rec.DELIVERY_LEAD_TIME                       := :new.DELIVERY_LEAD_TIME                            ;
    t_new_rec.TAX_EXEMPT_FLAG                          := :new.TAX_EXEMPT_FLAG                               ;
    t_new_rec.TAX_EXEMPT_NUMBER                        := :new.TAX_EXEMPT_NUMBER                             ;
    t_new_rec.TAX_EXEMPT_REASON_CODE                   := :new.TAX_EXEMPT_REASON_CODE                        ;
    t_new_rec.SHIP_FROM_ORG_ID                         := :new.SHIP_FROM_ORG_ID                              ;
    t_new_rec.SHIP_TO_ORG_ID                           := :new.SHIP_TO_ORG_ID                                ;
    t_new_rec.INVOICE_TO_ORG_ID                        := :new.INVOICE_TO_ORG_ID                             ;
    t_new_rec.DELIVER_TO_ORG_ID                        := :new.DELIVER_TO_ORG_ID                             ;
    t_new_rec.SHIP_TO_CONTACT_ID                       := :new.SHIP_TO_CONTACT_ID                            ;
    t_new_rec.DELIVER_TO_CONTACT_ID                    := :new.DELIVER_TO_CONTACT_ID                         ;
    t_new_rec.INVOICE_TO_CONTACT_ID                    := :new.INVOICE_TO_CONTACT_ID                         ;
    t_new_rec.INTMED_SHIP_TO_ORG_ID                    := :new.INTMED_SHIP_TO_ORG_ID                         ;
    t_new_rec.INTMED_SHIP_TO_CONTACT_ID                := :new.INTMED_SHIP_TO_CONTACT_ID                     ;
    t_new_rec.SOLD_FROM_ORG_ID                         := :new.SOLD_FROM_ORG_ID                              ;
    t_new_rec.SOLD_TO_ORG_ID                           := :new.SOLD_TO_ORG_ID                                ;
    t_new_rec.CUST_PO_NUMBER                           := :new.CUST_PO_NUMBER                                ;
    t_new_rec.SHIP_TOLERANCE_ABOVE                     := :new.SHIP_TOLERANCE_ABOVE                          ;
    t_new_rec.SHIP_TOLERANCE_BELOW                     := :new.SHIP_TOLERANCE_BELOW                          ;
    t_new_rec.DEMAND_BUCKET_TYPE_CODE                  := :new.DEMAND_BUCKET_TYPE_CODE                       ;
    t_new_rec.VEH_CUS_ITEM_CUM_KEY_ID                  := :new.VEH_CUS_ITEM_CUM_KEY_ID                       ;
    t_new_rec.RLA_SCHEDULE_TYPE_CODE                   := :new.RLA_SCHEDULE_TYPE_CODE                        ;
    t_new_rec.CUSTOMER_DOCK_CODE                       := :new.CUSTOMER_DOCK_CODE                            ;
    t_new_rec.CUSTOMER_JOB                             := :new.CUSTOMER_JOB                                  ;
    t_new_rec.CUSTOMER_PRODUCTION_LINE                 := :new.CUSTOMER_PRODUCTION_LINE                      ;
    t_new_rec.CUST_MODEL_SERIAL_NUMBER                 := :new.CUST_MODEL_SERIAL_NUMBER                      ;
    t_new_rec.PROJECT_ID                               := :new.PROJECT_ID                                    ;
    t_new_rec.TASK_ID                                  := :new.TASK_ID                                       ;
    t_new_rec.INVENTORY_ITEM_ID                        := :new.INVENTORY_ITEM_ID                             ;
    t_new_rec.TAX_DATE                                 := :new.TAX_DATE                                      ;
    t_new_rec.TAX_CODE                                 := :new.TAX_CODE                                      ;
    t_new_rec.TAX_RATE                                 := :new.TAX_RATE                                      ;
    t_new_rec.INVOICE_INTERFACE_STATUS_CODE            := :new.INVOICE_INTERFACE_STATUS_CODE                 ;
    t_new_rec.DEMAND_CLASS_CODE                        := :new.DEMAND_CLASS_CODE                             ;
    t_new_rec.PRICE_LIST_ID                            := :new.PRICE_LIST_ID                                 ;
    t_new_rec.PRICING_DATE                             := :new.PRICING_DATE                                  ;
    t_new_rec.SHIPMENT_NUMBER                          := :new.SHIPMENT_NUMBER                               ;
    t_new_rec.AGREEMENT_ID                             := :new.AGREEMENT_ID                                  ;
    t_new_rec.SHIPMENT_PRIORITY_CODE                   := :new.SHIPMENT_PRIORITY_CODE                        ;
    t_new_rec.SHIPPING_METHOD_CODE                     := :new.SHIPPING_METHOD_CODE                          ;
    t_new_rec.FREIGHT_CARRIER_CODE                     := :new.FREIGHT_CARRIER_CODE                          ;
    t_new_rec.FREIGHT_TERMS_CODE                       := :new.FREIGHT_TERMS_CODE                            ;
    t_new_rec.FOB_POINT_CODE                           := :new.FOB_POINT_CODE                                ;
    t_new_rec.TAX_POINT_CODE                           := :new.TAX_POINT_CODE                                ;
    t_new_rec.PAYMENT_TERM_ID                          := :new.PAYMENT_TERM_ID                               ;
    t_new_rec.INVOICING_RULE_ID                        := :new.INVOICING_RULE_ID                             ;
    t_new_rec.ACCOUNTING_RULE_ID                       := :new.ACCOUNTING_RULE_ID                            ;
    t_new_rec.SOURCE_DOCUMENT_TYPE_ID                  := :new.SOURCE_DOCUMENT_TYPE_ID                       ;
    t_new_rec.ORIG_SYS_DOCUMENT_REF                    := :new.ORIG_SYS_DOCUMENT_REF                         ;
    t_new_rec.SOURCE_DOCUMENT_ID                       := :new.SOURCE_DOCUMENT_ID                            ;
    t_new_rec.ORIG_SYS_LINE_REF                        := :new.ORIG_SYS_LINE_REF                             ;
    t_new_rec.SOURCE_DOCUMENT_LINE_ID                  := :new.SOURCE_DOCUMENT_LINE_ID                       ;
    t_new_rec.REFERENCE_LINE_ID                        := :new.REFERENCE_LINE_ID                             ;
    t_new_rec.REFERENCE_TYPE                           := :new.REFERENCE_TYPE                                ;
    t_new_rec.REFERENCE_HEADER_ID                      := :new.REFERENCE_HEADER_ID                           ;
    t_new_rec.ITEM_REVISION                            := :new.ITEM_REVISION                                 ;
    t_new_rec.UNIT_SELLING_PRICE                       := :new.UNIT_SELLING_PRICE                            ;
    t_new_rec.UNIT_LIST_PRICE                          := :new.UNIT_LIST_PRICE                               ;
    t_new_rec.TAX_VALUE                                := :new.TAX_VALUE                                     ;
    t_new_rec.CONTEXT                                  := :new.CONTEXT                                       ;
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
    t_new_rec.GLOBAL_ATTRIBUTE_CATEGORY                := :new.GLOBAL_ATTRIBUTE_CATEGORY                     ;
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
    t_new_rec.PRICING_CONTEXT                          := :new.PRICING_CONTEXT                               ;
    t_new_rec.PRICING_ATTRIBUTE1                       := :new.PRICING_ATTRIBUTE1                            ;
    t_new_rec.PRICING_ATTRIBUTE2                       := :new.PRICING_ATTRIBUTE2                            ;
    t_new_rec.PRICING_ATTRIBUTE3                       := :new.PRICING_ATTRIBUTE3                            ;
    t_new_rec.PRICING_ATTRIBUTE4                       := :new.PRICING_ATTRIBUTE4                            ;
    t_new_rec.PRICING_ATTRIBUTE5                       := :new.PRICING_ATTRIBUTE5                            ;
    t_new_rec.PRICING_ATTRIBUTE6                       := :new.PRICING_ATTRIBUTE6                            ;
    t_new_rec.PRICING_ATTRIBUTE7                       := :new.PRICING_ATTRIBUTE7                            ;
    t_new_rec.PRICING_ATTRIBUTE8                       := :new.PRICING_ATTRIBUTE8                            ;
    t_new_rec.PRICING_ATTRIBUTE9                       := :new.PRICING_ATTRIBUTE9                            ;
    t_new_rec.PRICING_ATTRIBUTE10                      := :new.PRICING_ATTRIBUTE10                           ;
    t_new_rec.INDUSTRY_CONTEXT                         := :new.INDUSTRY_CONTEXT                              ;
    t_new_rec.INDUSTRY_ATTRIBUTE1                      := :new.INDUSTRY_ATTRIBUTE1                           ;
    t_new_rec.INDUSTRY_ATTRIBUTE2                      := :new.INDUSTRY_ATTRIBUTE2                           ;
    t_new_rec.INDUSTRY_ATTRIBUTE3                      := :new.INDUSTRY_ATTRIBUTE3                           ;
    t_new_rec.INDUSTRY_ATTRIBUTE4                      := :new.INDUSTRY_ATTRIBUTE4                           ;
    t_new_rec.INDUSTRY_ATTRIBUTE5                      := :new.INDUSTRY_ATTRIBUTE5                           ;
    t_new_rec.INDUSTRY_ATTRIBUTE6                      := :new.INDUSTRY_ATTRIBUTE6                           ;
    t_new_rec.INDUSTRY_ATTRIBUTE7                      := :new.INDUSTRY_ATTRIBUTE7                           ;
    t_new_rec.INDUSTRY_ATTRIBUTE8                      := :new.INDUSTRY_ATTRIBUTE8                           ;
    t_new_rec.INDUSTRY_ATTRIBUTE9                      := :new.INDUSTRY_ATTRIBUTE9                           ;
    t_new_rec.INDUSTRY_ATTRIBUTE10                     := :new.INDUSTRY_ATTRIBUTE10                          ;
    t_new_rec.INDUSTRY_ATTRIBUTE11                     := :new.INDUSTRY_ATTRIBUTE11                          ;
    t_new_rec.INDUSTRY_ATTRIBUTE13                     := :new.INDUSTRY_ATTRIBUTE13                          ;
    t_new_rec.INDUSTRY_ATTRIBUTE12                     := :new.INDUSTRY_ATTRIBUTE12                          ;
    t_new_rec.INDUSTRY_ATTRIBUTE14                     := :new.INDUSTRY_ATTRIBUTE14                          ;
    t_new_rec.INDUSTRY_ATTRIBUTE15                     := :new.INDUSTRY_ATTRIBUTE15                          ;
    t_new_rec.INDUSTRY_ATTRIBUTE16                     := :new.INDUSTRY_ATTRIBUTE16                          ;
    t_new_rec.INDUSTRY_ATTRIBUTE17                     := :new.INDUSTRY_ATTRIBUTE17                          ;
    t_new_rec.INDUSTRY_ATTRIBUTE18                     := :new.INDUSTRY_ATTRIBUTE18                          ;
    t_new_rec.INDUSTRY_ATTRIBUTE19                     := :new.INDUSTRY_ATTRIBUTE19                          ;
    t_new_rec.INDUSTRY_ATTRIBUTE20                     := :new.INDUSTRY_ATTRIBUTE20                          ;
    t_new_rec.INDUSTRY_ATTRIBUTE21                     := :new.INDUSTRY_ATTRIBUTE21                          ;
    t_new_rec.INDUSTRY_ATTRIBUTE22                     := :new.INDUSTRY_ATTRIBUTE22                          ;
    t_new_rec.INDUSTRY_ATTRIBUTE23                     := :new.INDUSTRY_ATTRIBUTE23                          ;
    t_new_rec.INDUSTRY_ATTRIBUTE24                     := :new.INDUSTRY_ATTRIBUTE24                          ;
    t_new_rec.INDUSTRY_ATTRIBUTE25                     := :new.INDUSTRY_ATTRIBUTE25                          ;
    t_new_rec.INDUSTRY_ATTRIBUTE26                     := :new.INDUSTRY_ATTRIBUTE26                          ;
    t_new_rec.INDUSTRY_ATTRIBUTE27                     := :new.INDUSTRY_ATTRIBUTE27                          ;
    t_new_rec.INDUSTRY_ATTRIBUTE28                     := :new.INDUSTRY_ATTRIBUTE28                          ;
    t_new_rec.INDUSTRY_ATTRIBUTE29                     := :new.INDUSTRY_ATTRIBUTE29                          ;
    t_new_rec.INDUSTRY_ATTRIBUTE30                     := :new.INDUSTRY_ATTRIBUTE30                          ;
    t_new_rec.CREATION_DATE                            := :new.CREATION_DATE                                 ;
    t_new_rec.CREATED_BY                               := :new.CREATED_BY                                    ;
    t_new_rec.LAST_UPDATE_DATE                         := :new.LAST_UPDATE_DATE                              ;
    t_new_rec.LAST_UPDATED_BY                          := :new.LAST_UPDATED_BY                               ;
    t_new_rec.LAST_UPDATE_LOGIN                        := :new.LAST_UPDATE_LOGIN                             ;
    t_new_rec.PROGRAM_APPLICATION_ID                   := :new.PROGRAM_APPLICATION_ID                        ;
    t_new_rec.PROGRAM_ID                               := :new.PROGRAM_ID                                    ;
    t_new_rec.PROGRAM_UPDATE_DATE                      := :new.PROGRAM_UPDATE_DATE                           ;
    t_new_rec.REQUEST_ID                               := :new.REQUEST_ID                                    ;
    t_new_rec.TOP_MODEL_LINE_ID                        := :new.TOP_MODEL_LINE_ID                             ;
    t_new_rec.LINK_TO_LINE_ID                          := :new.LINK_TO_LINE_ID                               ;
    t_new_rec.COMPONENT_SEQUENCE_ID                    := :new.COMPONENT_SEQUENCE_ID                         ;
    t_new_rec.COMPONENT_CODE                           := :new.COMPONENT_CODE                                ;
    t_new_rec.CONFIG_DISPLAY_SEQUENCE                  := :new.CONFIG_DISPLAY_SEQUENCE                       ;
    t_new_rec.SORT_ORDER                               := :new.SORT_ORDER                                    ;
    t_new_rec.ITEM_TYPE_CODE                           := :new.ITEM_TYPE_CODE                                ;
    t_new_rec.OPTION_NUMBER                            := :new.OPTION_NUMBER                                 ;
    t_new_rec.OPTION_FLAG                              := :new.OPTION_FLAG                                   ;
    t_new_rec.DEP_PLAN_REQUIRED_FLAG                   := :new.DEP_PLAN_REQUIRED_FLAG                        ;
    t_new_rec.VISIBLE_DEMAND_FLAG                      := :new.VISIBLE_DEMAND_FLAG                           ;
    t_new_rec.LINE_CATEGORY_CODE                       := :new.LINE_CATEGORY_CODE                            ;
    t_new_rec.ACTUAL_SHIPMENT_DATE                     := :new.ACTUAL_SHIPMENT_DATE                          ;
    t_new_rec.CUSTOMER_TRX_LINE_ID                     := :new.CUSTOMER_TRX_LINE_ID                          ;
    t_new_rec.RETURN_CONTEXT                           := :new.RETURN_CONTEXT                                ;
    t_new_rec.RETURN_ATTRIBUTE1                        := :new.RETURN_ATTRIBUTE1                             ;
    t_new_rec.RETURN_ATTRIBUTE2                        := :new.RETURN_ATTRIBUTE2                             ;
    t_new_rec.RETURN_ATTRIBUTE3                        := :new.RETURN_ATTRIBUTE3                             ;
    t_new_rec.RETURN_ATTRIBUTE4                        := :new.RETURN_ATTRIBUTE4                             ;
    t_new_rec.RETURN_ATTRIBUTE5                        := :new.RETURN_ATTRIBUTE5                             ;
    t_new_rec.RETURN_ATTRIBUTE6                        := :new.RETURN_ATTRIBUTE6                             ;
    t_new_rec.RETURN_ATTRIBUTE7                        := :new.RETURN_ATTRIBUTE7                             ;
    t_new_rec.RETURN_ATTRIBUTE8                        := :new.RETURN_ATTRIBUTE8                             ;
    t_new_rec.RETURN_ATTRIBUTE9                        := :new.RETURN_ATTRIBUTE9                             ;
    t_new_rec.RETURN_ATTRIBUTE10                       := :new.RETURN_ATTRIBUTE10                            ;
    t_new_rec.RETURN_ATTRIBUTE11                       := :new.RETURN_ATTRIBUTE11                            ;
    t_new_rec.RETURN_ATTRIBUTE12                       := :new.RETURN_ATTRIBUTE12                            ;
    t_new_rec.RETURN_ATTRIBUTE13                       := :new.RETURN_ATTRIBUTE13                            ;
    t_new_rec.RETURN_ATTRIBUTE14                       := :new.RETURN_ATTRIBUTE14                            ;
    t_new_rec.RETURN_ATTRIBUTE15                       := :new.RETURN_ATTRIBUTE15                            ;
    t_new_rec.ACTUAL_ARRIVAL_DATE                      := :new.ACTUAL_ARRIVAL_DATE                           ;
    t_new_rec.ATO_LINE_ID                              := :new.ATO_LINE_ID                                   ;
    t_new_rec.AUTO_SELECTED_QUANTITY                   := :new.AUTO_SELECTED_QUANTITY                        ;
    t_new_rec.COMPONENT_NUMBER                         := :new.COMPONENT_NUMBER                              ;
    t_new_rec.EARLIEST_ACCEPTABLE_DATE                 := :new.EARLIEST_ACCEPTABLE_DATE                      ;
    t_new_rec.EXPLOSION_DATE                           := :new.EXPLOSION_DATE                                ;
    t_new_rec.LATEST_ACCEPTABLE_DATE                   := :new.LATEST_ACCEPTABLE_DATE                        ;
    t_new_rec.MODEL_GROUP_NUMBER                       := :new.MODEL_GROUP_NUMBER                            ;
    t_new_rec.SCHEDULE_ARRIVAL_DATE                    := :new.SCHEDULE_ARRIVAL_DATE                         ;
    t_new_rec.SHIP_MODEL_COMPLETE_FLAG                 := :new.SHIP_MODEL_COMPLETE_FLAG                      ;
    t_new_rec.SCHEDULE_STATUS_CODE                     := :new.SCHEDULE_STATUS_CODE                          ;
    t_new_rec.SOURCE_TYPE_CODE                         := :new.SOURCE_TYPE_CODE                              ;
    t_new_rec.CANCELLED_FLAG                           := :new.CANCELLED_FLAG                                ;
    t_new_rec.OPEN_FLAG                                := :new.OPEN_FLAG                                     ;
    t_new_rec.BOOKED_FLAG                              := :new.BOOKED_FLAG                                   ;
    t_new_rec.SALESREP_ID                              := :new.SALESREP_ID                                   ;
    t_new_rec.RETURN_REASON_CODE                       := :new.RETURN_REASON_CODE                            ;
    t_new_rec.ARRIVAL_SET_ID                           := :new.ARRIVAL_SET_ID                                ;
    t_new_rec.SHIP_SET_ID                              := :new.SHIP_SET_ID                                   ;
    t_new_rec.SPLIT_FROM_LINE_ID                       := :new.SPLIT_FROM_LINE_ID                            ;
    t_new_rec.CUST_PRODUCTION_SEQ_NUM                  := :new.CUST_PRODUCTION_SEQ_NUM                       ;
    t_new_rec.AUTHORIZED_TO_SHIP_FLAG                  := :new.AUTHORIZED_TO_SHIP_FLAG                       ;
    t_new_rec.OVER_SHIP_REASON_CODE                    := :new.OVER_SHIP_REASON_CODE                         ;
    t_new_rec.OVER_SHIP_RESOLVED_FLAG                  := :new.OVER_SHIP_RESOLVED_FLAG                       ;
    t_new_rec.ORDERED_ITEM_ID                          := :new.ORDERED_ITEM_ID                               ;
    t_new_rec.ITEM_IDENTIFIER_TYPE                     := :new.ITEM_IDENTIFIER_TYPE                          ;
    t_new_rec.CONFIGURATION_ID                         := :new.CONFIGURATION_ID                              ;
    t_new_rec.COMMITMENT_ID                            := :new.COMMITMENT_ID                                 ;
    t_new_rec.SHIPPING_INTERFACED_FLAG                 := :new.SHIPPING_INTERFACED_FLAG                      ;
    t_new_rec.CREDIT_INVOICE_LINE_ID                   := :new.CREDIT_INVOICE_LINE_ID                        ;
    t_new_rec.FIRST_ACK_CODE                           := :new.FIRST_ACK_CODE                                ;
    t_new_rec.FIRST_ACK_DATE                           := :new.FIRST_ACK_DATE                                ;
    t_new_rec.LAST_ACK_CODE                            := :new.LAST_ACK_CODE                                 ;
    t_new_rec.LAST_ACK_DATE                            := :new.LAST_ACK_DATE                                 ;
    t_new_rec.PLANNING_PRIORITY                        := :new.PLANNING_PRIORITY                             ;
    t_new_rec.ORDER_SOURCE_ID                          := :new.ORDER_SOURCE_ID                               ;
    t_new_rec.ORIG_SYS_SHIPMENT_REF                    := :new.ORIG_SYS_SHIPMENT_REF                         ;
    t_new_rec.CHANGE_SEQUENCE                          := :new.CHANGE_SEQUENCE                               ;
    t_new_rec.DROP_SHIP_FLAG                           := :new.DROP_SHIP_FLAG                                ;
    t_new_rec.CUSTOMER_LINE_NUMBER                     := :new.CUSTOMER_LINE_NUMBER                          ;
    t_new_rec.CUSTOMER_SHIPMENT_NUMBER                 := :new.CUSTOMER_SHIPMENT_NUMBER                      ;
    t_new_rec.CUSTOMER_ITEM_NET_PRICE                  := :new.CUSTOMER_ITEM_NET_PRICE                       ;
    t_new_rec.CUSTOMER_PAYMENT_TERM_ID                 := :new.CUSTOMER_PAYMENT_TERM_ID                      ;
    t_new_rec.FULFILLED_FLAG                           := :new.FULFILLED_FLAG                                ;
    t_new_rec.END_ITEM_UNIT_NUMBER                     := :new.END_ITEM_UNIT_NUMBER                          ;
    t_new_rec.CONFIG_HEADER_ID                         := :new.CONFIG_HEADER_ID                              ;
    t_new_rec.CONFIG_REV_NBR                           := :new.CONFIG_REV_NBR                                ;
    t_new_rec.MFG_COMPONENT_SEQUENCE_ID                := :new.MFG_COMPONENT_SEQUENCE_ID                     ;
    t_new_rec.SHIPPING_INSTRUCTIONS                    := :new.SHIPPING_INSTRUCTIONS                         ;
    t_new_rec.PACKING_INSTRUCTIONS                     := :new.PACKING_INSTRUCTIONS                          ;
    t_new_rec.INVOICED_QUANTITY                        := :new.INVOICED_QUANTITY                             ;
    t_new_rec.REFERENCE_CUSTOMER_TRX_LINE_ID           := :new.REFERENCE_CUSTOMER_TRX_LINE_ID                ;
    t_new_rec.SPLIT_BY                                 := :new.SPLIT_BY                                      ;
    t_new_rec.LINE_SET_ID                              := :new.LINE_SET_ID                                   ;
    t_new_rec.SERVICE_TXN_REASON_CODE                  := :new.SERVICE_TXN_REASON_CODE                       ;
    t_new_rec.SERVICE_TXN_COMMENTS                     := :new.SERVICE_TXN_COMMENTS                          ;
    t_new_rec.SERVICE_DURATION                         := :new.SERVICE_DURATION                              ;
    t_new_rec.SERVICE_START_DATE                       := :new.SERVICE_START_DATE                            ;
    t_new_rec.SERVICE_END_DATE                         := :new.SERVICE_END_DATE                              ;
    t_new_rec.SERVICE_COTERMINATE_FLAG                 := :new.SERVICE_COTERMINATE_FLAG                      ;
    t_new_rec.UNIT_LIST_PERCENT                        := :new.UNIT_LIST_PERCENT                             ;
    t_new_rec.UNIT_SELLING_PERCENT                     := :new.UNIT_SELLING_PERCENT                          ;
    t_new_rec.UNIT_PERCENT_BASE_PRICE                  := :new.UNIT_PERCENT_BASE_PRICE                       ;
    t_new_rec.SERVICE_NUMBER                           := :new.SERVICE_NUMBER                                ;
    t_new_rec.SERVICE_PERIOD                           := :new.SERVICE_PERIOD                                ;
    t_new_rec.SHIPPABLE_FLAG                           := :new.SHIPPABLE_FLAG                                ;
    t_new_rec.MODEL_REMNANT_FLAG                       := :new.MODEL_REMNANT_FLAG                            ;
    t_new_rec.RE_SOURCE_FLAG                           := :new.RE_SOURCE_FLAG                                ;
    t_new_rec.FLOW_STATUS_CODE                         := :new.FLOW_STATUS_CODE                              ;
    t_new_rec.TP_CONTEXT                               := :new.TP_CONTEXT                                    ;
    t_new_rec.TP_ATTRIBUTE1                            := :new.TP_ATTRIBUTE1                                 ;
    t_new_rec.TP_ATTRIBUTE2                            := :new.TP_ATTRIBUTE2                                 ;
    t_new_rec.TP_ATTRIBUTE3                            := :new.TP_ATTRIBUTE3                                 ;
    t_new_rec.TP_ATTRIBUTE4                            := :new.TP_ATTRIBUTE4                                 ;
    t_new_rec.TP_ATTRIBUTE5                            := :new.TP_ATTRIBUTE5                                 ;
    t_new_rec.TP_ATTRIBUTE6                            := :new.TP_ATTRIBUTE6                                 ;
    t_new_rec.TP_ATTRIBUTE7                            := :new.TP_ATTRIBUTE7                                 ;
    t_new_rec.TP_ATTRIBUTE8                            := :new.TP_ATTRIBUTE8                                 ;
    t_new_rec.TP_ATTRIBUTE9                            := :new.TP_ATTRIBUTE9                                 ;
    t_new_rec.TP_ATTRIBUTE10                           := :new.TP_ATTRIBUTE10                                ;
    t_new_rec.TP_ATTRIBUTE11                           := :new.TP_ATTRIBUTE11                                ;
    t_new_rec.TP_ATTRIBUTE12                           := :new.TP_ATTRIBUTE12                                ;
    t_new_rec.TP_ATTRIBUTE13                           := :new.TP_ATTRIBUTE13                                ;
    t_new_rec.TP_ATTRIBUTE14                           := :new.TP_ATTRIBUTE14                                ;
    t_new_rec.TP_ATTRIBUTE15                           := :new.TP_ATTRIBUTE15                                ;
    t_new_rec.FULFILLMENT_METHOD_CODE                  := :new.FULFILLMENT_METHOD_CODE                       ;
    t_new_rec.MARKETING_SOURCE_CODE_ID                 := :new.MARKETING_SOURCE_CODE_ID                      ;
    t_new_rec.SERVICE_REFERENCE_TYPE_CODE              := :new.SERVICE_REFERENCE_TYPE_CODE                   ;
    t_new_rec.SERVICE_REFERENCE_LINE_ID                := :new.SERVICE_REFERENCE_LINE_ID                     ;
    t_new_rec.SERVICE_REFERENCE_SYSTEM_ID              := :new.SERVICE_REFERENCE_SYSTEM_ID                   ;
    t_new_rec.CALCULATE_PRICE_FLAG                     := :new.CALCULATE_PRICE_FLAG                          ;
    t_new_rec.UPGRADED_FLAG                            := :new.UPGRADED_FLAG                                 ;
    t_new_rec.REVENUE_AMOUNT                           := :new.REVENUE_AMOUNT                                ;
    t_new_rec.FULFILLMENT_DATE                         := :new.FULFILLMENT_DATE                              ;
    t_new_rec.PREFERRED_GRADE                          := :new.PREFERRED_GRADE                               ;
    t_new_rec.ORDERED_QUANTITY2                        := :new.ORDERED_QUANTITY2                             ;
    t_new_rec.ORDERED_QUANTITY_UOM2                    := :new.ORDERED_QUANTITY_UOM2                         ;
    t_new_rec.SHIPPING_QUANTITY2                       := :new.SHIPPING_QUANTITY2                            ;
    t_new_rec.CANCELLED_QUANTITY2                      := :new.CANCELLED_QUANTITY2                           ;
    t_new_rec.SHIPPED_QUANTITY2                        := :new.SHIPPED_QUANTITY2                             ;
    t_new_rec.SHIPPING_QUANTITY_UOM2                   := :new.SHIPPING_QUANTITY_UOM2                        ;
    t_new_rec.FULFILLED_QUANTITY2                      := :new.FULFILLED_QUANTITY2                           ;
    t_new_rec.MFG_LEAD_TIME                            := :new.MFG_LEAD_TIME                                 ;
    t_new_rec.LOCK_CONTROL                             := :new.LOCK_CONTROL                                  ;
    t_new_rec.SUBINVENTORY                             := :new.SUBINVENTORY                                  ;
    t_new_rec.UNIT_LIST_PRICE_PER_PQTY                 := :new.UNIT_LIST_PRICE_PER_PQTY                      ;
    t_new_rec.UNIT_SELLING_PRICE_PER_PQTY              := :new.UNIT_SELLING_PRICE_PER_PQTY                   ;
    t_new_rec.PRICE_REQUEST_CODE                       := :new.PRICE_REQUEST_CODE                            ;
    t_new_rec.ORIGINAL_INVENTORY_ITEM_ID               := :new.ORIGINAL_INVENTORY_ITEM_ID                    ;
    t_new_rec.ORIGINAL_ORDERED_ITEM_ID                 := :new.ORIGINAL_ORDERED_ITEM_ID                      ;
    t_new_rec.ORIGINAL_ORDERED_ITEM                    := :new.ORIGINAL_ORDERED_ITEM                         ;
    t_new_rec.ORIGINAL_ITEM_IDENTIFIER_TYPE            := :new.ORIGINAL_ITEM_IDENTIFIER_TYPE                 ;
    t_new_rec.ITEM_SUBSTITUTION_TYPE_CODE              := :new.ITEM_SUBSTITUTION_TYPE_CODE                   ;
    t_new_rec.OVERRIDE_ATP_DATE_CODE                   := :new.OVERRIDE_ATP_DATE_CODE                        ;
    t_new_rec.LATE_DEMAND_PENALTY_FACTOR               := :new.LATE_DEMAND_PENALTY_FACTOR                    ;
    t_new_rec.ACCOUNTING_RULE_DURATION                 := :new.ACCOUNTING_RULE_DURATION                      ;
    t_new_rec.ATTRIBUTE16                              := :new.ATTRIBUTE16                                   ;
    t_new_rec.ATTRIBUTE17                              := :new.ATTRIBUTE17                                   ;
    t_new_rec.ATTRIBUTE18                              := :new.ATTRIBUTE18                                   ;
    t_new_rec.ATTRIBUTE19                              := :new.ATTRIBUTE19                                   ;
    t_new_rec.ATTRIBUTE20                              := :new.ATTRIBUTE20                                   ;
    t_new_rec.USER_ITEM_DESCRIPTION                    := :new.USER_ITEM_DESCRIPTION                         ;
    t_new_rec.UNIT_COST                                := :new.UNIT_COST                                     ;
    t_new_rec.ITEM_RELATIONSHIP_TYPE                   := :new.ITEM_RELATIONSHIP_TYPE                        ;
    t_new_rec.BLANKET_LINE_NUMBER                      := :new.BLANKET_LINE_NUMBER                           ;
    t_new_rec.BLANKET_NUMBER                           := :new.BLANKET_NUMBER                                ;
    t_new_rec.BLANKET_VERSION_NUMBER                   := :new.BLANKET_VERSION_NUMBER                        ;
    t_new_rec.SALES_DOCUMENT_TYPE_CODE                 := :new.SALES_DOCUMENT_TYPE_CODE                      ;
    t_new_rec.FIRM_DEMAND_FLAG                         := :new.FIRM_DEMAND_FLAG                              ;
    t_new_rec.EARLIEST_SHIP_DATE                       := :new.EARLIEST_SHIP_DATE                            ;
    t_new_rec.TRANSACTION_PHASE_CODE                   := :new.TRANSACTION_PHASE_CODE                        ;
    t_new_rec.SOURCE_DOCUMENT_VERSION_NUMBER           := :new.SOURCE_DOCUMENT_VERSION_NUMBER                ;
    t_new_rec.PAYMENT_TYPE_CODE                        := :new.PAYMENT_TYPE_CODE                             ;
    t_new_rec.MINISITE_ID                              := :new.MINISITE_ID                                   ;
    t_new_rec.END_CUSTOMER_ID                          := :new.END_CUSTOMER_ID                               ;
    t_new_rec.END_CUSTOMER_CONTACT_ID                  := :new.END_CUSTOMER_CONTACT_ID                       ;
    t_new_rec.END_CUSTOMER_SITE_USE_ID                 := :new.END_CUSTOMER_SITE_USE_ID                      ;
    t_new_rec.IB_OWNER                                 := :new.IB_OWNER                                      ;
    t_new_rec.IB_CURRENT_LOCATION                      := :new.IB_CURRENT_LOCATION                           ;
    t_new_rec.IB_INSTALLED_AT_LOCATION                 := :new.IB_INSTALLED_AT_LOCATION                      ;
    t_new_rec.RETROBILL_REQUEST_ID                     := :new.RETROBILL_REQUEST_ID                          ;
    t_new_rec.ORIGINAL_LIST_PRICE                      := :new.ORIGINAL_LIST_PRICE                           ;
    t_new_rec.SERVICE_CREDIT_ELIGIBLE_CODE             := :new.SERVICE_CREDIT_ELIGIBLE_CODE                  ;
    t_new_rec.ORDER_FIRMED_DATE                        := :new.ORDER_FIRMED_DATE                             ;
    t_new_rec.ACTUAL_FULFILLMENT_DATE                  := :new.ACTUAL_FULFILLMENT_DATE                       ;
    t_new_rec.CHARGE_PERIODICITY_CODE                  := :new.CHARGE_PERIODICITY_CODE                       ;
  END populate_new ;

  PROCEDURE populate_old IS
  BEGIN
    t_old_rec.LINE_ID                                  := :old.LINE_ID                                       ;
    t_old_rec.ORG_ID                                   := :old.ORG_ID                                        ;
    t_old_rec.HEADER_ID                                := :old.HEADER_ID                                     ;
    t_old_rec.LINE_TYPE_ID                             := :old.LINE_TYPE_ID                                  ;
    t_old_rec.LINE_NUMBER                              := :old.LINE_NUMBER                                   ;
    t_old_rec.ORDERED_ITEM                             := :old.ORDERED_ITEM                                  ;
    t_old_rec.REQUEST_DATE                             := :old.REQUEST_DATE                                  ;
    t_old_rec.PROMISE_DATE                             := :old.PROMISE_DATE                                  ;
    t_old_rec.SCHEDULE_SHIP_DATE                       := :old.SCHEDULE_SHIP_DATE                            ;
    t_old_rec.ORDER_QUANTITY_UOM                       := :old.ORDER_QUANTITY_UOM                            ;
    t_old_rec.PRICING_QUANTITY                         := :old.PRICING_QUANTITY                              ;
    t_old_rec.PRICING_QUANTITY_UOM                     := :old.PRICING_QUANTITY_UOM                          ;
    t_old_rec.CANCELLED_QUANTITY                       := :old.CANCELLED_QUANTITY                            ;
    t_old_rec.SHIPPED_QUANTITY                         := :old.SHIPPED_QUANTITY                              ;
    t_old_rec.ORDERED_QUANTITY                         := :old.ORDERED_QUANTITY                              ;
    t_old_rec.FULFILLED_QUANTITY                       := :old.FULFILLED_QUANTITY                            ;
    t_old_rec.SHIPPING_QUANTITY                        := :old.SHIPPING_QUANTITY                             ;
    t_old_rec.SHIPPING_QUANTITY_UOM                    := :old.SHIPPING_QUANTITY_UOM                         ;
    t_old_rec.DELIVERY_LEAD_TIME                       := :old.DELIVERY_LEAD_TIME                            ;
    t_old_rec.TAX_EXEMPT_FLAG                          := :old.TAX_EXEMPT_FLAG                               ;
    t_old_rec.TAX_EXEMPT_NUMBER                        := :old.TAX_EXEMPT_NUMBER                             ;
    t_old_rec.TAX_EXEMPT_REASON_CODE                   := :old.TAX_EXEMPT_REASON_CODE                        ;
    t_old_rec.SHIP_FROM_ORG_ID                         := :old.SHIP_FROM_ORG_ID                              ;
    t_old_rec.SHIP_TO_ORG_ID                           := :old.SHIP_TO_ORG_ID                                ;
    t_old_rec.INVOICE_TO_ORG_ID                        := :old.INVOICE_TO_ORG_ID                             ;
    t_old_rec.DELIVER_TO_ORG_ID                        := :old.DELIVER_TO_ORG_ID                             ;
    t_old_rec.SHIP_TO_CONTACT_ID                       := :old.SHIP_TO_CONTACT_ID                            ;
    t_old_rec.DELIVER_TO_CONTACT_ID                    := :old.DELIVER_TO_CONTACT_ID                         ;
    t_old_rec.INVOICE_TO_CONTACT_ID                    := :old.INVOICE_TO_CONTACT_ID                         ;
    t_old_rec.INTMED_SHIP_TO_ORG_ID                    := :old.INTMED_SHIP_TO_ORG_ID                         ;
    t_old_rec.INTMED_SHIP_TO_CONTACT_ID                := :old.INTMED_SHIP_TO_CONTACT_ID                     ;
    t_old_rec.SOLD_FROM_ORG_ID                         := :old.SOLD_FROM_ORG_ID                              ;
    t_old_rec.SOLD_TO_ORG_ID                           := :old.SOLD_TO_ORG_ID                                ;
    t_old_rec.CUST_PO_NUMBER                           := :old.CUST_PO_NUMBER                                ;
    t_old_rec.SHIP_TOLERANCE_ABOVE                     := :old.SHIP_TOLERANCE_ABOVE                          ;
    t_old_rec.SHIP_TOLERANCE_BELOW                     := :old.SHIP_TOLERANCE_BELOW                          ;
    t_old_rec.DEMAND_BUCKET_TYPE_CODE                  := :old.DEMAND_BUCKET_TYPE_CODE                       ;
    t_old_rec.VEH_CUS_ITEM_CUM_KEY_ID                  := :old.VEH_CUS_ITEM_CUM_KEY_ID                       ;
    t_old_rec.RLA_SCHEDULE_TYPE_CODE                   := :old.RLA_SCHEDULE_TYPE_CODE                        ;
    t_old_rec.CUSTOMER_DOCK_CODE                       := :old.CUSTOMER_DOCK_CODE                            ;
    t_old_rec.CUSTOMER_JOB                             := :old.CUSTOMER_JOB                                  ;
    t_old_rec.CUSTOMER_PRODUCTION_LINE                 := :old.CUSTOMER_PRODUCTION_LINE                      ;
    t_old_rec.CUST_MODEL_SERIAL_NUMBER                 := :old.CUST_MODEL_SERIAL_NUMBER                      ;
    t_old_rec.PROJECT_ID                               := :old.PROJECT_ID                                    ;
    t_old_rec.TASK_ID                                  := :old.TASK_ID                                       ;
    t_old_rec.INVENTORY_ITEM_ID                        := :old.INVENTORY_ITEM_ID                             ;
    t_old_rec.TAX_DATE                                 := :old.TAX_DATE                                      ;
    t_old_rec.TAX_CODE                                 := :old.TAX_CODE                                      ;
    t_old_rec.TAX_RATE                                 := :old.TAX_RATE                                      ;
    t_old_rec.INVOICE_INTERFACE_STATUS_CODE            := :old.INVOICE_INTERFACE_STATUS_CODE                 ;
    t_old_rec.DEMAND_CLASS_CODE                        := :old.DEMAND_CLASS_CODE                             ;
    t_old_rec.PRICE_LIST_ID                            := :old.PRICE_LIST_ID                                 ;
    t_old_rec.PRICING_DATE                             := :old.PRICING_DATE                                  ;
    t_old_rec.SHIPMENT_NUMBER                          := :old.SHIPMENT_NUMBER                               ;
    t_old_rec.AGREEMENT_ID                             := :old.AGREEMENT_ID                                  ;
    t_old_rec.SHIPMENT_PRIORITY_CODE                   := :old.SHIPMENT_PRIORITY_CODE                        ;
    t_old_rec.SHIPPING_METHOD_CODE                     := :old.SHIPPING_METHOD_CODE                          ;
    t_old_rec.FREIGHT_CARRIER_CODE                     := :old.FREIGHT_CARRIER_CODE                          ;
    t_old_rec.FREIGHT_TERMS_CODE                       := :old.FREIGHT_TERMS_CODE                            ;
    t_old_rec.FOB_POINT_CODE                           := :old.FOB_POINT_CODE                                ;
    t_old_rec.TAX_POINT_CODE                           := :old.TAX_POINT_CODE                                ;
    t_old_rec.PAYMENT_TERM_ID                          := :old.PAYMENT_TERM_ID                               ;
    t_old_rec.INVOICING_RULE_ID                        := :old.INVOICING_RULE_ID                             ;
    t_old_rec.ACCOUNTING_RULE_ID                       := :old.ACCOUNTING_RULE_ID                            ;
    t_old_rec.SOURCE_DOCUMENT_TYPE_ID                  := :old.SOURCE_DOCUMENT_TYPE_ID                       ;
    t_old_rec.ORIG_SYS_DOCUMENT_REF                    := :old.ORIG_SYS_DOCUMENT_REF                         ;
    t_old_rec.SOURCE_DOCUMENT_ID                       := :old.SOURCE_DOCUMENT_ID                            ;
    t_old_rec.ORIG_SYS_LINE_REF                        := :old.ORIG_SYS_LINE_REF                             ;
    t_old_rec.SOURCE_DOCUMENT_LINE_ID                  := :old.SOURCE_DOCUMENT_LINE_ID                       ;
    t_old_rec.REFERENCE_LINE_ID                        := :old.REFERENCE_LINE_ID                             ;
    t_old_rec.REFERENCE_TYPE                           := :old.REFERENCE_TYPE                                ;
    t_old_rec.REFERENCE_HEADER_ID                      := :old.REFERENCE_HEADER_ID                           ;
    t_old_rec.ITEM_REVISION                            := :old.ITEM_REVISION                                 ;
    t_old_rec.UNIT_SELLING_PRICE                       := :old.UNIT_SELLING_PRICE                            ;
    t_old_rec.UNIT_LIST_PRICE                          := :old.UNIT_LIST_PRICE                               ;
    t_old_rec.TAX_VALUE                                := :old.TAX_VALUE                                     ;
    t_old_rec.CONTEXT                                  := :old.CONTEXT                                       ;
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
    t_old_rec.GLOBAL_ATTRIBUTE_CATEGORY                := :old.GLOBAL_ATTRIBUTE_CATEGORY                     ;
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
    t_old_rec.PRICING_CONTEXT                          := :old.PRICING_CONTEXT                               ;
    t_old_rec.PRICING_ATTRIBUTE1                       := :old.PRICING_ATTRIBUTE1                            ;
    t_old_rec.PRICING_ATTRIBUTE2                       := :old.PRICING_ATTRIBUTE2                            ;
    t_old_rec.PRICING_ATTRIBUTE3                       := :old.PRICING_ATTRIBUTE3                            ;
    t_old_rec.PRICING_ATTRIBUTE4                       := :old.PRICING_ATTRIBUTE4                            ;
    t_old_rec.PRICING_ATTRIBUTE5                       := :old.PRICING_ATTRIBUTE5                            ;
    t_old_rec.PRICING_ATTRIBUTE6                       := :old.PRICING_ATTRIBUTE6                            ;
    t_old_rec.PRICING_ATTRIBUTE7                       := :old.PRICING_ATTRIBUTE7                            ;
    t_old_rec.PRICING_ATTRIBUTE8                       := :old.PRICING_ATTRIBUTE8                            ;
    t_old_rec.PRICING_ATTRIBUTE9                       := :old.PRICING_ATTRIBUTE9                            ;
    t_old_rec.PRICING_ATTRIBUTE10                      := :old.PRICING_ATTRIBUTE10                           ;
    t_old_rec.INDUSTRY_CONTEXT                         := :old.INDUSTRY_CONTEXT                              ;
    t_old_rec.INDUSTRY_ATTRIBUTE1                      := :old.INDUSTRY_ATTRIBUTE1                           ;
    t_old_rec.INDUSTRY_ATTRIBUTE2                      := :old.INDUSTRY_ATTRIBUTE2                           ;
    t_old_rec.INDUSTRY_ATTRIBUTE3                      := :old.INDUSTRY_ATTRIBUTE3                           ;
    t_old_rec.INDUSTRY_ATTRIBUTE4                      := :old.INDUSTRY_ATTRIBUTE4                           ;
    t_old_rec.INDUSTRY_ATTRIBUTE5                      := :old.INDUSTRY_ATTRIBUTE5                           ;
    t_old_rec.INDUSTRY_ATTRIBUTE6                      := :old.INDUSTRY_ATTRIBUTE6                           ;
    t_old_rec.INDUSTRY_ATTRIBUTE7                      := :old.INDUSTRY_ATTRIBUTE7                           ;
    t_old_rec.INDUSTRY_ATTRIBUTE8                      := :old.INDUSTRY_ATTRIBUTE8                           ;
    t_old_rec.INDUSTRY_ATTRIBUTE9                      := :old.INDUSTRY_ATTRIBUTE9                           ;
    t_old_rec.INDUSTRY_ATTRIBUTE10                     := :old.INDUSTRY_ATTRIBUTE10                          ;
    t_old_rec.INDUSTRY_ATTRIBUTE11                     := :old.INDUSTRY_ATTRIBUTE11                          ;
    t_old_rec.INDUSTRY_ATTRIBUTE13                     := :old.INDUSTRY_ATTRIBUTE13                          ;
    t_old_rec.INDUSTRY_ATTRIBUTE12                     := :old.INDUSTRY_ATTRIBUTE12                          ;
    t_old_rec.INDUSTRY_ATTRIBUTE14                     := :old.INDUSTRY_ATTRIBUTE14                          ;
    t_old_rec.INDUSTRY_ATTRIBUTE15                     := :old.INDUSTRY_ATTRIBUTE15                          ;
    t_old_rec.INDUSTRY_ATTRIBUTE16                     := :old.INDUSTRY_ATTRIBUTE16                          ;
    t_old_rec.INDUSTRY_ATTRIBUTE17                     := :old.INDUSTRY_ATTRIBUTE17                          ;
    t_old_rec.INDUSTRY_ATTRIBUTE18                     := :old.INDUSTRY_ATTRIBUTE18                          ;
    t_old_rec.INDUSTRY_ATTRIBUTE19                     := :old.INDUSTRY_ATTRIBUTE19                          ;
    t_old_rec.INDUSTRY_ATTRIBUTE20                     := :old.INDUSTRY_ATTRIBUTE20                          ;
    t_old_rec.INDUSTRY_ATTRIBUTE21                     := :old.INDUSTRY_ATTRIBUTE21                          ;
    t_old_rec.INDUSTRY_ATTRIBUTE22                     := :old.INDUSTRY_ATTRIBUTE22                          ;
    t_old_rec.INDUSTRY_ATTRIBUTE23                     := :old.INDUSTRY_ATTRIBUTE23                          ;
    t_old_rec.INDUSTRY_ATTRIBUTE24                     := :old.INDUSTRY_ATTRIBUTE24                          ;
    t_old_rec.INDUSTRY_ATTRIBUTE25                     := :old.INDUSTRY_ATTRIBUTE25                          ;
    t_old_rec.INDUSTRY_ATTRIBUTE26                     := :old.INDUSTRY_ATTRIBUTE26                          ;
    t_old_rec.INDUSTRY_ATTRIBUTE27                     := :old.INDUSTRY_ATTRIBUTE27                          ;
    t_old_rec.INDUSTRY_ATTRIBUTE28                     := :old.INDUSTRY_ATTRIBUTE28                          ;
    t_old_rec.INDUSTRY_ATTRIBUTE29                     := :old.INDUSTRY_ATTRIBUTE29                          ;
    t_old_rec.INDUSTRY_ATTRIBUTE30                     := :old.INDUSTRY_ATTRIBUTE30                          ;
    t_old_rec.CREATION_DATE                            := :old.CREATION_DATE                                 ;
    t_old_rec.CREATED_BY                               := :old.CREATED_BY                                    ;
    t_old_rec.LAST_UPDATE_DATE                         := :old.LAST_UPDATE_DATE                              ;
    t_old_rec.LAST_UPDATED_BY                          := :old.LAST_UPDATED_BY                               ;
    t_old_rec.LAST_UPDATE_LOGIN                        := :old.LAST_UPDATE_LOGIN                             ;
    t_old_rec.PROGRAM_APPLICATION_ID                   := :old.PROGRAM_APPLICATION_ID                        ;
    t_old_rec.PROGRAM_ID                               := :old.PROGRAM_ID                                    ;
    t_old_rec.PROGRAM_UPDATE_DATE                      := :old.PROGRAM_UPDATE_DATE                           ;
    t_old_rec.REQUEST_ID                               := :old.REQUEST_ID                                    ;
    t_old_rec.TOP_MODEL_LINE_ID                        := :old.TOP_MODEL_LINE_ID                             ;
    t_old_rec.LINK_TO_LINE_ID                          := :old.LINK_TO_LINE_ID                               ;
    t_old_rec.COMPONENT_SEQUENCE_ID                    := :old.COMPONENT_SEQUENCE_ID                         ;
    t_old_rec.COMPONENT_CODE                           := :old.COMPONENT_CODE                                ;
    t_old_rec.CONFIG_DISPLAY_SEQUENCE                  := :old.CONFIG_DISPLAY_SEQUENCE                       ;
    t_old_rec.SORT_ORDER                               := :old.SORT_ORDER                                    ;
    t_old_rec.ITEM_TYPE_CODE                           := :old.ITEM_TYPE_CODE                                ;
    t_old_rec.OPTION_NUMBER                            := :old.OPTION_NUMBER                                 ;
    t_old_rec.OPTION_FLAG                              := :old.OPTION_FLAG                                   ;
    t_old_rec.DEP_PLAN_REQUIRED_FLAG                   := :old.DEP_PLAN_REQUIRED_FLAG                        ;
    t_old_rec.VISIBLE_DEMAND_FLAG                      := :old.VISIBLE_DEMAND_FLAG                           ;
    t_old_rec.LINE_CATEGORY_CODE                       := :old.LINE_CATEGORY_CODE                            ;
    t_old_rec.ACTUAL_SHIPMENT_DATE                     := :old.ACTUAL_SHIPMENT_DATE                          ;
    t_old_rec.CUSTOMER_TRX_LINE_ID                     := :old.CUSTOMER_TRX_LINE_ID                          ;
    t_old_rec.RETURN_CONTEXT                           := :old.RETURN_CONTEXT                                ;
    t_old_rec.RETURN_ATTRIBUTE1                        := :old.RETURN_ATTRIBUTE1                             ;
    t_old_rec.RETURN_ATTRIBUTE2                        := :old.RETURN_ATTRIBUTE2                             ;
    t_old_rec.RETURN_ATTRIBUTE3                        := :old.RETURN_ATTRIBUTE3                             ;
    t_old_rec.RETURN_ATTRIBUTE4                        := :old.RETURN_ATTRIBUTE4                             ;
    t_old_rec.RETURN_ATTRIBUTE5                        := :old.RETURN_ATTRIBUTE5                             ;
    t_old_rec.RETURN_ATTRIBUTE6                        := :old.RETURN_ATTRIBUTE6                             ;
    t_old_rec.RETURN_ATTRIBUTE7                        := :old.RETURN_ATTRIBUTE7                             ;
    t_old_rec.RETURN_ATTRIBUTE8                        := :old.RETURN_ATTRIBUTE8                             ;
    t_old_rec.RETURN_ATTRIBUTE9                        := :old.RETURN_ATTRIBUTE9                             ;
    t_old_rec.RETURN_ATTRIBUTE10                       := :old.RETURN_ATTRIBUTE10                            ;
    t_old_rec.RETURN_ATTRIBUTE11                       := :old.RETURN_ATTRIBUTE11                            ;
    t_old_rec.RETURN_ATTRIBUTE12                       := :old.RETURN_ATTRIBUTE12                            ;
    t_old_rec.RETURN_ATTRIBUTE13                       := :old.RETURN_ATTRIBUTE13                            ;
    t_old_rec.RETURN_ATTRIBUTE14                       := :old.RETURN_ATTRIBUTE14                            ;
    t_old_rec.RETURN_ATTRIBUTE15                       := :old.RETURN_ATTRIBUTE15                            ;
    t_old_rec.ACTUAL_ARRIVAL_DATE                      := :old.ACTUAL_ARRIVAL_DATE                           ;
    t_old_rec.ATO_LINE_ID                              := :old.ATO_LINE_ID                                   ;
    t_old_rec.AUTO_SELECTED_QUANTITY                   := :old.AUTO_SELECTED_QUANTITY                        ;
    t_old_rec.COMPONENT_NUMBER                         := :old.COMPONENT_NUMBER                              ;
    t_old_rec.EARLIEST_ACCEPTABLE_DATE                 := :old.EARLIEST_ACCEPTABLE_DATE                      ;
    t_old_rec.EXPLOSION_DATE                           := :old.EXPLOSION_DATE                                ;
    t_old_rec.LATEST_ACCEPTABLE_DATE                   := :old.LATEST_ACCEPTABLE_DATE                        ;
    t_old_rec.MODEL_GROUP_NUMBER                       := :old.MODEL_GROUP_NUMBER                            ;
    t_old_rec.SCHEDULE_ARRIVAL_DATE                    := :old.SCHEDULE_ARRIVAL_DATE                         ;
    t_old_rec.SHIP_MODEL_COMPLETE_FLAG                 := :old.SHIP_MODEL_COMPLETE_FLAG                      ;
    t_old_rec.SCHEDULE_STATUS_CODE                     := :old.SCHEDULE_STATUS_CODE                          ;
    t_old_rec.SOURCE_TYPE_CODE                         := :old.SOURCE_TYPE_CODE                              ;
    t_old_rec.CANCELLED_FLAG                           := :old.CANCELLED_FLAG                                ;
    t_old_rec.OPEN_FLAG                                := :old.OPEN_FLAG                                     ;
    t_old_rec.BOOKED_FLAG                              := :old.BOOKED_FLAG                                   ;
    t_old_rec.SALESREP_ID                              := :old.SALESREP_ID                                   ;
    t_old_rec.RETURN_REASON_CODE                       := :old.RETURN_REASON_CODE                            ;
    t_old_rec.ARRIVAL_SET_ID                           := :old.ARRIVAL_SET_ID                                ;
    t_old_rec.SHIP_SET_ID                              := :old.SHIP_SET_ID                                   ;
    t_old_rec.SPLIT_FROM_LINE_ID                       := :old.SPLIT_FROM_LINE_ID                            ;
    t_old_rec.CUST_PRODUCTION_SEQ_NUM                  := :old.CUST_PRODUCTION_SEQ_NUM                       ;
    t_old_rec.AUTHORIZED_TO_SHIP_FLAG                  := :old.AUTHORIZED_TO_SHIP_FLAG                       ;
    t_old_rec.OVER_SHIP_REASON_CODE                    := :old.OVER_SHIP_REASON_CODE                         ;
    t_old_rec.OVER_SHIP_RESOLVED_FLAG                  := :old.OVER_SHIP_RESOLVED_FLAG                       ;
    t_old_rec.ORDERED_ITEM_ID                          := :old.ORDERED_ITEM_ID                               ;
    t_old_rec.ITEM_IDENTIFIER_TYPE                     := :old.ITEM_IDENTIFIER_TYPE                          ;
    t_old_rec.CONFIGURATION_ID                         := :old.CONFIGURATION_ID                              ;
    t_old_rec.COMMITMENT_ID                            := :old.COMMITMENT_ID                                 ;
    t_old_rec.SHIPPING_INTERFACED_FLAG                 := :old.SHIPPING_INTERFACED_FLAG                      ;
    t_old_rec.CREDIT_INVOICE_LINE_ID                   := :old.CREDIT_INVOICE_LINE_ID                        ;
    t_old_rec.FIRST_ACK_CODE                           := :old.FIRST_ACK_CODE                                ;
    t_old_rec.FIRST_ACK_DATE                           := :old.FIRST_ACK_DATE                                ;
    t_old_rec.LAST_ACK_CODE                            := :old.LAST_ACK_CODE                                 ;
    t_old_rec.LAST_ACK_DATE                            := :old.LAST_ACK_DATE                                 ;
    t_old_rec.PLANNING_PRIORITY                        := :old.PLANNING_PRIORITY                             ;
    t_old_rec.ORDER_SOURCE_ID                          := :old.ORDER_SOURCE_ID                               ;
    t_old_rec.ORIG_SYS_SHIPMENT_REF                    := :old.ORIG_SYS_SHIPMENT_REF                         ;
    t_old_rec.CHANGE_SEQUENCE                          := :old.CHANGE_SEQUENCE                               ;
    t_old_rec.DROP_SHIP_FLAG                           := :old.DROP_SHIP_FLAG                                ;
    t_old_rec.CUSTOMER_LINE_NUMBER                     := :old.CUSTOMER_LINE_NUMBER                          ;
    t_old_rec.CUSTOMER_SHIPMENT_NUMBER                 := :old.CUSTOMER_SHIPMENT_NUMBER                      ;
    t_old_rec.CUSTOMER_ITEM_NET_PRICE                  := :old.CUSTOMER_ITEM_NET_PRICE                       ;
    t_old_rec.CUSTOMER_PAYMENT_TERM_ID                 := :old.CUSTOMER_PAYMENT_TERM_ID                      ;
    t_old_rec.FULFILLED_FLAG                           := :old.FULFILLED_FLAG                                ;
    t_old_rec.END_ITEM_UNIT_NUMBER                     := :old.END_ITEM_UNIT_NUMBER                          ;
    t_old_rec.CONFIG_HEADER_ID                         := :old.CONFIG_HEADER_ID                              ;
    t_old_rec.CONFIG_REV_NBR                           := :old.CONFIG_REV_NBR                                ;
    t_old_rec.MFG_COMPONENT_SEQUENCE_ID                := :old.MFG_COMPONENT_SEQUENCE_ID                     ;
    t_old_rec.SHIPPING_INSTRUCTIONS                    := :old.SHIPPING_INSTRUCTIONS                         ;
    t_old_rec.PACKING_INSTRUCTIONS                     := :old.PACKING_INSTRUCTIONS                          ;
    t_old_rec.INVOICED_QUANTITY                        := :old.INVOICED_QUANTITY                             ;
    t_old_rec.REFERENCE_CUSTOMER_TRX_LINE_ID           := :old.REFERENCE_CUSTOMER_TRX_LINE_ID                ;
    t_old_rec.SPLIT_BY                                 := :old.SPLIT_BY                                      ;
    t_old_rec.LINE_SET_ID                              := :old.LINE_SET_ID                                   ;
    t_old_rec.SERVICE_TXN_REASON_CODE                  := :old.SERVICE_TXN_REASON_CODE                       ;
    t_old_rec.SERVICE_TXN_COMMENTS                     := :old.SERVICE_TXN_COMMENTS                          ;
    t_old_rec.SERVICE_DURATION                         := :old.SERVICE_DURATION                              ;
    t_old_rec.SERVICE_START_DATE                       := :old.SERVICE_START_DATE                            ;
    t_old_rec.SERVICE_END_DATE                         := :old.SERVICE_END_DATE                              ;
    t_old_rec.SERVICE_COTERMINATE_FLAG                 := :old.SERVICE_COTERMINATE_FLAG                      ;
    t_old_rec.UNIT_LIST_PERCENT                        := :old.UNIT_LIST_PERCENT                             ;
    t_old_rec.UNIT_SELLING_PERCENT                     := :old.UNIT_SELLING_PERCENT                          ;
    t_old_rec.UNIT_PERCENT_BASE_PRICE                  := :old.UNIT_PERCENT_BASE_PRICE                       ;
    t_old_rec.SERVICE_NUMBER                           := :old.SERVICE_NUMBER                                ;
    t_old_rec.SERVICE_PERIOD                           := :old.SERVICE_PERIOD                                ;
    t_old_rec.SHIPPABLE_FLAG                           := :old.SHIPPABLE_FLAG                                ;
    t_old_rec.MODEL_REMNANT_FLAG                       := :old.MODEL_REMNANT_FLAG                            ;
    t_old_rec.RE_SOURCE_FLAG                           := :old.RE_SOURCE_FLAG                                ;
    t_old_rec.FLOW_STATUS_CODE                         := :old.FLOW_STATUS_CODE                              ;
    t_old_rec.TP_CONTEXT                               := :old.TP_CONTEXT                                    ;
    t_old_rec.TP_ATTRIBUTE1                            := :old.TP_ATTRIBUTE1                                 ;
    t_old_rec.TP_ATTRIBUTE2                            := :old.TP_ATTRIBUTE2                                 ;
    t_old_rec.TP_ATTRIBUTE3                            := :old.TP_ATTRIBUTE3                                 ;
    t_old_rec.TP_ATTRIBUTE4                            := :old.TP_ATTRIBUTE4                                 ;
    t_old_rec.TP_ATTRIBUTE5                            := :old.TP_ATTRIBUTE5                                 ;
    t_old_rec.TP_ATTRIBUTE6                            := :old.TP_ATTRIBUTE6                                 ;
    t_old_rec.TP_ATTRIBUTE7                            := :old.TP_ATTRIBUTE7                                 ;
    t_old_rec.TP_ATTRIBUTE8                            := :old.TP_ATTRIBUTE8                                 ;
    t_old_rec.TP_ATTRIBUTE9                            := :old.TP_ATTRIBUTE9                                 ;
    t_old_rec.TP_ATTRIBUTE10                           := :old.TP_ATTRIBUTE10                                ;
    t_old_rec.TP_ATTRIBUTE11                           := :old.TP_ATTRIBUTE11                                ;
    t_old_rec.TP_ATTRIBUTE12                           := :old.TP_ATTRIBUTE12                                ;
    t_old_rec.TP_ATTRIBUTE13                           := :old.TP_ATTRIBUTE13                                ;
    t_old_rec.TP_ATTRIBUTE14                           := :old.TP_ATTRIBUTE14                                ;
    t_old_rec.TP_ATTRIBUTE15                           := :old.TP_ATTRIBUTE15                                ;
    t_old_rec.FULFILLMENT_METHOD_CODE                  := :old.FULFILLMENT_METHOD_CODE                       ;
    t_old_rec.MARKETING_SOURCE_CODE_ID                 := :old.MARKETING_SOURCE_CODE_ID                      ;
    t_old_rec.SERVICE_REFERENCE_TYPE_CODE              := :old.SERVICE_REFERENCE_TYPE_CODE                   ;
    t_old_rec.SERVICE_REFERENCE_LINE_ID                := :old.SERVICE_REFERENCE_LINE_ID                     ;
    t_old_rec.SERVICE_REFERENCE_SYSTEM_ID              := :old.SERVICE_REFERENCE_SYSTEM_ID                   ;
    t_old_rec.CALCULATE_PRICE_FLAG                     := :old.CALCULATE_PRICE_FLAG                          ;
    t_old_rec.UPGRADED_FLAG                            := :old.UPGRADED_FLAG                                 ;
    t_old_rec.REVENUE_AMOUNT                           := :old.REVENUE_AMOUNT                                ;
    t_old_rec.FULFILLMENT_DATE                         := :old.FULFILLMENT_DATE                              ;
    t_old_rec.PREFERRED_GRADE                          := :old.PREFERRED_GRADE                               ;
    t_old_rec.ORDERED_QUANTITY2                        := :old.ORDERED_QUANTITY2                             ;
    t_old_rec.ORDERED_QUANTITY_UOM2                    := :old.ORDERED_QUANTITY_UOM2                         ;
    t_old_rec.SHIPPING_QUANTITY2                       := :old.SHIPPING_QUANTITY2                            ;
    t_old_rec.CANCELLED_QUANTITY2                      := :old.CANCELLED_QUANTITY2                           ;
    t_old_rec.SHIPPED_QUANTITY2                        := :old.SHIPPED_QUANTITY2                             ;
    t_old_rec.SHIPPING_QUANTITY_UOM2                   := :old.SHIPPING_QUANTITY_UOM2                        ;
    t_old_rec.FULFILLED_QUANTITY2                      := :old.FULFILLED_QUANTITY2                           ;
    t_old_rec.MFG_LEAD_TIME                            := :old.MFG_LEAD_TIME                                 ;
    t_old_rec.LOCK_CONTROL                             := :old.LOCK_CONTROL                                  ;
    t_old_rec.SUBINVENTORY                             := :old.SUBINVENTORY                                  ;
    t_old_rec.UNIT_LIST_PRICE_PER_PQTY                 := :old.UNIT_LIST_PRICE_PER_PQTY                      ;
    t_old_rec.UNIT_SELLING_PRICE_PER_PQTY              := :old.UNIT_SELLING_PRICE_PER_PQTY                   ;
    t_old_rec.PRICE_REQUEST_CODE                       := :old.PRICE_REQUEST_CODE                            ;
    t_old_rec.ORIGINAL_INVENTORY_ITEM_ID               := :old.ORIGINAL_INVENTORY_ITEM_ID                    ;
    t_old_rec.ORIGINAL_ORDERED_ITEM_ID                 := :old.ORIGINAL_ORDERED_ITEM_ID                      ;
    t_old_rec.ORIGINAL_ORDERED_ITEM                    := :old.ORIGINAL_ORDERED_ITEM                         ;
    t_old_rec.ORIGINAL_ITEM_IDENTIFIER_TYPE            := :old.ORIGINAL_ITEM_IDENTIFIER_TYPE                 ;
    t_old_rec.ITEM_SUBSTITUTION_TYPE_CODE              := :old.ITEM_SUBSTITUTION_TYPE_CODE                   ;
    t_old_rec.OVERRIDE_ATP_DATE_CODE                   := :old.OVERRIDE_ATP_DATE_CODE                        ;
    t_old_rec.LATE_DEMAND_PENALTY_FACTOR               := :old.LATE_DEMAND_PENALTY_FACTOR                    ;
    t_old_rec.ACCOUNTING_RULE_DURATION                 := :old.ACCOUNTING_RULE_DURATION                      ;
    t_old_rec.ATTRIBUTE16                              := :old.ATTRIBUTE16                                   ;
    t_old_rec.ATTRIBUTE17                              := :old.ATTRIBUTE17                                   ;
    t_old_rec.ATTRIBUTE18                              := :old.ATTRIBUTE18                                   ;
    t_old_rec.ATTRIBUTE19                              := :old.ATTRIBUTE19                                   ;
    t_old_rec.ATTRIBUTE20                              := :old.ATTRIBUTE20                                   ;
    t_old_rec.USER_ITEM_DESCRIPTION                    := :old.USER_ITEM_DESCRIPTION                         ;
    t_old_rec.UNIT_COST                                := :old.UNIT_COST                                     ;
    t_old_rec.ITEM_RELATIONSHIP_TYPE                   := :old.ITEM_RELATIONSHIP_TYPE                        ;
    t_old_rec.BLANKET_LINE_NUMBER                      := :old.BLANKET_LINE_NUMBER                           ;
    t_old_rec.BLANKET_NUMBER                           := :old.BLANKET_NUMBER                                ;
    t_old_rec.BLANKET_VERSION_NUMBER                   := :old.BLANKET_VERSION_NUMBER                        ;
    t_old_rec.SALES_DOCUMENT_TYPE_CODE                 := :old.SALES_DOCUMENT_TYPE_CODE                      ;
    t_old_rec.FIRM_DEMAND_FLAG                         := :old.FIRM_DEMAND_FLAG                              ;
    t_old_rec.EARLIEST_SHIP_DATE                       := :old.EARLIEST_SHIP_DATE                            ;
    t_old_rec.TRANSACTION_PHASE_CODE                   := :old.TRANSACTION_PHASE_CODE                        ;
    t_old_rec.SOURCE_DOCUMENT_VERSION_NUMBER           := :old.SOURCE_DOCUMENT_VERSION_NUMBER                ;
    t_old_rec.PAYMENT_TYPE_CODE                        := :old.PAYMENT_TYPE_CODE                             ;
    t_old_rec.MINISITE_ID                              := :old.MINISITE_ID                                   ;
    t_old_rec.END_CUSTOMER_ID                          := :old.END_CUSTOMER_ID                               ;
    t_old_rec.END_CUSTOMER_CONTACT_ID                  := :old.END_CUSTOMER_CONTACT_ID                       ;
    t_old_rec.END_CUSTOMER_SITE_USE_ID                 := :old.END_CUSTOMER_SITE_USE_ID                      ;
    t_old_rec.IB_OWNER                                 := :old.IB_OWNER                                      ;
    t_old_rec.IB_CURRENT_LOCATION                      := :old.IB_CURRENT_LOCATION                           ;
    t_old_rec.IB_INSTALLED_AT_LOCATION                 := :old.IB_INSTALLED_AT_LOCATION                      ;
    t_old_rec.RETROBILL_REQUEST_ID                     := :old.RETROBILL_REQUEST_ID                          ;
    t_old_rec.ORIGINAL_LIST_PRICE                      := :old.ORIGINAL_LIST_PRICE                           ;
    t_old_rec.SERVICE_CREDIT_ELIGIBLE_CODE             := :old.SERVICE_CREDIT_ELIGIBLE_CODE                  ;
    t_old_rec.ORDER_FIRMED_DATE                        := :old.ORDER_FIRMED_DATE                             ;
    t_old_rec.ACTUAL_FULFILLMENT_DATE                  := :old.ACTUAL_FULFILLMENT_DATE                       ;
    t_old_rec.CHARGE_PERIODICITY_CODE                  := :old.CHARGE_PERIODICITY_CODE                       ;
  END populate_old ;

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


  /*
  * Bug 5095812. Added by Lakshmi Gopalsami
  * Removed the code which calls jai_cmn_utils_pkg and added the
  * following check using plsql caching for performance issues reported.
  */

  l_func_curr_det := jai_plsql_cache_pkg.return_sob_curr
                            (p_org_id  => :new.org_id );

  IF l_func_curr_det.currency_code <> 'INR' THEN
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

  IF inserting THEN

      jai_oe_ola_trigger_pkg.briu_t1 (
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

  IF updating THEN

      jai_oe_ola_trigger_pkg.briu_t1 (
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
                                      EXCEPTION_TEXT  => 'Encountered the error in trigger JAI_OE_OLA_BRIUD_T1' || substr(sqlerrm,1,1900)
                                    );

END JAI_OE_OLA_BRIUD_T1 ;

/
ALTER TRIGGER "APPS"."JAI_OE_OLA_BRIUD_T1" DISABLE;
