--------------------------------------------------------
--  DDL for Trigger FEM_ENTITY_TYPES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_ENTITY_TYPES_DL" 
instead of delete on FEM_ENTITY_TYPES_VL
referencing old as FEM_ENTITY_TYPES_B
for each row
begin
  FEM_ENTITY_TYPES_PKG.DELETE_ROW(
    X_ENTITY_TYPE_CODE => :FEM_ENTITY_TYPES_B.ENTITY_TYPE_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_ENTITY_TYPES_DL" ENABLE;
