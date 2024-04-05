--------------------------------------------------------
--  DDL for Trigger JAI_OPM_GMD_ARIUD_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_OPM_GMD_ARIUD_T1" 
AFTER INSERT OR UPDATE OR DELETE ON "GME"."GME_MATERIAL_DETAILS"
FOR EACH ROW
DECLARE
  t_old_rec             GME_MATERIAL_DETAILS%rowtype ;
  t_new_rec             GME_MATERIAL_DETAILS%rowtype ;
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

    t_new_rec.MATERIAL_DETAIL_ID                       := :new.MATERIAL_DETAIL_ID                            ;
    t_new_rec.BATCH_ID                                 := :new.BATCH_ID                                      ;
    t_new_rec.FORMULALINE_ID                           := :new.FORMULALINE_ID                                ;
    t_new_rec.LINE_NO                                  := :new.LINE_NO                                       ;
    t_new_rec.ITEM_ID                                  := :new.ITEM_ID                                       ;
    t_new_rec.LINE_TYPE                                := :new.LINE_TYPE                                     ;
    t_new_rec.PLAN_QTY                                 := :new.PLAN_QTY                                      ;
    t_new_rec.ITEM_UM                                  := :new.ITEM_UM                                       ;
    t_new_rec.DTL_UM                                   := :new.DTL_UM                                        ;/*Added by nprashar for bug 7540543*/
    t_new_rec.ITEM_UM2                                 := :new.ITEM_UM2                                      ;
    t_new_rec.ACTUAL_QTY                               := :new.ACTUAL_QTY                                    ;
    t_new_rec.RELEASE_TYPE                             := :new.RELEASE_TYPE                                  ;
    t_new_rec.SCRAP_FACTOR                             := :new.SCRAP_FACTOR                                  ;
    t_new_rec.SCALE_TYPE                               := :new.SCALE_TYPE                                    ;
    t_new_rec.PHANTOM_TYPE                             := :new.PHANTOM_TYPE                                  ;
    t_new_rec.COST_ALLOC                               := :new.COST_ALLOC                                    ;
    t_new_rec.ALLOC_IND                                := :new.ALLOC_IND                                     ;
    t_new_rec.COST                                     := :new.COST                                          ;
    t_new_rec.TEXT_CODE                                := :new.TEXT_CODE                                     ;
    t_new_rec.PHANTOM_ID                               := :new.PHANTOM_ID                                    ;
    t_new_rec.ROUNDING_DIRECTION                       := :new.ROUNDING_DIRECTION                            ;
    t_new_rec.CREATION_DATE                            := :new.CREATION_DATE                                 ;
    t_new_rec.CREATED_BY                               := :new.CREATED_BY                                    ;
    t_new_rec.LAST_UPDATE_DATE                         := :new.LAST_UPDATE_DATE                              ;
    t_new_rec.LAST_UPDATED_BY                          := :new.LAST_UPDATED_BY                               ;
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
    t_new_rec.LAST_UPDATE_LOGIN                        := :new.LAST_UPDATE_LOGIN                             ;
    t_new_rec.SCALE_ROUNDING_VARIANCE                  := :new.SCALE_ROUNDING_VARIANCE                       ;
    t_new_rec.SCALE_MULTIPLE                           := :new.SCALE_MULTIPLE                                ;
    t_new_rec.CONTRIBUTE_YIELD_IND                     := :new.CONTRIBUTE_YIELD_IND                          ;
    t_new_rec.CONTRIBUTE_STEP_QTY_IND                  := :new.CONTRIBUTE_STEP_QTY_IND                       ;
    t_new_rec.WIP_PLAN_QTY                             := :new.WIP_PLAN_QTY                                  ;
    t_new_rec.ORIGINAL_QTY                             := :new.ORIGINAL_QTY                                  ;
    t_new_rec.BY_PRODUCT_TYPE                          := :new.BY_PRODUCT_TYPE                               ;
  END populate_new ;

  PROCEDURE populate_old IS
  BEGIN
    t_old_rec.MATERIAL_DETAIL_ID                       := :old.MATERIAL_DETAIL_ID                            ;
    t_old_rec.BATCH_ID                                 := :old.BATCH_ID                                      ;
    t_old_rec.FORMULALINE_ID                           := :old.FORMULALINE_ID                                ;
    t_old_rec.LINE_NO                                  := :old.LINE_NO                                       ;
    t_old_rec.ITEM_ID                                  := :old.ITEM_ID                                       ;
    t_old_rec.LINE_TYPE                                := :old.LINE_TYPE                                     ;
    t_old_rec.PLAN_QTY                                 := :old.PLAN_QTY                                      ;
    t_old_rec.ITEM_UM                                  := :old.ITEM_UM                                       ;
    t_old_rec.DTL_UM                                   := :old.DTL_UM                                        ; /*Added by nprashar for bug 7540543*/
    t_old_rec.ITEM_UM2                                 := :old.ITEM_UM2                                      ;
    t_old_rec.ACTUAL_QTY                               := :old.ACTUAL_QTY                                    ;
    t_old_rec.RELEASE_TYPE                             := :old.RELEASE_TYPE                                  ;
    t_old_rec.SCRAP_FACTOR                             := :old.SCRAP_FACTOR                                  ;
    t_old_rec.SCALE_TYPE                               := :old.SCALE_TYPE                                    ;
    t_old_rec.PHANTOM_TYPE                             := :old.PHANTOM_TYPE                                  ;
    t_old_rec.COST_ALLOC                               := :old.COST_ALLOC                                    ;
    t_old_rec.ALLOC_IND                                := :old.ALLOC_IND                                     ;
    t_old_rec.COST                                     := :old.COST                                          ;
    t_old_rec.TEXT_CODE                                := :old.TEXT_CODE                                     ;
    t_old_rec.PHANTOM_ID                               := :old.PHANTOM_ID                                    ;
    t_old_rec.ROUNDING_DIRECTION                       := :old.ROUNDING_DIRECTION                            ;
    t_old_rec.CREATION_DATE                            := :old.CREATION_DATE                                 ;
    t_old_rec.CREATED_BY                               := :old.CREATED_BY                                    ;
    t_old_rec.LAST_UPDATE_DATE                         := :old.LAST_UPDATE_DATE                              ;
    t_old_rec.LAST_UPDATED_BY                          := :old.LAST_UPDATED_BY                               ;
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
    t_old_rec.LAST_UPDATE_LOGIN                        := :old.LAST_UPDATE_LOGIN                             ;
    t_old_rec.SCALE_ROUNDING_VARIANCE                  := :old.SCALE_ROUNDING_VARIANCE                       ;
    t_old_rec.SCALE_MULTIPLE                           := :old.SCALE_MULTIPLE                                ;
    t_old_rec.CONTRIBUTE_YIELD_IND                     := :old.CONTRIBUTE_YIELD_IND                          ;
    t_old_rec.CONTRIBUTE_STEP_QTY_IND                  := :old.CONTRIBUTE_STEP_QTY_IND                       ;
    t_old_rec.WIP_PLAN_QTY                             := :old.WIP_PLAN_QTY                                  ;
    t_old_rec.ORIGINAL_QTY                             := :old.ORIGINAL_QTY                                  ;
    t_old_rec.BY_PRODUCT_TYPE                          := :old.BY_PRODUCT_TYPE                               ;
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

      JAI_OPM_GMD_TRIGGER_PKG.ARU_T1 (
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
                                      EXCEPTION_TEXT  => 'Encountered the error in trigger JAI_OPM_GMD_ARIUD_T1' || substr(sqlerrm,1,1900)
                                    );

END JAI_OPM_GMD_ARIUD_T1 ;

/
ALTER TRIGGER "APPS"."JAI_OPM_GMD_ARIUD_T1" DISABLE;
