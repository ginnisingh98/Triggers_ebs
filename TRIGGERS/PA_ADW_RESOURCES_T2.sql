--------------------------------------------------------
--  DDL for Trigger PA_ADW_RESOURCES_T2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PA_ADW_RESOURCES_T2" 
-- $Header: PATRIG01.pls 115.5 99/07/16 15:14:43 porting ship  $
BEFORE UPDATE OF
  -- Columns required for data warehouse
  NAME
ON "PA"."PA_RESOURCES"
FOR EACH ROW

DECLARE
  X_ADW_LICENSED VARCHAR2(1) := NVL(FND_PROFILE.VALUE('PA_ADW_LICENSED'),'N');
BEGIN

--Fire Trigger only PA_ADW is Licensed
 IF X_ADW_LICENSED <> 'Y' THEN
    RETURN;
 END IF;

  UPDATE PA_RESOURCE_LIST_MEMBERS
  SET ADW_NOTIFY_FLAG = 'Y'
  WHERE
     RESOURCE_ID = :NEW.RESOURCE_ID
  AND ADW_NOTIFY_FLAG <> 'Y';
END;



/
ALTER TRIGGER "APPS"."PA_ADW_RESOURCES_T2" ENABLE;
