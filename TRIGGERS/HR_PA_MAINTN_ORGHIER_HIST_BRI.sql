--------------------------------------------------------
--  DDL for Trigger HR_PA_MAINTN_ORGHIER_HIST_BRI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."HR_PA_MAINTN_ORGHIER_HIST_BRI" 
-- $Header: pahrpose.sql 115.5 2003/06/04 00:49:51 ramurthy ship $
BEFORE INSERT
ON "HR"."PER_ORG_STRUCTURE_ELEMENTS"
FOR EACH ROW
DECLARE
  v_return_status varchar2(10);
BEGIN
null;
END;



/
ALTER TRIGGER "APPS"."HR_PA_MAINTN_ORGHIER_HIST_BRI" ENABLE;
