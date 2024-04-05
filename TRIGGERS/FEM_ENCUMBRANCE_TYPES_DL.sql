--------------------------------------------------------
--  DDL for Trigger FEM_ENCUMBRANCE_TYPES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_ENCUMBRANCE_TYPES_DL" 
instead of delete on FEM_ENCUMBRANCE_TYPES_VL
referencing old as FEM_ENCUMBRANCE_TYPES_B
for each row
begin
  FEM_ENCUMBRANCE_TYPES_PKG.DELETE_ROW(
    X_ENCUMBRANCE_TYPE_ID => :FEM_ENCUMBRANCE_TYPES_B.ENCUMBRANCE_TYPE_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_ENCUMBRANCE_TYPES_DL" ENABLE;
