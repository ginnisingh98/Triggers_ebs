--------------------------------------------------------
--  DDL for Trigger FEM_RELATION_TYPES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_RELATION_TYPES_DL" 
instead of delete on FEM_RELATION_TYPES_VL
referencing old as FEM_RELATION_TYPES_B
for each row
begin
  FEM_RELATION_TYPES_PKG.DELETE_ROW(
    X_RELATIONSHIP_TYPE_CODE => :FEM_RELATION_TYPES_B.RELATIONSHIP_TYPE_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_RELATION_TYPES_DL" ENABLE;
