--------------------------------------------------------
--  DDL for Trigger WIP_DISCRETE_JOBS_T5
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."WIP_DISCRETE_JOBS_T5" 

BEFORE UPDATE ON "WIP"."WIP_DISCRETE_JOBS"
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
   WHEN ((NVL(NEW.PROJECT_ID,-1) <> NVL(OLD.PROJECT_ID,-1))
  OR (NVL(NEW.TASK_ID,-1) <> NVL(OLD.TASK_ID,-1)) /*1265415*/
  OR (((NVL(NEW.BOM_REVISION_DATE,to_date('01/01/1000', 'mm/dd/yyyy')) <> NVL(OLD.BOM_REVISION_DATE,to_date('01/01/1000', 'mm/dd/yyyy')))
  OR (NVL(NEW.BOM_REVISION,-1) <> NVL(OLD.BOM_REVISION,-1))
  OR (NVL(NEW.ALTERNATE_BOM_DESIGNATOR,-1) <> NVL(OLD.ALTERNATE_BOM_DESIGNATOR,-1))
  OR (NVL(NEW.ROUTING_REVISION_DATE,to_date('01/01/1000', 'mm/dd/yyyy')) <> NVL(OLD.ROUTING_REVISION_DATE,to_date('01/01/1000', 'mm/dd/yyyy')))
  OR (NVL(NEW.ROUTING_REVISION,-1) <> NVL(OLD.ROUTING_REVISION,-1))
  OR (NVL(NEW.ALTERNATE_ROUTING_DESIGNATOR,-1) <> NVL(OLD.ALTERNATE_ROUTING_DESIGNATOR,-1)))
 AND (OLD.PROJECT_ID IS NOT NULL))) DECLARE
 DUMMY  NUMBER := 0;

BEGIN

 PJM_Project_Locator.Get_Job_ProjectSupply(:new.organization_id,
                     :new.wip_entity_id,
                     :new.project_id,
                     :new.task_id,
                     dummy);


END;



/
ALTER TRIGGER "APPS"."WIP_DISCRETE_JOBS_T5" ENABLE;
