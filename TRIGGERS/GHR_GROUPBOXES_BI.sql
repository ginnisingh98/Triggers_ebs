--------------------------------------------------------
--  DDL for Trigger GHR_GROUPBOXES_BI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GHR_GROUPBOXES_BI" 
before insert or update or delete on "HR"."GHR_GROUPBOXES"
for each row
begin
   ghr_api.ghr_gbx_index := 0;
end;


/
ALTER TRIGGER "APPS"."GHR_GROUPBOXES_BI" ENABLE;
