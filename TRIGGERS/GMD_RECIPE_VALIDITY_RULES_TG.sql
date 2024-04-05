--------------------------------------------------------
--  DDL for Trigger GMD_RECIPE_VALIDITY_RULES_TG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMD_RECIPE_VALIDITY_RULES_TG" 
AFTER INSERT OR UPDATE
ON "GMD"."GMD_RECIPE_VALIDITY_RULES"
FOR EACH ROW


DECLARE
  l_return_status     VARCHAR2(1);
  l_msg_data          VARCHAR2(2000);
  l_error_code        NUMBER;
BEGIN
  GR_WF_UTIL_PUB.INITIATE_PROCESS_FORMULA_CHNG (
    	 p_api_version		=> 1.0,
	 p_init_msg_list	=> 'F',
	 p_commit		=> 'F',
	 p_orgn_id              => :new.organization_id,
	 p_item_id              => :new.inventory_item_id,
	 p_formula_no           => NULL,
	 p_formula_vers         => -1,
	 p_user_id		=> :new.last_updated_by,
	 x_return_status	=> l_return_status,
	 x_error_code		=> l_error_code,
	 x_msg_data		=> l_msg_data);
END;

/
ALTER TRIGGER "APPS"."GMD_RECIPE_VALIDITY_RULES_TG" ENABLE;
