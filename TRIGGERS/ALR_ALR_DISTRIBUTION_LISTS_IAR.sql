--------------------------------------------------------
--  DDL for Trigger ALR_ALR_DISTRIBUTION_LISTS_IAR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."ALR_ALR_DISTRIBUTION_LISTS_IAR" after insert on "ALR"."ALR_DISTRIBUTION_LISTS" for each row 
declare MAILID varchar2(255):=null;REQID NUMBER; RETVAL boolean;ORGID varchar2(255);begin select rtrim(substr(userenv('CLIENT_INFO'),1,10)) into ORGID from dual;if (USER not in ('NONE')) then return;end if;if fnd_profile.value('RESP_ID') is not null then fnd_profile.get('EMAIL_ADDRESS',MAILID);if MAILID is null then if alr_profile.value('DEFAULT_USER_MAIL_ACCOUNT')!='O' then fnd_profile.get('USERNAME',MAILID);else fnd_profile.get('SIGNONAUDIT:LOGIN_NAME',MAILID);end if;if MAILID is null then MAILID:='MAILID';end if;end if;RETVAL:=FND_REQUEST.SET_MODE(DB_TRIGGER => TRUE);RETVAL:=FND_REQUEST.SET_OPTIONS(IMPLICIT => 'ERROR');REQID:=FND_REQUEST.SUBMIT_REQUEST('ALR','ALECTC','ALR_DISTRIBUTION_LISTS',NULL,FALSE,USER,'ALR_DISTRIBUTION_LISTS',rowidtochar(:new.rowid),'I',mailid,ORGID);if REQID=0 then raise_application_error(-20160, FND_MESSAGE.GET);end if;end if;end;


/
ALTER TRIGGER "APPS"."ALR_ALR_DISTRIBUTION_LISTS_IAR" DISABLE;
