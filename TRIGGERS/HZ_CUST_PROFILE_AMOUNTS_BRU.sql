--------------------------------------------------------
--  DDL for Trigger HZ_CUST_PROFILE_AMOUNTS_BRU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."HZ_CUST_PROFILE_AMOUNTS_BRU" 
/* $Header: arplt13.sql 120.2 2006/07/25 11:38:45 balkumar noship $  */

BEFORE UPDATE ON "AR"."HZ_CUST_PROFILE_AMTS"
FOR EACH ROW
DECLARE
  OverallCredit   varchar2(25) := null;
  TrxCredit       varchar2(25) := null;
  ChangesMade     varchar2(1)  := 'N';
BEGIN
  IF (( :new.overall_credit_limit <> :old.overall_credit_limit) OR
      ( :new.overall_credit_limit is null         and
        :old.overall_credit_limit is not null )                 OR
      ( :new.overall_credit_limit is not null     and
        :old.overall_credit_limit is null ))                    THEN

     OverallCredit      := :old.overall_credit_limit;

     /* IF FIELD VALUE OF overall_credit_limit   IS CHANGED THEN SET */
     /* THE VALUE OF THIS VARIABLE TO Y                              */

     ChangesMade         := 'Y';

  END IF;

  IF (( :new.trx_credit_limit <> :old.trx_credit_limit) OR
      ( :new.trx_credit_limit is null            and
        :old.trx_credit_limit is not null )             OR
      ( :new.trx_credit_limit is not null        and
        :old.trx_credit_limit is null ))                THEN

     TrxCredit           := :old.trx_credit_limit;

     /* IF FIELD VALUE OF trx_credit_limit   IS CHANGED THEN SET */
     /* THE VALUE OF THIS VARIABLE TO Y                          */

     ChangesMade         := 'Y';

  END IF;

  /* WHEN THE VALUE OF ANY OF THE ABOVE FIELD CHANGES THEN INSERT */
  /* IN TABLE AR_CREDIT_HISTORIES                                 */

 /* Bug 4672598 New columns credit_info_updated_by, credit_info_update_date, */
 /* credit_info_update_login required in AR_CREDIT_HISTORIES to track who */
 /* updated credit limit in HZ_CUST_PROFILE_AMTS table. */

  IF ChangesMade         = 'Y' THEN

     INSERT INTO ar_credit_histories
       (credit_history_id,
        last_updated_by,
        last_update_date,
        created_by,
        creation_date,
        customer_id,
        site_use_id,
        currency_code,

        credit_limit,
        trx_credit_limit,

	credit_info_updated_by,
	credit_info_update_date,
	credit_info_update_login)
     VALUES
        (
         ar_credit_histories_s.nextval,
         :old.last_updated_by,
         :old.last_update_date,
         :old.last_updated_by,
         :old.last_update_date,
         :old.cust_account_id,
         :old.site_use_id,
         :old.currency_code,

         OverallCredit,
         TrxCredit,

	 :new.last_updated_by,
	 :new.last_update_date,
	 :new.last_update_login
	 );
  END IF;
END;


/
ALTER TRIGGER "APPS"."HZ_CUST_PROFILE_AMOUNTS_BRU" ENABLE;
