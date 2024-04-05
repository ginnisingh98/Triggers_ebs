--------------------------------------------------------
--  DDL for Trigger FEM_PLEDG_STAT_UL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_PLEDG_STAT_UL" 
instead of update on FEM_PLEDG_STAT_VL
referencing new as FEM_PLEDG_STAT_B
for each row
begin
  FEM_PLEDG_STAT_PKG.UPDATE_ROW(
    X_PLEDGED_STATUS_ID => :FEM_PLEDG_STAT_B.PLEDGED_STATUS_ID,
    X_PLEDGED_STATUS_DISPLAY_CODE => :FEM_PLEDG_STAT_B.PLEDGED_STATUS_DISPLAY_CODE,
    X_ENABLED_FLAG => :FEM_PLEDG_STAT_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_PLEDG_STAT_B.PERSONAL_FLAG,
    X_READ_ONLY_FLAG => :FEM_PLEDG_STAT_B.READ_ONLY_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_PLEDG_STAT_B.OBJECT_VERSION_NUMBER,
    X_PLEDGED_STATUS_NAME => :FEM_PLEDG_STAT_B.PLEDGED_STATUS_NAME,
    X_DESCRIPTION => :FEM_PLEDG_STAT_B.DESCRIPTION,
    X_LAST_UPDATE_DATE => :FEM_PLEDG_STAT_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_PLEDG_STAT_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_PLEDG_STAT_B.LAST_UPDATE_LOGIN);
 ---
end UPDATE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_PLEDG_STAT_UL" ENABLE;
