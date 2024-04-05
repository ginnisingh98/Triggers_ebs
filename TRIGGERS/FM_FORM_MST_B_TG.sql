--------------------------------------------------------
--  DDL for Trigger FM_FORM_MST_B_TG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FM_FORM_MST_B_TG" 
AFTER INSERT OR UPDATE
ON "GMD"."FM_FORM_MST_B"
FOR EACH ROW

DECLARE
  CURSOR Cur_get_item (v_formula_id IN NUMBER) IS
    SELECT inventory_item_id,organization_id
    FROM   fm_matl_dtl
    WHERE  formula_id = v_formula_id
    AND    line_type = 1
    AND    line_no = 1;
  l_return_status     VARCHAR2(1);
  l_msg_data          VARCHAR2(2000);
  l_error_code        NUMBER;
  l_item_id	      NUMBER;
  l_orgn_id	      NUMBER;
BEGIN
  IF :old.total_input_qty <> :new.total_input_qty OR :old.total_output_qty <> :new.total_output_qty THEN
    OPEN Cur_get_item(:new.formula_id);
    FETCH Cur_get_item INTO l_item_id,l_orgn_id;
    CLOSE Cur_get_item;
    GR_WF_UTIL_PUB.INITIATE_PROCESS_FORMULA_CHNG (
    	 p_api_version		=> 1.0,
	 p_init_msg_list	=> 'F',
	 p_commit		=> 'F',
	 p_orgn_id              => l_orgn_id,
	 p_item_id              => l_item_id,
	 p_formula_no		=> :new.formula_no,
	 p_formula_vers		=> :new.formula_vers,
	 p_user_id		=> :new.last_updated_by,
	 x_return_status	=> l_return_status,
	 x_error_code		=> l_error_code,
	 x_msg_data		=> l_msg_data);
  END IF;
END;


/
ALTER TRIGGER "APPS"."FM_FORM_MST_B_TG" ENABLE;
