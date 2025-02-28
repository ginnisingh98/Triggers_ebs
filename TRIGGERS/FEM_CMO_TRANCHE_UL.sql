--------------------------------------------------------
--  DDL for Trigger FEM_CMO_TRANCHE_UL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_CMO_TRANCHE_UL" 
instead of update on FEM_CMO_TRANCHE_VL
referencing new as FEM_CMO_TRANCHE_B
for each row
begin
  FEM_CMO_TRANCHE_PKG.UPDATE_ROW(
    X_CMO_TRANCHE_ID => :FEM_CMO_TRANCHE_B.CMO_TRANCHE_ID,
    X_CMO_TRANCHE_DISPLAY_CODE => :FEM_CMO_TRANCHE_B.CMO_TRANCHE_DISPLAY_CODE,
    X_ENABLED_FLAG => :FEM_CMO_TRANCHE_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_CMO_TRANCHE_B.PERSONAL_FLAG,
    X_READ_ONLY_FLAG => :FEM_CMO_TRANCHE_B.READ_ONLY_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_CMO_TRANCHE_B.OBJECT_VERSION_NUMBER,
    X_CMO_TRANCHE_NAME => :FEM_CMO_TRANCHE_B.CMO_TRANCHE_NAME,
    X_DESCRIPTION => :FEM_CMO_TRANCHE_B.DESCRIPTION,
    X_LAST_UPDATE_DATE => :FEM_CMO_TRANCHE_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_CMO_TRANCHE_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_CMO_TRANCHE_B.LAST_UPDATE_LOGIN);
 ---
end UPDATE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_CMO_TRANCHE_UL" ENABLE;
