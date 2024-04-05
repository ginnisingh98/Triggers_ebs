--------------------------------------------------------
--  DDL for Trigger GHR_GROUPBOXES_AI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GHR_GROUPBOXES_AI" 
after insert on "HR"."GHR_GROUPBOXES"
for each row
begin
   ghr_api.ghr_gbx_index := ghr_api.ghr_gbx_index + 1;
   ghr_api.ghr_gbx_tab(ghr_api.ghr_gbx_index).groupbox_id
              := :new.groupbox_id;
  ghr_api.ghr_gbx_tab(ghr_api.ghr_gbx_index).name := :new.name;
  ghr_api.ghr_gbx_tab(ghr_api.ghr_gbx_index).display_name := :new.display_name;
  ghr_api.ghr_gbx_tab(ghr_api.ghr_gbx_index).description := :new.description;
end GHR_GROUPBOXES_AI;


/
ALTER TRIGGER "APPS"."GHR_GROUPBOXES_AI" ENABLE;
