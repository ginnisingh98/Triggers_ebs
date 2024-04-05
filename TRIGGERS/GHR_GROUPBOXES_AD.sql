--------------------------------------------------------
--  DDL for Trigger GHR_GROUPBOXES_AD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GHR_GROUPBOXES_AD" 
after delete on "HR"."GHR_GROUPBOXES"
for each row
begin
   ghr_api.ghr_gbx_index := ghr_api.ghr_gbx_index + 1;
   ghr_api.ghr_gbx_tab(ghr_api.ghr_gbx_index).groupbox_id := :old.groupbox_id;
end;


/
ALTER TRIGGER "APPS"."GHR_GROUPBOXES_AD" ENABLE;
