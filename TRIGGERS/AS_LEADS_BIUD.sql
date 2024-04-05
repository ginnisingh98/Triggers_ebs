--------------------------------------------------------
--  DDL for Trigger AS_LEADS_BIUD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."AS_LEADS_BIUD" BEFORE INSERT OR UPDATE OR DELETE
ON OSM.AS_LEADS_ALL
FOR EACH ROW
DECLARE
Trigger_Mode VARCHAR(20);
cust_id NUMBER;
lead_id NUMBER;
Auto_assignment_type varchar2(30);
addr_id NUMBER;
old_addr_id  NUMBER;    -- ffang 052302, bug 2372391
lead_number VARCHAR2(30);
description VARCHAR2(240);
new_decision DATE;
old_decision DATE;
sales_stage_id NUMBER;
source_promotion_id NUMBER;
new_win_probability NUMBER;
old_win_probability NUMBER;
status VARCHAR2(30);
channel_code VARCHAR2(30);
lead_source_code VARCHAR2(30);
orig_system_reference VARCHAR2(240);
new_currency VARCHAR2(15);
old_currency VARCHAR2(15);
new_total NUMBER;
old_total NUMBER;
old_lead NUMBER;
trigger_mode2 VARCHAR(20);
new_delete_flag VARCHAR2(1);
old_delete_flag VARCHAR2(1);
org_id number;
BEGIN

  if INSERTING then
     Trigger_Mode := 'ON-INSERT';
     cust_id := :new.customer_id;
     addr_id := :new.address_id;
     lead_id := :new.lead_id;
     org_id  := :new.org_id;
     Auto_assignment_type:= :new.Auto_assignment_type;
     new_delete_flag:=:new.deleted_flag;
	old_delete_flag:='N';
  elsif UPDATING then
     cust_id := :new.customer_id;
     addr_id := :new.address_id;
     -- ffang 052302, bug 2372391
     old_addr_id := :old.address_id;
     -- end ffang 052302, bug 2372391
     lead_id := :new.lead_id;
     org_id  := :new.org_id;
     Auto_assignment_type:= :new.Auto_assignment_type;
     Trigger_Mode := 'ON-UPDATE';
     lead_number := :new.lead_number;
     description := :new.description;
     new_decision := :new.decision_date;
     old_decision := :old.decision_date;
     sales_stage_id := :new.sales_stage_id;
     source_promotion_id := :new.source_promotion_id;
     old_win_probability := :old.win_probability;
     new_win_probability := :new.win_probability;
     status := :new.status;
     channel_code := :new.channel_code;
     lead_source_code := :new.lead_source_code;
     orig_system_reference := :new.orig_system_reference;
     new_currency := :new.currency_code;
     old_currency := :old.currency_code;
     new_total := :new.total_amount;
     old_total := :old.total_amount;
     old_lead := :old.lead_id;
     trigger_mode2 := 'UPDATE';
	new_delete_flag:=:new.deleted_flag;
	old_delete_flag:=:old.deleted_flag;
  elsif DELETING then
     Trigger_Mode := 'ON-DELETE';
     cust_id := :old.customer_id;
     addr_id := :old.address_id;
     lead_id := :old.lead_id;
     org_id  := :old.org_id;
     Auto_assignment_type:= :old.Auto_assignment_type;
	new_delete_flag:='Y';
	old_delete_flag:='N';

     DELETE FROM AS_TODO_LISTS
     WHERE lead_id = :old.lead_id;
  end if;

  IF AS_GAR.G_TAP_FLAG <> 'Y' THEN -- added for TAP perf

/* Calling of AS_TATA_TRIGGERS.Leads_Trigger_Handler API to insert into as_Changed_Accounts_all table
have removed  and moved to Opportunity real time API.*/


  AS_SC_DENORM_TRG.Leads_Trigger_Handler(
			:new.last_update_date,
			:new.last_updated_by,
			:new.creation_date,
			:new.created_by,
			:new.last_update_login,
			:new.customer_id ,
			addr_id,
			lead_id,
			lead_number,
			description,
			new_decision,
			old_decision,
			sales_stage_id,
			source_promotion_id,
		 	:new.close_competitor_id,
			:new.owner_salesforce_id,
			:new.owner_sales_group_id,
			:new.win_probability,
			:old.win_probability,
			:new.status,
			:old.status,
			channel_code,
			lead_source_code,
			orig_system_reference,
			new_currency,
			old_currency,
			new_total,
			old_total,
			:old.lead_id,
			:new.org_id,
               		:new.deleted_flag,
			:new.parent_project,
               		:new.close_reason,
			:new.attribute_category,
			:new.attribute1,
			:new.attribute2,
			:new.attribute3,
			:new.attribute4,
			:new.attribute5,
			:new.attribute6,
			:new.attribute7,
			:new.attribute8,
			:new.attribute9,
			:new.attribute10,
			:new.attribute11,
			:new.attribute12,
			:new.attribute13,
			:new.attribute14,
			:new.attribute15,
                        :new.sales_methodology_id,
			Trigger_Mode);
  END IF; -- added for TAP perf

 -- DBMS_output.put_line('In Trigger calling AS_LEADS_AUDIT_PKG.Leads_Trigger_Handler');
   AS_LEADS_AUDIT_PKG.Leads_Trigger_Handler(
 	p_new_last_update_date 		=> :new.last_update_date ,
 	p_old_last_update_date 		=> :old.last_update_date ,
 	p_new_last_updated_by 		=> :new.last_updated_by,
 	p_new_creation_date 		=> :new.creation_date,
 	p_new_created_by 		=> :new.created_by,
 	p_new_last_update_login  	=> :new.last_update_login,
 	p_new_lead_id 			=> :new.lead_id,
 	p_old_lead_id 			=> :old.lead_id,
 	p_new_address_id 		=> :new.address_id,
 	p_old_address_id 		=> :old.address_id,
 	p_new_status 			=> :new.status,
 	p_old_status 			=> :old.status,
 	p_new_sales_stage_id 		=> :new.sales_stage_id,
 	p_old_sales_stage_id 		=> :old.sales_stage_id,
 	p_new_channel_code 		=> :new.channel_code,
 	p_old_channel_code 		=> :old.channel_code,
 	p_new_win_probability 		=> :new.win_probability,
 	p_old_win_probability 		=> :old.win_probability,
 	p_new_decision_date 		=> :new.decision_date ,
 	p_old_decision_date 		=> :old.decision_date ,
 	p_new_currency_code 		=> :new.currency_code,
 	p_old_currency_code 		=> :old.currency_code,
 	p_new_total_amount 		=> :new.total_amount,
 	p_old_total_amount 		=> :old.total_amount,

 	p_new_security_group_id      	=> :new.security_group_id      	 ,
 	p_old_security_group_id      	=> :old.security_group_id      	 ,



 	p_new_customer_id               => :new.customer_id,
 	p_old_customer_id               => :old.customer_id,

 	p_new_description            	=> :new.description ,
 	p_old_description            	=> :old.description ,

 	p_new_source_promotion_id    	=> :new.source_promotion_id    ,
 	p_old_source_promotion_id    	=> :old.source_promotion_id    ,

 	p_new_offer_id               	=> :new.offer_id               ,
 	p_old_offer_id               	=> :old.offer_id               ,

 	p_new_close_competitor_id    	=> :new.close_competitor_id    ,
 	p_old_close_competitor_id    	=> :old.close_competitor_id    ,

 	p_new_vehicle_response_code  	=> :new.vehicle_response_code  ,
 	p_old_vehicle_response_code  	=> :old.vehicle_response_code  ,

 	p_new_sales_methodology_id   	=> :new.sales_methodology_id   ,
 	p_old_sales_methodology_id   	=> :old.sales_methodology_id   ,

 	p_new_owner_salesforce_id    	=> :new.owner_salesforce_id    ,
 	p_old_owner_salesforce_id    	=> :old.owner_salesforce_id    ,

 	p_new_owner_sales_group_id   	=> :new.owner_sales_group_id   ,
 	p_old_owner_sales_group_id   	=> :old.owner_sales_group_id   ,

 	p_new_org_id       			=> :new.org_id       ,
 	p_old_org_id       			=> :old.org_id       ,

 	p_trigger_mode 			=> Trigger_Mode);



END AS_LEADS_BIUD;


/
ALTER TRIGGER "APPS"."AS_LEADS_BIUD" ENABLE;
