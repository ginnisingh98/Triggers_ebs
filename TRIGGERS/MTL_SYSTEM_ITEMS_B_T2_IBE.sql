--------------------------------------------------------
--  DDL for Trigger MTL_SYSTEM_ITEMS_B_T2_IBE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."MTL_SYSTEM_ITEMS_B_T2_IBE" 
/* $Header: INVITSI1.sql 115.1 2003/12/26 04:06:26 wwahid ship $ */

AFTER DELETE
ON "INV"."MTL_SYSTEM_ITEMS_B"
FOR EACH ROW

DECLARE
  plsql_block  VARCHAR2(2000);
BEGIN

  IF ( INV_Item_Util.g_Appl_Inst.IBE <> 0 ) THEN

     plsql_block :=
     ' BEGIN 								'||
     '   IBE_INV_Database_Trigger_PVT.MTL_System_Items_B_Deleted 	'||
     '   (  p_old_inventory_item_id => :item_id 			'||
     '   ,  p_old_organization_id   => :org_id 				'||
     '   ); 								'||
     ' EXCEPTION 							'||
     '   WHEN others THEN 						'||
     '      NULL; 							'||
     ' END;';

     EXECUTE IMMEDIATE plsql_block
       USING IN :old.inventory_item_id
           , IN :old.organization_id ;

  END IF;  -- IBE installed

EXCEPTION
   WHEN others THEN
      NULL;

END MTL_SYSTEM_ITEMS_B_T2_IBE;



/
ALTER TRIGGER "APPS"."MTL_SYSTEM_ITEMS_B_T2_IBE" DISABLE;
