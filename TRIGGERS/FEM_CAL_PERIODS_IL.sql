--------------------------------------------------------
--  DDL for Trigger FEM_CAL_PERIODS_IL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_CAL_PERIODS_IL" 
instead of insert on FEM_CAL_PERIODS_VL
referencing new as FEM_CAL_PERIODS_B
for each row
declare
  row_id rowid;
 ---
begin
  FEM_CAL_PERIODS_PKG.INSERT_ROW(
    X_ROWID => ROW_ID,
    X_CAL_PERIOD_ID => :FEM_CAL_PERIODS_B.CAL_PERIOD_ID,
    X_DIMENSION_GROUP_ID => :FEM_CAL_PERIODS_B.DIMENSION_GROUP_ID,
    X_CALENDAR_ID => :FEM_CAL_PERIODS_B.CALENDAR_ID,
    X_ENABLED_FLAG => :FEM_CAL_PERIODS_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_CAL_PERIODS_B.PERSONAL_FLAG,
    X_READ_ONLY_FLAG => :FEM_CAL_PERIODS_B.READ_ONLY_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_CAL_PERIODS_B.OBJECT_VERSION_NUMBER,
    X_CAL_PERIOD_NAME => :FEM_CAL_PERIODS_B.CAL_PERIOD_NAME,
    X_DESCRIPTION => :FEM_CAL_PERIODS_B.DESCRIPTION,
    X_CREATION_DATE => :FEM_CAL_PERIODS_B.CREATION_DATE,
    X_CREATED_BY => :FEM_CAL_PERIODS_B.CREATED_BY,
    X_LAST_UPDATE_DATE => :FEM_CAL_PERIODS_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_CAL_PERIODS_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_CAL_PERIODS_B.LAST_UPDATE_LOGIN);
 ---
end INSERT_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_CAL_PERIODS_IL" ENABLE;
