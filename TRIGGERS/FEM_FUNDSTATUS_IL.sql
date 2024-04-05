--------------------------------------------------------
--  DDL for Trigger FEM_FUNDSTATUS_IL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_FUNDSTATUS_IL" 
instead of insert on FEM_FUNDSTATUS_VL
referencing new as FEM_FUNDSTATUS_B
for each row
declare
  row_id rowid;
 ---
begin
  FEM_FUNDSTATUS_PKG.INSERT_ROW(
    X_ROWID => ROW_ID,
    X_FUNDING_STATUS_CODE => :FEM_FUNDSTATUS_B.FUNDING_STATUS_CODE,
    X_ENABLED_FLAG => :FEM_FUNDSTATUS_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_FUNDSTATUS_B.PERSONAL_FLAG,
    X_READ_ONLY_FLAG => :FEM_FUNDSTATUS_B.READ_ONLY_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_FUNDSTATUS_B.OBJECT_VERSION_NUMBER,
    X_FUNDING_STATUS_NAME => :FEM_FUNDSTATUS_B.FUNDING_STATUS_NAME,
    X_DESCRIPTION => :FEM_FUNDSTATUS_B.DESCRIPTION,
    X_CREATION_DATE => :FEM_FUNDSTATUS_B.CREATION_DATE,
    X_CREATED_BY => :FEM_FUNDSTATUS_B.CREATED_BY,
    X_LAST_UPDATE_DATE => :FEM_FUNDSTATUS_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_FUNDSTATUS_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_FUNDSTATUS_B.LAST_UPDATE_LOGIN);
 ---
end INSERT_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_FUNDSTATUS_IL" ENABLE;
