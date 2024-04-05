--------------------------------------------------------
--  DDL for Trigger FEM_COLUMN_REQUIREMNT_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_COLUMN_REQUIREMNT_DL" 
instead of delete on FEM_COLUMN_REQUIREMNT_VL
referencing old as FEM_COLUMN_REQUIREMNT_B
for each row
begin
  FEM_COLUMN_REQUIREMNT_PKG.DELETE_ROW(
    X_COLUMN_NAME => :FEM_COLUMN_REQUIREMNT_B.COLUMN_NAME);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_COLUMN_REQUIREMNT_DL" ENABLE;
