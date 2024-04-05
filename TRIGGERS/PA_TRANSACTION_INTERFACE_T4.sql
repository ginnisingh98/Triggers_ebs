--------------------------------------------------------
--  DDL for Trigger PA_TRANSACTION_INTERFACE_T4
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PA_TRANSACTION_INTERFACE_T4" 
/* $Header: PAXTRXT4.pls 120.1 2005/11/02 23:46:34 appldev ship $ */
AFTER UPDATE ON "PA"."PA_TRANSACTION_INTERFACE_ALL"
DECLARE

 dummy  number ;

BEGIN

      --Check if Transaction Import is running
      --If not running then execute the code in No_data_Found
      --Within an expenditure, if few records get rejected and few others approved,
      --we reject the whole expenditure.  But due to this trigger the approved
      --ones are not rejected ('R' transaction status code) and remain as Pending ('P')
      --Hence they get picked up again in the next loop of the processing and EI's get created
      --for them. This is wrong and thus this trigger code (in the no data found) will be
      --executed only when trx import is not running.
      If pa_txn_int_trig_ctl.G_TrxImport2 IS NULL Then

         SELECT 1
           INTO dummy
           FROM dual
          WHERE EXISTS (
            select 1 from fnd_concurrent_programs
            WHERE concurrent_program_name in ( 'PAXTRTRX' , 'PAAPIMP_SI', 'PAAPIMP')
            AND concurrent_program_id = fnd_global.conc_program_id
            AND application_id        = 275) ;

         pa_txn_int_trig_ctl.G_TrxImport2 := 1;

      ElsIf pa_txn_int_trig_ctl.G_TrxImport2 = 0 Then

         RAISE NO_DATA_FOUND;

      End If;

EXCEPTION
 WHEN NO_DATA_FOUND THEN

  pa_txn_int_trig_ctl.G_TrxImport2 := 0;

  IF (pa_txn_int_trig_ctl.T4_Trig = TRUE ) THEN
      pa_txn_int_trig_ctl.T4_Trig := FALSE   ;
      FOR v_index in 1 .. (pa_txn_int_trig_ctl.idx - 1 ) LOOP
        IF pa_txn_int_trig_ctl.expenditure_id(v_index) IS NOT NULL then
        BEGIN
          UPDATE pa_transaction_interface
             SET transaction_status_code = 'P'
           WHERE expenditure_id = pa_txn_int_trig_ctl.expenditure_id(v_index)
	     --Bug 4552319. Used pa_txn_int_trig_ctl.batch_name_tbl populated in pa_transaction_interface_t3
             AND batch_name = pa_txn_int_trig_ctl.batch_name_tbl(v_index) -- added this for index
             AND transaction_status_code = 'R'
             AND transaction_rejection_code is NULL
             AND  NOT EXISTS (SELECT 'Y'          /* Bug#2473239 */
                              FROM   PA_TRANSACTION_INTERFACE_ALL
                              WHERE  EXPENDITURE_ID = pa_txn_int_trig_ctl.expenditure_id(v_index)
                              AND    TRANSACTION_STATUS_CODE = 'R'
                              AND    TRANSACTION_REJECTION_CODE IS NOT NULL);

        EXCEPTION
           WHEN OTHERS THEN
             pa_txn_int_trig_ctl.T4_Trig := TRUE   ;
             pa_txn_int_trig_ctl.idx     := 1      ;
        END ;
        END IF ;
      END LOOP ;
   END IF ;
   pa_txn_int_trig_ctl.T4_Trig := TRUE   ;
   pa_txn_int_trig_ctl.idx     := 1      ;
END ;


/
ALTER TRIGGER "APPS"."PA_TRANSACTION_INTERFACE_T4" ENABLE;
