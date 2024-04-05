--------------------------------------------------------
--  DDL for Trigger PA_TRANSACTION_INTERFACE_T2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PA_TRANSACTION_INTERFACE_T2" 
/* $Header: PAXTRXT2.pls 115.3 2002/11/01 23:04:02 pbandla ship $ */
  BEFORE INSERT
  ON "PA"."PA_TRANSACTION_INTERFACE_ALL"
  FOR EACH ROW

DECLARE

X_system_linkage     varchar2(30) ;
X_trx_src        varchar2(30) ;
X_usr_trx_src        varchar2(80) ;
x_txn_interface_id   number(15) ;

-- If a valid trx_src is found
--    update rejection_code and status_code with null

  PROCEDURE get_trx_source
  AS
  BEGIN

     If (pa_txn_int_trig_ctl.G_UserTrxSrc1 = :NEW.user_transaction_source) Then

         X_trx_src := pa_txn_int_trig_ctl.G_TrxSrc1;

     Else

     X_trx_src := NULL ;
     SELECT transaction_source
       INTO X_trx_src
       FROM pa_transaction_sources
      WHERE user_transaction_source = :NEW.user_transaction_source ;

       pa_txn_int_trig_ctl.G_UserTrxSrc1 :=  :NEW.user_transaction_source;
       pa_txn_int_trig_ctl.G_TrxSrc1     := X_trx_src;
     End If;

      :NEW.transaction_rejection_code := NULL ;
      :NEW.transaction_status_code    := 'P' ;
  EXCEPTION
    WHEN  NO_DATA_FOUND  THEN
         :NEW.transaction_rejection_code := 'INVALID_TRX_SOURCE' ;
         :NEW.transaction_status_code    := 'R' ;
         X_system_linkage := NULL ;
  END get_trx_source ;

  PROCEDURE get_usr_trx_source
  AS
  BEGIN
     If (pa_txn_int_trig_ctl.G_TrxSrc2 = :NEW.transaction_source) Then

        X_usr_trx_src := pa_txn_int_trig_ctl.G_UserTrxSrc2;

     Else

     X_trx_src := NULL ;
     SELECT user_transaction_source
       INTO X_usr_trx_src
       FROM pa_transaction_sources
      WHERE transaction_source = :NEW.transaction_source ;

       pa_txn_int_trig_ctl.G_TrxSrc2 :=  :NEW.transaction_source;
       pa_txn_int_trig_ctl.G_UserTrxSrc2     := X_usr_trx_src;

     End If;

      :NEW.transaction_rejection_code := NULL ;
      :NEW.transaction_status_code    := 'P' ;
  EXCEPTION
    WHEN  NO_DATA_FOUND  THEN
         :NEW.transaction_rejection_code := 'INVALID_TRX_SOURCE' ;
         :NEW.transaction_status_code    := 'R' ;
         X_system_linkage := NULL ;
  END get_usr_trx_source ;

-- If a valid system_linkage is found
--    update rejection_code and status_code with null

  PROCEDURE get_system_linkage
  AS
  BEGIN

     If pa_txn_int_trig_ctl.G_TrxSrc3 = :NEW.transaction_source Then

        X_system_linkage := pa_txn_int_trig_ctl.G_SysLink1;

     Else

     X_system_linkage := NULL ;
     SELECT system_linkage_function
       INTO X_system_linkage
       FROM pa_transaction_sources
      WHERE transaction_source = :NEW.transaction_source ;

        pa_txn_int_trig_ctl.G_SysLink1 := X_system_linkage;
        pa_txn_int_trig_ctl.G_TrxSrc3  := :NEW.transaction_source;
     End If;

      :NEW.transaction_rejection_code := NULL ;
      :NEW.transaction_status_code    := 'P' ;
  EXCEPTION
    WHEN  NO_DATA_FOUND  THEN
         :NEW.transaction_rejection_code := 'INVALID_TRX_SOURCE' ;
         :NEW.transaction_status_code    := 'R' ;
         X_system_linkage := NULL ;
  END get_system_linkage ;

BEGIN

-- Generate the sequence number
if :NEW.TXN_INTERFACE_ID is NULL then
      select PA_TXN_INTERFACE_S.nextval
        into X_txn_interface_id
      from dual ;
      :NEW.TXN_INTERFACE_ID := X_txn_interface_id  ;
end if ;

-- If the transaction_source is null get that from pa_transaction_sources

  IF :NEW.transaction_source is NULL THEN
      get_trx_source;
      :NEW.transaction_source := X_trx_src ;
  END IF ;

-- If the user_transaction_source is null get that from pa_transaction_sources

  IF :NEW.user_transaction_source is NULL THEN
      get_usr_trx_source;
      :NEW.user_transaction_source := X_usr_trx_src ;
  END IF ;

-- If the system_linkage is null get that from pa_transaction_sources

  IF :NEW.system_linkage is NULL THEN
      get_system_linkage;
      :NEW.system_linkage := X_system_linkage ;
  END IF ;

-- If the system_linkage is not null then validate it

  IF :NEW.system_linkage is NOT NULL THEN
         IF pa_utils.GetETypeClassCode(:NEW.system_linkage) IS NULL  THEN
              :NEW.transaction_rejection_code := 'INVALID_EXP_TYPE_CLASS' ;
            :NEW.transaction_status_code    := 'R' ;
         END IF ;
  END IF ;
END;



/
ALTER TRIGGER "APPS"."PA_TRANSACTION_INTERFACE_T2" ENABLE;
