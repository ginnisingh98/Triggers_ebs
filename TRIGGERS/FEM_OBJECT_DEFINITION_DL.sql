--------------------------------------------------------
--  DDL for Trigger FEM_OBJECT_DEFINITION_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_OBJECT_DEFINITION_DL" 
instead of delete on FEM_OBJECT_DEFINITION_VL
referencing old as FEM_OBJECT_DEFINITION_B
for each row
begin
  FEM_OBJECT_DEFINITION_PKG.DELETE_ROW(
    X_OBJECT_DEFINITION_ID => :FEM_OBJECT_DEFINITION_B.OBJECT_DEFINITION_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_OBJECT_DEFINITION_DL" ENABLE;
