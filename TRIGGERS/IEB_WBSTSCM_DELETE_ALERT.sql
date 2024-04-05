--------------------------------------------------------
--  DDL for Trigger IEB_WBSTSCM_DELETE_ALERT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."IEB_WBSTSCM_DELETE_ALERT" 
 AFTER DELETE
 ON "IEB"."IEB_WBST_WB_SC_RULES"
 FOR EACH ROW
BEGIN
DBMS_ALERT.SIGNAL('IEB_WBSTSCM_DELETE_ALERT', CONCAT(TO_CHAR(:old.WBSKTR_WBSKTR_ID), CONCAT(':', TO_CHAR(:old.WBSCRULE_WBSCRULE_ID))));
END IEB_WBSTSCM_DELETE_ALERT;



/
ALTER TRIGGER "APPS"."IEB_WBSTSCM_DELETE_ALERT" ENABLE;
