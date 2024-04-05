--------------------------------------------------------
--  DDL for Trigger PA_TRANSACTION_INTERFACE_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PA_TRANSACTION_INTERFACE_T1" 
/* $Header: PAXTRXT1.pls 115.8 2002/11/13 22:47:14 pbandla ship $ */
  AFTER INSERT OR DELETE OR UPDATE OF transaction_source, system_linkage,batch_name,
    transaction_status_code, org_id
  ON "PA"."PA_TRANSACTION_INTERFACE_ALL"
  FOR EACH ROW

DECLARE
  dummy   NUMBER;
  old_etypeclass_code   VARCHAR2(3) ;
  new_etypeclass_code  VARCHAR2(3) ;
  PROCEDURE increment_xc
  AS
       l_status VARCHAR2(30);
       l_transaction_count number;
  BEGIN

    IF ( :NEW.transaction_status_code = 'P' ) THEN

      SELECT xc.status
        INTO l_status
        FROM pa_transaction_xface_ctrl_all xc
       WHERE xc.transaction_source = :NEW.transaction_source
         AND xc.system_linkage_function  = new_etypeclass_code
         AND xc.batch_name = :NEW.batch_name
         AND nvl(xc.org_id, -99) = nvl(:NEW.org_id, -99)
         AND xc.status in ( 'PENDING', 'PROCESSED');

      UPDATE pa_transaction_xface_ctrl_all xc
         SET transaction_count = transaction_count + 1,
             status = decode(l_status, 'PROCESSED', 'PENDING', xc.status)
       WHERE xc.transaction_source = :NEW.transaction_source
         AND xc.system_linkage_function  = new_etypeclass_code
         AND xc.batch_name  = :NEW.batch_name
         AND nvl(xc.org_id, -99)   = nvl(:NEW.org_id, -99)
         AND xc.status in ('PENDING', 'PROCESSED');

    END IF;

  EXCEPTION
    WHEN  NO_DATA_FOUND  THEN
      INSERT INTO pa_transaction_xface_ctrl_all
            (transaction_source, system_linkage_function, batch_name, status, transaction_count, org_id ,
             intermediate_flag, processed_count)
      VALUES( :NEW.transaction_source, new_etypeclass_code, :NEW.batch_name, 'PENDING', 1, :NEW.org_id,
             'N',0);
  END;

  PROCEDURE decrement_xc
  AS
  BEGIN
    IF ( :OLD.transaction_status_code = 'P' ) THEN


      SELECT xc.transaction_count
        INTO dummy
        FROM pa_transaction_xface_ctrl_all xc
       WHERE xc.transaction_source = :OLD.transaction_source
         AND xc.system_linkage_function  = old_etypeclass_code
         AND xc.batch_name = :OLD.batch_name
         AND nvl(xc.org_id, -99)  = nvl(:OLD.org_id, -99)
         AND xc.status = 'PENDING';

      IF (dummy = 1) THEN

        DELETE FROM pa_transaction_xface_ctrl_all
              WHERE transaction_source = :OLD.transaction_source
                AND system_linkage_function  = old_etypeclass_code
                AND batch_name = :OLD.batch_name
                AND nvl(org_id, -99)  = nvl(:OLD.org_id, -99)
                AND status = 'PENDING';

      ELSE
        UPDATE pa_transaction_xface_ctrl_all
           SET transaction_count = transaction_count - 1
         WHERE transaction_source = :OLD.transaction_source
           AND system_linkage_function  = old_etypeclass_code
           AND batch_name = :OLD.batch_name
           AND nvl(org_id, -99) = nvl(:OLD.org_id, -99)
           AND status = 'PENDING';

      END IF;
    END IF;

  EXCEPTION
    WHEN  NO_DATA_FOUND  THEN
      NULL;
  END;

BEGIN

  IF  INSERTING  THEN
    new_etypeclass_code := pa_utils.GetETypeClassCode(:NEW.system_linkage) ;

    -- Bug 1000221, grouping ST and OT items into one exp batch
    IF ( new_etypeclass_code = 'OT' ) THEN
       new_etypeclass_code := 'ST';
    END IF;

    increment_xc;

  ELSIF  UPDATING  THEN
    new_etypeclass_code := pa_utils.GetETypeClassCode(:NEW.system_linkage) ;
    old_etypeclass_code := pa_utils.GetETypeClassCode(:OLD.system_linkage) ;

    -- Bug 1000221, grouping ST and OT items into one exp batch
    IF ( new_etypeclass_code = 'OT' ) THEN
       new_etypeclass_code := 'ST';
    END IF;

    -- Bug 1000221, grouping ST and OT items into one exp batch
    IF ( old_etypeclass_code = 'OT' ) THEN
       old_etypeclass_code := 'ST';
    END IF;

    BEGIN

      If pa_txn_int_trig_ctl.G_TrxImport1 IS NULL Then

         SELECT 1
           INTO dummy
           FROM fnd_concurrent_programs
          WHERE concurrent_program_name = 'PAXTRTRX'
            AND concurrent_program_id = fnd_global.conc_program_id
            AND application_id        = 275 ;

         pa_txn_int_trig_ctl.G_TrxImport1 := 1;

      ElsIf pa_txn_int_trig_ctl.G_TrxImport1 = 0 Then

         RAISE NO_DATA_FOUND;

      End If;


    EXCEPTION
      WHEN NO_DATA_FOUND THEN

        pa_txn_int_trig_ctl.G_TrxImport1 := 0;

        IF (      :NEW.transaction_source = :OLD.transaction_source
            AND (new_etypeclass_code  = old_etypeclass_code)
            AND ( :NEW.batch_name = :OLD.batch_name )
            AND ( nvl(:NEW.org_id, -99) = nvl(:OLD.org_id, -99) )
            AND ( :NEW.transaction_status_code = :OLD.transaction_status_code)
           ) THEN
          NULL;
        ELSE

          IF ( :OLD.transaction_status_code = 'P' ) THEN
            decrement_xc;
          END IF;

          IF ( :NEW.transaction_status_code = 'P' ) THEN
            increment_xc;
          END IF;

        END IF;
    END;

  ELSIF  DELETING  THEN
      old_etypeclass_code := pa_utils.GetETypeClassCode(:OLD.system_linkage) ;

      -- Bug 1000221, grouping ST and OT items into one exp batch
      IF ( old_etypeclass_code = 'OT' ) THEN
         old_etypeclass_code := 'ST';
      END IF;

      decrement_xc;

  END IF;

END;



/
ALTER TRIGGER "APPS"."PA_TRANSACTION_INTERFACE_T1" ENABLE;
