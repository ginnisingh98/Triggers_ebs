--------------------------------------------------------
--  DDL for Trigger PA_ADW_PROJECTS_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PA_ADW_PROJECTS_T1" 

-- $Header: pa_projects_all.xdf 120.1 2005/10/14 04:58:59 rpareek noship $
BEFORE UPDATE OF
  -- Columns required for data warehouse
  PROJECT_TYPE,
  NAME,
  SEGMENT1,
  DESCRIPTION,
  CARRYING_OUT_ORGANIZATION_ID
ON "PA"."PA_PROJECTS_ALL"
FOR EACH ROW







DECLARE
  X_ADW_LICENSED VARCHAR2(1) := NVL(FND_PROFILE.VALUE('PA_ADW_LICENSED'),'N');
BEGIN

--Fire Trigger only PA_ADW is Licensed
 IF  X_ADW_LICENSED <> 'Y' THEN
    RETURN;
 END IF;

  IF (:OLD.ADW_NOTIFY_FLAG <> 'Y') THEN
    :NEW.ADW_NOTIFY_FLAG := 'Y';
  END IF;
END;

   


/
ALTER TRIGGER "APPS"."PA_ADW_PROJECTS_T1" ENABLE;
