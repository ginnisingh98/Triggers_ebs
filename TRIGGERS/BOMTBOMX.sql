--------------------------------------------------------
--  DDL for Trigger BOMTBOMX
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."BOMTBOMX" 

/* $Header: BOMTBOMX.sql 120.3 2006/07/26 11:46:32 arudresh noship $ */

AFTER INSERT OR UPDATE OR DELETE ON "BOM"."BOM_STRUCTURES_B"
FOR EACH ROW
   WHEN (((OLD.ALTERNATE_BOM_DESIGNATOR IS NULL) OR
       (NEW.ALTERNATE_BOM_DESIGNATOR IS NULL))) DECLARE
    error_msg VARCHAR2(80);
    error_cd  NUMBER;

    is_product_family NUMBER;

BEGIN

IF UPDATING THEN

  UPDATE  BOM_EXPLOSIONS BE
  SET BE.REXPLODE_FLAG = 1,
      BE.comp_common_bill_Seq_id = :NEW.common_bill_Sequence_id,
      BE.comp_source_bill_Seq_id = :NEW.source_bill_Sequence_id,
      BE.common_bill_Sequence_id = Decode(plan_level, 0, :NEW.common_bill_Sequence_id, :OLD.common_bill_Sequence_id)
  WHERE BE.COMPONENT_ITEM_ID = :NEW.ASSEMBLY_ITEM_ID
  AND BE.ORGANIZATION_ID = :NEW.ORGANIZATION_ID ;
/*     OR  BE.ORGANIZATION_ID = :NEW.COMMON_ORGANIZATION_ID); */

END IF;

IF INSERTING THEN
        UPDATE BOM_EXPLOSIONS BE
        set REXPLODE_FLAG = 1,
            comp_common_bill_seq_id = :NEW.COMMON_BILL_SEQUENCE_ID,
            comp_bill_seq_id = :NEW.BILL_SEQUENCE_ID,
            comp_source_bill_Seq_id = :NEW.SOURCE_BILL_SEQUENCE_ID
        WHERE   BE.COMPONENT_ITEM_ID = :NEW.ASSEMBLY_ITEM_ID
        AND     BE.ORGANIZATION_ID = :NEW.ORGANIZATION_ID
        AND BE.comp_common_bill_seq_id is null;
/* The last update ststement is written for fixing bug 1553040 */
END IF;

/* If the Record from Bom_Bill_of_Materials is being deleted and the
   assembly item is a Product Family item, then the correspondinf
   record in mtl_system_items needs to be updated with product_family_item_id
   as NULL and also all corresponding component records in msi also need
   to be updated. While updating of Member's if any of the components is a
   Model item, then all its configuration items must also be updated.
*/

IF DELETING THEN

  UPDATE	BOM_EXPLOSIONS_ALL BE
  SET 	REXPLODE_FLAG = 1
  WHERE	BE.BILL_SEQUENCE_ID IN (SELECT BILL_SEQUENCE_ID
                                FROM BOM_EXPLOSIONS_ALL
                                WHERE COMP_COMMON_BILL_SEQ_ID = :old.bill_sequence_id)
  AND BE.BILL_SEQUENCE_ID = BE.comp_common_bill_seq_id;

  -- Verify that the Assembly being deleted is a Product Family
  SELECT bom_item_type
    INTO is_product_family
    FROM mtl_system_items
   WHERE inventory_item_id = :old.assembly_item_id
     AND organization_id   = :old.organization_id;

     IF is_product_family = 5 THEN

  -- Update the Assemly Item itself
  Product_Family_Pkg.Update_Pf_Item_Id(x_inventory_item_id  => :old.assembly_item_id,
               x_organization_id    => :old.organization_id,
               x_pf_item_id   => NULL,
               x_trans_type   => 'REMOVE',
               x_error_msg    => error_msg,
               x_error_code   => error_cd
              );
  UPDATE mtl_system_items
           SET product_family_item_id = NULL
         WHERE product_family_item_id = :old.assembly_item_id
     AND organization_id = :old.organization_id;
      END IF;

      UPDATE eng_revised_items
   SET bill_sequence_id = NULL
       WHERE bill_sequence_id = :old.bill_sequence_id
         AND organization_id = :old.organization_id
   AND implementation_date is null ;

   -- Update the BOM_EXPLOSIONS TABLE
         UPDATE  BOM_EXPLOSIONS BE
     SET REXPLODE_FLAG = 1
     WHERE BE.COMPONENT_ITEM_ID = :OLD.ASSEMBLY_ITEM_ID
     AND BE.ORGANIZATION_ID = :OLD.ORGANIZATION_ID ;


END IF;

EXCEPTION
    when others then
  error_msg := 'BOMTBOMX ' || substrb(SQLERRM, 1, 60);
  raise_application_error(-20500, error_msg);
END;


/
ALTER TRIGGER "APPS"."BOMTBOMX" ENABLE;
