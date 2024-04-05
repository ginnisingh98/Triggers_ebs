--------------------------------------------------------
--  DDL for Trigger AS_SALES_CREDITS_BIUD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."AS_SALES_CREDITS_BIUD" BEFORE INSERT OR UPDATE OR DELETE
ON OSM.AS_SALES_CREDITS
FOR EACH ROW
DECLARE
Trigger_Mode VARCHAR(20);
sc_id NUMBER;
lead_id NUMBER;
lead_line_id NUMBER;
salesforce_id NUMBER;
person_id NUMBER;
salesgroup_id NUMBER;
credit_amount NUMBER;
credit_percent NUMBER;
BEGIN
  if INSERTING then
    Trigger_Mode := 'ON-INSERT';
     sc_id := :new.sales_credit_id;
     lead_id := :new.lead_id;
     lead_line_id := :new.lead_line_id;
     salesforce_id := :new.salesforce_id;
     person_id := :new.person_id;
     salesgroup_id := :new.salesgroup_id;
     credit_amount := :new.credit_amount;
     credit_percent := :new.credit_percent;
  elsif UPDATING then
	Trigger_Mode := 'ON-UPDATE';
     sc_id := :new.sales_credit_id;
     lead_id := :new.lead_id;
     lead_line_id := :new.lead_line_id;
     salesforce_id := :new.salesforce_id;
     person_id := :new.person_id;
     salesgroup_id := :new.salesgroup_id;
     credit_amount := :new.credit_amount;
     credit_percent := :new.credit_percent;
  elsif DELETING then
	Trigger_Mode := 'ON-DELETE';
  end if;

  		AS_SC_DENORM_TRG.Sales_Credit_Trg_Handler(
					sc_id,
					:new.last_update_date,
					:new.last_updated_by,
					:new.creation_date,
					:new.created_by,
					:new.last_update_login,
					:new.request_id,
					lead_id,
					lead_line_id,
					salesforce_id,
					person_id,
					salesgroup_id,
					credit_amount,
					credit_percent,
					:old.sales_credit_id,
					:new.credit_type_id,
					:new.partner_address_id,
					:old.partner_customer_id,
					:new.partner_customer_id,
					:new.opp_worst_forecast_amount,
					:new.opp_forecast_amount,
					:new.opp_best_forecast_amount,
					trigger_mode);

  EXCEPTION WHEN OTHERS THEN
     NULL;

END AS_SALES_CREDITS_BIUD;


/
ALTER TRIGGER "APPS"."AS_SALES_CREDITS_BIUD" ENABLE;
