--------------------------------------------------------
--  DDL for Trigger BOM_STD_OP_RESOURCES_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."BOM_STD_OP_RESOURCES_T1" 
	BEFORE INSERT ON "BOM"."BOM_STD_OP_RESOURCES" FOR EACH ROW

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

	/*Bug 6530358 Added the column Priniple_flag and defaulting its value to 2 */
		INSERT INTO bom_operation_resources
		(
		operation_sequence_id,
		resource_seq_num,
		resource_id,
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
                substitute_group_num,
		principle_flag
		)
		VALUES (
		var_op_seq_id,
		:new.RESOURCE_SEQ_NUM,
		:new.RESOURCE_ID,
		:new.ACTIVITY_ID,
		:new.STANDARD_RATE_FLAG,
		:new.ASSIGNED_UNITS,
		:new.USAGE_RATE_OR_AMOUNT,
		:new.USAGE_RATE_OR_AMOUNT_INVERSE,
		:new.BASIS_TYPE,
		:new.SCHEDULE_FLAG,
		:new.LAST_UPDATE_DATE,
		:new.last_updated_by,
		:new.CREATION_DATE,
		:new.CREATED_BY,
		:new.LAST_UPDATE_LOGIN,
		NULL,
		:new.AUTOCHARGE_TYPE,
		:new.ATTRIBUTE_CATEGORY,
		:new.ATTRIBUTE1,
		:new.ATTRIBUTE2,
		:new.ATTRIBUTE3,
		:new.ATTRIBUTE4,
		:new.ATTRIBUTE5,
		:new.ATTRIBUTE6,
		:new.ATTRIBUTE7,
		:new.ATTRIBUTE8,
		:new.ATTRIBUTE9,
		:new.ATTRIBUTE10,
		:new.ATTRIBUTE11,
		:new.ATTRIBUTE12,
		:new.ATTRIBUTE13,
		:new.ATTRIBUTE14,
		:new.ATTRIBUTE15,
                :new.SUBSTITUTE_GROUP_NUM,
		2);

	END LOOP;

END;

/
ALTER TRIGGER "APPS"."BOM_STD_OP_RESOURCES_T1" ENABLE;
