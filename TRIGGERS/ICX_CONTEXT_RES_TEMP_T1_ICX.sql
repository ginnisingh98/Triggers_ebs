--------------------------------------------------------
--  DDL for Trigger ICX_CONTEXT_RES_TEMP_T1_ICX
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."ICX_CONTEXT_RES_TEMP_T1_ICX" 
BEFORE INSERT
ON ICX.ICX_CONTEXT_RESULTS_TEMP FOR EACH ROW


DECLARE
    l_return_err        varchar2(160) := NULL;
BEGIN
        :new.datestamp := sysdate;
EXCEPTION
   WHEN OTHERS THEN
        l_return_err := 'ICX_CONTEXT_RES_TEMP_T1_ICX: '||substrb(sqlerrm,1,54);
        raise_application_error (-20000, l_return_err);

END;



/
ALTER TRIGGER "APPS"."ICX_CONTEXT_RES_TEMP_T1_ICX" ENABLE;
