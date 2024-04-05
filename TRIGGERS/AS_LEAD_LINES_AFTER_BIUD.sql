--------------------------------------------------------
--  DDL for Trigger AS_LEAD_LINES_AFTER_BIUD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."AS_LEAD_LINES_AFTER_BIUD" AFTER INSERT OR UPDATE OR DELETE
ON OSM.AS_LEAD_LINES_ALL
FOR EACH ROW
DECLARE
Trigger_Mode VARCHAR(20);
lead_id NUMBER;
BEGIN

   IF( UPPER(nvl(FND_PROFILE.VALUE('AS_OPP_LINE_ENABLE_LOG'), 'N')) = 'Y' ) THEN
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

	AS_LEADS_AUDIT_PKG.Lead_Lines_Trigger_Handler(Trigger_Mode 			 ,
							:new.lead_id 			 ,
							:old.lead_id 			 ,
							:new.lead_line_id		 ,
							:old.lead_line_id		 ,
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
							:new.interest_type_id		 ,
							:old.interest_type_id		 ,
							:new.primary_interest_code_id	 ,
							:old.primary_interest_code_id	 ,
							:new.secondary_interest_code_id    ,
							:old.secondary_interest_code_id    ,
                            :new.product_category_id,
                            :old.product_category_id,
                            :new.product_cat_set_id,
                            :old.product_cat_set_id,
							:new.inventory_item_id 	 ,
							:old.inventory_item_id 	 ,
							:new.organization_id	 	 ,
							:old.organization_id	 	 ,
							:new.source_promotion_id 	 ,
							:old.source_promotion_id 	 ,
							:new.offer_id		 	 ,
							:old.offer_id		 	 ,
							:new.org_id		 	 ,
							:old.org_id		 	 ,
							:new.forecast_date		 ,
							:old.forecast_date		 ,
							:new.rolling_forecast_flag	 ,
							:old.rolling_forecast_flag,
							:new.total_amount,
							:old.total_amount,
							:new.QUANTITY ,
							:old.QUANTITY ,
							:new.UOM_CODE,
							:old.UOM_CODE);
END IF;
END AS_LEAD_LINES_AFTER_BIUD;


/
ALTER TRIGGER "APPS"."AS_LEAD_LINES_AFTER_BIUD" ENABLE;
