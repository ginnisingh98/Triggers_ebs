--------------------------------------------------------
--  DDL for Trigger FEM_NAT_ACCTS_IL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_NAT_ACCTS_IL" 
instead of insert on FEM_NAT_ACCTS_VL
referencing new as FEM_NAT_ACCTS_B
for each row
declare
  row_id rowid;
 ---
begin
  FEM_NAT_ACCTS_PKG.INSERT_ROW(
    X_ROWID => ROW_ID,
    X_NATURAL_ACCOUNT_ID => :FEM_NAT_ACCTS_B.NATURAL_ACCOUNT_ID,
    X_VALUE_SET_ID => :FEM_NAT_ACCTS_B.VALUE_SET_ID,
    X_DIMENSION_GROUP_ID => :FEM_NAT_ACCTS_B.DIMENSION_GROUP_ID,
    X_NATURAL_ACCOUNT_DISPLAY_CODE => :FEM_NAT_ACCTS_B.NATURAL_ACCOUNT_DISPLAY_CODE,
    X_ENABLED_FLAG => :FEM_NAT_ACCTS_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_NAT_ACCTS_B.PERSONAL_FLAG,
    X_READ_ONLY_FLAG => :FEM_NAT_ACCTS_B.READ_ONLY_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_NAT_ACCTS_B.OBJECT_VERSION_NUMBER,
    X_NATURAL_ACCOUNT_NAME => :FEM_NAT_ACCTS_B.NATURAL_ACCOUNT_NAME,
    X_DESCRIPTION => :FEM_NAT_ACCTS_B.DESCRIPTION,
    X_CREATION_DATE => :FEM_NAT_ACCTS_B.CREATION_DATE,
    X_CREATED_BY => :FEM_NAT_ACCTS_B.CREATED_BY,
    X_LAST_UPDATE_DATE => :FEM_NAT_ACCTS_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_NAT_ACCTS_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_NAT_ACCTS_B.LAST_UPDATE_LOGIN);
 ---
end INSERT_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_NAT_ACCTS_IL" ENABLE;
