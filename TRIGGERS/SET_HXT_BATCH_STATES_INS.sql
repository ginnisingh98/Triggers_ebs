--------------------------------------------------------
--  DDL for Trigger SET_HXT_BATCH_STATES_INS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."SET_HXT_BATCH_STATES_INS" AFTER INSERT ON  "HR"."PAY_BATCH_HEADERS" REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW  
BEGIN

if hr_general.g_data_migrator_mode <> 'Y' then
   INSERT INTO HXT_BATCH_STATES(BATCH_ID, STATUS)
   VALUES( :NEW.BATCH_ID, 'H');
--END GLOBAL
end if;
 EXCEPTION
  WHEN OTHERS THEN
    DECLARE
     v_error VARCHAR2(300) := SQLERRM;
     l_EXCEP_seqno NUMBER;   --- the next sequence number for new error record
    BEGIN
if hr_general.g_data_migrator_mode <> 'Y' then
     SELECT hxt_seqno.nextval
     INTO l_EXCEP_seqno
     FROM dual;

     INSERT INTO HXT_ERRORS_F (
       ID,
       EFFECTIVE_START_DATE,
       EFFECTIVE_END_DATE,
       ERROR_MSG,
       CREATION_DATE,
       LOCATION,
       CREATED_BY,
       ERR_TYPE,
       TIM_ID,
       HRW_ID,
       PTP_ID,
       ORA_MESSAGE,
       PPB_ID)
     VALUES(
       l_EXCEP_seqno,
       hr_general.start_of_time,
       hr_general.end_of_time,
       'Could not insert into HXT_BATCH_STATES. Sqlerror = '||v_error,
       sysdate,
       'HXT_BATCH_STATES_INS trigger',
       1,
       'NEW',
       0,0,0,
       '',
       :NEW.BATCH_ID);
end if;
    END;
END;



/
ALTER TRIGGER "APPS"."SET_HXT_BATCH_STATES_INS" ENABLE;
