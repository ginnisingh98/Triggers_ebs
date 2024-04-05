--------------------------------------------------------
--  DDL for Trigger JL_BR_AR_OCC_DOCS_DIS_N_OTHER
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JL_BR_AR_OCC_DOCS_DIS_N_OTHER" 
AFTER UPDATE OF global_attribute2,
                global_attribute1,
                global_attribute3,
                global_attribute5
ON "AR"."RA_CUSTOMER_TRX_ALL"
FOR EACH ROW
  WHEN ((sys_context('JG','JGZZ_COUNTRY_CODE') in ('BR'))
OR (to_char(new.org_id) <> nvl(sys_context('JG','JGZZ_ORG_ID'),'XX'))) DECLARE

  X_global_attribute2      NUMBER := NULL;
  X_global_attribute1      VARCHAR2(1) := NULL;
  X_global_attribute3      NUMBER := NULL;
  X_global_attribute5      NUMBER := NULL;
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
  l_country_code    VARCHAR2(100);

  CURSOR ps (p_customer_trx_id IN NUMBER) IS
    SELECT payment_schedule_id,
           amount_due_original
    FROM   ar_payment_schedules
    WHERE  customer_trx_id = p_customer_trx_id
           AND global_attribute11 = 'Y';

BEGIN

    IF (to_char(:new.org_id) <> nvl(sys_context('JG','JGZZ_ORG_ID'),'XX')) THEN

       l_country_code := JG_ZZ_SHARED_PKG.GET_COUNTRY(:new.org_id,NULL,NULL);

       JG_CONTEXT.name_value('JGZZ_COUNTRY_CODE',l_country_code);

       JG_CONTEXT.name_value('JGZZ_ORG_ID',to_char(:new.org_id));

    END IF;

    IF (sys_context('JG','JGZZ_COUNTRY_CODE') = 'BR') THEN

    IF NVL(:old.global_attribute5,'X') <> NVL(:new.global_attribute5,'X')
      OR NVL(:old.global_attribute1,'X') <> NVL(:new.global_attribute1, 'X')
      OR ((NVL(:old.global_attribute3,'X') <> NVL(:new.global_attribute3,'X'))
         AND fnd_number.canonical_to_number(NVL(:new.global_attribute3,'0')) <> 0)
      OR ((NVL(:old.global_attribute2,'X') <> NVL(:new.global_attribute2,'X'))
         AND fnd_number.canonical_to_number(NVL(:new.global_attribute2,'0')) <> 0)
    THEN

      IF NVL(:old.global_attribute5,'X') <> NVL(:new.global_attribute5,'X')
      THEN
        X_global_attribute5 := fnd_number.canonical_to_number(:new.global_attribute5);
      END IF;

      IF NVL(:old.global_attribute1, 'X') <> NVL(:new.global_attribute1, 'X')
      THEN
        X_global_attribute1  := :new.global_attribute1;
      END IF;

      IF NVL(:old.global_attribute3,'X') <> NVL(:new.global_attribute3,'X')
      THEN
        X_global_attribute3    := fnd_number.canonical_to_number(:new.global_attribute3);
      END IF;

      IF NVL(:old.global_attribute2,'X') <> NVL(:new.global_attribute2,'X')
        AND fnd_number.canonical_to_number(NVL(:new.global_attribute2,'0')) <> 0
      THEN
        X_global_attribute2 := fnd_number.canonical_to_number(:new.global_attribute2);
      END IF;

      FOR c_ps IN ps (:new.customer_trx_id)
      LOOP
        BEGIN
          SELECT   doc.document_id,
                   doc.bordero_id,
                   bor.bordero_type
          INTO     X_document_id,
                   X_bordero_id,
                   X_bordero_type
          FROM     jl_br_ar_collection_docs doc,
                   jl_br_ar_borderos_all bor
          WHERE    doc.payment_schedule_id = c_ps.payment_schedule_id
                   AND bor.bordero_id = doc.bordero_id
                   AND doc.document_status not in
                     ('CANCELED','REFUSED','PARTIALLY_RECEIVED','WRITTEN_OFF');

       EXCEPTION
          WHEN NO_DATA_FOUND THEN
             X_bank_occurrence_exists := FALSE;
        END;
        IF X_bordero_type = 'COLLECTION' THEN
          BEGIN
            X_bank_occurrence_exists := TRUE;

            /* CE uptake - Bug#2932986
            SELECT   boc.bank_number,
                     boc.bank_occurrence_code,
                     boc.bank_occurrence_type,
                     boc.remittance_media
            INTO     X_bank_number,
                     X_bank_occurrence_code,
                     X_bank_occurrence_type,
                     X_remittance_media
            FROM     jl_br_ar_borderos b,
                     jl_br_ar_bank_occurrences boc,
                     ap_bank_accounts_all acc,
                     ap_bank_branches bra
            WHERE    b.bank_account_id = acc.bank_account_id
                     AND acc.bank_branch_id = bra.bank_branch_id
                     AND b.bordero_id = X_bordero_id
                     AND boc.bank_number = bra.bank_number
                     AND boc.bank_occurrence_type = 'REMITTANCE_OCCURRENCE'
                     AND boc.std_occurrence_code  = 'OTHER_DATA_CHANGING';
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
                   And acct.bank_account_id = acctUse.bank_account_id
                   And acct.bank_id =  HzPartyBank.party_id
                   --And HzPartyBank.Country = 'BR'
                   AND boc.bank_party_id = HzPartyBank.party_id
                   AND b.bordero_id = X_bordero_id
                   AND boc.bank_occurrence_type = 'REMITTANCE_OCCURRENCE'
                   AND boc.std_occurrence_code  = 'OTHER_DATA_CHANGING';

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
              document_amount,
              interest_indicator,
              interest_percent,
              interest_period,
              interest_amount,
              grace_days,
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
              c_ps.amount_due_original,
              decode(X_global_attribute1,'','N','Y'),
              decode(X_global_attribute1,'R',X_global_attribute2,''),
              X_global_attribute3,
              decode(X_global_attribute1,'A',X_global_attribute2,''),
              X_global_attribute5,
              :new.org_id
              );

          END IF;

        END IF;

      END LOOP;

    END IF;

    IF NVL(:new.global_attribute2,'X') <> NVL(:old.global_attribute2,'X')
    THEN
      IF fnd_number.canonical_to_number(NVL(:new.global_attribute2,'0'))  = 0
      THEN
        FOR c_ps IN ps (:new.customer_trx_id)
        LOOP
          SELECT   doc.document_id,
                   doc.bordero_id,
                   bor.bordero_type
          INTO     X_document_id,
                   X_bordero_id,
                   X_bordero_type
          FROM     jl_br_ar_collection_docs doc,
                   jl_br_ar_borderos_all bor
          WHERE    doc.payment_schedule_id  = c_ps.payment_schedule_id
                   AND bor.bordero_id = doc.bordero_id
                   AND doc.document_status not in
                       ('CANCELED','REFUSED','PARTIALLY_RECEIVED','WRITTEN_OFF');

          IF X_bordero_type = 'COLLECTION' THEN

            BEGIN
              X_bank_occurrence_exists := TRUE;

              /* CE uptake - Bug#2932986
              SELECT   boc.bank_number,
                       boc.bank_occurrence_code,
                       boc.bank_occurrence_type,
                       boc.remittance_media
              INTO     X_bank_number,
                       X_bank_occurrence_code,
                       X_bank_occurrence_type,
                       X_remittance_media
              FROM     jl_br_ar_borderos b,
                       jl_br_ar_bank_occurrences boc,
                       ap_bank_accounts_all acc,
                       ap_bank_branches bra
              WHERE    b.bank_account_id = acc.bank_account_id
                       AND acc.bank_branch_id = bra.bank_branch_id
                       AND b.bordero_id = X_bordero_id
                       AND boc.bank_number = bra.bank_number
                       AND boc.bank_occurrence_type = 'REMITTANCE_OCCURRENCE'
                       AND boc.std_occurrence_code  =
                                             'DISCHARGE_INTEREST_COLLECTION';
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
                   AND boc.std_occurrence_code  =
                                             'DISCHARGE_INTEREST_COLLECTION';


              EXCEPTION
                WHEN NO_DATA_FOUND
                THEN
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
                c_ps.amount_due_original,
                :new.org_id
                );

            END IF;

          END IF;

        END LOOP;

      END IF;

    END IF;

    END IF;
END;

/
ALTER TRIGGER "APPS"."JL_BR_AR_OCC_DOCS_DIS_N_OTHER" ENABLE;
