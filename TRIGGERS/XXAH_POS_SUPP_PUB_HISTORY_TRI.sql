--------------------------------------------------------
--  DDL for Trigger XXAH_POS_SUPP_PUB_HISTORY_TRI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XXAH_POS_SUPP_PUB_HISTORY_TRI" 
AFTER INSERT  ON "POS"."POS_SUPP_PUB_HISTORY"
FOR EACH ROW
DECLARE

BEGIN
WF_EVENT.RAISE(p_event_name => 'xxah.oracle.apps.pos.supplier.publish',
          p_event_key    => :NEW.PUBLICATION_EVENT_ID,
          p_event_data   => null,
          p_parameters   => null
       );

END XXAH_POS_SUPP_PUB_HISTORY_TRI;

/
ALTER TRIGGER "APPS"."XXAH_POS_SUPP_PUB_HISTORY_TRI" ENABLE;
