--------------------------------------------------------
--  DDL for Trigger WIP_FLOW_SCHEDULES_BRI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."WIP_FLOW_SCHEDULES_BRI" 
/* $Header: wipt016.sql 115.3 99/07/16 16:49:56 porting ship  $ */
BEFORE INSERT
ON "WIP"."WIP_FLOW_SCHEDULES"
FOR EACH ROW
    WHEN (new.status = 1) BEGIN
	INSERT INTO WIP_ENTITIES (
                                wip_entity_id,
                                organization_id,
                                last_update_date,
                                last_updated_by,
                                creation_date,
                                created_by,
                                last_update_login,
                                request_id,
                                program_application_id,
                                program_id,
                                program_update_date,
                                wip_entity_name,
                                entity_type,
				description,
				primary_item_id )
			 VALUES (
				:new.wip_entity_id,
				:new.organization_id,
                        	:new.last_update_date,
                        	:new.last_updated_by,
                        	:new.creation_date,
                        	:new.created_by,
				:new.last_update_login,
				:new.request_id,
				:new.program_application_id,
				:new.program_id,
				:new.program_update_date,
				:new.schedule_number,
				4,		-- Flow Schedule
				NULL,
				:new.primary_item_id );

  /* now insert records into MRP_RELIEF_INTERFACE table for MPS relief */

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
                         :old.planned_quantity,          -- null, but ok
                         :new.scheduled_completion_date,
                         :old.scheduled_completion_date, -- null but ok
                         :new.wip_entity_id,
                         :new.demand_class,
                         :old.demand_class,             -- null but ok
                         :new.alternate_bom_designator,
                         :old.alternate_bom_designator,
                         :new.status,
                         :old.status,                   -- null but ok
                         :new.quantity_completed,
                         :old.quantity_completed,       -- null but ok
                         :new.scheduled_completion_date,
                         :old.scheduled_completion_date, -- null but ok
                         :new.project_id,
                         :old.project_id,
                         :new.task_id,
                         :old.task_id
                         );

END;



/
ALTER TRIGGER "APPS"."WIP_FLOW_SCHEDULES_BRI" ENABLE;
