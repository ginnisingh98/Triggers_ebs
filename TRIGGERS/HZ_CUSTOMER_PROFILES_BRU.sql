--------------------------------------------------------
--  DDL for Trigger HZ_CUSTOMER_PROFILES_BRU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."HZ_CUSTOMER_PROFILES_BRU" 
/* $Header: arplt26.sql 115.4 2001/12/13 09:31:53 pkm ship    $  */

BEFORE UPDATE ON "AR"."HZ_CUSTOMER_PROFILES"
FOR EACH ROW


DECLARE
  CreditHold      varchar2(1)  := null;
  RiskCode        varchar2(30) := null;
  CreditRating    varchar2(30) := null;
  ChangesMade     varchar2(1)  := 'N';
BEGIN
  IF (( :new.credit_hold    <> :old.credit_hold )                    OR
      ( :new.credit_hold is null and :old.credit_hold is not null )  OR
      ( :new.credit_hold is not null and :old.credit_hold is null )) THEN

     CreditHold          := :old.credit_hold;

     /* IF FIELD VALUE OF credit_hold IS CHANGED THEN SET */
     /* THE VALUE OF THIS VARIABLE TO Y                   */
     ChangesMade         := 'Y';
  END IF;

  IF (( :new.risk_code    <> :old.risk_code )                    OR
      ( :new.risk_code is null and :old.risk_code is not null )  OR
      ( :new.risk_code is not null and :old.risk_code is null )) THEN

     RiskCode            := :old.risk_code;

     /* IF FIELD VALUE OF risk_code   IS CHANGED THEN SET */
     /* THE VALUE OF THIS VARIABLE TO Y                   */
     ChangesMade         := 'Y';
  END IF;

  IF (( :new.credit_rating    <> :old.credit_rating )                    OR
      ( :new.credit_rating is null and :old.credit_rating is not null )  OR
      ( :new.credit_rating is not null and :old.credit_rating is null )) THEN

     CreditRating        := :old.credit_rating;

     /* IF FIELD VALUE OF credit_rating IS CHANGED THEN SET */
     /* THE VALUE OF THIS VARIABLE TO Y                     */
     ChangesMade         := 'Y';
  END IF;

  /* WHEN THE VALUE OF ANY OF THE ABOVE FIELD CHANGES THEN INSERT */
  /* IN TABLE AR_CREDIT_HISTORIES                                 */

  IF ChangesMade          = 'Y' THEN

     INSERT INTO ar_credit_histories
       (credit_history_id,
       last_updated_by,
       last_update_date,
       created_by,
       creation_date,
       customer_id,
       on_hold,
       hold_date,
       credit_rating,
       risk_code,
       site_use_id)
     VALUES
       (ar_credit_histories_s.nextval,
       :old.last_updated_by,
        sysdate,
       :old.last_updated_by,
        sysdate,
       :old.cust_account_id,
       CreditHold,
       decode(CreditHold, 'Y', :old.last_update_date, null ),
       CreditRating,
       RiskCode,
       :old.site_use_id);
  END IF;
END;



/
ALTER TRIGGER "APPS"."HZ_CUSTOMER_PROFILES_BRU" ENABLE;
