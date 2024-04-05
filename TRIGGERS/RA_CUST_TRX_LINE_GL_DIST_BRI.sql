--------------------------------------------------------
--  DDL for Trigger RA_CUST_TRX_LINE_GL_DIST_BRI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."RA_CUST_TRX_LINE_GL_DIST_BRI" 
/*$Header: arpltgld.sql 120.14.12010000.3 2009/02/25 16:31:38 mraymond ship $*/
BEFORE INSERT OR DELETE OR UPDATE ON "AR"."RA_CUST_TRX_LINE_GL_DIST_ALL"
referencing new as new
            old as old
FOR EACH ROW

DECLARE
  delete_error EXCEPTION;
/*  l_conc_program_id NUMBER      := fnd_global.conc_program_id; Bug 3411026*/
  l_conc_name       VARCHAR2(30);
BEGIN
 /* Retained previous logic for insert */

 IF INSERTING THEN
    IF (:new.account_class = 'REC') AND (:new.latest_rec_flag IS NULL)THEN
       :new.latest_rec_flag := 'Y';
    END IF;

    /* Bug 4029814 */
    IF (:new.cust_trx_line_gl_dist_id IS NULL)
    THEN
      SELECT ra_cust_trx_line_gl_dist_s.nextval
      INTO   :new.cust_trx_line_gl_dist_id
      FROM   dual;
    END IF;
 END IF;

 /* Added code to ensure, posted records are not deleted */
 /* Posted records can only be deleted when doing archive and purge*/

 IF DELETING OR UPDATING THEN

/*Moved this to the package ARP_GLOBAL, bug 3411026

   IF l_conc_program_id IS NOT NULL THEN
    BEGIN
        SELECT concurrent_program_name
        INTO   l_conc_name
        FROM   fnd_concurrent_programs_vl
        WHERE  concurrent_program_id = l_conc_program_id
          AND  application_id = 222;

    EXCEPTION
    WHEN others THEN
      l_conc_name := 'NONE';
    END;
   END IF; */

   l_conc_name := ARP_GLOBAL.conc_program_name;
/* Bug 5153036 and 5364951 changed the IF condition for conc_program name*/
/* 7291422 - Added CSTRCMCR to exclusion list */
     IF NVL(l_conc_name,'NONE') not in ( 'ARPURGE' , 'ARARCPUR', 'ARGLTP',
                                         'CSTRCMCR')
     THEN

     IF (DELETING) OR
        ((UPDATING) AND
         ((nvl(:new.amount,0.000000000001)
                                <> nvl(:old.amount,0.000000000001)) OR
         (nvl(:new.acctd_amount,0.000000000001)
                          <> nvl(:old.acctd_amount,0.000000000001)) OR
         (nvl(:new.gl_date,to_date('31-12-4172','DD-MM-RRRR'))
                    <>  nvl(:old.gl_date,to_date('31-12-4172','DD-MM-RRRR'))) OR
         (nvl(:new.code_combination_id,0.000000000001)
                          <>  nvl(:old.code_combination_id,0.000000000001)) OR
         (nvl(:new.posting_control_id,0.000000000001)
                          <> nvl(:old.posting_control_id,0.000000000001)))
        )
      THEN
       IF :old.posting_control_id <> -3
          and  :old.posting_control_id <> -600 and
          /* Bug 3146233 : added code to check for global variable g_allow_datafix */
          NOT arp_global.g_allow_datafix THEN
             raise delete_error;
       END IF;
     END IF;
    END IF ;

 END IF;

EXCEPTION
  WHEN delete_error THEN
    fnd_message.set_name('AR', 'AR_ALL_CANT_DELETE_IF_POSTED');
    RAISE_APPLICATION_ERROR(-20001, fnd_message.get);
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20001,SQLERRM);
END;

/
ALTER TRIGGER "APPS"."RA_CUST_TRX_LINE_GL_DIST_BRI" ENABLE;
