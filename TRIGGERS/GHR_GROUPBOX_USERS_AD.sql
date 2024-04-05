--------------------------------------------------------
--  DDL for Trigger GHR_GROUPBOX_USERS_AD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GHR_GROUPBOX_USERS_AD" 
  after DELETE on "HR"."GHR_GROUPBOX_USERS"
for each row
begin

   ghr_api.ghr_gbx_user_index := ghr_api.ghr_gbx_user_index + 1;
   ghr_api.ghr_gbx_user_old_tab(ghr_api.ghr_gbx_user_index).groupbox_id
              := :old.groupbox_id;
   ghr_api.ghr_gbx_user_old_tab(ghr_api.ghr_gbx_user_index).user_name := :old.user_name;

end GHR_GROUPBOX_USERS_AD;


/
ALTER TRIGGER "APPS"."GHR_GROUPBOX_USERS_AD" ENABLE;
