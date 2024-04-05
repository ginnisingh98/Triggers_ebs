--------------------------------------------------------
--  DDL for Trigger FEM_APPLICATION_GROUPS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_APPLICATION_GROUPS_DL" 
instead of delete on FEM_APPLICATION_GROUPS_VL
referencing old as APPLICATION_GROUP
for each row
begin
  FEM_APPLICATION_GROUPS_PKG.DELETE_ROW(
    X_APPLICATION_GROUP_ID => :APPLICATION_GROUP.APPLICATION_GROUP_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_APPLICATION_GROUPS_DL" ENABLE;
