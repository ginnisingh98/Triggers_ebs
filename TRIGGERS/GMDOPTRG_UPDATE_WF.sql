--------------------------------------------------------
--  DDL for Trigger GMDOPTRG_UPDATE_WF
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMDOPTRG_UPDATE_WF" 
	before update of operation_status
	on "GMD"."GMD_OPERATIONS_B"
	for each row
         WHEN ((new.operation_status between 400 and 499 AND
             old.operation_status not between 200 and 299 AND
             old.operation_status <> new.operation_status AND
            old.operation_status not between 500 and 599 )
        OR (new.operation_status between 700 and 799 AND
            old.operation_status not between 500 and 599 AND
             old.operation_status <> new.operation_status) ) declare
  PRAGMA AUTONOMOUS_TRANSACTION;
  p_data_string       VARCHAR2(2000);
  p_wf_data_string    VARCHAR2(2000);
  p_lab_wf_item_type  VARCHAR2(8)  := 'GMDOPLAP';  -- Recipe Lab use Approval Workflow Inernal Name
  P_lab_Process_name  VARCHAR2(32) := 'GMDOPLAP_PROCESS'; -- Recipe Lab use Approval Workflow Process Inernal Name
  P_table_name        VARCHAR2(32) := 'GMD_OPERATIONS_B'; -- Key Table
  p_gen_wf_item_type  VARCHAR2(8)  := 'GMDOPGAP';      -- Recipe General use Approval Workflow Inernal Name
  P_gen_Process_name  VARCHAR2(32) := 'GMDOPGAP_PROCESS'; -- Recipe General use Approval Workflow Process Inernal Name
  P_where_clause      VARCHAR2(100):= ' GMD_OPERATIONS_B.OPRN_ID='||:new.OPRN_ID; -- Where clause to be appended

begin
/* $Header: GMDOPTRG.sql 120.1 2005/06/09 04:59:07 appldev  $ */
   IF ((:new.operation_status between 400 and 499) AND
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
            gmdoplap_wf_pkg.wf_init(:new.oprn_id,
                                  :new.oprn_no,
                                  :new.oprn_vers,
                                  :old.operation_status,
                                  :new.operation_status,
                                  :new.last_updated_by,
                                  :new.last_update_date);
          SELECT pending_status into :new.operation_status
          from gmd_status_next
          where :old.operation_status = current_status and
                :new.operation_status = Target_status and
                pending_status IS NOT NULL;
       END IF;
   ELSIF ((:new.operation_status between 700 and 799) AND gma_wfstd_p.check_process_enabled(P_GEN_WF_ITEM_TYPE,P_GEN_PROCESS_NAME))
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
          gmdopgap_wf_pkg.wf_init(:new.oprn_id,
                                  :new.oprn_no,
                                  :new.oprn_vers,
                                  :old.operation_status,
                                  :new.operation_status,
                                  :new.last_updated_by,
                                  :new.last_update_date);
          SELECT pending_status into :new.operation_status
          from gmd_status_next
          where :old.operation_status = current_status and
                :new.operation_status = Target_status and
                pending_status IS NOT NULL;
       END IF;
   END IF;
   commit;
end;


/
ALTER TRIGGER "APPS"."GMDOPTRG_UPDATE_WF" ENABLE;
