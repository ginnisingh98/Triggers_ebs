--------------------------------------------------------
--  DDL for Trigger GMDFMTRG_UPDATE_WF
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMDFMTRG_UPDATE_WF" 
	before update of formula_status
	on "GMD"."FM_FORM_MST_B"
	for each row
         WHEN ((new.formula_status  between 400 and 499 AND
             old.formula_status  not between 200 and 299 AND
             old.formula_status <> new.formula_status  AND
             old.formula_status  not between 500 and 599 )
        OR  (new.formula_status  between 700 and 799 AND
             old.formula_status  not between 500 and 599 AND
             old.formula_status <> new.formula_status)) declare
  PRAGMA AUTONOMOUS_TRANSACTION;
  p_data_string       VARCHAR2(2000);
  p_wf_data_string    VARCHAR2(2000);
  p_lab_wf_item_type  VARCHAR2(8)  := 'GMDFMLAP';  -- Formula Lab use Approval Workflow Inernal Name
  P_lab_Process_name  VARCHAR2(32) := 'GMDFMLAP_PROCESS'; -- Formula Lab use Approval Workflow Process Inernal Name
  P_table_name        VARCHAR2(32) := 'FM_FORM_MST_B'; -- Key Table
  p_gen_wf_item_type  VARCHAR2(8)  := 'GMDFMGAP';      -- Formula General use Approval Workflow Inernal Name
  P_gen_Process_name  VARCHAR2(32) := 'GMDFMGAP_PROCESS'; -- Formula General use Approval Workflow Process Inernal Name
  P_where_clause      VARCHAR2(100):= ' FM_FORM_MST_B.FORMULA_ID='||:new.FORMULA_ID; -- Where clause to be appended
                              -- to get single row of actual data using query defined in Process Configuration Framework

begin
/* $Header: GMDFMTRG.sql 120.1 2005/06/09 04:58:13 appldev  $ */
   IF ((:new.formula_status  between 400 and 499) AND
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
            gmdfmlap_wf_pkg.wf_init(:new.formula_id,
                                  :new.formula_no,
                                  :new.formula_vers,
                                  :old.formula_status ,
                                  :new.formula_status ,
                                  :new.last_updated_by,
                                  :new.last_update_date);
          SELECT pending_status into :new.formula_status
          from gmd_status_next
          where :old.formula_status  = current_status and
                :new.formula_status  = Target_status and
                pending_status IS NOT NULL;
       END IF;
   ELSIF ((:new.formula_status  between 700 and 799) AND gma_wfstd_p.check_process_enabled(P_GEN_WF_ITEM_TYPE,P_GEN_PROCESS_NAME))
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
          gmdfmgap_wf_pkg.wf_init(:new.formula_id,
                                  :new.formula_no,
                                  :new.formula_vers,
                                  :old.formula_status ,
                                  :new.formula_status ,
                                  :new.last_updated_by,
                                  :new.last_update_date);
          SELECT pending_status into :new.formula_status
          from gmd_status_next
          where :old.formula_status  = current_status and
                :new.formula_status  = Target_status and
                pending_status IS NOT NULL;
       END IF;
   END IF;
commit;
end;


/
ALTER TRIGGER "APPS"."GMDFMTRG_UPDATE_WF" ENABLE;
