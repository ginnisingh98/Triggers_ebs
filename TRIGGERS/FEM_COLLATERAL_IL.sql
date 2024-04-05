--------------------------------------------------------
--  DDL for Trigger FEM_COLLATERAL_IL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_COLLATERAL_IL" 
instead of insert on FEM_COLLATERAL_VL
referencing new as FEM_COLLATERAL_B
for each row
declare
  row_id rowid;
 ---
begin
  FEM_COLLATERAL_PKG.INSERT_ROW(
    X_ROWID => ROW_ID,
    X_COLLATERAL_ID => :FEM_COLLATERAL_B.COLLATERAL_ID,
    X_COLLATERAL_DISPLAY_CODE => :FEM_COLLATERAL_B.COLLATERAL_DISPLAY_CODE,
    X_ENABLED_FLAG => :FEM_COLLATERAL_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_COLLATERAL_B.PERSONAL_FLAG,
    X_READ_ONLY_FLAG => :FEM_COLLATERAL_B.READ_ONLY_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_COLLATERAL_B.OBJECT_VERSION_NUMBER,
    X_COLLATERAL_NAME => :FEM_COLLATERAL_B.COLLATERAL_NAME,
    X_DESCRIPTION => :FEM_COLLATERAL_B.DESCRIPTION,
    X_CREATION_DATE => :FEM_COLLATERAL_B.CREATION_DATE,
    X_CREATED_BY => :FEM_COLLATERAL_B.CREATED_BY,
    X_LAST_UPDATE_DATE => :FEM_COLLATERAL_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_COLLATERAL_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_COLLATERAL_B.LAST_UPDATE_LOGIN);
 ---
end INSERT_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_COLLATERAL_IL" ENABLE;
