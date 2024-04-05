--------------------------------------------------------
--  DDL for Trigger FEM_CURRTYPES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_CURRTYPES_DL" 
instead of delete on FEM_CURRTYPES_VL
referencing old as FEM_CURRTYPES_B
for each row
begin
  FEM_CURRTYPES_PKG.DELETE_ROW(
    X_CURRENCY_TYPE_CODE => :FEM_CURRTYPES_B.CURRENCY_TYPE_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_CURRTYPES_DL" ENABLE;
