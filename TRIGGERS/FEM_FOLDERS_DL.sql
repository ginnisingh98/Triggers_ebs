--------------------------------------------------------
--  DDL for Trigger FEM_FOLDERS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_FOLDERS_DL" 
instead of delete on FEM_FOLDERS_VL
referencing old as FEM_FOLDERS_B
for each row
begin
  FEM_FOLDERS_PKG.DELETE_ROW(
    X_FOLDER_ID => :FEM_FOLDERS_B.FOLDER_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_FOLDERS_DL" ENABLE;
