--------------------------------------------------------
--  DDL for Trigger WIP_DISCRETE_JOBS_BRD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."WIP_DISCRETE_JOBS_BRD" 
/* $Header: wipt003.sql 120.0.12010000.3 2010/02/11 04:16:01 pding noship $ */
BEFORE DELETE
ON "WIP"."WIP_DISCRETE_JOBS"
FOR EACH ROW
	   WHEN (    old.job_type in (1,3)/*BUG 7240404 (FP of 7126271)*/
      AND old.status_type < 7) BEGIN
  WIP_MRP_RELIEF.wip_discrete_jobs_proc(:old.primary_item_id,
                         :old.organization_id,
                         :old.last_update_date,
                         :old.last_updated_by,
                         :old.creation_date,
                         :old.created_by,
                         :new.net_quantity,         -- null but ok
                         :old.net_quantity,
                         :new.start_quantity, /*add for bug 8979443 (FP of 8420494)*/
                         :old.start_quantity,/*add for bug 8979443 (FP of 8420494)*/
                         :new.scheduled_completion_date, -- null but ok
                         :old.scheduled_completion_date,
                         :old.wip_entity_id,
                         :old.source_code,
                         :old.source_line_id,
                         :new.alternate_bom_designator,
                         :old.alternate_bom_designator,
                         :new.bom_revision_date,
                         :old.bom_revision_date,
                         :old.demand_class,
                         :old.demand_class,
                         :new.status_type,              -- null but ok
                         :old.status_type,
                         :new.quantity_completed +
			  :new.quantity_scrapped,       -- null but ok
                         :old.quantity_completed +
			  :old.quantity_scrapped,
                         :new.date_completed,           -- null but ok
                         :old.date_completed,
			 :new.project_id,
			 :old.project_id,
			 :new.task_id,
			 :old.task_id
                         );
END;

/
ALTER TRIGGER "APPS"."WIP_DISCRETE_JOBS_BRD" ENABLE;
