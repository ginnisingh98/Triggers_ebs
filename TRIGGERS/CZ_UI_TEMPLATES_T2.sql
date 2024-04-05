--------------------------------------------------------
--  DDL for Trigger CZ_UI_TEMPLATES_T2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CZ_UI_TEMPLATES_T2" 
AFTER INSERT OR UPDATE OF
TEMPLATE_NAME,
TEMPLATE_DESC,
DELETED_FLAG,
LAST_UPDATED_BY,
LAST_UPDATE_DATE,
Last_Update_login,
template_rev_nbr
ON "CZ"."CZ_UI_TEMPLATES"
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
BEGIN
  IF INSERTING OR (UPDATING AND (
      ( ((:old.template_name IS NULL)<>(:new.template_name IS NULL) )OR(:old.template_name<>:new.template_name)) OR
      ( ((:old.template_desc IS NULL)<>(:new.template_desc IS NULL))OR(:old.template_desc<>:new.template_desc)) OR
      ( ((:old.Last_Updated_By IS NULL)<>(:new.Last_Updated_By IS NULL))OR(:old.Last_Updated_By<>:new.Last_Updated_By)) OR
      ( ((:old.Last_Update_Date IS NULL)<>(:new.Last_Update_Date IS NULL))OR(:old.Last_Update_Date<>:new.Last_Update_Date)) OR
      ( ((:old.Last_Update_login IS NULL)<>(:new.Last_Update_login IS NULL))OR(:old.Last_Update_login<>:new.Last_Update_login)) OR
      ( ((:old.deleted_flag IS NULL)<>(:new.deleted_flag IS NULL))OR(:old.deleted_flag<>:new.deleted_flag)) OR
      ( ((:old.template_rev_nbr IS NULL)<>(:new.template_rev_nbr IS NULL))OR(:old.template_rev_nbr<>:new.template_rev_nbr))
     )) THEN
       UPDATE CZ_RP_ENTRIES
	SET   LAST_UPDATE_DATE=SYSDATE
        WHERE OBJECT_ID=:OLD.TEMPLATE_ID
	AND  OBJECT_TYPE = 'UCT';
   END IF;
END;

/
ALTER TRIGGER "APPS"."CZ_UI_TEMPLATES_T2" ENABLE;
