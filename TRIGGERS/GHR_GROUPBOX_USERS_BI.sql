--------------------------------------------------------
--  DDL for Trigger GHR_GROUPBOX_USERS_BI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GHR_GROUPBOX_USERS_BI" 
before insert or update or delete on "HR"."GHR_GROUPBOX_USERS"
for each row
begin
   ghr_api.ghr_gbx_user_index := 0;
end;


/
ALTER TRIGGER "APPS"."GHR_GROUPBOX_USERS_BI" ENABLE;
