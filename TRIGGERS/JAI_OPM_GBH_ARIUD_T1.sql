--------------------------------------------------------
--  DDL for Trigger JAI_OPM_GBH_ARIUD_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_OPM_GBH_ARIUD_T1" 
AFTER INSERT OR UPDATE OR DELETE ON "GME"."GME_BATCH_HEADER"
FOR EACH ROW
  WHEN (NEW.JA_OSP_BATCH = 1) DECLARE
  t_old_rec             GME_BATCH_HEADER%rowtype ;
  t_new_rec             GME_BATCH_HEADER%rowtype ;
  lv_return_message     VARCHAR2(2000);
  lv_return_code        VARCHAR2(100) ;
  le_error              EXCEPTION     ;
  lv_action             VARCHAR2(20)  ;

  /*
  || Here initialising the pr_new record type in the inline procedure
  ||
  */

  PROCEDURE populate_new IS
  BEGIN

    t_new_rec.BATCH_ID                                 := :new.BATCH_ID                                      ;
    t_new_rec.PLANT_CODE                               := :new.PLANT_CODE                                    ;
    t_new_rec.BATCH_NO                                 := :new.BATCH_NO                                      ;
    t_new_rec.BATCH_TYPE                               := :new.BATCH_TYPE                                    ;
    t_new_rec.PROD_ID                                  := :new.PROD_ID                                       ;
    t_new_rec.PROD_SEQUENCE                            := :new.PROD_SEQUENCE                                 ;
    t_new_rec.RECIPE_VALIDITY_RULE_ID                  := :new.RECIPE_VALIDITY_RULE_ID                       ;
    t_new_rec.FORMULA_ID                               := :new.FORMULA_ID                                    ;
    t_new_rec.ROUTING_ID                               := :new.ROUTING_ID                                    ;
    t_new_rec.PLAN_START_DATE                          := :new.PLAN_START_DATE                               ;
    t_new_rec.ACTUAL_START_DATE                        := :new.ACTUAL_START_DATE                             ;
    t_new_rec.DUE_DATE                                 := :new.DUE_DATE                                      ;
    t_new_rec.PLAN_CMPLT_DATE                          := :new.PLAN_CMPLT_DATE                               ;
    t_new_rec.ACTUAL_CMPLT_DATE                        := :new.ACTUAL_CMPLT_DATE                             ;
    t_new_rec.BATCH_STATUS                             := :new.BATCH_STATUS                                  ;
    t_new_rec.PRIORITY_VALUE                           := :new.PRIORITY_VALUE                                ;
    t_new_rec.PRIORITY_CODE                            := :new.PRIORITY_CODE                                 ;
    t_new_rec.PRINT_COUNT                              := :new.PRINT_COUNT                                   ;
    t_new_rec.FMCONTROL_CLASS                          := :new.FMCONTROL_CLASS                               ;
    t_new_rec.WIP_WHSE_CODE                            := :new.WIP_WHSE_CODE                                 ;
    t_new_rec.BATCH_CLOSE_DATE                         := :new.BATCH_CLOSE_DATE                              ;
    t_new_rec.POC_IND                                  := :new.POC_IND                                       ;
    t_new_rec.ACTUAL_COST_IND                          := :new.ACTUAL_COST_IND                               ;
    t_new_rec.UPDATE_INVENTORY_IND                     := :new.UPDATE_INVENTORY_IND                          ;
    t_new_rec.LAST_UPDATE_DATE                         := :new.LAST_UPDATE_DATE                              ;
    t_new_rec.LAST_UPDATED_BY                          := :new.LAST_UPDATED_BY                               ;
    t_new_rec.CREATION_DATE                            := :new.CREATION_DATE                                 ;
    t_new_rec.CREATED_BY                               := :new.CREATED_BY                                    ;
    t_new_rec.LAST_UPDATE_LOGIN                        := :new.LAST_UPDATE_LOGIN                             ;
    t_new_rec.DELETE_MARK                              := :new.DELETE_MARK                                   ;
    t_new_rec.TEXT_CODE                                := :new.TEXT_CODE                                     ;
    t_new_rec.PARENTLINE_ID                            := :new.PARENTLINE_ID                                 ;
    t_new_rec.FPO_ID                                   := :new.FPO_ID                                        ;
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
    t_new_rec.ATTRIBUTE_CATEGORY                       := :new.ATTRIBUTE_CATEGORY                            ;
    t_new_rec.AUTOMATIC_STEP_CALCULATION               := :new.AUTOMATIC_STEP_CALCULATION                    ;
    t_new_rec.GL_POSTED_IND                            := :new.GL_POSTED_IND                                 ;
    t_new_rec.FIRMED_IND                               := :new.FIRMED_IND                                    ;
    t_new_rec.FINITE_SCHEDULED_IND                     := :new.FINITE_SCHEDULED_IND                          ;
    t_new_rec.ORDER_PRIORITY                           := :new.ORDER_PRIORITY                                ;
    t_new_rec.ATTRIBUTE31                              := :new.ATTRIBUTE31                                   ;
    t_new_rec.ATTRIBUTE32                              := :new.ATTRIBUTE32                                   ;
    t_new_rec.ATTRIBUTE33                              := :new.ATTRIBUTE33                                   ;
    t_new_rec.ATTRIBUTE34                              := :new.ATTRIBUTE34                                   ;
    t_new_rec.ATTRIBUTE35                              := :new.ATTRIBUTE35                                   ;
    t_new_rec.ATTRIBUTE36                              := :new.ATTRIBUTE36                                   ;
    t_new_rec.ATTRIBUTE37                              := :new.ATTRIBUTE37                                   ;
    t_new_rec.ATTRIBUTE38                              := :new.ATTRIBUTE38                                   ;
    t_new_rec.ATTRIBUTE39                              := :new.ATTRIBUTE39                                   ;
    t_new_rec.ATTRIBUTE40                              := :new.ATTRIBUTE40                                   ;
    t_new_rec.MIGRATED_BATCH_IND                       := :new.MIGRATED_BATCH_IND                            ;
    t_new_rec.ENFORCE_STEP_DEPENDENCY                  := :new.ENFORCE_STEP_DEPENDENCY                       ;
    t_new_rec.TERMINATED_IND                           := :new.TERMINATED_IND                                ;
    t_new_rec.ORGANIZATION_ID                          := :new.ORGANIZATION_ID                               ;  /*Added for bug # 9088563 */
    t_new_rec.JA_OSP_BATCH                             := :new.JA_OSP_BATCH                                  ;  /*Added for bug # 9088563 */
  END populate_new ;

  PROCEDURE populate_old IS
  BEGIN
    t_old_rec.BATCH_ID                                 := :old.BATCH_ID                                      ;
    t_old_rec.PLANT_CODE                               := :old.PLANT_CODE                                    ;
    t_old_rec.BATCH_NO                                 := :old.BATCH_NO                                      ;
    t_old_rec.BATCH_TYPE                               := :old.BATCH_TYPE                                    ;
    t_old_rec.PROD_ID                                  := :old.PROD_ID                                       ;
    t_old_rec.PROD_SEQUENCE                            := :old.PROD_SEQUENCE                                 ;
    t_old_rec.RECIPE_VALIDITY_RULE_ID                  := :old.RECIPE_VALIDITY_RULE_ID                       ;
    t_old_rec.FORMULA_ID                               := :old.FORMULA_ID                                    ;
    t_old_rec.ROUTING_ID                               := :old.ROUTING_ID                                    ;
    t_old_rec.PLAN_START_DATE                          := :old.PLAN_START_DATE                               ;
    t_old_rec.ACTUAL_START_DATE                        := :old.ACTUAL_START_DATE                             ;
    t_old_rec.DUE_DATE                                 := :old.DUE_DATE                                      ;
    t_old_rec.PLAN_CMPLT_DATE                          := :old.PLAN_CMPLT_DATE                               ;
    t_old_rec.ACTUAL_CMPLT_DATE                        := :old.ACTUAL_CMPLT_DATE                             ;
    t_old_rec.BATCH_STATUS                             := :old.BATCH_STATUS                                  ;
    t_old_rec.PRIORITY_VALUE                           := :old.PRIORITY_VALUE                                ;
    t_old_rec.PRIORITY_CODE                            := :old.PRIORITY_CODE                                 ;
    t_old_rec.PRINT_COUNT                              := :old.PRINT_COUNT                                   ;
    t_old_rec.FMCONTROL_CLASS                          := :old.FMCONTROL_CLASS                               ;
    t_old_rec.WIP_WHSE_CODE                            := :old.WIP_WHSE_CODE                                 ;
    t_old_rec.BATCH_CLOSE_DATE                         := :old.BATCH_CLOSE_DATE                              ;
    t_old_rec.POC_IND                                  := :old.POC_IND                                       ;
    t_old_rec.ACTUAL_COST_IND                          := :old.ACTUAL_COST_IND                               ;
    t_old_rec.UPDATE_INVENTORY_IND                     := :old.UPDATE_INVENTORY_IND                          ;
    t_old_rec.LAST_UPDATE_DATE                         := :old.LAST_UPDATE_DATE                              ;
    t_old_rec.LAST_UPDATED_BY                          := :old.LAST_UPDATED_BY                               ;
    t_old_rec.CREATION_DATE                            := :old.CREATION_DATE                                 ;
    t_old_rec.CREATED_BY                               := :old.CREATED_BY                                    ;
    t_old_rec.LAST_UPDATE_LOGIN                        := :old.LAST_UPDATE_LOGIN                             ;
    t_old_rec.DELETE_MARK                              := :old.DELETE_MARK                                   ;
    t_old_rec.TEXT_CODE                                := :old.TEXT_CODE                                     ;
    t_old_rec.PARENTLINE_ID                            := :old.PARENTLINE_ID                                 ;
    t_old_rec.FPO_ID                                   := :old.FPO_ID                                        ;
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
    t_old_rec.ATTRIBUTE_CATEGORY                       := :old.ATTRIBUTE_CATEGORY                            ;
    t_old_rec.AUTOMATIC_STEP_CALCULATION               := :old.AUTOMATIC_STEP_CALCULATION                    ;
    t_old_rec.GL_POSTED_IND                            := :old.GL_POSTED_IND                                 ;
    t_old_rec.FIRMED_IND                               := :old.FIRMED_IND                                    ;
    t_old_rec.FINITE_SCHEDULED_IND                     := :old.FINITE_SCHEDULED_IND                          ;
    t_old_rec.ORDER_PRIORITY                           := :old.ORDER_PRIORITY                                ;
    t_old_rec.ATTRIBUTE31                              := :old.ATTRIBUTE31                                   ;
    t_old_rec.ATTRIBUTE32                              := :old.ATTRIBUTE32                                   ;
    t_old_rec.ATTRIBUTE33                              := :old.ATTRIBUTE33                                   ;
    t_old_rec.ATTRIBUTE34                              := :old.ATTRIBUTE34                                   ;
    t_old_rec.ATTRIBUTE35                              := :old.ATTRIBUTE35                                   ;
    t_old_rec.ATTRIBUTE36                              := :old.ATTRIBUTE36                                   ;
    t_old_rec.ATTRIBUTE37                              := :old.ATTRIBUTE37                                   ;
    t_old_rec.ATTRIBUTE38                              := :old.ATTRIBUTE38                                   ;
    t_old_rec.ATTRIBUTE39                              := :old.ATTRIBUTE39                                   ;
    t_old_rec.ATTRIBUTE40                              := :old.ATTRIBUTE40                                   ;
    t_old_rec.MIGRATED_BATCH_IND                       := :old.MIGRATED_BATCH_IND                            ;
    t_old_rec.ENFORCE_STEP_DEPENDENCY                  := :old.ENFORCE_STEP_DEPENDENCY                       ;
    t_old_rec.TERMINATED_IND                           := :old.TERMINATED_IND                                ;
    t_old_rec.ORGANIZATION_ID                          := :old.ORGANIZATION_ID                               ; /*Added for bug # 9088563*/
    t_old_rec.JA_OSP_BATCH                             := :old.JA_OSP_BATCH                                  ; /*Added for bug # 9088563*/
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
  || Have to check for OPM how INR check should be done
  IF jai_cmn_utils_pkg.check_jai_exists(P_CALLING_OBJECT => 'JAI_OPM_GBH_ARIUD_T1', P_ORG_ID => :new.org_id) = FALSE THEN
       RETURN;
  END IF;
  */

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

  IF UPDATING THEN

      JAI_OPM_GBH_TRIGGER_PKG.ARU_T1 (
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
                                      EXCEPTION_TEXT  => 'Encountered the error in trigger JAI_OPM_GBH_ARIUD_T1' || substr(sqlerrm,1,1900)
                                    );

END JAI_OPM_GBH_ARIUD_T1 ;

/
ALTER TRIGGER "APPS"."JAI_OPM_GBH_ARIUD_T1" DISABLE;
