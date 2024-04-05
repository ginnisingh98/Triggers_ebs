--------------------------------------------------------
--  DDL for Trigger FEM_BUS_TYPE_CD_UL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_BUS_TYPE_CD_UL" 
instead of update on FEM_BUS_TYPE_CD_VL
referencing new as FEM_BUS_TYPE_CD_B
for each row
begin
  FEM_BUS_TYPE_CD_PKG.UPDATE_ROW(
    X_BUS_TYPE_CD_CODE => :FEM_BUS_TYPE_CD_B.BUS_TYPE_CD_CODE,
    X_ENABLED_FLAG => :FEM_BUS_TYPE_CD_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_BUS_TYPE_CD_B.PERSONAL_FLAG,
    X_READ_ONLY_FLAG => :FEM_BUS_TYPE_CD_B.READ_ONLY_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_BUS_TYPE_CD_B.OBJECT_VERSION_NUMBER,
    X_BUS_TYPE_CD_NAME => :FEM_BUS_TYPE_CD_B.BUS_TYPE_CD_NAME,
    X_DESCRIPTION => :FEM_BUS_TYPE_CD_B.DESCRIPTION,
    X_LAST_UPDATE_DATE => :FEM_BUS_TYPE_CD_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_BUS_TYPE_CD_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_BUS_TYPE_CD_B.LAST_UPDATE_LOGIN);
 ---
end UPDATE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_BUS_TYPE_CD_UL" ENABLE;
