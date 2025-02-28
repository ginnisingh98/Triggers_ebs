--------------------------------------------------------
--  DDL for Trigger IEB_WB_SKILL_TRANS_ALERT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."IEB_WB_SKILL_TRANS_ALERT" 
 AFTER INSERT OR UPDATE OF SKILL_CATEGORY, SKILL_CONTENTS, WBSKTR_ID
 ON "IEB"."IEB_WB_SKILL_TRANS"
 FOR EACH ROW
BEGIN
DBMS_ALERT.SIGNAL('IEB_WB_SKILL_TRANS_ALERT', TO_CHAR(:new.WBSKTR_ID));
END IEB_WB_SKILL_TRANS_ALERT;



/
ALTER TRIGGER "APPS"."IEB_WB_SKILL_TRANS_ALERT" ENABLE;
