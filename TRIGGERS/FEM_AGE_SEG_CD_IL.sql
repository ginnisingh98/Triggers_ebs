--------------------------------------------------------
--  DDL for Trigger FEM_AGE_SEG_CD_IL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_AGE_SEG_CD_IL" 
instead of insert on FEM_AGE_SEG_CD_VL
referencing new as FEM_AGE_SEG_CD_B
for each row
declare
  row_id rowid;
 ---
begin
  FEM_AGE_SEG_CD_PKG.INSERT_ROW(
    X_ROWID => ROW_ID,
    X_AGE_SEG_CD_CODE => :FEM_AGE_SEG_CD_B.AGE_SEG_CD_CODE,
    X_ENABLED_FLAG => :FEM_AGE_SEG_CD_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_AGE_SEG_CD_B.PERSONAL_FLAG,
    X_READ_ONLY_FLAG => :FEM_AGE_SEG_CD_B.READ_ONLY_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_AGE_SEG_CD_B.OBJECT_VERSION_NUMBER,
    X_AGE_SEG_CD_NAME => :FEM_AGE_SEG_CD_B.AGE_SEG_CD_NAME,
    X_DESCRIPTION => :FEM_AGE_SEG_CD_B.DESCRIPTION,
    X_CREATION_DATE => :FEM_AGE_SEG_CD_B.CREATION_DATE,
    X_CREATED_BY => :FEM_AGE_SEG_CD_B.CREATED_BY,
    X_LAST_UPDATE_DATE => :FEM_AGE_SEG_CD_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_AGE_SEG_CD_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_AGE_SEG_CD_B.LAST_UPDATE_LOGIN);
 ---
end INSERT_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_AGE_SEG_CD_IL" ENABLE;
