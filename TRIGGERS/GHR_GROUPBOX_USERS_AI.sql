--------------------------------------------------------
--  DDL for Trigger GHR_GROUPBOX_USERS_AI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GHR_GROUPBOX_USERS_AI" after INSERT on
"HR"."GHR_GROUPBOX_USERS"
for each row
begin
   ghr_api.ghr_gbx_user_index := ghr_api.ghr_gbx_user_index + 1;
   ghr_api.ghr_gbx_user_new_tab(ghr_api.ghr_gbx_user_index).groupbox_id
              := :new.groupbox_id;
   ghr_api.ghr_gbx_user_new_tab(ghr_api.ghr_gbx_user_index).user_name := :new.user_name;

end GHR_GROUPBOX_USERS_AI;


/
ALTER TRIGGER "APPS"."GHR_GROUPBOX_USERS_AI" ENABLE;
