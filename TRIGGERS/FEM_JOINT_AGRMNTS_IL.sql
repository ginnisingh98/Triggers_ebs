--------------------------------------------------------
--  DDL for Trigger FEM_JOINT_AGRMNTS_IL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_JOINT_AGRMNTS_IL" 
instead of insert on FEM_JOINT_AGRMNTS_VL
referencing new as FEM_JOINT_AGRMNTS_B
for each row
declare
  row_id rowid;
 ---
begin
  FEM_JOINT_AGRMNTS_PKG.INSERT_ROW(
    X_ROWID => ROW_ID,
    X_JOINT_AGREEMENT_CODE => :FEM_JOINT_AGRMNTS_B.JOINT_AGREEMENT_CODE,
    X_ENABLED_FLAG => :FEM_JOINT_AGRMNTS_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_JOINT_AGRMNTS_B.PERSONAL_FLAG,
    X_READ_ONLY_FLAG => :FEM_JOINT_AGRMNTS_B.READ_ONLY_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_JOINT_AGRMNTS_B.OBJECT_VERSION_NUMBER,
    X_JOINT_AGREEMENT_NAME => :FEM_JOINT_AGRMNTS_B.JOINT_AGREEMENT_NAME,
    X_DESCRIPTION => :FEM_JOINT_AGRMNTS_B.DESCRIPTION,
    X_CREATION_DATE => :FEM_JOINT_AGRMNTS_B.CREATION_DATE,
    X_CREATED_BY => :FEM_JOINT_AGRMNTS_B.CREATED_BY,
    X_LAST_UPDATE_DATE => :FEM_JOINT_AGRMNTS_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_JOINT_AGRMNTS_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_JOINT_AGRMNTS_B.LAST_UPDATE_LOGIN);
 ---
end INSERT_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_JOINT_AGRMNTS_IL" ENABLE;
