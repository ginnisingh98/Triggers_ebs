--------------------------------------------------------
--  DDL for Trigger MTL_SYSTEM_ITEMS_TL_TA_IBE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."MTL_SYSTEM_ITEMS_TL_TA_IBE" 
/* $Header: INVITST1.sql 120.0 2005/05/25 06:46:32 appldev noship $ */

AFTER INSERT OR DELETE OR UPDATE
ON "INV"."MTL_SYSTEM_ITEMS_TL"
FOR EACH ROW

DECLARE
  plsql_block  VARCHAR2(2000);
BEGIN

IF ( INV_Item_Util.g_Appl_Inst.IBE <> 0 ) THEN

  IF ( INSERTING ) THEN

     plsql_block :=
     ' BEGIN 								'||
     '   IBE_INV_Database_Trigger_PVT.MTL_System_Items_TL_Inserted	'||
     '   (  p_new_inventory_item_id => :new_item_id 			'||
     '   ,  p_new_organization_id   => :new_org_id 			'||
     '   ,  p_new_language          => :new_language 			'||
     '   ,  p_new_description       => :new_description 		'||
     '   ,  p_new_long_description  => :new_long_description 		'||
     '   ); 								'||
     ' EXCEPTION 							'||
     '   WHEN others THEN 						'||
     '      NULL; 							'||
     ' END;';

     EXECUTE IMMEDIATE plsql_block
       USING IN :new.inventory_item_id
           , IN :new.organization_id
           , IN :new.language
           , IN :new.description
           , IN :new.long_description ;

  ELSIF ( DELETING ) THEN

     plsql_block :=
     ' BEGIN 								'||
     '   IBE_INV_Database_Trigger_PVT.MTL_System_Items_TL_Deleted 	'||
     '   (  p_old_inventory_item_id => :old_item_id 			'||
     '   ,  p_old_organization_id   => :old_org_id 			'||
     '   ,  p_old_language          => :old_language 			'||
     '   ); 								'||
     ' EXCEPTION 							'||
     '   WHEN others THEN 						'||
     '      NULL; 							'||
     ' END;';

     EXECUTE IMMEDIATE plsql_block
       USING IN :old.inventory_item_id
           , IN :old.organization_id
           , IN :old.language ;

  ELSIF ( UPDATING ) THEN

    IF ( :new.language <> :old.language OR
         NVL(:new.description,'$') <> NVL(:old.description,'$') OR NVL(:new.long_description,'$') <> NVL(:old.long_description,'$') )
    THEN

     plsql_block :=
     ' BEGIN 								'||
     '   IBE_INV_Database_Trigger_PVT.MTL_System_Items_TL_Updated 	'||
     '   (  p_old_inventory_item_id => :old_item_id 			'||
     '   ,  p_old_organization_id   => :old_org_id 			'||
     '   ,  p_old_language          => :old_language 			'||
     '   ,  p_old_description       => :old_description 		'||
     '   ,  p_old_long_description  => :old_long_description 		'||
     '   ,  p_new_language          => :new_language 			'||
     '   ,  p_new_description       => :new_description 		'||
     '   ,  p_new_long_description  => :new_long_description 		'||
     '   ); 								'||
     ' EXCEPTION 							'||
     '   WHEN others THEN 						'||
     '      NULL; 							'||
     ' END;';

     EXECUTE IMMEDIATE plsql_block
       USING IN :old.inventory_item_id
           , IN :old.organization_id
           , IN :old.language
           , IN :old.description
           , IN :old.long_description
           , IN :new.language
           , IN :new.description
           , IN :new.long_description ;

    END IF;

  END IF;  -- event

END IF;  -- IBE installed

EXCEPTION
   WHEN others THEN
      NULL;

END MTL_SYSTEM_ITEMS_TL_TA_IBE;


/
ALTER TRIGGER "APPS"."MTL_SYSTEM_ITEMS_TL_TA_IBE" ENABLE;
