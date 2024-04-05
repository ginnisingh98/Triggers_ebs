--------------------------------------------------------
--  DDL for Trigger FEM_OWNRSHP_TYPES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_OWNRSHP_TYPES_DL" 
instead of delete on FEM_OWNRSHP_TYPES_VL
referencing old as FEM_OWNRSHP_TYPES_B
for each row
begin
  FEM_OWNRSHP_TYPES_PKG.DELETE_ROW(
    X_OWNERSHIP_TYPE_CODE => :FEM_OWNRSHP_TYPES_B.OWNERSHIP_TYPE_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_OWNRSHP_TYPES_DL" ENABLE;
