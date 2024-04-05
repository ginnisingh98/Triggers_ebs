--------------------------------------------------------
--  DDL for Trigger GR_DISPATCH_HISTORY_TG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GR_DISPATCH_HISTORY_TG" 
AFTER  INSERT ON "GR"."GR_DISPATCH_HISTORY"
FOR EACH ROW

BEGIN
   IF :new.creation_source <> 0 THEN
      --Call API to send the dispatch history information to 3rd party only if the
      --creation source is 1 - internal application or 2 - form..
      GR_WF_UTIL_PVT.SEND_OUTBOUND_DOCUMENT('GR','GRDDO',:new.dispatch_history_id);
   END IF;
exception
  when OTHERS then
        raise_application_error(-20000,SQLERRM);

END;


/
ALTER TRIGGER "APPS"."GR_DISPATCH_HISTORY_TG" ENABLE;
