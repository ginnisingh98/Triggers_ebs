--------------------------------------------------------
--  DDL for Trigger GHR_MASS_ACTIONS_PREVIEW_INS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GHR_MASS_ACTIONS_PREVIEW_INS" BEFORE INSERT ON "HR"."GHR_MASS_ACTIONS_PREVIEW" FOR EACH ROW

begin
  if :new.MASS_ACTION_PREVIEW_ID is null then
       select ghr_mass_actions_preview_s.nextval
         into :new.mass_action_preview_id
         from dual;
   end if;
end;



/
ALTER TRIGGER "APPS"."GHR_MASS_ACTIONS_PREVIEW_INS" ENABLE;
