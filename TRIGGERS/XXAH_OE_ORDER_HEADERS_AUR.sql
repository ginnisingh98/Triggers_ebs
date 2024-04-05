--------------------------------------------------------
--  DDL for Trigger XXAH_OE_ORDER_HEADERS_AUR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XXAH_OE_ORDER_HEADERS_AUR" 
AFTER UPDATE OF FLOW_STATUS_CODE
ON "ONT"."OE_ORDER_HEADERS_ALL"
REFERENCING OLD AS OLD
            NEW AS NEW
FOR EACH ROW
   WHEN (OLD.FLOW_STATUS_CODE <> 'BOOKED'
 AND NEW.FLOW_STATUS_CODE = 'BOOKED') DECLARE
 PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
/**************************************************************************
 * VERSION      : $Id$
 * DESCRIPTION  : Call business event when sales order gets booked
 *
 * Date        Authors           Change reference/Description
 * ----------- ----------------- ----------------------------------
 * 14-SEP-2010 Kevin Bouwmeester Genesis
 *  5-NOV-2010 Joost Voordouw    logging added
 *************************************************************************/

 fnd_log.STRING(LOG_LEVEL => fnd_log.LEVEL_STATEMENT, MODULE => 'XXAH_OE_ORDER_HEADERS_AUR', MESSAGE =>  'WF_EVENT.raise: OLD.FLOW_STATUS_CODE=' || :OLD.FLOW_STATUS_CODE  ||
' NEW.FLOW_STATUS_CODE=' || :NEW.FLOW_STATUS_CODE );

WF_EVENT.raise
( p_event_name => 'oracle.apps.xxah.oe.order.booked'
, p_event_key  => :NEW.header_id
);
COMMIT;

END XXAH_OE_ORDER_HEADERS_AUR;


/
ALTER TRIGGER "APPS"."XXAH_OE_ORDER_HEADERS_AUR" ENABLE;
