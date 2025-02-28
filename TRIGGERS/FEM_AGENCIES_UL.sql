--------------------------------------------------------
--  DDL for Trigger FEM_AGENCIES_UL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_AGENCIES_UL" 
instead of update on FEM_AGENCIES_VL
referencing new as FEM_AGENCIES_B
for each row
begin
  FEM_AGENCIES_PKG.UPDATE_ROW(
    X_AGENCY_ID => :FEM_AGENCIES_B.AGENCY_ID,
    X_AGENCY_DISPLAY_CODE => :FEM_AGENCIES_B.AGENCY_DISPLAY_CODE,
    X_ENABLED_FLAG => :FEM_AGENCIES_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_AGENCIES_B.PERSONAL_FLAG,
    X_READ_ONLY_FLAG => :FEM_AGENCIES_B.READ_ONLY_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_AGENCIES_B.OBJECT_VERSION_NUMBER,
    X_AGENCY_NAME => :FEM_AGENCIES_B.AGENCY_NAME,
    X_DESCRIPTION => :FEM_AGENCIES_B.DESCRIPTION,
    X_LAST_UPDATE_DATE => :FEM_AGENCIES_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_AGENCIES_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_AGENCIES_B.LAST_UPDATE_LOGIN);
 ---
end UPDATE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_AGENCIES_UL" ENABLE;
