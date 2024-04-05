--------------------------------------------------------
--  DDL for Trigger FEM_GOV_ID_NUMS_IL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_GOV_ID_NUMS_IL" 
instead of insert on FEM_GOV_ID_NUMS_VL
referencing new as FEM_GOV_ID_NUMS_B
for each row
declare
  row_id rowid;
 ---
begin
  FEM_GOV_ID_NUMS_PKG.INSERT_ROW(
    X_ROWID => ROW_ID,
    X_GOVT_ID_NUM_CODE => :FEM_GOV_ID_NUMS_B.GOVT_ID_NUM_CODE,
    X_ENABLED_FLAG => :FEM_GOV_ID_NUMS_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_GOV_ID_NUMS_B.PERSONAL_FLAG,
    X_READ_ONLY_FLAG => :FEM_GOV_ID_NUMS_B.READ_ONLY_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_GOV_ID_NUMS_B.OBJECT_VERSION_NUMBER,
    X_GOVT_ID_NUM_NAME => :FEM_GOV_ID_NUMS_B.GOVT_ID_NUM_NAME,
    X_DESCRIPTION => :FEM_GOV_ID_NUMS_B.DESCRIPTION,
    X_CREATION_DATE => :FEM_GOV_ID_NUMS_B.CREATION_DATE,
    X_CREATED_BY => :FEM_GOV_ID_NUMS_B.CREATED_BY,
    X_LAST_UPDATE_DATE => :FEM_GOV_ID_NUMS_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_GOV_ID_NUMS_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_GOV_ID_NUMS_B.LAST_UPDATE_LOGIN);
 ---
end INSERT_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_GOV_ID_NUMS_IL" ENABLE;
