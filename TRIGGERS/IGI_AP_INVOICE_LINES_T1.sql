--------------------------------------------------------
--  DDL for Trigger IGI_AP_INVOICE_LINES_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."IGI_AP_INVOICE_LINES_T1" 
after insert or delete or update on "AP"."AP_INVOICE_LINES_ALL"
for each row
DECLARE
l_SapStatusFlag VARCHAR2(1);
l_SapErrorNum   NUMBER;
--
BEGIN
--
IGI_GEN.get_option_status('SIA'
                           ,l_SapStatusFlag
                           ,l_SapErrorNum);
--
IF l_SapStatusFlag='Y' THEN

  if INSERTING then
    INSERT INTO IGI_INVOICE_LINES_ALL (INVOICE_ID,
                                       LINE_NUMBER,
                                       LAST_UPDATED_DATE,
                                       LAST_UPDATED_BY,
                                       LINE_TYPE_LOOKUP_CODE,
                                       ORG_ID)
    VALUES (:new.INVOICE_ID,
            :new.LINE_NUMBER,
            :new.LAST_UPDATE_DATE,
            :new.LAST_UPDATED_BY,
            :new.LINE_TYPE_LOOKUP_CODE,
            :new.org_id);

  elsif UPDATING then

    IF :new.LINE_NUMBER <> :old.LINE_NUMBER then
	UPDATE IGI_INVOICE_LINES_ALL
	SET LINE_NUMBER = :new.LINE_NUMBER
        WHERE INVOICE_ID = :old.INVOICE_ID
        AND LINE_NUMBER = :old.LINE_NUMBER;
    END IF;


  else
    DELETE FROM IGI_INVOICE_LINES_ALL
    WHERE INVOICE_ID = :old.INVOICE_ID
    AND   LINE_NUMBER = :old.LINE_NUMBER;


  end if;
END IF;
END;

/
ALTER TRIGGER "APPS"."IGI_AP_INVOICE_LINES_T1" ENABLE;
