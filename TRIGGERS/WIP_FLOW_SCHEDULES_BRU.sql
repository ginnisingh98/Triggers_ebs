--------------------------------------------------------
--  DDL for Trigger WIP_FLOW_SCHEDULES_BRU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."WIP_FLOW_SCHEDULES_BRU" 
/* $Header: wipt018.sql 115.3 99/07/16 16:50:02 porting ship  $ */
BEFORE UPDATE of
  request_id,
  demand_class,
  planned_quantity,
  scheduled_completion_date,
  alternate_bom_designator,
  status,
  project_id,
  task_id
ON "WIP"."WIP_FLOW_SCHEDULES"
FOR EACH ROW
    WHEN (new.status = 1 OR old.status = 1) BEGIN

  WIP_MRP_RELIEF.wip_flow_schedules_proc (
			 :new.primary_item_id,
                         :new.organization_id,
                         :new.last_update_date,
                         :new.last_updated_by,
                         :new.creation_date,
                         :new.created_by,
                         :new.request_id,
                         :old.request_id,
                         :new.demand_source_type,
                         :new.demand_source_line,
                         :new.planned_quantity,
                         :old.planned_quantity,
                         :new.scheduled_completion_date,
                         :old.scheduled_completion_date,
                         :new.wip_entity_id,
                         :new.demand_class,
                         :old.demand_class,
                         :new.alternate_bom_designator,
                         :old.alternate_bom_designator,
                         :new.status,
                         :old.status,
                         :new.quantity_completed,
                         :old.quantity_completed,
                         :new.scheduled_completion_date,
                         :old.scheduled_completion_date,
			 :new.project_id,
			 :old.project_id,
			 :new.task_id,
			 :old.task_id
                         );
END;



/
ALTER TRIGGER "APPS"."WIP_FLOW_SCHEDULES_BRU" ENABLE;
