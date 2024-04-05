--------------------------------------------------------
--  DDL for Trigger EGO_MTL_SYSTEM_ITEMS_TL_TR1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."EGO_MTL_SYSTEM_ITEMS_TL_TR1" 
/* $Header: EGOTIST1.sql 120.2 2007/11/09 22:50:47 mantyaku ship $ */

AFTER INSERT OR UPDATE OF DESCRIPTION,LONG_DESCRIPTION OR DELETE
ON "INV"."MTL_SYSTEM_ITEMS_TL"
FOR EACH ROW

DECLARE
   l_table_name          VARCHAR2(30)    :=  'MTL_SYSTEM_ITEMS_TL';
   l_event               VARCHAR2(30);
   l_scope               VARCHAR2(30)    :=  'ROW';
   l_process_event       BOOLEAN         :=  TRUE;
BEGIN

   IF ( INSERTING ) THEN
      l_event := 'INSERT';
   ELSIF ( UPDATING ) THEN
      l_event := 'UPDATE';
   ELSIF ( DELETING ) THEN
      l_event := 'DELETE';
   END IF;  -- event

   -- Call the event handler

   IF ( l_process_event ) THEN

      IF UPDATING
      AND NVL(:new.DESCRIPTION,'#')       = NVL(:old.DESCRIPTION,'#')
      AND NVL(:new.LONG_DESCRIPTION,'#')  = NVL(:old.LONG_DESCRIPTION,'#')
      THEN
         RETURN;
      END IF;

      EGO_ITEM_TEXT_UTIL.Process_Source_Table_Event
      (  p_table_name         =>  l_table_name
      ,  p_event              =>  l_event
      ,  p_scope              =>  l_scope
      ,  p_item_id            =>  :new.INVENTORY_ITEM_ID
      ,  p_org_id             =>  :new.ORGANIZATION_ID
      ,  p_language           =>  :new.LANGUAGE
      ,  p_source_lang        =>  :new.SOURCE_LANG
      ,  p_last_update_date   =>  :new.LAST_UPDATE_DATE
      ,  p_last_updated_by    =>  :new.LAST_UPDATED_BY
      ,  p_last_update_login  =>  :new.LAST_UPDATE_LOGIN
      );

   END IF;

EXCEPTION
   WHEN others THEN
      NULL;

END EGO_MTL_SYSTEM_ITEMS_TL_TR1;

/
ALTER TRIGGER "APPS"."EGO_MTL_SYSTEM_ITEMS_TL_TR1" ENABLE;
