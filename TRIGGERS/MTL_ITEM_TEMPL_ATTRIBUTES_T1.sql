--------------------------------------------------------
--  DDL for Trigger MTL_ITEM_TEMPL_ATTRIBUTES_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."MTL_ITEM_TEMPL_ATTRIBUTES_T1" 
/* $Header: INVITTR1.sql 115.0 99/07/16 10:57:06 porting ship $ */

BEFORE insert
ON "INV"."MTL_ITEM_TEMPL_ATTRIBUTES"
FOR EACH ROW

DECLARE
   l_return_err  varchar2(80);
BEGIN

   if :new.attribute_group_id_gui is null then
     select attribute_group_id_gui, sequence_gui
     into   :new.attribute_group_id_gui, :new.sequence_gui
     from   mtl_item_attributes
     where  attribute_name = :new.attribute_name;
   end if;

EXCEPTION
   when others then
     l_return_err := 'MTL_ITEM_TEMPL_ATTRIBUTES_T1: ' ||
                     substrb(sqlerrm,1,50);
     raise_application_error(-20000,l_return_err);
end;



/
ALTER TRIGGER "APPS"."MTL_ITEM_TEMPL_ATTRIBUTES_T1" DISABLE;
