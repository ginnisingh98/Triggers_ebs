--------------------------------------------------------
--  DDL for Trigger GMDRTTRG_UPDATE_WF
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMDRTTRG_UPDATE_WF" 
	before update of routing_status
	on "GMD"."GMD_ROUTINGS_B"
	for each row
         WHEN ((new.routing_status between 400 and 499 AND
             old.routing_status not between 200 and 299 AND
             old.routing_status <> new.routing_status AND
            old.routing_status not between 500 and 599  )
        OR (new.routing_status between 700 and 799 AND
            old.routing_status not between 500 and 599  AND
             old.routing_status <> new.routing_status) ) declare
  PRAGMA AUTONOMOUS_TRANSACTION;
  p_data_string       VARCHAR2(2000);
  p_wf_data_string    VARCHAR2(2000);
  p_lab_wf_item_type  VARCHAR2(8)  := 'GMDRTLAP';  -- Routing Lab use Approval Workflow Inernal Name
  P_lab_Process_name  VARCHAR2(32) := 'GMDRTLAP_PROCESS'; -- Routing Lab use Approval Workflow Process Inernal Name
  P_table_name        VARCHAR2(32) := 'GMD_ROUTINGS_B'; -- Key Table
  p_gen_wf_item_type  VARCHAR2(8)  := 'GMDRTGAP';      -- Routing General use Approval Workflow Inernal Name
  P_gen_Process_name  VARCHAR2(32) := 'GMDRTGAP_PROCESS'; -- Routing General use Approval Workflow Process Inernal Name
  P_where_clause      VARCHAR2(100):= 'GMD_ROUTINGS_B.ROUTING_ID='||:new.ROUTING_ID; -- Where clause to be appended

begin
/* $Header: GMDRTTRG.sql 120.1 2005/06/09 05:02:52 appldev  $ */
   IF ((:new.routing_status between 400 and 499) AND
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
            gmdrtlap_wf_pkg.wf_init(:new.routing_id,
                                  :new.routing_no,
                                  :new.routing_vers,
                                  :old.routing_status,
                                  :new.routing_status,
                                  :new.last_updated_by,
                                  :new.last_update_date);
          SELECT pending_status into :new.routing_status
          from gmd_status_next
          where :old.routing_status = current_status and
                :new.routing_status = Target_status and
                pending_status IS NOT NULL;
       END IF;
   ELSIF ((:new.routing_status between 700 and 799) AND gma_wfstd_p.check_process_enabled(P_GEN_WF_ITEM_TYPE,P_GEN_PROCESS_NAME))
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
          gmdrtgap_wf_pkg.wf_init(:new.routing_id,
                                  :new.routing_no,
                                  :new.routing_vers,
                                  :old.routing_status,
                                  :new.routing_status,
                                  :new.last_updated_by,
                                  :new.last_update_date);
          SELECT pending_status into :new.routing_status
          from gmd_status_next
          where :old.routing_status = current_status and
                :new.routing_status = Target_status and
                pending_status IS NOT NULL;
       END IF;
   END IF;
commit;
end;


/
ALTER TRIGGER "APPS"."GMDRTTRG_UPDATE_WF" ENABLE;
