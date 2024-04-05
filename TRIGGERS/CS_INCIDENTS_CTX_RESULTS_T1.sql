--------------------------------------------------------
--  DDL for Trigger CS_INCIDENTS_CTX_RESULTS_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CS_INCIDENTS_CTX_RESULTS_T1" 
BEFORE INSERT
ON CS.CS_INCIDENTS_CTX_RESULTS FOR EACH ROW


DECLARE
    l_return_err        varchar2(160) := NULL;
BEGIN
        :new.datestamp := sysdate;
EXCEPTION
   WHEN OTHERS THEN
        l_return_err := 'CS_INCIDENTS_CTX_RESULTS_T1: '||substrb(sqlerrm,1,54);
        raise_application_error (-20000, l_return_err);

END;



/
ALTER TRIGGER "APPS"."CS_INCIDENTS_CTX_RESULTS_T1" ENABLE;
