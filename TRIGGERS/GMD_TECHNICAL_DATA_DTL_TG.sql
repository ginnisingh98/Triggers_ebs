--------------------------------------------------------
--  DDL for Trigger GMD_TECHNICAL_DATA_DTL_TG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMD_TECHNICAL_DATA_DTL_TG" 
AFTER INSERT OR UPDATE OR DELETE
ON "GMD"."GMD_TECHNICAL_DATA_DTL"
FOR EACH ROW


DECLARE
  CURSOR Cur_get_item (v_tech_data_id IN NUMBER) IS
    SELECT organization_id
    FROM   gmd_technical_data_hdr
    WHERE  tech_data_id = v_tech_data_id;
  l_return_status     VARCHAR2(1);
  l_msg_data          VARCHAR2(2000);
  l_error_code        NUMBER;
  l_orgn_id	      NUMBER;
BEGIN
  OPEN Cur_get_item(:new.tech_data_id);
  FETCH Cur_get_item INTO l_orgn_id;
  CLOSE Cur_get_item;
  GR_WF_UTIL_PUB.INITIATE_PROCESS_TECH_CHNG (
    	 p_api_version		=> 1.0,
	 p_init_msg_list	=> 'F',
	 p_commit		=> 'F',
	 p_orgn_id              => l_orgn_id,
	 p_tech_data_id		=> :new.tech_data_id,
	 p_tech_parm_id		=> :new.tech_parm_id,
	 p_user_id		=> :new.last_updated_by,
	 x_return_status	=> l_return_status,
	 x_error_code		=> l_error_code,
	 x_msg_data		=> l_msg_data);
END;


/
ALTER TRIGGER "APPS"."GMD_TECHNICAL_DATA_DTL_TG" ENABLE;
