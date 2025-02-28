--------------------------------------------------------
--  DDL for Trigger FEM_PUT_CALLS_UL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_PUT_CALLS_UL" 
instead of update on FEM_PUT_CALLS_VL
referencing new as FEM_PUT_CALLS_B
for each row
begin
  FEM_PUT_CALLS_PKG.UPDATE_ROW(
    X_PUT_CALL_ID => :FEM_PUT_CALLS_B.PUT_CALL_ID,
    X_PUT_CALL_DISPLAY_CODE => :FEM_PUT_CALLS_B.PUT_CALL_DISPLAY_CODE,
    X_ENABLED_FLAG => :FEM_PUT_CALLS_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_PUT_CALLS_B.PERSONAL_FLAG,
    X_READ_ONLY_FLAG => :FEM_PUT_CALLS_B.READ_ONLY_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_PUT_CALLS_B.OBJECT_VERSION_NUMBER,
    X_PUT_CALL_NAME => :FEM_PUT_CALLS_B.PUT_CALL_NAME,
    X_DESCRIPTION => :FEM_PUT_CALLS_B.DESCRIPTION,
    X_LAST_UPDATE_DATE => :FEM_PUT_CALLS_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_PUT_CALLS_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_PUT_CALLS_B.LAST_UPDATE_LOGIN);
 ---
end UPDATE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_PUT_CALLS_UL" ENABLE;
