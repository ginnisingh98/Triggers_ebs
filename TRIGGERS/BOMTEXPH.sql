--------------------------------------------------------
--  DDL for Trigger BOMTEXPH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."BOMTEXPH" 

/* $Header: BOMTEXPH.sql 120.6.12010000.4 2010/06/23 17:06:04 minxie ship $ */

AFTER INSERT OR UPDATE ON "BOM"."BOM_STRUCTURES_B"
FOR EACH ROW
DECLARE
   error_msg varchar2(2000);
BEGIN
  IF INSERTING THEN
    UPDATE bom_explosions_all BET
      SET  BET.rexplode_flag = 1,
           BET.comp_bill_seq_id = :NEW.bill_sequence_id,
           BET.comp_common_bill_seq_id = :NEW.common_bill_sequence_id,
           BET.structure_type_id = :NEW.structure_type_id,
           BET.is_preferred = :NEW.is_preferred,
           BET.bom_implementation_date = :NEW.implementation_date,
           BET.effectivity_control = :NEW.effectivity_control,
           BET.assembly_type = :NEW.assembly_type,
           BET.comp_source_bill_Seq_id = :NEW.source_bill_sequence_id
      WHERE BET.component_item_id = :NEW.assembly_item_id
            AND BET.organization_id = :NEW.organization_id
            AND ( --(:NEW.alternate_bom_designator IS NULL AND BET.top_alternate_designator IS NULL)
	          :NEW.alternate_bom_designator IS NULL
                  OR (:NEW.alternate_bom_designator = BET.top_alternate_designator));
            -- AND BET.comp_bill_seq_id IS NULL;  /* Commented for Bug 7237706 */
  END IF;

  IF UPDATING THEN

    UPDATE BOM_EXPLOSIONS_ALL BET
    SET BET.rexplode_flag = 1,
    BET.comp_common_bill_Seq_id = :NEW.common_bill_Sequence_id,
    BET.comp_source_bill_Seq_id = :NEW.source_bill_Sequence_id,
    --Start code change for Bug 9544054.
    --BET.common_bill_Sequence_id = Decode(plan_level, 0, :NEW.common_bill_Sequence_id, :OLD.common_bill_Sequence_id)
    BET.common_bill_Sequence_id = Decode(plan_level, 0, :NEW.common_bill_Sequence_id, BET.common_bill_Sequence_id)
    --End code change for Bug 9544054.
    WHERE  BET.comp_bill_seq_id = :NEW.bill_sequence_id;

  END IF;

EXCEPTION
  WHEN OTHERS THEN
    error_msg := 'BOMTSTRH ' || substrb(SQLERRM, 1, 60);
    raise_application_error(-20500, error_msg);
END;
/
ALTER TRIGGER "APPS"."BOMTEXPH" ENABLE;
