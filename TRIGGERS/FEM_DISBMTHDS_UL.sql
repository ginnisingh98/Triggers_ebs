--------------------------------------------------------
--  DDL for Trigger FEM_DISBMTHDS_UL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_DISBMTHDS_UL" 
instead of update on FEM_DISBMTHDS_VL
referencing new as FEM_DISBMTHDS_B
for each row
begin
  FEM_DISBMTHDS_PKG.UPDATE_ROW(
    X_DISBURS_METHOD_CODE => :FEM_DISBMTHDS_B.DISBURS_METHOD_CODE,
    X_ENABLED_FLAG => :FEM_DISBMTHDS_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_DISBMTHDS_B.PERSONAL_FLAG,
    X_READ_ONLY_FLAG => :FEM_DISBMTHDS_B.READ_ONLY_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_DISBMTHDS_B.OBJECT_VERSION_NUMBER,
    X_DISBURS_METHOD_NAME => :FEM_DISBMTHDS_B.DISBURS_METHOD_NAME,
    X_DESCRIPTION => :FEM_DISBMTHDS_B.DESCRIPTION,
    X_LAST_UPDATE_DATE => :FEM_DISBMTHDS_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_DISBMTHDS_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_DISBMTHDS_B.LAST_UPDATE_LOGIN);
 ---
end UPDATE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_DISBMTHDS_UL" ENABLE;
