--------------------------------------------------------
--  DDL for Trigger FEM_COMMIT_TYPES_UL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_COMMIT_TYPES_UL" 
instead of update on FEM_COMMIT_TYPES_VL
referencing new as FEM_COMMIT_TYPES_B
for each row
begin
  FEM_COMMIT_TYPES_PKG.UPDATE_ROW(
    X_COMMITMENT_TYPE_ID => :FEM_COMMIT_TYPES_B.COMMITMENT_TYPE_ID,
    X_COMMITMENT_TYPE_DISPLAY_CODE => :FEM_COMMIT_TYPES_B.COMMITMENT_TYPE_DISPLAY_CODE,
    X_ENABLED_FLAG => :FEM_COMMIT_TYPES_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_COMMIT_TYPES_B.PERSONAL_FLAG,
    X_READ_ONLY_FLAG => :FEM_COMMIT_TYPES_B.READ_ONLY_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_COMMIT_TYPES_B.OBJECT_VERSION_NUMBER,
    X_COMMITMENT_TYPE_NAME => :FEM_COMMIT_TYPES_B.COMMITMENT_TYPE_NAME,
    X_DESCRIPTION => :FEM_COMMIT_TYPES_B.DESCRIPTION,
    X_LAST_UPDATE_DATE => :FEM_COMMIT_TYPES_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_COMMIT_TYPES_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_COMMIT_TYPES_B.LAST_UPDATE_LOGIN);
 ---
end UPDATE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_COMMIT_TYPES_UL" ENABLE;
