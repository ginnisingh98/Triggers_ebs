--------------------------------------------------------
--  DDL for Trigger CZ_CONFIG_CONTENTS_V_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CZ_CONFIG_CONTENTS_V_T1" INSTEAD OF INSERT
 OR UPDATE  OR DELETE ON CZ_CONFIG_CONTENTS_V
 FOR EACH ROW
DECLARE
      v_config_item_id           INTEGER;
      NULL_INPUT_TYPE_CODE       CONSTANT INTEGER:=-1;
BEGIN
    IF INSERTING THEN
         --
         -- now CZ_CONFIG_ITEMS is the driving table
         -- CONFIG_ITEM_ID should be ALWAYS SPECIFIED
         -- otherwise an exception will be generated
         --
         IF :new.CONFIG_ITEM_ID IS NOT NULL THEN
             --dbms_output.put_line('DEBUG : CZ_CONFIG_ITEMS');

             IF :new.CONFIG_HDR_ID IS NULL THEN
                raise_application_error(-20101, ' NOT NULL value for CONFIG_HDR_ID should be specified in INSERT statement.');
             END IF;

             IF :new.CONFIG_REV_NBR IS NULL THEN
                raise_application_error(-20102, ' NOT NULL value for CONFIG_REV_NBR should be specified in INSERT statement.');
             END IF;


             IF :new.ITEM_TYPE_CODE IS NULL THEN
                raise_application_error(-20103, ' NOT NULL value for ITEM_TYPE_CODE should be specified in INSERT statement.');
             END IF;

-- The folowing checks should be enable later
/*
             IF :new.INSTANCE_HDR_ID IS NULL THEN
                raise_application_error(-20105, ' NOT NULL value for INSTANCE_HDR_ID should be specified in INSERT statement.');
             END IF;

             IF :new.INSTANCE_REV_NBR IS NULL THEN
                raise_application_error(-20106, ' NOT NULL value for INSTANCE_REV_NBR should be specified in INSERT statement.');
             END IF;

             IF :new.COMPONENT_INSTANCE_TYPE IS NULL THEN
                raise_application_error(-20107, ' NOT NULL value for COMPONENT_INSTANCE_TYPE should be specified in INSERT statement.');
             END IF;
*/


             IF :new.CONFIG_INPUT_ID IS NOT NULL THEN
                v_config_item_id:=:new.CONFIG_ITEM_ID;
             END IF;

             INSERT INTO CZ_CONFIG_ITEMS
                           (CONFIG_HDR_ID
                           ,CONFIG_REV_NBR
                           ,CONFIG_ITEM_ID
                           ,PS_NODE_ID
                           ,VALUE_TYPE_CODE
                           ,SEQUENCE_NBR
                           ,ITEM_VAL
                           ,INSTANCE_NBR
                           ,PARENT_CONFIG_ITEM_ID
                           ,NODE_IDENTIFIER
                           ,INVENTORY_ITEM_ID
                           ,ORGANIZATION_ID
                           ,COMPONENT_SEQUENCE_ID
                           ,UOM_CODE
                           ,USER_STR01
                           ,USER_STR02
                           ,USER_STR03
                           ,USER_STR04
                           ,USER_NUM01
                           ,USER_NUM02
                           ,USER_NUM03
                           ,USER_NUM04
                           ,BOM_ITEM_TYPE
                           ,QUOTEABLE_FLAG
                           ,BOM_SORT_ORDER
                           ,INSTANCE_CONFIG_ITEM_ID
                           ,TARGET_CONFIG_ITEM_ID
                           ,ATO_CONFIG_ITEM_ID
                           ,NAME
                           ,INSTANCE_HDR_ID
                           ,INSTANCE_REV_NBR
                           ,TARGET_HDR_ID
                           ,TARGET_REV_NBR
                           ,CONFIG_DELTA
                           ,LINE_TYPE
                           ,LOCATION_ID
                           ,LOCATION_TYPE_CODE
                           ,COMPONENT_INSTANCE_TYPE
			   ,IB_TRACKABLE
                           ,EXT_ACTIVATED_FLAG
                           ,DISCONTINUED_FLAG
                           ,ITEM_NUM_VAL
                           ,ORIG_SYS_REF
                           ,ITEM_SRC_APPL_ID
                           ,PS_NODE_NAME
                           ,TANGIBLE_ITEM_FLAG
                           ,RETURNED_FLAG
                           )
             VALUES
                           (:new.CONFIG_HDR_ID
                           ,:new.CONFIG_REV_NBR
                           ,:new.CONFIG_ITEM_ID
                           ,:new.PS_NODE_ID
                           ,:new.ITEM_TYPE_CODE
                           ,:new.SEQUENCE_NBR
                           ,:new.ITEM_VAL
                           ,:new.INSTANCE_NBR
                           ,:new.PARENT_CONFIG_ITEM_ID
                           ,:new.NODE_IDENTIFIER
                           ,:new.INVENTORY_ITEM_ID
                           ,:new.ORGANIZATION_ID
                           ,:new.COMPONENT_SEQUENCE_ID
                           ,:new.UOM_CODE
                           ,:new.USER_STR01
                           ,:new.USER_STR02
                           ,:new.USER_STR03
                           ,:new.USER_STR04
                           ,:new.USER_NUM01
                           ,:new.USER_NUM02
                           ,:new.USER_NUM03
                           ,:new.USER_NUM04
                           ,:new.BOM_ITEM_TYPE
                           ,:new.QUOTEABLE_FLAG
                           ,:new.BOM_SORT_ORDER
                           ,:new.INSTANCE_CONFIG_ITEM_ID
                           ,:new.TARGET_CONFIG_ITEM_ID
                           ,:new.ATO_CONFIG_ITEM_ID
                           ,:new.NAME
                           ,:new.INSTANCE_HDR_ID
                           ,:new.INSTANCE_REV_NBR
                           ,:new.TARGET_HDR_ID
                           ,:new.TARGET_REV_NBR
                           ,:new.CONFIG_DELTA
                           ,:new.LINE_TYPE
                           ,:new.LOCATION_ID
                           ,:new.LOCATION_TYPE_CODE
                           ,:new.COMPONENT_INSTANCE_TYPE
			   ,:new.IB_TRACKABLE
                           ,:new.EXT_ACTIVATED_FLAG
                           ,NVL(:new.DISCONTINUED_FLAG,'0')
                           ,:new.ITEM_NUM_VAL
                           ,:new.ORIG_SYS_REF
                           ,:new.ITEM_SRC_APPL_ID
                           ,:new.PS_NODE_NAME
                           ,:new.TANGIBLE_ITEM_FLAG
                           ,:new.RETURNED_FLAG
                           );

             --
             -- insert into CZ_CONFIG_INPUTS only when
             -- CONFIG_INPUT_ID is SPECIFIED
             -- otherwise an exception will be generated
             --

             IF :new.CONFIG_INPUT_ID IS NOT NULL AND :new.INPUT_TYPE_CODE<>NULL_INPUT_TYPE_CODE THEN
                --dbms_output.put_line('DEBUG : CZ_CONFIG_INPUTS');

                INSERT INTO CZ_CONFIG_INPUTS
                             (CONFIG_HDR_ID
                              ,CONFIG_INPUT_ID
                              ,CONFIG_REV_NBR
                              ,INPUT_VAL
                              ,INPUT_SEQ
                              ,PARENT_INPUT_ID
                              ,INPUT_TYPE_CODE
                              ,NODE_IDENTIFIER
                              ,INSTANCE_ACTION_TYPE
                              ,TARGET_CONFIG_INPUT_ID
                              ,CONFIG_ITEM_ID
                              ,PS_NODE_ID
                              ,INSTANCE_NBR
                              ,TARGET_CONFIG_ITEM_ID
                              ,INPUT_NUM_VAL)
                 VALUES
                             (:new.CONFIG_HDR_ID
                              ,:new.CONFIG_INPUT_ID
                              ,:new.CONFIG_REV_NBR
                              ,:new.INPUT_VAL
                              ,:new.INPUT_SEQ
                              ,:new.PARENT_INPUT_ID
                              ,:new.INPUT_TYPE_CODE
                              ,:new.NODE_IDENTIFIER
                              ,:new.INSTANCE_ACTION_TYPE
                              ,:new.TARGET_CONFIG_INPUT_ID
                              ,v_config_item_id
                              ,:new.PS_NODE_ID
                              ,:new.INSTANCE_NBR
                              ,:new.TARGET_CONFIG_ITEM_ID
                              ,:new.INPUT_NUM_VAL);
            ELSE
               --
               -- CONFIG_INPUT_ID is not specified,              --
               -- but some CZ_CONFIG_INPUTS values are specified --
               -- raise an exception in this case                --
               --
               IF (:new.INSTANCE_ACTION_TYPE IS NOT NULL OR
                   :new.PARENT_INPUT_ID IS NOT NULL OR
                   :new.TARGET_CONFIG_INPUT_ID IS NOT NULL OR
                   :new.INPUT_TYPE_CODE IS NOT NULL OR
                   :new.INPUT_VAL IS NOT NULL OR
                   :new.INPUT_NUM_VAL IS NOT NULL OR
                   :new.INPUT_SEQ IS NOT NULL) AND :new.INPUT_TYPE_CODE<>NULL_INPUT_TYPE_CODE THEN
                   raise_application_error(-20107, ' NOT NULL value for CONFIG_INPUT_ID should be specified in INSERT statement.');
              END IF;

            END IF; -- end of CONFIG_INPUTS insert

          ELSE
             raise_application_error(-20105, 'NOT NULL value for CONFIG_ITEM_ID should be specified in INSERT statement.');
       END IF;
   END IF;

   IF UPDATING THEN
      --
      -- delete record from CZ_CONFIG_INPUTS if
      -- update statement sets INPUT_TYPE_CODE = -1
      --
      IF :new.INPUT_TYPE_CODE = NULL_INPUT_TYPE_CODE THEN
         DELETE FROM CZ_CONFIG_INPUTS
         WHERE CONFIG_HDR_ID=:new.CONFIG_HDR_ID
         AND CONFIG_REV_NBR=:new.CONFIG_REV_NBR
         AND CONFIG_ITEM_ID=:new.CONFIG_ITEM_ID;
      END IF;

      IF :new.CONFIG_INPUT_ID IS NOT NULL THEN
         UPDATE CZ_CONFIG_INPUTS
         SET  INPUT_VAL =:new.INPUT_VAL
              ,INPUT_SEQ =:new.INPUT_SEQ
              ,PARENT_INPUT_ID =:new.PARENT_INPUT_ID
              ,INPUT_TYPE_CODE =:new.INPUT_TYPE_CODE
              ,NODE_IDENTIFIER =:new.NODE_IDENTIFIER
              ,INSTANCE_ACTION_TYPE =:new.INSTANCE_ACTION_TYPE
              ,TARGET_CONFIG_INPUT_ID =:new.TARGET_CONFIG_INPUT_ID
              ,CONFIG_ITEM_ID =:new.CONFIG_ITEM_ID
              ,PS_NODE_ID =:new.PS_NODE_ID
              ,INSTANCE_NBR =:new.INSTANCE_NBR
              ,TARGET_CONFIG_ITEM_ID=:new.TARGET_CONFIG_ITEM_ID
              ,INPUT_NUM_VAL=:new.INPUT_NUM_VAL
         WHERE CONFIG_HDR_ID=:new.CONFIG_HDR_ID
         AND CONFIG_REV_NBR=:new.CONFIG_REV_NBR
         AND CONFIG_ITEM_ID=:new.CONFIG_ITEM_ID;

         -- bug 2700460 fix: insert a new input rec if previously there was
         --                  no such input rec and so update returns 0
         IF SQL%ROWCOUNT = 0 AND :new.INPUT_TYPE_CODE<>NULL_INPUT_TYPE_CODE THEN

           IF :new.CONFIG_HDR_ID IS NULL THEN
             raise_application_error(-20101, ' NOT NULL value for CONFIG_HDR_ID should be specified in INSERT statement.');
           END IF;

           IF :new.CONFIG_REV_NBR IS NULL THEN
             raise_application_error(-20102, ' NOT NULL value for CONFIG_REV_NBR should be specified in INSERT statement.');
           END IF;

           INSERT INTO CZ_CONFIG_INPUTS
               (CONFIG_HDR_ID
               ,CONFIG_INPUT_ID
               ,CONFIG_REV_NBR
               ,INPUT_VAL
               ,INPUT_SEQ
               ,PARENT_INPUT_ID
               ,INPUT_TYPE_CODE
               ,NODE_IDENTIFIER
               ,INSTANCE_ACTION_TYPE
               ,TARGET_CONFIG_INPUT_ID
               ,CONFIG_ITEM_ID
               ,PS_NODE_ID
               ,INSTANCE_NBR
               ,TARGET_CONFIG_ITEM_ID
               ,INPUT_NUM_VAL)
           VALUES
               (:new.CONFIG_HDR_ID
               ,:new.CONFIG_INPUT_ID
               ,:new.CONFIG_REV_NBR
               ,:new.INPUT_VAL
               ,:new.INPUT_SEQ
               ,:new.PARENT_INPUT_ID
               ,:new.INPUT_TYPE_CODE
               ,:new.NODE_IDENTIFIER
               ,:new.INSTANCE_ACTION_TYPE
               ,:new.TARGET_CONFIG_INPUT_ID
               ,:new.CONFIG_ITEM_ID
               ,:new.PS_NODE_ID
               ,:new.INSTANCE_NBR
               ,:new.TARGET_CONFIG_ITEM_ID
               ,:new.INPUT_NUM_VAL);
         END IF;
      END IF;

      IF :new.CONFIG_ITEM_ID IS NOT NULL THEN
         UPDATE CZ_CONFIG_ITEMS
         SET  PS_NODE_ID =:new.PS_NODE_ID
              ,VALUE_TYPE_CODE =:new.ITEM_TYPE_CODE
              ,SEQUENCE_NBR =:new.SEQUENCE_NBR
              ,ITEM_VAL =:new.ITEM_VAL
              ,INSTANCE_NBR =:new.INSTANCE_NBR
              ,PARENT_CONFIG_ITEM_ID =:new.PARENT_CONFIG_ITEM_ID
              ,NODE_IDENTIFIER =:new.NODE_IDENTIFIER
              ,INVENTORY_ITEM_ID =:new.INVENTORY_ITEM_ID
              ,ORGANIZATION_ID =:new.ORGANIZATION_ID
              ,COMPONENT_SEQUENCE_ID =:new.COMPONENT_SEQUENCE_ID
              ,UOM_CODE =:new.UOM_CODE
              ,USER_STR01 =:new.USER_STR01
              ,USER_STR02 =:new.USER_STR02
              ,USER_STR03 =:new.USER_STR03
              ,USER_STR04 =:new.USER_STR04
              ,USER_NUM01 =:new.USER_NUM01
              ,USER_NUM02 =:new.USER_NUM02
              ,USER_NUM03 =:new.USER_NUM03
              ,USER_NUM04 =:new.USER_NUM04
              ,BOM_ITEM_TYPE =:new.BOM_ITEM_TYPE
              ,QUOTEABLE_FLAG =:new.QUOTEABLE_FLAG
              ,BOM_SORT_ORDER =:new.BOM_SORT_ORDER
              ,TARGET_CONFIG_ITEM_ID =:new.TARGET_CONFIG_ITEM_ID
              ,INSTANCE_CONFIG_ITEM_ID =:new.INSTANCE_CONFIG_ITEM_ID
              ,NAME =:new.NAME
              ,ATO_CONFIG_ITEM_ID=:new.ATO_CONFIG_ITEM_ID
              ,INSTANCE_HDR_ID =:new.INSTANCE_HDR_ID
              ,INSTANCE_REV_NBR =:new.INSTANCE_REV_NBR
              ,TARGET_HDR_ID =:new.TARGET_HDR_ID
              ,TARGET_REV_NBR =:new.TARGET_REV_NBR
              ,CONFIG_DELTA =:new.CONFIG_DELTA
              ,LINE_TYPE =:new.LINE_TYPE
              ,LOCATION_ID =:new.LOCATION_ID
              ,LOCATION_TYPE_CODE =:new.LOCATION_TYPE_CODE
              ,COMPONENT_INSTANCE_TYPE =:new.COMPONENT_INSTANCE_TYPE
              ,EXT_ACTIVATED_FLAG=:new.EXT_ACTIVATED_FLAG
              ,IB_TRACKABLE=:new.IB_TRACKABLE
              ,DISCONTINUED_FLAG=NVL(:new.DISCONTINUED_FLAG,'0')
              ,ITEM_NUM_VAL=:new.ITEM_NUM_VAL
              ,ORIG_SYS_REF = :new.ORIG_SYS_REF
              ,ITEM_SRC_APPL_ID = :new.ITEM_SRC_APPL_ID
              ,PS_NODE_NAME = :new.PS_NODE_NAME
              ,TANGIBLE_ITEM_FLAG = :new.TANGIBLE_ITEM_FLAG
              ,RETURNED_FLAG = :new.RETURNED_FLAG
         WHERE CONFIG_HDR_ID=:new.CONFIG_HDR_ID
         AND CONFIG_REV_NBR=:new.CONFIG_REV_NBR
         AND CONFIG_ITEM_ID=:new.CONFIG_ITEM_ID;
      END IF;
   END IF;

   IF DELETING THEN
      IF :old.CONFIG_HDR_ID IS NULL OR :old.CONFIG_REV_NBR IS NULL THEN
         raise_application_error(-20106, 'CONFIG_HDR_ID and CONFIG_REV_NBR should be specified in DELETE statement.');
      END IF;

      IF :old.CONFIG_ITEM_ID IS NOT NULL THEN
         DELETE FROM CZ_CONFIG_ITEMS
         WHERE CONFIG_HDR_ID=:old.CONFIG_HDR_ID AND CONFIG_REV_NBR=:old.CONFIG_REV_NBR
         AND CONFIG_ITEM_ID=:old.CONFIG_ITEM_ID;

         DELETE FROM CZ_CONFIG_INPUTS
         WHERE CONFIG_HDR_ID=:old.CONFIG_HDR_ID AND CONFIG_REV_NBR=:old.CONFIG_REV_NBR
         AND CONFIG_ITEM_ID=:old.CONFIG_ITEM_ID;
      END IF;
   END IF;

END;

/
ALTER TRIGGER "APPS"."CZ_CONFIG_CONTENTS_V_T1" ENABLE;
