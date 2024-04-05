--------------------------------------------------------
--  DDL for Trigger FEM_LIQ_CLASSES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_LIQ_CLASSES_DL" 
instead of delete on FEM_LIQ_CLASSES_VL
referencing old as FEM_LIQ_CLASSES_B
for each row
begin
  FEM_LIQ_CLASSES_PKG.DELETE_ROW(
    X_LIQUIDITY_CLASS_ID => :FEM_LIQ_CLASSES_B.LIQUIDITY_CLASS_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_LIQ_CLASSES_DL" ENABLE;
