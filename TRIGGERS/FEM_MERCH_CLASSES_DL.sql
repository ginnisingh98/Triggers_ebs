--------------------------------------------------------
--  DDL for Trigger FEM_MERCH_CLASSES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_MERCH_CLASSES_DL" 
instead of delete on FEM_MERCH_CLASSES_VL
referencing old as FEM_MERCH_CLASSES_B
for each row
begin
  FEM_MERCH_CLASSES_PKG.DELETE_ROW(
    X_MERCHANT_CLASS_CODE => :FEM_MERCH_CLASSES_B.MERCHANT_CLASS_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_MERCH_CLASSES_DL" ENABLE;
