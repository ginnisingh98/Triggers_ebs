--------------------------------------------------------
--  DDL for Trigger FEM_PAY_AHEAD_UL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_PAY_AHEAD_UL" 
instead of update on FEM_PAY_AHEAD_VL
referencing new as FEM_PAY_AHEAD_B
for each row
begin
  FEM_PAY_AHEAD_PKG.UPDATE_ROW(
    X_PAY_AHEAD_CODE => :FEM_PAY_AHEAD_B.PAY_AHEAD_CODE,
    X_ENABLED_FLAG => :FEM_PAY_AHEAD_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_PAY_AHEAD_B.PERSONAL_FLAG,
    X_READ_ONLY_FLAG => :FEM_PAY_AHEAD_B.READ_ONLY_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_PAY_AHEAD_B.OBJECT_VERSION_NUMBER,
    X_PAY_AHEAD_NAME => :FEM_PAY_AHEAD_B.PAY_AHEAD_NAME,
    X_DESCRIPTION => :FEM_PAY_AHEAD_B.DESCRIPTION,
    X_LAST_UPDATE_DATE => :FEM_PAY_AHEAD_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_PAY_AHEAD_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_PAY_AHEAD_B.LAST_UPDATE_LOGIN);
 ---
end UPDATE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_PAY_AHEAD_UL" ENABLE;
