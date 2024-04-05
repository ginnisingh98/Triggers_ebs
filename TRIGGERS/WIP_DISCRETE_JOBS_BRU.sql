--------------------------------------------------------
--  DDL for Trigger WIP_DISCRETE_JOBS_BRU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."WIP_DISCRETE_JOBS_BRU" 
/* $Header: wipt002.sql 120.1.12010000.3 2010/02/11 04:13:23 pding ship $ */
BEFORE UPDATE of
  demand_class,
  net_quantity,
  scheduled_completion_date,
  date_completed,
  status_type,
  alternate_bom_designator,
  bom_reference_id,
  bom_revision,
  bom_revision_date,
  project_id,
  task_id,
  start_quantity /*Bug 4259501- Change of start_quantity should also be notified to planning manager*/
ON "WIP"."WIP_DISCRETE_JOBS"
FOR EACH ROW
  WHEN (    new.job_type in (1,3)/*BUG 7240404 (FP of 7126271)*/
      AND (new.status_type < 7 OR old.status_type < 7)
     ) BEGIN
  WIP_MRP_RELIEF.wip_discrete_jobs_proc(:new.primary_item_id,
                         :new.organization_id,
                         :new.last_update_date,
                         :new.last_updated_by,
                         :new.creation_date,
                         :new.created_by,
                         :new.net_quantity,
                         :old.net_quantity,
                         :new.start_quantity, /*add for bug 8979443 (FP of 8420494)*/
                         :old.start_quantity,/*add for bug 8979443 (FP of 8420494)*/
                         :new.scheduled_completion_date,
                         :old.scheduled_completion_date,
                         :new.wip_entity_id,
                         :new.source_code,
                         :new.source_line_id,
                         :new.alternate_bom_designator,
                         :old.alternate_bom_designator,
                         :new.bom_revision_date,
                         :old.bom_revision_date,
                         :new.demand_class,
                         :old.demand_class,
                         :new.status_type,
                         :old.status_type,
                         :new.quantity_completed +
			  :new.quantity_scrapped,
                         :old.quantity_completed +
			  :old.quantity_scrapped,
                         :new.date_completed,
                         :old.date_completed,
			 :new.project_id,
			 :old.project_id,
			 :new.task_id,
			 :old.task_id
                         );

       /* Bug#2777229 - Added below code to delete records from
          wip_scheduling_exceptions when the job status is changed
          to complete/cancelled/closed */

   if ( :new.status_type in
       (WIP_CONSTANTS.COMP_CHRG,WIP_CONSTANTS.CANCELLED,WIP_CONSTANTS.CLOSED)
       and :old.status_type not in
       (WIP_CONSTANTS.COMP_CHRG,WIP_CONSTANTS.CANCELLED,WIP_CONSTANTS.CLOSED))
   then
              delete from wip_scheduling_exceptions
               where wip_entity_id = :new.wip_entity_id
                 and organization_id = :new.organization_id;
   end if;

END;

/
ALTER TRIGGER "APPS"."WIP_DISCRETE_JOBS_BRU" ENABLE;
