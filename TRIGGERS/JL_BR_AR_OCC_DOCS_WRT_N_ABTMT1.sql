--------------------------------------------------------
--  DDL for Trigger JL_BR_AR_OCC_DOCS_WRT_N_ABTMT1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JL_BR_AR_OCC_DOCS_WRT_N_ABTMT1" 
AFTER INSERT ON "AR"."AR_RECEIVABLE_APPLICATIONS_ALL"
FOR EACH ROW
  WHEN ((sys_context('JG','JGZZ_COUNTRY_CODE') in ('BR'))
OR (to_char(new.org_id) <> nvl(sys_context('JG','JGZZ_ORG_ID'),'XX'))) DECLARE

    X_count                        NUMBER;
    X_class                        ar_payment_schedules_all.class%TYPE;
    X_global_attribute11           VARCHAR2(01);
    X_amount_due_remaining         ar_payment_schedules_all.amount_due_remaining%TYPE;
    X_amount_due_original          ar_payment_schedules_all.amount_due_original%TYPE;
    X_std_occurrence_code          jl_br_ar_bank_occurrences.std_occurrence_code%TYPE;
    X_occurrence_id                jl_br_ar_occurrence_docs_all.occurrence_id%TYPE;
    X_document_id                  jl_br_ar_collection_docs_all.document_id%TYPE;
    X_bordero_id                   jl_br_ar_collection_docs_all.bordero_id%TYPE;
    --X_bank_number                jl_br_ar_occurrence_docs_all.bank_number%TYPE;
    X_bank_party_id                jl_br_ar_occurrence_docs_all.bank_party_id%TYPE;
    X_bank_occurrence_type         jl_br_ar_occurrence_docs_all.bank_occurrence_type%TYPE;
    X_bank_occurrence_code         jl_br_ar_occurrence_docs_all.bank_occurrence_code%TYPE;
    X_bank_occurrence_code1        jl_br_ar_occurrence_docs_all.bank_occurrence_code%TYPE;
    X_bank_occurrence_exists       BOOLEAN := TRUE;
    X_remittance_media             jl_br_ar_occurrence_docs_all.remittance_media%TYPE;
    X_bordero_type                 jl_br_ar_borderos_all.bordero_type%TYPE;

    X_endorsement_credit_ccid      NUMBER := NULL;
    X_endorsement_debit_ccid       NUMBER:= NULL;
    X_endorsement_debit_amount     NUMBER:= NULL;
    X_endorsement_credit_amount    NUMBER:= NULL;
    l_ps_rec                       ar_payment_schedules%ROWTYPE;
    l_country_code        VARCHAR2(100);

BEGIN

   IF (to_char(:new.org_id) <> nvl(sys_context('JG','JGZZ_ORG_ID'),'XX')) THEN

       l_country_code := JG_ZZ_SHARED_PKG.GET_COUNTRY(:new.org_id,NULL,NULL);

       JG_CONTEXT.name_value('JGZZ_COUNTRY_CODE',l_country_code);

       JG_CONTEXT.name_value('JGZZ_ORG_ID',to_char(:new.org_id));


    END IF;

   IF (sys_context('JG','JGZZ_COUNTRY_CODE') = 'BR') THEN

    IF NVL(:new.applied_payment_schedule_id,0) <> 0
    THEN
      SELECT class
      INTO   X_class
      FROM   ar_payment_schedules
      WHERE  payment_schedule_id = :new.payment_schedule_id;

      IF X_class = 'CM'
      THEN
        SELECT global_attribute11,
               amount_due_remaining,
               amount_due_original
        INTO   X_global_attribute11,
               X_amount_due_remaining,
               X_amount_due_original
        FROM   ar_payment_schedules
        WHERE  payment_schedule_id = :new.applied_payment_schedule_id;

        IF X_global_attribute11 = 'Y'
        THEN
          BEGIN
            SELECT doc.document_id,
                   doc.bordero_id,
                   bor.bordero_type
            INTO   X_document_id,
                   X_bordero_id,
                   X_bordero_type
            FROM   jl_br_ar_collection_docs doc,
                   jl_br_ar_borderos_all bor
            WHERE  doc.payment_schedule_id  = :new.applied_payment_schedule_id
                   AND doc.document_status not in
                        ('CANCELED','REFUSED','PARTIALLY_RECEIVED','WRITTEN_OFF')
                   AND bor.bordero_id = doc.bordero_id;

          EXCEPTION
            WHEN OTHERS THEN
              X_bank_occurrence_exists := FALSE;
          END;
/* Aviso de credito com o numero da nota incluso */

          IF X_bordero_type = 'COLLECTION' THEN

            IF :new.applied_customer_trx_line_id is null
            THEN
              IF (X_amount_due_remaining - :new.amount_applied) = 0
              THEN
                X_std_occurrence_code := 'WRITE_OFF_REQUISITION';
              ELSE
                X_std_occurrence_code := 'ABATEMENT_CONCESSION';
  		END IF;

  /* Aviso de credito sem informar o numero da nota - reaplicacao */

            ELSIF X_amount_due_remaining = 0
            THEN
              X_std_occurrence_code := 'WRITE_OFF_REQUISITION';
  	    ELSE
              X_std_occurrence_code := 'ABATEMENT_CONCESSION';
            END IF;

            BEGIN
              /* CE uptake - Bug#2932986
              SELECT boc.bank_number,
                     boc.bank_occurrence_code,
                     boc.bank_occurrence_type,
                     boc.remittance_media
              INTO   X_bank_number,
                     X_bank_occurrence_code,
                     X_bank_occurrence_type,
                     X_remittance_media
              FROM   jl_br_ar_borderos b,
                     jl_br_ar_bank_occurrences boc,
                     ap_bank_accounts_all acc,
                     ap_bank_branches bra
              WHERE  b.bank_account_id = acc.bank_account_id
                     AND acc.bank_branch_id = bra.bank_branch_id
                     AND b.bordero_id = X_bordero_id
                     AND boc.bank_number = bra.bank_number
                     AND boc.bank_occurrence_type = 'REMITTANCE_OCCURRENCE'
                     AND boc.std_occurrence_code  = X_std_occurrence_code;
              */

            SELECT boc.bank_party_id,
                   boc.bank_occurrence_code,
                   boc.bank_occurrence_type,
                   boc.remittance_media
            INTO   X_bank_party_id,
                   X_bank_occurrence_code,
                   X_bank_occurrence_type,
                   X_remittance_media
            FROM   jl_br_ar_borderos b,
                   jl_br_ar_bank_occurrences boc,
                   ce_bank_accounts acct,
                   ce_bank_acct_uses_all acctUse,
                   hz_parties HzPartyBank
             Where b.bank_acct_use_id = acctUse.bank_acct_use_id
                   And acctUse.bank_account_id = acct.bank_account_id
                   And acct.bank_id =  HzPartyBank.party_id
                   --And HzPartyBank.Country = 'BR'
                   AND boc.bank_party_id = HzPartyBank.party_id
                   AND b.bordero_id = X_bordero_id
                   AND boc.bank_occurrence_type = 'REMITTANCE_OCCURRENCE'
                   AND boc.std_occurrence_code  = X_std_occurrence_code;

              EXCEPTION
                WHEN OTHERS THEN
                  X_bank_occurrence_exists := FALSE;
            END;

            IF X_bank_occurrence_exists
            THEN
              SELECT jl_br_ar_occurrence_docs_s.nextval
              INTO   X_occurrence_id
              FROM   dual;

              IF X_std_occurrence_code = 'WRITE_OFF_REQUISITION'
              THEN
                /* CE uptake - Bug#2932986
                SELECT boc.bank_occurrence_code
                INTO   X_bank_occurrence_code1
                FROM   jl_br_ar_borderos b,
                       jl_br_ar_bank_occurrences boc,
                       ap_bank_accounts_all acc,
                       ap_bank_branches bra
                WHERE  b.bank_account_id = acc.bank_account_id
                       AND acc.bank_branch_id = bra.bank_branch_id
                       AND b.bordero_id = X_bordero_id
                       AND boc.bank_number = bra.bank_number
                       AND boc.bank_occurrence_type = 'REMITTANCE_OCCURRENCE'
                       AND boc.std_occurrence_code  = 'REMITTANCE';
                */

            SELECT boc.bank_occurrence_code
            INTO   X_bank_occurrence_code1
            FROM   jl_br_ar_borderos b,
                   jl_br_ar_bank_occurrences boc,
                   ce_bank_accounts acct,
                   ce_bank_acct_uses_all acctUse,
                   hz_parties HzPartyBank
             Where b.bank_acct_use_id = acctUse.bank_acct_use_id
                   And acct.bank_account_id = acctUse.bank_account_id
                   And acct.bank_id =  HzPartyBank.party_id
                   --And HzPartyBank.Country = 'BR'
                   AND boc.bank_party_id = HzPartyBank.party_id
                   AND b.bordero_id = X_bordero_id
                   AND boc.bank_occurrence_type = 'REMITTANCE_OCCURRENCE'
                   AND boc.std_occurrence_code  = 'REMITTANCE';

                SELECT endorsement_credit_ccid,
                       endorsement_debit_ccid,
                       endorsement_debit_amount,
                       endorsement_credit_amount
                INTO   X_endorsement_debit_ccid,
                       X_endorsement_credit_ccid,
                       X_endorsement_credit_amount,
                       X_endorsement_debit_amount
                FROM   jl_br_ar_occurrence_docs
                WHERE  document_id = X_document_id
                       AND bank_occurrence_code = X_bank_occurrence_code1
                       AND occurrence_status <> 'CANCELED';

                UPDATE jl_br_ar_collection_docs
                SET    document_status = 'WRITTEN_OFF',
                       previous_doc_status = document_status
                WHERE  document_id = X_document_id;

/*                UPDATE ar_payment_schedules
                SET    global_attribute11 = NULL
                WHERE  payment_schedule_id = :new.applied_payment_schedule_id;
*/

/* Replace Update by AR's table handler. Bug # 2249731 */

                arp_ps_pkg.fetch_p(:new.applied_payment_schedule_id, l_ps_rec);
                arp_ps_pkg.lock_p(:new.applied_payment_schedule_id);
                l_ps_rec.global_attribute11 := NULL;
                arp_ps_pkg.update_p(l_ps_rec, :new.applied_payment_schedule_id);


                SELECT count(*)
                INTO   X_count
                FROM   jl_br_ar_collection_docs
                WHERE  bordero_id = X_bordero_id
                       AND document_status not in
                                  ('CANCELED','WRITTEN_OFF','REFUSED');

                IF X_count = 0
                THEN
                  UPDATE jl_br_ar_borderos
                  SET    bordero_status = 'WRITE_OFF',
                         write_off_date = SYSDATE
                  WHERE bordero_id = X_bordero_id;
                END IF;

              END IF;

            -- CE uptake - Bug#2932986 ; insert party_id instead of bank_number
            IF (x_std_occurrence_code = 'WRITE_OFF_REQUISITION' OR (x_std_occurrence_code = 'ABATEMENT_CONCESSION' and :new.amount_applied > 0 )) THEN --Bug 9501221
              INSERT INTO jl_br_ar_occurrence_docs
                (
                occurrence_id,
                last_update_date,
                last_updated_by,
                last_update_login,
                creation_date,
                created_by,
                document_id,
                gl_date,
                bank_occurrence_code,
                --bank_number,
                bank_party_id,
                bank_occurrence_type,
                occurrence_date,
                occurrence_status,
                original_remittance_media,
                remittance_media,
                document_amount,
                abatement_amount,
                endorsement_credit_ccid,
                endorsement_debit_ccid,
                endorsement_debit_amount,
                endorsement_credit_amount,
                org_id
                )
                VALUES
                (
                X_occurrence_id,
                SYSDATE,
                :new.last_updated_by,
                :new.last_update_login,
                SYSDATE,
                :new.created_by,
                X_document_id,
                sysdate,
                X_bank_occurrence_code,
                --X_bank_number,
                X_bank_party_id,
                X_bank_occurrence_type,
                :new.apply_date,
                'CREATED',
                X_remittance_media,
                X_remittance_media,
                X_amount_due_original,
                :new.amount_applied,
                X_endorsement_credit_ccid,
                X_endorsement_debit_ccid,
                X_endorsement_debit_amount,
                X_endorsement_credit_amount,
                :new.org_id
                );

              END IF;

            END IF;

          END IF;

        END IF;

      END IF;

    END IF;

   END IF;

END;

/
ALTER TRIGGER "APPS"."JL_BR_AR_OCC_DOCS_WRT_N_ABTMT1" ENABLE;
