--------------------------------------------------------
--  DDL for Trigger IBY_ACTIVITY_TRIG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."IBY_ACTIVITY_TRIG" before insert on "IBY"."IBY_ACTIVITY"
for each row
begin

select iby_activity_s.nextval into :new.jtf_act_activity_logs_id from dual;

end;




/
ALTER TRIGGER "APPS"."IBY_ACTIVITY_TRIG" ENABLE;
