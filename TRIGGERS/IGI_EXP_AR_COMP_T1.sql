--------------------------------------------------------
--  DDL for Trigger IGI_EXP_AR_COMP_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."IGI_EXP_AR_COMP_T1" 
BEFORE INSERT OR UPDATE
 OF complete_flag
ON "IGI"."IGI_RA_CUSTOMER_TRX_ALL"
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
    IF igi_gen.is_req_installed('EXP') THEN
      IF nvl(:new.dial_unit_id,0) = -999
      THEN
	 :new.DIAL_UNIT_ID := :old.DIAL_UNIT_ID;
      ELSE
         IF (igi_gen.is_req_installed('EXP')
	 AND
	   :new.complete_flag = 'Y'
	 AND
	   :new.created_from <> 'RAXTRX')
         THEN
            fnd_message.set_name('IGI', 'IGI_EXP_AR_COMP');
            RAISE_APPLICATION_ERROR(-20010, fnd_message.get);
         END IF;
      END IF;
    END IF ;
END;



/
ALTER TRIGGER "APPS"."IGI_EXP_AR_COMP_T1" DISABLE;
