--------------------------------------------------------
--  DDL for Trigger MTL_SYSTEM_ITEMS_T2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."MTL_SYSTEM_ITEMS_T2" 
AFTER UPDATE OF DESCRIPTION,SEGMENT1,SEGMENT2,SEGMENT3,SEGMENT4,SEGMENT5,
		SEGMENT6,SEGMENT7,SEGMENT8,SEGMENT9,SEGMENT10,SEGMENT11,
                SEGMENT12,SEGMENT13,SEGMENT14,SEGMENT15,SEGMENT16,SEGMENT17,
                SEGMENT18,SEGMENT19,SEGMENT20
	ON "INV"."MTL_SYSTEM_ITEMS_B"
FOR EACH ROW
DECLARE

   l_return_err  	 VARCHAR2(80);
   TYPE NumType IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
   TYPE VarType IS TABLE OF mtl_system_items.segment1%TYPE  INDEX BY BINARY_INTEGER;
   max_segment     NUMBER;
   totalsegs       NUMBER;
   segnum          NUMBER;
   old_segmt       VARTYPE;
   new_segmt       VARTYPE;
   old_item_name   VARCHAR2(240);
   new_item_name   VARCHAR2(240);
	delimiter	    VARCHAR2(1);

BEGIN
   IF ((:new.description <> :old.description) OR
	    (:new.description IS NULL AND :old.description is NOT NULL) OR
	    (:new.description IS NOT NULL AND :old.description is NULL) OR
      (:new.BASE_ITEM_ID <> :old.BASE_ITEM_ID) OR
	    (:new.BASE_ITEM_ID IS NULL AND :old.BASE_ITEM_ID is NOT NULL) OR
	    (:new.BASE_ITEM_ID IS NOT NULL AND :old.BASE_ITEM_ID is NULL) OR
      (:new.ATP_COMPONENTS_FLAG <> :old.ATP_COMPONENTS_FLAG) OR
	    (:new.ATP_COMPONENTS_FLAG IS NULL AND :old.ATP_COMPONENTS_FLAG is NOT NULL) OR
	    (:new.ATP_COMPONENTS_FLAG IS NOT NULL AND :old.ATP_COMPONENTS_FLAG is NULL) OR
      (:new.ATP_FLAG <> :old.ATP_FLAG) OR
	    (:new.ATP_FLAG IS NULL AND :old.ATP_FLAG is NOT NULL) OR
	    (:new.ATP_FLAG IS NOT NULL AND :old.ATP_FLAG is NULL) OR
      (:new.BOM_ITEM_TYPE <> :old.BOM_ITEM_TYPE) OR
	    (:new.BOM_ITEM_TYPE IS NULL AND :old.BOM_ITEM_TYPE is NOT NULL) OR
	    (:new.BOM_ITEM_TYPE IS NOT NULL AND :old.BOM_ITEM_TYPE is NULL) OR
      (:new.PICK_COMPONENTS_FLAG <> :old.PICK_COMPONENTS_FLAG) OR
	    (:new.PICK_COMPONENTS_FLAG IS NULL AND :old.PICK_COMPONENTS_FLAG is NOT NULL) OR
	    (:new.PICK_COMPONENTS_FLAG IS NOT NULL AND :old.PICK_COMPONENTS_FLAG is NULL) OR
      (:new.REPLENISH_TO_ORDER_FLAG <> :old.REPLENISH_TO_ORDER_FLAG) OR
	    (:new.REPLENISH_TO_ORDER_FLAG IS NULL AND :old.REPLENISH_TO_ORDER_FLAG is NOT NULL) OR
	    (:new.REPLENISH_TO_ORDER_FLAG IS NOT NULL AND :old.REPLENISH_TO_ORDER_FLAG is NULL) OR
      (:new.SHIPPABLE_ITEM_FLAG <> :old.SHIPPABLE_ITEM_FLAG) OR
	    (:new.SHIPPABLE_ITEM_FLAG IS NULL AND :old.SHIPPABLE_ITEM_FLAG is NOT NULL) OR
	    (:new.SHIPPABLE_ITEM_FLAG IS NOT NULL AND :old.SHIPPABLE_ITEM_FLAG is NULL) OR
      (:new.CUSTOMER_ORDER_FLAG <> :old.CUSTOMER_ORDER_FLAG) OR
	    (:new.CUSTOMER_ORDER_FLAG IS NULL AND :old.CUSTOMER_ORDER_FLAG is NOT NULL) OR
	    (:new.CUSTOMER_ORDER_FLAG IS NOT NULL AND :old.CUSTOMER_ORDER_FLAG is NULL) OR
      (:new.INTERNAL_ORDER_FLAG <> :old.INTERNAL_ORDER_FLAG) OR
	    (:new.INTERNAL_ORDER_FLAG IS NULL AND :old.INTERNAL_ORDER_FLAG is NOT NULL) OR
	    (:new.INTERNAL_ORDER_FLAG IS NOT NULL AND :old.INTERNAL_ORDER_FLAG is NULL) OR
      (:new.CUSTOMER_ORDER_ENABLED_FLAG <> :old.CUSTOMER_ORDER_ENABLED_FLAG) OR
	    (:new.CUSTOMER_ORDER_ENABLED_FLAG IS NULL AND :old.CUSTOMER_ORDER_ENABLED_FLAG is NOT NULL) OR
	    (:new.CUSTOMER_ORDER_ENABLED_FLAG IS NOT NULL AND :old.CUSTOMER_ORDER_ENABLED_FLAG is NULL) OR
      (:new.INTERNAL_ORDER_ENABLED_FLAG <> :old.INTERNAL_ORDER_ENABLED_FLAG) OR
	    (:new.INTERNAL_ORDER_ENABLED_FLAG IS NULL AND :old.INTERNAL_ORDER_ENABLED_FLAG is NOT NULL) OR
	    (:new.INTERNAL_ORDER_ENABLED_FLAG IS NOT NULL AND :old.INTERNAL_ORDER_ENABLED_FLAG is NULL) OR
      (:new.SO_TRANSACTIONS_FLAG <> :old.SO_TRANSACTIONS_FLAG) OR
	    (:new.SO_TRANSACTIONS_FLAG IS NULL AND :old.SO_TRANSACTIONS_FLAG is NOT NULL) OR
	    (:new.SO_TRANSACTIONS_FLAG IS NOT NULL AND :old.SO_TRANSACTIONS_FLAG is NULL))
   THEN

     UPDATE BOM_EXPLOSIONS
     SET DESCRIPTION = :new.DESCRIPTION  ,
         LAST_UPDATE_DATE = sysdate,
         LAST_UPDATED_BY  = :new.last_updated_by,
         BASE_ITEM_ID = :new.BASE_ITEM_ID,
         ATP_COMPONENTS_FLAG = :new.ATP_COMPONENTS_FLAG,
         ATP_FLAG = :new.ATP_FLAG,
         BOM_ITEM_TYPE = :new.BOM_ITEM_TYPE,
         PICK_COMPONENTS_FLAG = :new.PICK_COMPONENTS_FLAG,
         REPLENISH_TO_ORDER_FLAG = :new.REPLENISH_TO_ORDER_FLAG,
         SHIPPABLE_ITEM_FLAG = :new.SHIPPABLE_ITEM_FLAG,
         CUSTOMER_ORDER_FLAG = :new.CUSTOMER_ORDER_FLAG,
         INTERNAL_ORDER_FLAG = :new.INTERNAL_ORDER_FLAG,
         CUSTOMER_ORDER_ENABLED_FLAG = :new.CUSTOMER_ORDER_ENABLED_FLAG,
         INTERNAL_ORDER_ENABLED_FLAG = :new.INTERNAL_ORDER_ENABLED_FLAG,
         SO_TRANSACTIONS_FLAG  = :new.SO_TRANSACTIONS_FLAG
     WHERE ORGANIZATION_ID = :new.organization_id
     AND COMPONENT_ITEM_ID = :new.inventory_item_id;

      UPDATE WIP_ENTITIES
      SET   DESCRIPTION = :new.DESCRIPTION
      WHERE ORGANIZATION_ID = :new.organization_id
      AND  PRIMARY_ITEM_ID = :new.inventory_item_id
		AND  ENTITY_TYPE = WIP_CONSTANTS.REPETITIVE;
	END IF;

   old_segmt(1) :=:old.SEGMENT1;
   old_segmt(2) :=:old.SEGMENT2;
   old_segmt(3) :=:old.SEGMENT3;
   old_segmt(4) :=:old.SEGMENT4;
   old_segmt(5) :=:old.SEGMENT5;
   old_segmt(6) :=:old.SEGMENT6;
   old_segmt(7) :=:old.SEGMENT7;
   old_segmt(8) :=:old.SEGMENT8;
   old_segmt(9) :=:old.SEGMENT9;
   old_segmt(10):=:old.SEGMENT10;
   old_segmt(11):=:old.SEGMENT11;
   old_segmt(12):=:old.SEGMENT12;
   old_segmt(13):=:old.SEGMENT13;
   old_segmt(14):=:old.SEGMENT14;
   old_segmt(15):=:old.SEGMENT15;
   old_segmt(16):=:old.SEGMENT16;
   old_segmt(17):=:old.SEGMENT17;
   old_segmt(18):=:old.SEGMENT18;
   old_segmt(19):=:old.SEGMENT19;
   old_segmt(20):=:old.SEGMENT20;

   new_segmt(1) :=:new.SEGMENT1;
   new_segmt(2) :=:new.SEGMENT2;
   new_segmt(3) :=:new.SEGMENT3;
   new_segmt(4) :=:new.SEGMENT4;
   new_segmt(5) :=:new.SEGMENT5;
   new_segmt(6) :=:new.SEGMENT6;
   new_segmt(7) :=:new.SEGMENT7;
   new_segmt(8) :=:new.SEGMENT8;
   new_segmt(9) :=:new.SEGMENT9;
   new_segmt(10):=:new.SEGMENT10;
   new_segmt(11):=:new.SEGMENT11;
   new_segmt(12):=:new.SEGMENT12;
   new_segmt(13):=:new.SEGMENT13;
   new_segmt(14):=:new.SEGMENT14;
   new_segmt(14):=:new.SEGMENT14;
   new_segmt(15):=:new.SEGMENT15;
   new_segmt(16):=:new.SEGMENT16;
   new_segmt(17):=:new.SEGMENT17;
   new_segmt(18):=:new.SEGMENT18;
   new_segmt(19):=:new.SEGMENT19;
   new_segmt(20):=:new.SEGMENT20;

   old_item_name:=NULL;
   new_item_name:=NULL;

   SELECT MAX(FS.segment_num),COUNT(*)
   INTO max_segment,totalsegs
   FROM FND_ID_FLEX_SEGMENTS FS
   WHERE FS.APPLICATION_ID = 401
   AND FS.id_flex_code = 'MSTK'
   AND FS.ENABLED_FLAG = 'Y'
   AND FS.id_flex_num = 101;

	SELECT FST.concatenated_segment_delimiter
	INTO   delimiter
	FROM FND_ID_FLEX_STRUCTURES FST
	WHERE FST.ID_FLEX_CODE = 'MSTK'
	AND   FST.ID_FLEX_NUM = 101
	AND   FST.ENABLED_FLAG='Y'
	AND   FST.APPLICATION_ID = 401;

   FOR n IN 1..max_segment LOOP
      BEGIN
         SELECT to_number(SUBSTR(FS.application_column_name, 8))
         INTO segnum
         FROM FND_ID_FLEX_SEGMENTS FS
         WHERE FS.SEGMENT_NUM = n
         AND   FS.ID_FLEX_CODE = 'MSTK'
         AND   FS.ID_FLEX_NUM = 101
         AND   FS.ENABLED_FLAG = 'Y'
         AND   FS.APPLICATION_ID = 401;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            segnum := NULL;
         WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20001, SQLERRM);
      END;

      IF segnum IS NOT NULL THEN
		   IF new_item_name IS NOT NULL THEN
            old_item_name := old_item_name || delimiter || old_segmt(segnum);
            new_item_name := new_item_name || delimiter || new_segmt(segnum);
  		   ELSE
            old_item_name := old_item_name || old_segmt(segnum);
            new_item_name := new_item_name || new_segmt(segnum);
		   END IF;
      END IF;
   END LOOP;

	IF old_item_name <> new_item_name THEN
	   UPDATE wip_entities
		SET    WIP_ENTITY_NAME = new_item_name
      WHERE PRIMARY_ITEM_ID  = :new.INVENTORY_ITEM_ID
  		AND   entity_type      = WIP_CONSTANTS.REPETITIVE
		AND   organization_id  = :new.organization_id
		AND   wip_entity_name  = old_item_name;
	END IF;

EXCEPTION
   WHEN OTHERS THEN
      l_return_err := 'MTL_SYSTEM_ITEMS_T2:' || 'S'|| ':' || substrb(sqlerrm,1,55);
      RAISE_APPLICATION_ERROR(-20000,L_RETURN_ERR);
END;


/
ALTER TRIGGER "APPS"."MTL_SYSTEM_ITEMS_T2" ENABLE;
