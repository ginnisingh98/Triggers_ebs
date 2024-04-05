--------------------------------------------------------
--  DDL for Trigger FEM_OBJECT_TYPES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_OBJECT_TYPES_DL" 
instead of delete on FEM_OBJECT_TYPES_VL
referencing old as FEM_OBJECT_TYPES_B
for each row
begin
  FEM_OBJECT_TYPES_PKG.DELETE_ROW(
    X_OBJECT_TYPE_CODE => :FEM_OBJECT_TYPES_B.OBJECT_TYPE_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_OBJECT_TYPES_DL" ENABLE;
