--------------------------------------------------------
--  DDL for Trigger JL_BR_AR_OCC_DOCS_DUE_DATE_CHG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JL_BR_AR_OCC_DOCS_DUE_DATE_CHG" 
AFTER UPDATE OF due_date
ON "AR"."AR_PAYMENT_SCHEDULES_ALL"
FOR EACH ROW
  WHEN ((sys_context('JG','JGZZ_COUNTRY_CODE') in ('BR'))
OR (to_char(new.org_id) <> nvl(sys_context('JG','JGZZ_ORG_ID'),'XX'))) DECLARE

    X_occurrence_id          jl_br_ar_occurrence_docs_all.occurrence_id%TYPE;
    X_document_id            jl_br_ar_collection_docs_all.document_id%TYPE;
    X_bordero_id             jl_br_ar_collection_docs_all.bordero_id%TYPE;
    --X_bank_number          jl_br_ar_occurrence_docs_all.bank_number%TYPE;
    X_bank_party_id          jl_br_ar_occurrence_docs_all.bank_party_id%TYPE;
    X_bank_occurrence_type   jl_br_ar_occurrence_docs_all.bank_occurrence_type%TYPE;
    X_bank_occurrence_code   jl_br_ar_occurrence_docs_all.bank_occurrence_code%TYPE;
    X_bank_occurrence_exists BOOLEAN := TRUE;
    X_remittance_media       jl_br_ar_occurrence_docs_all.remittance_media%TYPE;
    X_bordero_type           jl_br_ar_borderos_all.bordero_type%TYPE;
    l_country_code           VARCHAR2(100);

BEGIN

    IF (to_char(:new.org_id) <> nvl(sys_context('JG','JGZZ_ORG_ID'),'XX')) THEN

       l_country_code := JG_ZZ_SHARED_PKG.GET_COUNTRY(:new.org_id,NULL,NULL);

       JG_CONTEXT.name_value('JGZZ_COUNTRY_CODE',l_country_code);

       JG_CONTEXT.name_value('JGZZ_ORG_ID',to_char(:new.org_id));

    END IF;

   IF (sys_context('JG','JGZZ_COUNTRY_CODE') = 'BR') THEN

    IF (:new.global_attribute11 = 'Y') and (:old.due_date <> :new.due_date)
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
        WHERE  doc.payment_schedule_id = :new.payment_schedule_id
               AND bor.bordero_id = doc.bordero_id
               AND doc.document_status not in
                  ('CANCELED','TOTALLY_RECEIVED', 'REFUSED', 'PARTIALLY_RECEIVED','WRITTEN_OFF');

        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            X_bank_occurrence_exists := FALSE;
        END;

      IF X_bordero_type in ('COLLECTION','FACTORING') THEN

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
                   AND boc.std_occurrence_code  = 'DUE_DATE_CHANGING';
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
                   AND boc.std_occurrence_code  = 'DUE_DATE_CHANGING';

            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                X_bank_occurrence_exists := FALSE;
            END;

          IF X_bank_occurrence_exists
          THEN

            SELECT jl_br_ar_occurrence_docs_s.nextval
            INTO   X_occurrence_id
            FROM   dual;

            -- CE uptake - Bug#2932986 ; insert party_id instead of bank_number
            INSERT INTO jl_br_ar_occurrence_docs
              (
              occurrence_id,
              last_update_date,
              last_updated_by,
              last_update_login,
              creation_date,
              created_by,
              document_id,
              bank_occurrence_code,
              --bank_number,
              bank_party_id,
              bank_occurrence_type,
              occurrence_date,
              occurrence_status,
              original_remittance_media,
              remittance_media,
              selection_date,
              bordero_id,
              portfolio_code,
              trade_note_number,
              due_date,
              document_amount,
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
              X_bank_occurrence_code,
              --X_bank_number,
              X_bank_party_id,
              X_bank_occurrence_type,
              SYSDATE,
              'CREATED',
              X_remittance_media,
              X_remittance_media,
              NULL,
              NULL,
              NULL,
              NULL,
              :new.due_date,
              :new.amount_due_original,
              :new.org_id
              );

          END IF;

      END IF;

    END IF;
   END IF;

END;

/
ALTER TRIGGER "APPS"."JL_BR_AR_OCC_DOCS_DUE_DATE_CHG" DISABLE;
