--------------------------------------------------------
--  DDL for Trigger WIP_FLOW_SCHEDULES_ARD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."WIP_FLOW_SCHEDULES_ARD" 
/* $Header: wipt017.sql 115.1 99/07/16 16:49:59 porting sh $ */
AFTER DELETE
ON "WIP"."WIP_FLOW_SCHEDULES"
FOR EACH ROW

BEGIN
	DELETE FROM WIP_ENTITIES
	WHERE
		wip_entity_id = :old.wip_entity_id
	and	organization_id = :old.organization_id ;

END;



/
ALTER TRIGGER "APPS"."WIP_FLOW_SCHEDULES_ARD" ENABLE;
