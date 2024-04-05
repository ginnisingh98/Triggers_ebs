--------------------------------------------------------
--  DDL for Trigger FEM_FIN_ELEM_GROUPS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_FIN_ELEM_GROUPS_DL" 
instead of delete on FEM_FIN_ELEM_GROUPS_VL
referencing old as FEM_FIN_ELEM_GROUPS_B
for each row
begin
  FEM_FIN_ELEM_GROUPS_PKG.DELETE_ROW(
    X_FIN_ELEM_GROUP_CODE => :FEM_FIN_ELEM_GROUPS_B.FIN_ELEM_GROUP_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_FIN_ELEM_GROUPS_DL" ENABLE;
