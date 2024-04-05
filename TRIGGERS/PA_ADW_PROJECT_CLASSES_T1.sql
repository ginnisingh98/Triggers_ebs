--------------------------------------------------------
--  DDL for Trigger PA_ADW_PROJECT_CLASSES_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PA_ADW_PROJECT_CLASSES_T1" 
-- $Header: PATRIG01.pls 115.5 99/07/16 15:14:43 porting ship  $
BEFORE UPDATE OF
  -- Columns required for data warehouse
  CLASS_CATEGORY,
  CLASS_CODE
ON "PA"."PA_PROJECT_CLASSES"
FOR EACH ROW

DECLARE
  X_ADW_LICENSED VARCHAR2(1) := NVL(FND_PROFILE.VALUE('PA_ADW_LICENSED'),'N');
BEGIN

--Fire Trigger only PA_ADW is Licensed
 IF X_ADW_LICENSED <> 'Y' THEN
    RETURN;
 END IF;

  IF (:OLD.ADW_NOTIFY_FLAG <> 'Y') THEN
    :NEW.ADW_NOTIFY_FLAG := 'Y';
  END IF;
END;



/
ALTER TRIGGER "APPS"."PA_ADW_PROJECT_CLASSES_T1" ENABLE;
