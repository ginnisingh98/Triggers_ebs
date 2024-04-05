--------------------------------------------------------
--  DDL for Trigger PO_REQUISITIONS_INTERFACE_BRI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PO_REQUISITIONS_INTERFACE_BRI" 
/* $Header: POXREQIN.sql 115.0 99/07/17 01:58:02 porting ship $ */
BEFORE INSERT
ON "PO"."PO_REQUISITIONS_INTERFACE_ALL"
FOR EACH ROW
    WHEN (
  new.interface_source_code = 'WIP'
  AND new.source_type_code = 'VENDOR'
  AND new.destination_type_code = 'SHOP FLOOR'
) BEGIN
  INSERT INTO WIP_SHOP_FLOOR_STATUSES
   (WIP_ENTITY_ID,
    ORGANIZATION_ID,
    OPERATION_SEQ_NUM,
    SHOP_FLOOR_STATUS_CODE,
    LINE_ID,
    INTRAOPERATION_STEP_TYPE,
    LAST_UPDATE_DATE,
    LAST_UPDATED_BY,
    CREATION_DATE,
    CREATED_BY,
    LAST_UPDATE_LOGIN)
  SELECT
    :new.wip_entity_id,
    :new.destination_organization_id,
    :new.wip_operation_seq_num,
    WSFSC.SHOP_FLOOR_STATUS_CODE,
    :new.wip_line_id,
    WIP_CONSTANTS.QUEUE,
    :new.last_update_date,
    :new.last_updated_by,
    :new.creation_date,
    :new.created_by,
    :new.last_update_login
  FROM  WIP_SHOP_FLOOR_STATUS_CODES WSFSC,
        WIP_PARAMETERS WP
  WHERE WSFSC.ORGANIZATION_ID = WP.ORGANIZATION_ID
  AND   WSFSC.SHOP_FLOOR_STATUS_CODE = WP.OSP_SHOP_FLOOR_STATUS
  AND   WP.ORGANIZATION_ID = :new.destination_organization_id
  AND   EXISTS
         (SELECT 'X'
          FROM WIP_OPERATION_RESOURCES WOR
          WHERE  WOR.ORGANIZATION_ID = :new.destination_organization_id
          AND    WOR.WIP_ENTITY_ID = :new.wip_entity_id
          AND    WOR.OPERATION_SEQ_NUM = :new.wip_operation_seq_num
          AND    WOR.RESOURCE_SEQ_NUM = :new.wip_resource_seq_num
          AND    NVL(WOR.REPETITIVE_SCHEDULE_ID, -1) =
                   NVL(:new.wip_repetitive_schedule_id, -1)
          AND    WOR.AUTOCHARGE_TYPE = WIP_CONSTANTS.PO_MOVE)
  AND NOT EXISTS
         (SELECT 'X'
          FROM   WIP_SHOP_FLOOR_STATUSES WSFS
          WHERE  WSFS.SHOP_FLOOR_STATUS_CODE = WSFSC.SHOP_FLOOR_STATUS_CODE
          AND    WSFS.ORGANIZATION_ID = WSFSC.ORGANIZATION_ID
          AND    WSFS.WIP_ENTITY_ID = :new.wip_entity_id
          AND    NVL(WSFS.LINE_ID, -1) = NVL(:new.wip_line_id, -1)
          AND    WSFS.OPERATION_SEQ_NUM = :new.wip_operation_seq_num
          AND    WSFS.INTRAOPERATION_STEP_TYPE = WIP_CONSTANTS.QUEUE);
END;



/
ALTER TRIGGER "APPS"."PO_REQUISITIONS_INTERFACE_BRI" ENABLE;
