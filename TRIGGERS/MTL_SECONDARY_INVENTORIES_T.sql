--------------------------------------------------------
--  DDL for Trigger MTL_SECONDARY_INVENTORIES_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."MTL_SECONDARY_INVENTORIES_T" 
/* $Header: INVSUBTR.sql 120.0 2005/05/25 16:11:16 appldev noship $ */
BEFORE INSERT OR UPDATE
ON "INV"."MTL_SECONDARY_INVENTORIES"
FOR EACH ROW
DECLARE
CURSOR cur_mat IS SELECT ms.reservable_type,
                         ms.availability_type,
                         ms.inventory_atp_code FROM mtl_material_statuses_b ms
                                               WHERE ms.status_id = :NEW.status_id;
BEGIN
   IF :NEW.status_id <> NVL(:OLD.STATUS_ID,-1) THEN
       OPEN cur_mat;
       FETCH cur_mat INTO :NEW.reservable_type,
                          :NEW.availability_type,
                          :NEW.inventory_atp_code;
       CLOSE cur_mat;
   END IF;
END;


/
ALTER TRIGGER "APPS"."MTL_SECONDARY_INVENTORIES_T" ENABLE;
