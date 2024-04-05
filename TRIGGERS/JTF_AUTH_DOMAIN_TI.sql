--------------------------------------------------------
--  DDL for Trigger JTF_AUTH_DOMAIN_TI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JTF_AUTH_DOMAIN_TI" before insert on JTF.jtf_auth_domains_b
for each row
begin
  select jtf_auth_s1.nextval into :new.jtf_auth_domain_id from dual;
end;


/
ALTER TRIGGER "APPS"."JTF_AUTH_DOMAIN_TI" ENABLE;
