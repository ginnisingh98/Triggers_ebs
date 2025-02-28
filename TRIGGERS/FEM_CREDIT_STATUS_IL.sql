--------------------------------------------------------
--  DDL for Trigger FEM_CREDIT_STATUS_IL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_CREDIT_STATUS_IL" 
instead of insert on FEM_CREDIT_STATUS_VL
referencing new as FEM_CREDIT_STATUS_B
for each row
declare
  row_id rowid;
 ---
begin
  FEM_CREDIT_STATUS_PKG.INSERT_ROW(
    X_ROWID => ROW_ID,
    X_CREDIT_STATUS_ID => :FEM_CREDIT_STATUS_B.CREDIT_STATUS_ID,
    X_CREDIT_STATUS_DISPLAY_CODE => :FEM_CREDIT_STATUS_B.CREDIT_STATUS_DISPLAY_CODE,
    X_ENABLED_FLAG => :FEM_CREDIT_STATUS_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_CREDIT_STATUS_B.PERSONAL_FLAG,
    X_READ_ONLY_FLAG => :FEM_CREDIT_STATUS_B.READ_ONLY_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_CREDIT_STATUS_B.OBJECT_VERSION_NUMBER,
    X_CREDIT_STATUS_NAME => :FEM_CREDIT_STATUS_B.CREDIT_STATUS_NAME,
    X_DESCRIPTION => :FEM_CREDIT_STATUS_B.DESCRIPTION,
    X_CREATION_DATE => :FEM_CREDIT_STATUS_B.CREATION_DATE,
    X_CREATED_BY => :FEM_CREDIT_STATUS_B.CREATED_BY,
    X_LAST_UPDATE_DATE => :FEM_CREDIT_STATUS_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_CREDIT_STATUS_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_CREDIT_STATUS_B.LAST_UPDATE_LOGIN);
 ---
end INSERT_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_CREDIT_STATUS_IL" ENABLE;
