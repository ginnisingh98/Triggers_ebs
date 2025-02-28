--------------------------------------------------------
--  DDL for Trigger FEM_CCTR_ORGS_UL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_CCTR_ORGS_UL" 
instead of update on FEM_CCTR_ORGS_VL
referencing new as FEM_CCTR_ORGS_B
for each row
begin
  FEM_CCTR_ORGS_PKG.UPDATE_ROW(
    X_COMPANY_COST_CENTER_ORG_ID => :FEM_CCTR_ORGS_B.COMPANY_COST_CENTER_ORG_ID,
    X_VALUE_SET_ID => :FEM_CCTR_ORGS_B.VALUE_SET_ID,
    X_DIMENSION_GROUP_ID => :FEM_CCTR_ORGS_B.DIMENSION_GROUP_ID,
    X_CCTR_ORG_DISPLAY_CODE => :FEM_CCTR_ORGS_B.CCTR_ORG_DISPLAY_CODE,
    X_ENABLED_FLAG => :FEM_CCTR_ORGS_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_CCTR_ORGS_B.PERSONAL_FLAG,
    X_READ_ONLY_FLAG => :FEM_CCTR_ORGS_B.READ_ONLY_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_CCTR_ORGS_B.OBJECT_VERSION_NUMBER,
    X_COMPANY_COST_CENTER_ORG_NAME => :FEM_CCTR_ORGS_B.COMPANY_COST_CENTER_ORG_NAME,
    X_DESCRIPTION => :FEM_CCTR_ORGS_B.DESCRIPTION,
    X_LAST_UPDATE_DATE => :FEM_CCTR_ORGS_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_CCTR_ORGS_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_CCTR_ORGS_B.LAST_UPDATE_LOGIN);
 ---
end UPDATE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_CCTR_ORGS_UL" ENABLE;
