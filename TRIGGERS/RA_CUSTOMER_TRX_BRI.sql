--------------------------------------------------------
--  DDL for Trigger RA_CUSTOMER_TRX_BRI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."RA_CUSTOMER_TRX_BRI" 
/* $Header: arplttrx.sql 120.2 2005/10/30 04:08:10 appldev ship $ */
BEFORE INSERT ON "AR"."RA_CUSTOMER_TRX_ALL" FOR EACH ROW
BEGIN
   IF :new.invoicing_rule_id IS NOT NULL THEN
      arp_queue.enqueue(system.ar_rev_rec_typ(:new.customer_trx_id,
					  NVL(arp_global.sysparam.org_id, 0),
					  :new.created_from,
					  :new.trx_number));
   END IF;
EXCEPTION
   WHEN OTHERS THEN
      arp_standard.debug( 'Exception:ra_customer_trx_bri');
      arp_standard.debug( 'Not able to enqueue the message');
      RAISE;
END;


/
ALTER TRIGGER "APPS"."RA_CUSTOMER_TRX_BRI" ENABLE;
