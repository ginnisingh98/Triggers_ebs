--------------------------------------------------------
--  DDL for Trigger AS_SALES_LEAD_LINES_BIUD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."AS_SALES_LEAD_LINES_BIUD" BEFORE INSERT OR UPDATE OR DELETE
ON OSM.AS_SALES_LEAD_LINES
FOR EACH ROW
DECLARE
Trigger_Mode    VARCHAR2(20);
l_sales_lead_id NUMBER;
BEGIN
  IF INSERTING THEN
   Trigger_Mode := 'ON-INSERT';
   l_sales_lead_id := :new.sales_lead_id;
  ELSIF UPDATING THEN
   Trigger_Mode := 'ON-UPDATE';
   l_sales_lead_id := :new.sales_lead_id;
  ELSIF DELETING THEN
   Trigger_Mode := 'ON-DELETE';
   l_sales_lead_id := :old.sales_lead_id;
  END IF;

  AS_SALES_LEAD_ASSIGN_PVT.Sales_Lead_Lines_Handler(
      l_sales_lead_id,
      :old.category_id,
      :old.category_set_id,
      :old.inventory_item_id,
      :old.budget_amount,
      :new.category_id,
      :new.category_set_id,
      :new.inventory_item_id,
      :new.budget_amount,
      Trigger_Mode );

END AS_SALES_LEAD_LINES_BIUD;



/
ALTER TRIGGER "APPS"."AS_SALES_LEAD_LINES_BIUD" ENABLE;
