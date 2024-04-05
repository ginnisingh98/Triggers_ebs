--------------------------------------------------------
--  DDL for Trigger BOM_DELETE_ENTITIES_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."BOM_DELETE_ENTITIES_T" 
	AFTER INSERT ON "BOM"."BOM_DELETE_ENTITIES" FOR EACH ROW

   WHEN ( new.delete_entity_type= 1 ) DECLARE
l_parameter_list      wf_parameter_list_t := wf_parameter_list_t();

BEGIN

Bom_Business_Event_PKG.Add_Parameter_To_List('INVENTORY_ITEM_ID', :new.inventory_item_id, l_parameter_list);
Bom_Business_Event_PKG.Add_Parameter_To_List('ORGANIZATION_ID', :new.organization_id, l_parameter_list);
Bom_Business_Event_PKG.Add_Parameter_To_List('ITEM_NAME', :new.ITEM_CONCAT_SEGMENTS, l_parameter_list);
Bom_Business_Event_PKG.Add_Parameter_To_List('ITEM_DESCRIPTION', :new.ITEM_DESCRIPTION, l_parameter_list);
Bom_Business_Event_PKG.Raise_event ( Bom_Business_Event_PKG.G_ITEM_MARKED_DEL_EVENT, 'DG'||to_char(SYSDATE,'DD-MON-YYYY HH24:MI:SS'),l_parameter_list);
END;



/
ALTER TRIGGER "APPS"."BOM_DELETE_ENTITIES_T" ENABLE;
