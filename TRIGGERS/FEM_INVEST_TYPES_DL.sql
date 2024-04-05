--------------------------------------------------------
--  DDL for Trigger FEM_INVEST_TYPES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_INVEST_TYPES_DL" 
instead of delete on FEM_INVEST_TYPES_VL
referencing old as FEM_INVEST_TYPES_B
for each row
begin
  FEM_INVEST_TYPES_PKG.DELETE_ROW(
    X_INVESTOR_TYPE_CODE => :FEM_INVEST_TYPES_B.INVESTOR_TYPE_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_INVEST_TYPES_DL" ENABLE;
