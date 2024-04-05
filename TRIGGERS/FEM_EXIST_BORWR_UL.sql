--------------------------------------------------------
--  DDL for Trigger FEM_EXIST_BORWR_UL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_EXIST_BORWR_UL" 
instead of update on FEM_EXIST_BORWR_VL
referencing new as FEM_EXIST_BORWR_B
for each row
begin
  FEM_EXIST_BORWR_PKG.UPDATE_ROW(
    X_EXIST_BORROWER_ID => :FEM_EXIST_BORWR_B.EXIST_BORROWER_ID,
    X_EXIST_BORROWER_DISPLAY_CODE => :FEM_EXIST_BORWR_B.EXIST_BORROWER_DISPLAY_CODE,
    X_ENABLED_FLAG => :FEM_EXIST_BORWR_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_EXIST_BORWR_B.PERSONAL_FLAG,
    X_READ_ONLY_FLAG => :FEM_EXIST_BORWR_B.READ_ONLY_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_EXIST_BORWR_B.OBJECT_VERSION_NUMBER,
    X_EXIST_BORROWER_NAME => :FEM_EXIST_BORWR_B.EXIST_BORROWER_NAME,
    X_DESCRIPTION => :FEM_EXIST_BORWR_B.DESCRIPTION,
    X_LAST_UPDATE_DATE => :FEM_EXIST_BORWR_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_EXIST_BORWR_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_EXIST_BORWR_B.LAST_UPDATE_LOGIN);
 ---
end UPDATE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_EXIST_BORWR_UL" ENABLE;
