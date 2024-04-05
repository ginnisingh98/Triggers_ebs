--------------------------------------------------------
--  DDL for Trigger FEM_COMPANIES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_COMPANIES_DL" 
instead of delete on FEM_COMPANIES_VL
referencing old as FEM_COMPANIES_B
for each row
begin
  FEM_COMPANIES_PKG.DELETE_ROW(
    X_COMPANY_ID => :FEM_COMPANIES_B.COMPANY_ID,
    X_VALUE_SET_ID => :FEM_COMPANIES_B.VALUE_SET_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_COMPANIES_DL" ENABLE;
