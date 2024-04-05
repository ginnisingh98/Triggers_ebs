--------------------------------------------------------
--  DDL for Trigger WIP_FLOW_SCHEDULES_BRD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."WIP_FLOW_SCHEDULES_BRD" 
/* $Header: wipt019.sql 115.3 99/07/16 16:50:11 porting ship  $ */
BEFORE DELETE
ON "WIP"."WIP_FLOW_SCHEDULES"
FOR EACH ROW
    WHEN (old.status = 1) BEGIN

  WIP_MRP_RELIEF.wip_flow_schedules_proc (
		         :old.primary_item_id,
                         :old.organization_id,
                         :old.last_update_date,
                         :old.last_updated_by,
                         :old.creation_date,
                         :old.created_by,
                         :new.request_id,
                         :old.request_id,
                         :old.demand_source_type,
                         :old.demand_source_line,
                         :new.planned_quantity,          -- null but ok
                         :old.planned_quantity,
                         :new.scheduled_completion_date, -- null but ok
                         :old.scheduled_completion_date,
                         :old.wip_entity_id,
                         :new.demand_class,
                         :old.demand_class,
                         :new.alternate_bom_designator,
                         :old.alternate_bom_designator,
                         :new.status,                   -- null but ok
                         :old.status,
                         :new.quantity_completed,     	-- null but ok
                         :old.quantity_completed,
                         :new.scheduled_completion_date, -- null but ok
                         :old.scheduled_completion_date,
			 :new.project_id,
			 :old.project_id,
			 :new.task_id,
			 :old.task_id
                         );
END;



/
ALTER TRIGGER "APPS"."WIP_FLOW_SCHEDULES_BRD" ENABLE;
