--------------------------------------------------------
--  DDL for Trigger FEM_ADVICE_TYPES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_ADVICE_TYPES_DL" 
instead of delete on FEM_ADVICE_TYPES_VL
referencing old as FEM_ADVICE_TYPES_B
for each row
begin
  FEM_ADVICE_TYPES_PKG.DELETE_ROW(
    X_ADVICE_TYPE_CODE => :FEM_ADVICE_TYPES_B.ADVICE_TYPE_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_ADVICE_TYPES_DL" ENABLE;
