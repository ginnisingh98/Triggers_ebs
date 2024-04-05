--------------------------------------------------------
--  DDL for Trigger GMDRPTRG_UPDATE_WF
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMDRPTRG_UPDATE_WF" 
	before update of recipe_status
	on "GMD"."GMD_RECIPES_B"
	for each row
         WHEN ((new.recipe_status between 400 and 499 AND
             old.recipe_status not between 200 and 299 AND
             old.recipe_status <> new.recipe_status AND
             old.recipe_status not between 500 and 599 )
        OR (new.recipe_status between 700 and 799 AND
           old.recipe_status not between 500 and 599 AND
           old.recipe_status <> new.recipe_status) ) declare
  PRAGMA AUTONOMOUS_TRANSACTION;
  p_data_string       VARCHAR2(2000);
  p_wf_data_string    VARCHAR2(2000);
  p_lab_wf_item_type  VARCHAR2(8)  := 'GMDRPLAP';  -- Recipe Lab use Approval Workflow Inernal Name
  P_lab_Process_name  VARCHAR2(32) := 'GMDRPLAP_PROCESS'; -- Recipe Lab use Approval Workflow Process Inernal Name
  P_table_name        VARCHAR2(32) := 'GMD_RECIPES_B'; -- Key Table
  p_gen_wf_item_type  VARCHAR2(8)  := 'GMDRPGAP';      -- Recipe General use Approval Workflow Inernal Name
  P_gen_Process_name  VARCHAR2(32) := 'GMDRPGAP_PROCESS'; -- Recipe General use Approval Workflow Process Inernal Name
  P_where_clause      VARCHAR2(100):= ' GMD_RECIPES_B.RECIPE_ID='||:new.RECIPE_ID; -- Where clause to be appended
                                                                  -- to get singl

begin
/* $Header: GMDRPTRG.sql 120.1 2005/06/09 05:02:26 appldev  $ */
   IF ((:new.recipe_status between 400 and 499) AND
       gma_wfstd_p.check_process_enabled(P_LAB_WF_ITEM_TYPE,P_LAB_PROCESS_NAME))
   THEN
       gma_wfstd_p.WF_GET_CONTORL_PARAMS(P_LAB_WF_ITEM_TYPE,
                                         P_LAB_PROCESS_NAME,
                                         null,  -- Activity Name
                                         P_TABLE_NAME,
                                         P_WHERE_CLAUSE,
                                         P_DATA_STRING,
                                         p_wf_data_string);
       IF gma_wfstd_p.check_process_approval_req(p_lab_wf_item_type,
                                                 p_lab_process_name,
                                                 p_data_string)  = 'Y' THEN
            gmdrplap_wf_pkg.wf_init(:new.recipe_id,
                                  :new.recipe_no,
                                  :new.recipe_version,
                                  :old.recipe_status,
                                  :new.recipe_status,
                                  :new.last_updated_by,
                                  :new.last_update_date);
          SELECT pending_status into :new.recipe_status
          from gmd_status_next
          where :old.recipe_status = current_status and
                :new.recipe_status = Target_status and
                pending_status IS NOT NULL;
       END IF;
   ELSIF ((:new.recipe_status between 700 and 799) AND gma_wfstd_p.check_process_enabled(P_GEN_WF_ITEM_TYPE,P_GEN_PROCESS_NAME))
   THEN
       gma_wfstd_p.WF_GET_CONTORL_PARAMS(P_GEN_WF_ITEM_TYPE,
                                         P_GEN_PROCESS_NAME,
                                         null,  -- Activity Name
                                         P_TABLE_NAME,
                                         P_WHERE_CLAUSE,
                                         P_DATA_STRING,
                                         p_wf_data_string);
       IF gma_wfstd_p.check_process_approval_req(p_gen_wf_item_type,
                                            p_gen_process_name,
                                            p_data_string)  = 'Y' THEN
          gmdrpgap_wf_pkg.wf_init(:new.recipe_id,
                                  :new.recipe_no,
                                  :new.recipe_version,
                                  :old.recipe_status,
                                  :new.recipe_status,
                                  :new.last_updated_by,
                                  :new.last_update_date);
          SELECT pending_status into :new.recipe_status
          from gmd_status_next
          where :old.recipe_status = current_status and
                :new.recipe_status = Target_status and
                pending_status IS NOT NULL;
       END IF;
   END IF;
commit;
end;


/
ALTER TRIGGER "APPS"."GMDRPTRG_UPDATE_WF" ENABLE;
