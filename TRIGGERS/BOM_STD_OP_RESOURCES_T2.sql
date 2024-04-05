--------------------------------------------------------
--  DDL for Trigger BOM_STD_OP_RESOURCES_T2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."BOM_STD_OP_RESOURCES_T2" 
	BEFORE UPDATE ON "BOM"."BOM_STD_OP_RESOURCES" FOR EACH ROW

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

		UPDATE bom_operation_resources
		SET     resource_seq_num = :new.resource_seq_num,
			resource_id = :new.resource_id,
			activity_id = :new.activity_id,
			standard_rate_flag = :new.standard_rate_flag,
			assigned_units = :new.assigned_units,
			usage_rate_or_amount = :new.usage_rate_or_amount,
			usage_rate_or_amount_inverse = :new.usage_rate_or_amount_inverse,
			basis_type = :new.basis_type,
			schedule_flag = :new.schedule_flag,
			last_update_date = :new.last_update_date,
			last_updated_by = :new.last_updated_by,
			creation_date = :new.creation_date,
			created_by = :new.created_by,
			last_update_login = :new.last_update_login,
			autocharge_type = :new.autocharge_type,
			attribute_category = :new.attribute_category,
			attribute1 = :new.attribute1,
			attribute2 = :new.attribute2,
			attribute3 = :new.attribute3,
			attribute4 = :new.attribute4,
			attribute5 = :new.attribute5,
			attribute6 = :new.attribute6,
			attribute7 = :new.attribute7,
			attribute8 = :new.attribute8,
			attribute9 = :new.attribute9,
			attribute10 = :new.attribute10,
			attribute11 = :new.attribute11,
			attribute12 = :new.attribute12,
			attribute13 = :new.attribute13,
			attribute14 = :new.attribute14,
			attribute15 = :new.attribute15,
                        substitute_group_num = :new.substitute_group_num
		WHERE operation_sequence_id = var_op_seq_id
		AND   resource_seq_num = :old.resource_seq_num;
	END LOOP;


END;


/
ALTER TRIGGER "APPS"."BOM_STD_OP_RESOURCES_T2" ENABLE;
