--------------------------------------------------------
--  DDL for Trigger IGI_EXP_TRAN_UNIT_DEF_ALL_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."IGI_EXP_TRAN_UNIT_DEF_ALL_T1" 
BEFORE INSERT OR UPDATE
  OF trans_unit_num
ON "IGI"."IGI_EXP_TRAN_UNIT_DEF_ALL"
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
    IF igi_gen.is_req_installed('EXP') THEN
      IF inserting THEN
        IF :NEW.ACT_NUMBER IS NULL THEN
           :NEW.ACT_NUMBER :=:NEW.TRANS_UNIT_NUM;
        END IF;
      ELSIF updating THEN
        IF :NEW.ACT_NUMBER IS NOT NULL THEN
           :NEW.LEGAL_NUMBER :=:NEW.TRANS_UNIT_NUM;
        END IF;
      END IF ;
    END IF ;
END;



/
ALTER TRIGGER "APPS"."IGI_EXP_TRAN_UNIT_DEF_ALL_T1" DISABLE;
