--------------------------------------------------------
--  DDL for Trigger FEM_PROJECTS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_PROJECTS_DL" 
instead of delete on FEM_PROJECTS_VL
referencing old as FEM_PROJECTS_B
for each row
begin
  FEM_PROJECTS_PKG.DELETE_ROW(
    X_PROJECT_ID => :FEM_PROJECTS_B.PROJECT_ID,
    X_VALUE_SET_ID => :FEM_PROJECTS_B.VALUE_SET_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_PROJECTS_DL" ENABLE;
