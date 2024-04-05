--------------------------------------------------------
--  DDL for Trigger BOM_STD_SUB_OP_RESOURCES_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."BOM_STD_SUB_OP_RESOURCES_T1" 
	BEFORE INSERT ON "BOM"."BOM_STD_SUB_OP_RESOURCES" FOR EACH ROW

DECLARE

CURSOR op_seq IS
SELECT operation_sequence_id
FROM bom_operation_sequences
WHERE standard_operation_id = :new.standard_operation_id
AND   reference_flag = 1;

var_op_seq_id NUMBER;

BEGIN
	OPEN op_seq;
	LOOP
		FETCH op_seq
		INTO  var_op_seq_id;

		EXIT WHEN op_seq%NOTFOUND;

INSERT INTO bom_sub_operation_resources(
    	operation_sequence_id,
        substitute_group_num,
        resource_id,
        schedule_seq_num,
        replacement_group_num,
        activity_id,
        standard_rate_flag,
        assigned_units,
        usage_rate_or_amount,
        usage_rate_or_amount_inverse,
        basis_type,
        schedule_flag,
        last_update_date,
        last_updated_by,
        creation_date,
        created_by,
        last_update_login,
        resource_offset_percent,
        autocharge_type,
        attribute_category,
        request_id,
        program_application_id,
        program_id,
        program_update_date,
        attribute1,
        attribute2,
        attribute3,
        attribute4,
        attribute5,
        attribute6,
        attribute7,
        attribute8,
        attribute9,
        attribute10,
        attribute11,
        attribute12,
        attribute13,
        attribute14,
        attribute15,
        principle_flag,
        setup_id,
        change_notice,
        acd_type,
        original_system_reference)
    VALUES
    (var_op_seq_id,
     :new.substitute_group_num,
     :new.resource_id,
     :new.schedule_seq_num, -- Bug 7370692  --null --after making this column nullable in the table
     :new.replacement_group_num,
     :new.activity_id,
     :new.standard_rate_flag,
     :new.assigned_units,
     :new.usage_rate_or_amount,
     :new.usage_rate_or_amount_inverse,
     :new.basis_type,
     :new.schedule_flag,
     :new.last_update_date,
     :new.last_updated_by,
     :new.creation_date,
     :new.created_by,
     :new.last_update_login,
     null,
     :new.autocharge_type,
     :new.attribute_category,
     :new.request_id,
     :new.program_application_id,
     :new.program_id,
     :new.program_update_date,
     :new.attribute1,
     :new.attribute2,
     :new.attribute3,
     :new.attribute4,
     :new.attribute5,
     :new.attribute6,
     :new.attribute7,
     :new.attribute8,
     :new.attribute9,
     :new.attribute10,
     :new.attribute11,
     :new.attribute12,
     :new.attribute13,
     :new.attribute14,
     :new.attribute15,
     2,  -- Default the principle flag to 2
     null,
     null,
     null,
     null);

  END LOOP;

END;

/
ALTER TRIGGER "APPS"."BOM_STD_SUB_OP_RESOURCES_T1" ENABLE;
