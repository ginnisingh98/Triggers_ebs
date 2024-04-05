--------------------------------------------------------
--  DDL for Trigger FEM_FLAGS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_FLAGS_DL" 
instead of delete on FEM_FLAGS_VL
referencing old as FEM_FLAGS_B
for each row
begin
  FEM_FLAGS_PKG.DELETE_ROW(
    X_FLAG_CODE => :FEM_FLAGS_B.FLAG_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_FLAGS_DL" ENABLE;
