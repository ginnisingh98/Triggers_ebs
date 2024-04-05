--------------------------------------------------------
--  DDL for Trigger FM_ROUT_DTL_AD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FM_ROUT_DTL_AD" AFTER DELETE ON "GMD"."FM_ROUT_DTL" FOR EACH ROW BEGIN IF fnd_audit_pkg.audit_on THEN FM_ROUT_DTL_ADP(:old.ROUTINGSTEP_NO,:old.ROUTING_ID,:old.OPRN_ID,:old.ROUTINGSTEP_ID,:old.STEPRELEASE_TYPE,:old.STEP_QTY,:new.ROUTINGSTEP_NO,:new.ROUTING_ID,:new.OPRN_ID,:new.ROUTINGSTEP_ID,:new.STEPRELEASE_TYPE,:new.STEP_QTY);END IF;END;

/
ALTER TRIGGER "APPS"."FM_ROUT_DTL_AD" ENABLE;
