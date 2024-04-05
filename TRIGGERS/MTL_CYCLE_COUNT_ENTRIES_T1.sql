--------------------------------------------------------
--  DDL for Trigger MTL_CYCLE_COUNT_ENTRIES_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."MTL_CYCLE_COUNT_ENTRIES_T1" 
AFTER UPDATE
OF EXPORT_FLAG
ON "INV"."MTL_CYCLE_COUNT_ENTRIES"
FOR EACH ROW

DECLARE
BEGIN
  BEGIN
     IF UPDATING AND (:old.export_flag = 1 and :new.export_flag=2) THEN
        UPDATE MTL_CC_ENTRIES_INTERFACE
        SET
           delete_flag = 1
        WHERE
           cycle_count_entry_id = :old.cycle_count_entry_id
           and lock_flag <> 1 ;
         --
         IF SQL%ROWCOUNT  = 0 THEN
              FND_MESSAGE.SET_NAME('INV','INV_CCEOI_IS_LOCKED');
              APP_EXCEPTION.RAISE_EXCEPTION;
         END IF;
     END IF;
  END;
END;



/
ALTER TRIGGER "APPS"."MTL_CYCLE_COUNT_ENTRIES_T1" ENABLE;
