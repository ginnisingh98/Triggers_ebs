--------------------------------------------------------
--  DDL for Trigger BOM_STANDARD_OPERATIONS_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."BOM_STANDARD_OPERATIONS_T" 
	BEFORE UPDATE ON "BOM"."BOM_STANDARD_OPERATIONS" FOR EACH ROW

BEGIN

	UPDATE bom_operation_sequences bos
	SET bos.DEPARTMENT_ID = :new.DEPARTMENT_ID,
		bos.MINIMUM_TRANSFER_QUANTITY = :new.MINIMUM_TRANSFER_QUANTITY,
		bos.COUNT_POINT_TYPE = :new.COUNT_POINT_TYPE,
		bos.OPTION_DEPENDENT_FLAG = :new.OPTION_DEPENDENT_FLAG,
		bos.BACKFLUSH_FLAG = :new.BACKFLUSH_FLAG,
		bos.OPERATION_TYPE = :new.OPERATION_TYPE,
		bos.OPERATION_DESCRIPTION = :new.OPERATION_DESCRIPTION,
		bos.LAST_UPDATE_DATE = sysdate,
		bos.LAST_UPDATED_BY = :new.LAST_UPDATED_BY,
		bos.CREATION_DATE = sysdate,
		bos.CREATED_BY = :new.CREATED_BY,
		bos.ATTRIBUTE_CATEGORY = :new.ATTRIBUTE_CATEGORY,
		bos.ATTRIBUTE1 = :new.ATTRIBUTE1,
		bos.ATTRIBUTE2 = :new.ATTRIBUTE2,
		bos.ATTRIBUTE3 = :new.ATTRIBUTE3,
		bos.ATTRIBUTE4 = :new.ATTRIBUTE4,
		bos.ATTRIBUTE5 = :new.ATTRIBUTE5,
		bos.ATTRIBUTE6 = :new.ATTRIBUTE6,
		bos.ATTRIBUTE7 = :new.ATTRIBUTE7,
		bos.ATTRIBUTE8 = :new.ATTRIBUTE8,
		bos.ATTRIBUTE9 = :new.ATTRIBUTE9,
		bos.ATTRIBUTE10 = :new.ATTRIBUTE10,
		bos.ATTRIBUTE11 = :new.ATTRIBUTE11,
		bos.ATTRIBUTE12 = :new.ATTRIBUTE12,
		bos.ATTRIBUTE13 = :new.ATTRIBUTE13,
		bos.ATTRIBUTE14 = :new.ATTRIBUTE14,
		bos.ATTRIBUTE15 = :new.ATTRIBUTE15,
		bos.YIELD = :new.YIELD,
		bos.OPERATION_YIELD_ENABLED = :new.OPERATION_YIELD_ENABLED,
		bos.VALUE_ADDED = :new.VALUE_ADDED,
		bos.CRITICAL_TO_QUALITY = :new.CRITICAL_TO_QUALITY,
		bos.LOWEST_ACCEPTABLE_YIELD = :new.LOWEST_ACCEPTABLE_YIELD,
		bos.USE_ORG_SETTINGS = :new.USE_ORG_SETTINGS,
		bos.QUEUE_MANDATORY_FLAG = :new.QUEUE_MANDATORY_FLAG,
		bos.RUN_MANDATORY_FLAG = :new.RUN_MANDATORY_FLAG,
		bos.TO_MOVE_MANDATORY_FLAG = :new.TO_MOVE_MANDATORY_FLAG,
		bos.SHOW_NEXT_OP_BY_DEFAULT = :new.SHOW_NEXT_OP_BY_DEFAULT,
		bos.SHOW_SCRAP_CODE = :new.SHOW_SCRAP_CODE,
		bos.SHOW_LOT_ATTRIB = :new.SHOW_LOT_ATTRIB,
		bos.TRACK_MULTIPLE_RES_USAGE_DATES = :new.TRACK_MULTIPLE_RES_USAGE_DATES,
		bos.CHECK_SKILL = :new.CHECK_SKILL
	WHERE  bos.STANDARD_OPERATION_ID = :new.STANDARD_OPERATION_ID
	 and   bos.reference_flag = 1;

END;

/
ALTER TRIGGER "APPS"."BOM_STANDARD_OPERATIONS_T" ENABLE;
