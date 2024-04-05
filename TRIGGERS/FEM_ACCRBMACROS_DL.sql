--------------------------------------------------------
--  DDL for Trigger FEM_ACCRBMACROS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_ACCRBMACROS_DL" 
instead of delete on FEM_ACCRBMACROS_VL
referencing old as FEM_ACCRBMACROS_B
for each row
begin
  FEM_ACCRBMACROS_PKG.DELETE_ROW(
    X_AB_USAGE_MACRO_CODE => :FEM_ACCRBMACROS_B.AB_USAGE_MACRO_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_ACCRBMACROS_DL" ENABLE;
