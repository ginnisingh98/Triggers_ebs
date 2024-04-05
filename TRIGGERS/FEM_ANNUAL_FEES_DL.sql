--------------------------------------------------------
--  DDL for Trigger FEM_ANNUAL_FEES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_ANNUAL_FEES_DL" 
instead of delete on FEM_ANNUAL_FEES_VL
referencing old as FEM_ANNUAL_FEES_B
for each row
begin
  FEM_ANNUAL_FEES_PKG.DELETE_ROW(
    X_ANNUAL_FEE_CODE => :FEM_ANNUAL_FEES_B.ANNUAL_FEE_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_ANNUAL_FEES_DL" ENABLE;
