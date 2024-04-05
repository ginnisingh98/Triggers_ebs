--------------------------------------------------------
--  DDL for Trigger EGO_MTL_MANUFACTURERS_TR1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."EGO_MTL_MANUFACTURERS_TR1" 
/* $Header: EGOTMMAN.sql 120.2 2005/07/20 01:48:24 gnanda noship $ */


AFTER UPDATE OF MANUFACTURER_NAME
ON "INV"."MTL_MANUFACTURERS"
FOR EACH ROW

DECLARE
   l_table_name          VARCHAR2(30)    :=  'MTL_MANUFACTURERS';
   l_scope               VARCHAR2(30)    :=  'ROW';
   l_event               VARCHAR2(30);

BEGIN


   IF ( UPDATING ) THEN

     l_event := 'UPDATE';
     EGO_ITEM_TEXT_UTIL.Process_Source_Table_Event
     (     p_table_name              =>  l_table_name
        ,  p_event                   =>  l_event
        ,  p_scope                   =>  l_scope
        ,  p_manufacturer_id         =>  :new.MANUFACTURER_ID
        ,  p_old_item_id             =>  NULL
        ,  p_item_id                 =>  FND_API.G_MISS_NUM
        ,  p_org_id                  =>  FND_API.G_MISS_NUM
        ,  p_language                =>  FND_API.G_MISS_CHAR
        ,  p_source_lang             =>  FND_API.G_MISS_CHAR
        ,  p_last_update_date        =>  :new.LAST_UPDATE_DATE
        ,  p_last_updated_by         =>  :new.LAST_UPDATED_BY
        ,  p_last_update_login       =>  :new.LAST_UPDATE_LOGIN
        ,  p_id_type                 =>  FND_API.G_MISS_CHAR
        ,  p_item_code               =>  FND_API.G_MISS_CHAR
        ,  p_item_catalog_group_id   =>  FND_API.G_MISS_NUM
     );

   END IF;


END EGO_MTL_MANUFACTURERS_TR1;



/
ALTER TRIGGER "APPS"."EGO_MTL_MANUFACTURERS_TR1" ENABLE;
