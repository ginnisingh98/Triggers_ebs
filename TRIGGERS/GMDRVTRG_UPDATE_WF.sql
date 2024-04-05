--------------------------------------------------------
--  DDL for Trigger GMDRVTRG_UPDATE_WF
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMDRVTRG_UPDATE_WF" 
	before update of VALIDITY_RULE_STATUS
	on "GMD"."GMD_RECIPE_VALIDITY_RULES"
	for each row
         WHEN ((new.VALIDITY_RULE_STATUS between 400 and 499 AND
             old.VALIDITY_RULE_STATUS not between 200 and 299 AND
             old.VALIDITY_RULE_STATUS <> new.VALIDITY_RULE_STATUS AND
            old.VALIDITY_RULE_STATUS not between 500 and 599 )
        OR (new.VALIDITY_RULE_STATUS between 700 and 799 AND
            old.VALIDITY_RULE_STATUS not between 500 and 599 AND
             old.VALIDITY_RULE_STATUS <> new.VALIDITY_RULE_STATUS) ) declare
  PRAGMA AUTONOMOUS_TRANSACTION;
  p_data_string       VARCHAR2(2000);
  p_wf_data_string    VARCHAR2(2000);
  p_lab_wf_item_type  VARCHAR2(8)  := 'GMDRVLAP';  -- Recipe Validity Rule Lab use Approval Workflow Inernal Name
  P_lab_Process_name  VARCHAR2(32) := 'GMDRVLAP_PROCESS'; -- Recipe Validity Rule Lab use Approval Workflow Process Inernal Name
  P_table_name        VARCHAR2(32) := 'GMD_RECIPE_VALIDITY_RULES'; -- Key Table
  p_gen_wf_item_type  VARCHAR2(8)  := 'GMDRVGAP';      -- Recipe Validity Rule General use Approval Workflow Inernal Name
  P_gen_Process_name  VARCHAR2(32) := 'GMDRVGAP_PROCESS'; -- Recipe Validity Rule General use Approval Workflow Process Inernal Name
  P_where_clause      VARCHAR2(100):= ' RECIPE_VALIDITY_RULE_ID='||:new.RECIPE_VALIDITY_RULE_ID; -- Where clause to be appended

begin
/* $Header: GMDRVTRG.sql 120.2 2006/03/08 23:14:22 kshukla noship $ */
   IF ((:new.VALIDITY_RULE_STATUS between 400 and 499) AND
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
            gmdrvlap_wf_pkg.wf_init(:new.recipe_validity_rule_id,
                                  :new.recipe_id,
                                  :old.VALIDITY_RULE_STATUS,
                                  :new.VALIDITY_RULE_STATUS,
                                  :new.last_updated_by,
                                  :new.last_update_date);
          SELECT pending_status into :new.VALIDITY_RULE_STATUS
          from gmd_status_next
          where :old.VALIDITY_RULE_STATUS = current_status and
                :new.VALIDITY_RULE_STATUS = Target_status and
                pending_status IS NOT NULL;
       END IF;
   ELSIF ((:new.VALIDITY_RULE_STATUS between 700 and 799) AND gma_wfstd_p.check_process_enabled(P_GEN_WF_ITEM_TYPE,P_GEN_PROCESS_NAME))
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
          gmdrvgap_wf_pkg.wf_init(:new.recipe_validity_rule_id,
                                  :new.recipe_id,
                                  :old.VALIDITY_RULE_STATUS,
                                  :new.VALIDITY_RULE_STATUS,
                                  :new.last_updated_by,
                                  :new.last_update_date);
          SELECT pending_status into :new.VALIDITY_RULE_STATUS
          from gmd_status_next
          where :old.VALIDITY_RULE_STATUS = current_status and
                :new.VALIDITY_RULE_STATUS = Target_status and
                pending_status IS NOT NULL;
       END IF;
   END IF;
commit;
end;


/
ALTER TRIGGER "APPS"."GMDRVTRG_UPDATE_WF" ENABLE;
