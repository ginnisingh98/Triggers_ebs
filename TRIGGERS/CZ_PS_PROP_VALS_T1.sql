--------------------------------------------------------
--  DDL for Trigger CZ_PS_PROP_VALS_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CZ_PS_PROP_VALS_T1" 
  BEFORE UPDATE OR INSERT OR DELETE
 ON "CZ"."CZ_PS_PROP_VALS"
 REFERENCING OLD AS OLD NEW AS NEW
 FOR EACH ROW
DECLARE
VAR_USER_ID INTEGER;
BEGIN
VAR_USER_ID:=CZ_UTILS.SPX_UID;
IF INSERTING THEN
   :new.CREATED_BY:=VAR_USER_ID;
   :new.LAST_UPDATED_BY:=VAR_USER_ID;
   :new.CREATION_DATE:=SYSDATE;
   :new.LAST_UPDATE_DATE:=SYSDATE;
END IF;
IF UPDATING THEN
   :new.LAST_UPDATED_BY:=VAR_USER_ID;
   :new.LAST_UPDATE_DATE:=SYSDATE;
END IF;

--Bug #4920028. If deleted_flag = '1', we are purging a logically deleted record.
IF(NVL(:old.deleted_flag, '0') = '0')THEN

  update cz_devl_projects
  set    last_logic_update = sysdate,
         post_migr_change_flag = DECODE(post_migr_change_flag, 'N', 'R', 'Z', 'R', post_migr_change_flag)
  where  devl_project_id  = (SELECT devl_project_id
	   		       FROM cz_ps_nodes
			      WHERE cz_ps_nodes.ps_node_id  = NVL(:old.ps_node_id, :new.ps_node_id));
END IF;
END;

/
ALTER TRIGGER "APPS"."CZ_PS_PROP_VALS_T1" ENABLE;
