--------------------------------------------------------
--  DDL for Trigger FEM_GOV_ID_NUMS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_GOV_ID_NUMS_DL" 
instead of delete on FEM_GOV_ID_NUMS_VL
referencing old as FEM_GOV_ID_NUMS_B
for each row
begin
  FEM_GOV_ID_NUMS_PKG.DELETE_ROW(
    X_GOVT_ID_NUM_CODE => :FEM_GOV_ID_NUMS_B.GOVT_ID_NUM_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_GOV_ID_NUMS_DL" ENABLE;
