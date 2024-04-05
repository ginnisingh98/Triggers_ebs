--------------------------------------------------------
--  DDL for Trigger MTL_ITEM_CATEGORIES_TA_IBE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."MTL_ITEM_CATEGORIES_TA_IBE" 
/* $Header: INVITIC1.sql 115.2 2003/12/26 03:25:42 wwahid ship $ */

AFTER INSERT OR DELETE OR UPDATE
ON "INV"."MTL_ITEM_CATEGORIES"
FOR EACH ROW

DECLARE
  plsql_block  VARCHAR2(2000);
BEGIN

IF ( INV_Item_Util.g_Appl_Inst.IBE <> 0 ) THEN

  IF ( INSERTING ) THEN

     plsql_block :=
     ' BEGIN 								'||
     '   IBE_INV_Database_Trigger_PVT.MTL_Item_Categories_Inserted 	'||
     '   (  p_new_inventory_item_id => :new_item_id 			'||
     '   ,  p_new_organization_id   => :new_org_id 			'||
     '   ,  p_new_category_set_id   => :new_category_set_id 		'||
     '   ,  p_new_category_id       => :new_category_id 		'||
     '   ); 								'||
     ' EXCEPTION 							'||
     '   WHEN others THEN 						'||
     '      NULL; 							'||
     ' END;';

     EXECUTE IMMEDIATE plsql_block
       USING IN :new.inventory_item_id
           , IN :new.organization_id
           , IN :new.category_set_id
           , IN :new.category_id ;

  ELSIF ( DELETING ) THEN

     plsql_block :=
     ' BEGIN 								'||
     '   IBE_INV_Database_Trigger_PVT.MTL_Item_Categories_Deleted 	'||
     '   (  p_old_inventory_item_id => :old_item_id 			'||
     '   ,  p_old_organization_id   => :old_org_id 			'||
     '   ,  p_old_category_set_id   => :old_category_set_id 		'||
     '   ,  p_old_category_id       => :old_category_id 		'||
     '   ); 								'||
     ' EXCEPTION 							'||
     '   WHEN others THEN 						'||
     '      NULL; 							'||
     ' END;';

     EXECUTE IMMEDIATE plsql_block
       USING IN :old.inventory_item_id
           , IN :old.organization_id
           , IN :old.category_set_id
           , IN :old.category_id ;

  ELSIF ( UPDATING ) THEN

     plsql_block :=
     ' BEGIN 								'||
     '   IBE_INV_Database_Trigger_PVT.MTL_Item_Categories_Updated 	'||
     '   (  p_old_inventory_item_id => :old_item_id 			'||
     '   ,  p_old_organization_id   => :old_org_id 			'||
     '   ,  p_old_category_set_id   => :old_category_set_id 		'||
     '   ,  p_old_category_id       => :old_category_id 		'||
     '   ,  p_new_inventory_item_id => :new_item_id 			'||
     '   ,  p_new_organization_id   => :new_org_id 			'||
     '   ,  p_new_category_set_id   => :new_category_set_id 		'||
     '   ,  p_new_category_id       => :new_category_id 		'||
     '   ); 								'||
     ' EXCEPTION 							'||
     '   WHEN others THEN 						'||
     '      NULL; 							'||
     ' END;';

     EXECUTE IMMEDIATE plsql_block
       USING IN :old.inventory_item_id
           , IN :old.organization_id
           , IN :old.category_set_id
           , IN :old.category_id
           , IN :new.inventory_item_id
           , IN :new.organization_id
           , IN :new.category_set_id
           , IN :new.category_id ;

  END IF;  -- event

END IF;  -- IBE installed

EXCEPTION
   WHEN others THEN
      NULL;

END MTL_ITEM_CATEGORIES_TA_IBE;



/
ALTER TRIGGER "APPS"."MTL_ITEM_CATEGORIES_TA_IBE" DISABLE;
