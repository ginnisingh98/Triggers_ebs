--------------------------------------------------------
--  DDL for Trigger AS_LEAD_LINES_BIUD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."AS_LEAD_LINES_BIUD" BEFORE INSERT OR UPDATE OR DELETE
ON OSM.AS_LEAD_LINES_ALL
FOR EACH ROW
DECLARE
Trigger_Mode VARCHAR(20);
lead_id NUMBER;
BEGIN
  if INSERTING then
   Trigger_Mode := 'ON-INSERT';
   lead_id := :new.lead_id;
  elsif UPDATING then
   Trigger_Mode := 'ON-UPDATE';
   lead_id := :new.lead_id;
  elsif DELETING then
   Trigger_Mode := 'ON-DELETE';
   lead_id := :old.lead_id;
  end if;

/* Calling of AS_TATA_TRIGGERS.Leads_Trigger_Handler API to insert into as_Changed_Accounts_all table
have removed  and moved to Opportunity real time API.*/

  AS_SC_DENORM_TRG.Lead_Lines_Trigger_Handler(
						:new.last_update_date,
						:new.last_updated_by,
						:new.creation_date,
						:new.created_by,
						:new.last_update_login,
						:new.lead_id,
						:new.lead_line_id,
						:new.interest_Type_id,
						:new.primary_interest_code_id,
						:new.secondary_interest_code_id,
                        :new.product_category_id,
                        :new.product_cat_set_id,
						:new.total_amount,
						:old.total_amount,
						:old.lead_line_id,
					     :new.quantity,
						:new.uom_code,
						:new.inventory_item_id,
						:new.organization_id,
                        	     :old.forecast_date,
                        		:old.rolling_forecast_flag,
                        	     :new.forecast_date,
                        		:new.rolling_forecast_flag,
						Trigger_Mode);


END AS_LEAD_LINES_BIUD;


/
ALTER TRIGGER "APPS"."AS_LEAD_LINES_BIUD" ENABLE;
