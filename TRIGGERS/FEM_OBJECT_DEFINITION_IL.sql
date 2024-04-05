--------------------------------------------------------
--  DDL for Trigger FEM_OBJECT_DEFINITION_IL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_OBJECT_DEFINITION_IL" 
instead of insert on FEM_OBJECT_DEFINITION_VL
referencing new as FEM_OBJECT_DEFINITION_B
for each row
declare
  row_id rowid;
 ---
begin
  FEM_OBJECT_DEFINITION_PKG.INSERT_ROW(
    X_ROWID => ROW_ID,
    X_OBJECT_DEFINITION_ID => :FEM_OBJECT_DEFINITION_B.OBJECT_DEFINITION_ID,
    X_OBJECT_VERSION_NUMBER => :FEM_OBJECT_DEFINITION_B.OBJECT_VERSION_NUMBER,
    X_OBJECT_ID => :FEM_OBJECT_DEFINITION_B.OBJECT_ID,
    X_EFFECTIVE_START_DATE => :FEM_OBJECT_DEFINITION_B.EFFECTIVE_START_DATE,
    X_EFFECTIVE_END_DATE => :FEM_OBJECT_DEFINITION_B.EFFECTIVE_END_DATE,
    X_OBJECT_ORIGIN_CODE => :FEM_OBJECT_DEFINITION_B.OBJECT_ORIGIN_CODE,
    X_APPROVAL_STATUS_CODE => :FEM_OBJECT_DEFINITION_B.APPROVAL_STATUS_CODE,
    X_OLD_APPROVED_COPY_FLAG => :FEM_OBJECT_DEFINITION_B.OLD_APPROVED_COPY_FLAG,
    X_OLD_APPROVED_COPY_OBJ_DEF_ID => :FEM_OBJECT_DEFINITION_B.OLD_APPROVED_COPY_OBJ_DEF_ID,
    X_APPROVED_BY => :FEM_OBJECT_DEFINITION_B.APPROVED_BY,
    X_APPROVAL_DATE => :FEM_OBJECT_DEFINITION_B.APPROVAL_DATE,
    X_DISPLAY_NAME => :FEM_OBJECT_DEFINITION_B.DISPLAY_NAME,
    X_DESCRIPTION => :FEM_OBJECT_DEFINITION_B.DESCRIPTION,
    X_CREATION_DATE => :FEM_OBJECT_DEFINITION_B.CREATION_DATE,
    X_CREATED_BY => :FEM_OBJECT_DEFINITION_B.CREATED_BY,
    X_LAST_UPDATE_DATE => :FEM_OBJECT_DEFINITION_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_OBJECT_DEFINITION_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_OBJECT_DEFINITION_B.LAST_UPDATE_LOGIN);
 ---
end INSERT_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_OBJECT_DEFINITION_IL" ENABLE;
