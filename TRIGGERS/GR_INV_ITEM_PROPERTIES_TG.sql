--------------------------------------------------------
--  DDL for Trigger GR_INV_ITEM_PROPERTIES_TG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GR_INV_ITEM_PROPERTIES_TG" 
AFTER INSERT OR UPDATE OR DELETE
ON "GR"."GR_INV_ITEM_PROPERTIES"
FOR EACH ROW

DECLARE
  l_return_status     VARCHAR2(1);
  l_msg_data          VARCHAR2(2000);
  l_error_code        NUMBER;
BEGIN
  GR_WF_UTIL_PUB.INITIATE_PROCESS_ITEM_CHNG (
    	 p_api_version		=> 1.0,
	 p_init_msg_list	=> 'F',
--	Bug 4510201 Start
	--p_commit		=> 'T',
	 p_commit		=> 'F',
--	Bug 4510201 End
	 p_orgn_id              => :new.organization_id,
	 p_item_id              => :new.inventory_item_id,
	 p_user_id		=> :new.last_updated_by,
	 x_return_status	=> l_return_status,
	 x_error_code		=> l_error_code,
	 x_msg_data		=> l_msg_data);
END;


/
ALTER TRIGGER "APPS"."GR_INV_ITEM_PROPERTIES_TG" ENABLE;
