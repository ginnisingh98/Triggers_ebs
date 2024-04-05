--------------------------------------------------------
--  DDL for Trigger FEM_COMPANIES_IL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_COMPANIES_IL" 
instead of insert on FEM_COMPANIES_VL
referencing new as FEM_COMPANIES_B
for each row
declare
  row_id rowid;
 ---
begin
  FEM_COMPANIES_PKG.INSERT_ROW(
    X_ROWID => ROW_ID,
    X_COMPANY_ID => :FEM_COMPANIES_B.COMPANY_ID,
    X_VALUE_SET_ID => :FEM_COMPANIES_B.VALUE_SET_ID,
    X_DIMENSION_GROUP_ID => :FEM_COMPANIES_B.DIMENSION_GROUP_ID,
    X_COMPANY_DISPLAY_CODE => :FEM_COMPANIES_B.COMPANY_DISPLAY_CODE,
    X_ENABLED_FLAG => :FEM_COMPANIES_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_COMPANIES_B.PERSONAL_FLAG,
    X_READ_ONLY_FLAG => :FEM_COMPANIES_B.READ_ONLY_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_COMPANIES_B.OBJECT_VERSION_NUMBER,
    X_COMPANY_NAME => :FEM_COMPANIES_B.COMPANY_NAME,
    X_DESCRIPTION => :FEM_COMPANIES_B.DESCRIPTION,
    X_CREATION_DATE => :FEM_COMPANIES_B.CREATION_DATE,
    X_CREATED_BY => :FEM_COMPANIES_B.CREATED_BY,
    X_LAST_UPDATE_DATE => :FEM_COMPANIES_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_COMPANIES_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_COMPANIES_B.LAST_UPDATE_LOGIN);
 ---
end INSERT_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_COMPANIES_IL" ENABLE;
