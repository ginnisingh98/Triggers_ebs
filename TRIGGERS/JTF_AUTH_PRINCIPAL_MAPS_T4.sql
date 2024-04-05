--------------------------------------------------------
--  DDL for Trigger JTF_AUTH_PRINCIPAL_MAPS_T4
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JTF_AUTH_PRINCIPAL_MAPS_T4" before insert on JTF.jtf_auth_principal_maps
for each row
begin
  select jtf_auth_s1.nextval into :new.jtf_auth_principal_mapping_id from dual;
end;


/
ALTER TRIGGER "APPS"."JTF_AUTH_PRINCIPAL_MAPS_T4" ENABLE;
