--------------------------------------------------------
--  DDL for Trigger AS_SALES_CREDITS_AFTER_BIUD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."AS_SALES_CREDITS_AFTER_BIUD" AFTER INSERT OR UPDATE OR DELETE
ON OSM.AS_SALES_CREDITS
FOR EACH ROW
DECLARE
Trigger_Mode VARCHAR(20);
lead_id NUMBER;
BEGIN
   IF( UPPER(nvl(FND_PROFILE.VALUE('AS_OPP_SC_ENABLE_LOG'), 'N')) = 'Y' ) THEN
	  if INSERTING then
	    Trigger_Mode := 'ON-INSERT';
	    -- lead_id := :new.lead_id;
	  elsif UPDATING then
	    Trigger_Mode := 'ON-UPDATE';
	    -- lead_id := :new.lead_id;
	  elsif DELETING then
	    Trigger_Mode := 'ON-DELETE';
	    -- lead_id := :old.lead_id;
	  end if;
       -- dbms_output.put_line('In AS_LEAD_LINES_AFTER_BIUD Trigger Mode:'||Trigger_Mode);

	AS_LEADS_AUDIT_PKG.Sales_Credits_Trigger_Handler(Trigger_Mode 			 ,
							:new.lead_id 			 ,
							:old.lead_id 			 ,
							:new.lead_line_id		 ,
							:old.lead_line_id		 ,

							:new.sales_credit_id		 ,
							:old.sales_credit_id		 ,
							:new.last_update_date		 ,
							:old.last_update_date		 ,
							:new.last_updated_by		 ,
							:old.last_updated_by		 ,

							:new.last_update_login		 ,
							:old.last_update_login		 ,
							:new.creation_date		 ,
							:old.creation_date		 ,
							:new.created_by		 	 ,
							:old.created_by		 	 ,
							:new.salesforce_id		 ,
							:old.salesforce_id		 ,
							:new.salesgroup_id		 ,
							:old.salesgroup_id		 ,
							:new.credit_type_id		 ,
							:old.credit_type_id		 ,
							:new.credit_percent	 	 ,
							:old.credit_percent	 	 ,
							:new.credit_amount	 	 ,
							:old.credit_amount	 	 ,
							:new.opp_worst_forecast_amount	,
							:old.opp_worst_forecast_amount	,
							:new.opp_forecast_amount		,
							:old.opp_forecast_amount		,
							:new.opp_best_forecast_amount	,
							:old.opp_best_forecast_amount
                            );
END IF;
END AS_SALES_CREDITS_AFTER_BIUD;


/
ALTER TRIGGER "APPS"."AS_SALES_CREDITS_AFTER_BIUD" ENABLE;
