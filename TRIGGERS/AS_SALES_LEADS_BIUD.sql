--------------------------------------------------------
--  DDL for Trigger AS_SALES_LEADS_BIUD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."AS_SALES_LEADS_BIUD" BEFORE INSERT OR UPDATE OR DELETE
ON OSM.AS_SALES_LEADS
FOR EACH ROW
DECLARE
Trigger_Mode              VARCHAR2(20);
BEGIN

  -- In case profile AS_ENABLE_LEAD_ONLINE_TAP is set to 'N',
  -- still pass to Sales_Leads_Trigger_Handler when lead is created
  -- or deleted.
  IF INSERTING THEN
      Trigger_Mode := 'ON-INSERT';
  ELSIF UPDATING THEN
      Trigger_Mode := 'ON-UPDATE';
  ELSIF DELETING THEN
      Trigger_Mode := 'ON-DELETE';
  END IF;

  AS_SALES_LEAD_ASSIGN_PVT.Sales_Leads_Trigger_Handler(
      :new.customer_id,
      :new.sales_lead_Id,
      :old.address_id,
      :old.budget_amount,
      :old.currency_code,
      :old.source_promotion_id,
      :old.channel_code,
      :new.address_id,
      :new.budget_amount,
      :new.currency_code,
      :new.source_promotion_id,
      :new.channel_code,
      :new.assign_to_salesforce_id,
      :new.reject_reason_code,
      Trigger_Mode);

END AS_SALES_LEADS_BIUD;



/
ALTER TRIGGER "APPS"."AS_SALES_LEADS_BIUD" ENABLE;
