--------------------------------------------------------
--  DDL for Trigger MTL_LOT_NUMBERS_AIU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."MTL_LOT_NUMBERS_AIU" 
/* $Header: invmlntr.sql 120.0 2005/05/25 04:48:10 appldev noship $ */
BEFORE   INSERT
      OR UPDATE OF status_id
      ON "INV"."MTL_LOT_NUMBERS"
FOR EACH ROW
--INVCONV KKILLAMS WHEN (new.status_id is NULL)
DECLARE
CURSOR cur_mat IS SELECT ms.reservable_type,
                         ms.availability_type,
                         ms.inventory_atp_code FROM mtl_material_statuses_b ms
                                               WHERE ms.status_id = :NEW.status_id;
BEGIN
   IF :NEW.status_id IS NULL THEN    --INVCONV KKILLAMS
       :NEW.status_id := inv_globals.g_material_status_active;
   END IF;                           --INVCONV KKILLAMS
   --INVCONV KKILLAMS
   IF :NEW.status_id <> NVL(:OLD.STATUS_ID,-1) THEN
       OPEN cur_mat;
       FETCH cur_mat INTO :NEW.reservable_type,
                          :NEW.availability_type,
                          :NEW.inventory_atp_code;
       CLOSE cur_mat;
   END IF;
   --END INVCONV KKILLAMS
END MTL_LOT_NUMBERS_AIU;


/
ALTER TRIGGER "APPS"."MTL_LOT_NUMBERS_AIU" ENABLE;
