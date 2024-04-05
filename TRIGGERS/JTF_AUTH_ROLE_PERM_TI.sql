--------------------------------------------------------
--  DDL for Trigger JTF_AUTH_ROLE_PERM_TI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JTF_AUTH_ROLE_PERM_TI" before insert on JTF.jtf_auth_role_perms
for each row
begin
  select jtf_auth_s1.nextval into :new.JTF_AUTH_ROLE_PERMISSION_ID from dual;
end;


/
ALTER TRIGGER "APPS"."JTF_AUTH_ROLE_PERM_TI" ENABLE;
