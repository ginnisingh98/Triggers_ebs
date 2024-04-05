--------------------------------------------------------
--  DDL for Trigger IGI_AP_INVOICE_DIST_T3
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."IGI_AP_INVOICE_DIST_T3" 
after insert or delete or update on "AP"."AP_INVOICE_DISTRIBUTIONS_ALL"
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
--- $Header: igisiatgr.sql 120.1.12010000.2 2010/04/08 12:20:02 schakkin ship $
  if INSERTING then
    INSERT INTO IGI_INVOICE_DISTRIBUTIONS_ALL (INVOICE_ID,
                                               DISTRIBUTION_LINE_NUMBER,
                                               LAST_UPDATE_DATE,
                                               LAST_UPDATED_BY,
                                               INVOICE_LINE_NUMBER, -- Bug # 5905278 pashivara
                                               ORG_ID)   -- Bug # 5905278 pashivara
    VALUES (:new.INVOICE_ID, :new.DISTRIBUTION_LINE_NUMBER,
            :new.LAST_UPDATE_DATE, :new.LAST_UPDATED_BY,
            :new.INVOICE_LINE_NUMBER,  -- Bug # 5905278 pashivara
            :new.org_id);  -- Bug # 5905278 pashivara
-- Bug 3702967 start --
  elsif UPDATING then

    IF :new.DISTRIBUTION_LINE_NUMBER <>  :old.DISTRIBUTION_LINE_NUMBER then
	UPDATE IGI_INVOICE_DISTRIBUTIONS_ALL
	SET INVOICE_LINE_NUMBER = :new.INVOICE_LINE_NUMBER,   -- Bug # 5905278 pashivara
        DISTRIBUTION_LINE_NUMBER = :new.DISTRIBUTION_LINE_NUMBER
        WHERE INVOICE_ID = :old.INVOICE_ID
 	AND   DISTRIBUTION_LINE_NUMBER = :old.DISTRIBUTION_LINE_NUMBER
        AND INVOICE_LINE_NUMBER = :old.INVOICE_LINE_NUMBER; -- Bug # 5905278 pashivara
    END IF;

-- Bug 3702967 end --
  else
    DELETE FROM IGI_INVOICE_DISTRIBUTIONS_ALL
    WHERE INVOICE_ID = :old.INVOICE_ID
    AND   INVOICE_LINE_NUMBER = :old.INVOICE_LINE_NUMBER  -- Bug # 5905278 pashivara
    AND   DISTRIBUTION_LINE_NUMBER =  :old.DISTRIBUTION_LINE_NUMBER;

  end if;
END IF;
END;

/
ALTER TRIGGER "APPS"."IGI_AP_INVOICE_DIST_T3" ENABLE;
