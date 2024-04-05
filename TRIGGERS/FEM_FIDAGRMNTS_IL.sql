--------------------------------------------------------
--  DDL for Trigger FEM_FIDAGRMNTS_IL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_FIDAGRMNTS_IL" 
instead of insert on FEM_FIDAGRMNTS_VL
referencing new as FEM_FIDAGRMNTS_B
for each row
declare
  row_id rowid;
 ---
begin
  FEM_FIDAGRMNTS_PKG.INSERT_ROW(
    X_ROWID => ROW_ID,
    X_FIDUCIARY_AGREEMENT_CODE => :FEM_FIDAGRMNTS_B.FIDUCIARY_AGREEMENT_CODE,
    X_ENABLED_FLAG => :FEM_FIDAGRMNTS_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_FIDAGRMNTS_B.PERSONAL_FLAG,
    X_READ_ONLY_FLAG => :FEM_FIDAGRMNTS_B.READ_ONLY_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_FIDAGRMNTS_B.OBJECT_VERSION_NUMBER,
    X_FIDUCIARY_AGREEMENT_NAME => :FEM_FIDAGRMNTS_B.FIDUCIARY_AGREEMENT_NAME,
    X_DESCRIPTION => :FEM_FIDAGRMNTS_B.DESCRIPTION,
    X_CREATION_DATE => :FEM_FIDAGRMNTS_B.CREATION_DATE,
    X_CREATED_BY => :FEM_FIDAGRMNTS_B.CREATED_BY,
    X_LAST_UPDATE_DATE => :FEM_FIDAGRMNTS_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_FIDAGRMNTS_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_FIDAGRMNTS_B.LAST_UPDATE_LOGIN);
 ---
end INSERT_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_FIDAGRMNTS_IL" ENABLE;
