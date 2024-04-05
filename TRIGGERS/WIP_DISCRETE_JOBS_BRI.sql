--------------------------------------------------------
--  DDL for Trigger WIP_DISCRETE_JOBS_BRI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."WIP_DISCRETE_JOBS_BRI" 
/* $Header: wipt001.sql 120.0.12010000.4 2010/02/11 04:12:33 pding noship $ */
BEFORE INSERT
ON "WIP"."WIP_DISCRETE_JOBS"
FOR EACH ROW
  WHEN (    new.job_type in (1,3) /*BUG 7240404 (FP of 7126271)*/
      AND new.status_type < 7) BEGIN
  WIP_MRP_RELIEF.wip_discrete_jobs_proc(:new.primary_item_id,
                         :new.organization_id,
                         :new.last_update_date,
                         :new.last_updated_by,
                         :new.creation_date,
                         :new.created_by,
                         :new.net_quantity,
                         :old.net_quantity,          -- null, but ok
                         :new.start_quantity, /*add for bug 8979443 (FP of 8420494)*/
                         :old.start_quantity,/*add for bug 8979443 (FP of 8420494)*/
                         :new.scheduled_completion_date,
                         :old.scheduled_completion_date, -- null but ok
                         :new.wip_entity_id,
                         :new.source_code,
                         :new.source_line_id,
                         :new.alternate_bom_designator,
                         :old.alternate_bom_designator,
                         :new.bom_revision_date,
                         :old.bom_revision_date,
                         :new.demand_class,
                         :old.demand_class,              -- null but ok
                         :new.status_type,
                         :old.status_type,               -- null but ok
                         :new.quantity_completed +
			  :new.quantity_scrapped,
                         :old.quantity_completed +
			  :old.quantity_scrapped,        --null but ok
                         :new.date_completed,
                         :old.date_completed,            -- null but ok
			 :new.project_id,
			 :old.project_id,
			 :new.task_id,
			 :old.task_id
                         );
END;

/
ALTER TRIGGER "APPS"."WIP_DISCRETE_JOBS_BRI" ENABLE;
