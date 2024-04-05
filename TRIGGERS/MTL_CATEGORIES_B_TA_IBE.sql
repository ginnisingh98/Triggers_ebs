--------------------------------------------------------
--  DDL for Trigger MTL_CATEGORIES_B_TA_IBE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."MTL_CATEGORIES_B_TA_IBE" 
/* $Header: INVITCA1.sql 115.1 2003/12/26 03:16:05 wwahid ship $ */

AFTER DELETE
ON "INV"."MTL_CATEGORIES_B"
FOR EACH ROW

DECLARE
  plsql_block  VARCHAR2(2000);
BEGIN

  IF ( INV_Item_Util.g_Appl_Inst.IBE <> 0 ) THEN

     plsql_block :=
     ' BEGIN 								'||
     '   IBE_INV_Database_Trigger_PVT.MTL_Categories_B_Deleted 		'||
     '   (  p_old_category_id => :old_category_id 			'||
     '   ); 								'||
     ' EXCEPTION 							'||
     '   WHEN others THEN 						'||
     '      NULL; 							'||
     ' END;';

     EXECUTE IMMEDIATE plsql_block
       USING IN :old.category_id ;

  END IF;  -- IBE installed

EXCEPTION
   WHEN others THEN
      NULL;

END MTL_CATEGORIES_B_TA_IBE;



/
ALTER TRIGGER "APPS"."MTL_CATEGORIES_B_TA_IBE" DISABLE;
