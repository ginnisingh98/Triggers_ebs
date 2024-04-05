--------------------------------------------------------
--  DDL for Trigger BOM_STD_OP_RESOURCES_T3
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."BOM_STD_OP_RESOURCES_T3" 
	BEFORE DELETE ON "BOM"."BOM_STD_OP_RESOURCES" FOR EACH ROW

DECLARE

CURSOR op_seq IS
SELECT operation_sequence_id
FROM bom_operation_sequences
WHERE standard_operation_id = :old.standard_operation_id
AND   reference_flag = 1;

var_op_seq_id NUMBER;
BEGIN
    OPEN op_seq;
    LOOP
        FETCH op_seq
        INTO  var_op_seq_id;

        EXIT WHEN op_seq%NOTFOUND;

		DELETE from bom_operation_resources
		WHERE  operation_sequence_id = var_op_seq_id
		AND    resource_seq_num = :old.resource_seq_num;

	END LOOP;
END;


/
ALTER TRIGGER "APPS"."BOM_STD_OP_RESOURCES_T3" ENABLE;
