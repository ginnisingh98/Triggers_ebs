--------------------------------------------------------
--  DDL for Trigger XXAH_VA_ACTIVE_DATE_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XXAH_VA_ACTIVE_DATE_T1" 
  BEFORE INSERT OR UPDATE ON ONT.OE_BLANKET_HEADERS_ALL
REFERENCING OLD AS OLD
            NEW AS NEW
  FOR EACH ROW
declare
	l_flow_status_old			OE_BLANKET_HEADERS_ALL.flow_status_code%type;
	l_flow_status_new			OE_BLANKET_HEADERS_ALL.flow_status_code%type;

BEGIN
  l_flow_status_new := :new.flow_status_code;
  l_flow_status_old := :old.flow_status_code;



  IF l_flow_status_new <> l_flow_status_old
  AND l_flow_status_new = 'ACTIVE'
  THEN
     :new.attribute13 := fnd_date.date_to_canonical(sysdate);
  END IF;



end XXAH_VA_ACTIVE_DATE_T1;

/
ALTER TRIGGER "APPS"."XXAH_VA_ACTIVE_DATE_T1" ENABLE;
