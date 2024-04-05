--------------------------------------------------------
--  DDL for Trigger MTL_SYSTEM_ITEMS_B_T3_IBE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."MTL_SYSTEM_ITEMS_B_T3_IBE" 
/* $Header: INVITSI2.sql 120.0 2005/05/25 06:07:07 appldev noship $ */

AFTER UPDATE OF web_status
ON "INV"."MTL_SYSTEM_ITEMS_B"
FOR EACH ROW

DECLARE
  plsql_block  VARCHAR2(2000);
BEGIN

  IF ( INV_Item_Util.g_Appl_Inst.IBE <> 0
       AND NVL(:new.web_status,'$') <> NVL(:old.web_status,'$') ) THEN

     plsql_block :=
     ' BEGIN 								'||
     '   IBE_INV_Database_Trigger_PVT.MTL_System_Items_B_Updated	'||
     '   (  p_old_inventory_item_id => :item_id 			'||
     '   ,  p_old_organization_id   => :org_id 				'||
     '   ,  p_old_web_status        => :old_web_status			'||
     '   ,  p_new_web_status        => :new_web_status			'||
     '   ); 								'||
     ' EXCEPTION 							'||
     '   WHEN others THEN 						'||
     '      NULL; 							'||
     ' END;';

     EXECUTE IMMEDIATE plsql_block
       USING IN :old.inventory_item_id
           , IN :old.organization_id
           , IN :old.web_status
           , IN :new.web_status ;

  END IF;  -- IBE installed

EXCEPTION
   WHEN others THEN
      NULL;

END MTL_SYSTEM_ITEMS_B_T3_IBE;


/
ALTER TRIGGER "APPS"."MTL_SYSTEM_ITEMS_B_T3_IBE" ENABLE;
