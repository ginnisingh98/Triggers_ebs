--------------------------------------------------------
--  DDL for Trigger FEM_CCTR_ORGS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_CCTR_ORGS_DL" 
instead of delete on FEM_CCTR_ORGS_VL
referencing old as FEM_CCTR_ORGS_B
for each row
begin
  FEM_CCTR_ORGS_PKG.DELETE_ROW(
    X_COMPANY_COST_CENTER_ORG_ID => :FEM_CCTR_ORGS_B.COMPANY_COST_CENTER_ORG_ID,
    X_VALUE_SET_ID => :FEM_CCTR_ORGS_B.VALUE_SET_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_CCTR_ORGS_DL" ENABLE;
