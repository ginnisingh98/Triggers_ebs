--------------------------------------------------------
--  DDL for Trigger WIP_DISCRETE_JOBS_T4
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."WIP_DISCRETE_JOBS_T4" 
/* $Header: wipt012.sql 115.1 99/07/16 16:49:49 porting sh $ */
BEFORE INSERT ON "WIP"."WIP_DISCRETE_JOBS"
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
    WHEN (NEW.PROJECT_ID IS NOT NULL) DECLARE

 DUMMY  NUMBER := 0;

BEGIN

 PJM_Project_Locator.Get_Job_ProjectSupply(:new.organization_id,
                     :new.wip_entity_id,
                     :new.project_id,
                     :new.task_id,
                     dummy);

END;




/
ALTER TRIGGER "APPS"."WIP_DISCRETE_JOBS_T4" ENABLE;
