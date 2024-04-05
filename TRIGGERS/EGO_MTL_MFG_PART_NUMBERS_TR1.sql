--------------------------------------------------------
--  DDL for Trigger EGO_MTL_MFG_PART_NUMBERS_TR1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."EGO_MTL_MFG_PART_NUMBERS_TR1" 
/* $Header: EGOTMMPN.sql 120.2 2005/07/20 01:45:47 gnanda noship $ */

AFTER UPDATE OR INSERT OR DELETE OF MFG_PART_NUM,INVENTORY_ITEM_ID,MANUFACTURER_ID
ON "INV"."MTL_MFG_PART_NUMBERS"
FOR EACH ROW

DECLARE
   l_table_name          VARCHAR2(30)    :=  'MTL_MFG_PART_NUMBERS';
   l_scope               VARCHAR2(30)    :=  'ROW';
   l_event               VARCHAR2(30);
   l_org_id              NUMBER;
BEGIN

   IF ( INSERTING ) THEN
      l_event := 'INSERT';

   ELSIF ( UPDATING ) THEN
      l_event := 'UPDATE';

   ELSIF ( DELETING ) THEN
      l_event := 'DELETE';

   END IF;

   IF (l_event = 'DELETE') THEN
     l_org_id :=  :old.ORGANIZATION_ID;
   ELSE
     l_org_id :=  :new.ORGANIZATION_ID;
   END IF;

   EGO_ITEM_TEXT_UTIL.Process_Source_Table_Event
   (     p_table_name              =>  l_table_name
      ,  p_event                   =>  l_event
      ,  p_scope                   =>  l_scope
      ,  p_manufacturer_id         =>  NULL
      ,  p_old_item_id             =>  :old.INVENTORY_ITEM_ID
      ,  p_item_id                 =>  :new.INVENTORY_ITEM_ID
      ,  p_org_id                  =>  l_org_id
      ,  p_language                =>  FND_API.G_MISS_CHAR
      ,  p_source_lang             =>  FND_API.G_MISS_CHAR
      ,  p_last_update_date        =>  :new.LAST_UPDATE_DATE
      ,  p_last_updated_by         =>  :new.LAST_UPDATED_BY
      ,  p_last_update_login       =>  :new.LAST_UPDATE_LOGIN
      ,  p_id_type                 =>  FND_API.G_MISS_CHAR
      ,  p_item_code               =>  FND_API.G_MISS_CHAR
      ,  p_item_catalog_group_id   =>  FND_API.G_MISS_NUM
   );


END EGO_MTL_MFG_PART_NUMBERS_TR1;



/
ALTER TRIGGER "APPS"."EGO_MTL_MFG_PART_NUMBERS_TR1" ENABLE;
