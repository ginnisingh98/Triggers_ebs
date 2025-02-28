--------------------------------------------------------
--  DDL for Trigger FEM_INTDIV_OPTN_IL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_INTDIV_OPTN_IL" 
instead of insert on FEM_INTDIV_OPTN_VL
referencing new as FEM_INTDIV_OPTN_B
for each row
declare
  row_id rowid;
 ---
begin
  FEM_INTDIV_OPTN_PKG.INSERT_ROW(
    X_ROWID => ROW_ID,
    X_INT_DIVIDENDS_OPTION_CODE => :FEM_INTDIV_OPTN_B.INT_DIVIDENDS_OPTION_CODE,
    X_ENABLED_FLAG => :FEM_INTDIV_OPTN_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_INTDIV_OPTN_B.PERSONAL_FLAG,
    X_READ_ONLY_FLAG => :FEM_INTDIV_OPTN_B.READ_ONLY_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_INTDIV_OPTN_B.OBJECT_VERSION_NUMBER,
    X_INT_DIVIDENDS_OPTION_NAME => :FEM_INTDIV_OPTN_B.INT_DIVIDENDS_OPTION_NAME,
    X_DESCRIPTION => :FEM_INTDIV_OPTN_B.DESCRIPTION,
    X_CREATION_DATE => :FEM_INTDIV_OPTN_B.CREATION_DATE,
    X_CREATED_BY => :FEM_INTDIV_OPTN_B.CREATED_BY,
    X_LAST_UPDATE_DATE => :FEM_INTDIV_OPTN_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_INTDIV_OPTN_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_INTDIV_OPTN_B.LAST_UPDATE_LOGIN);
 ---
end INSERT_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_INTDIV_OPTN_IL" ENABLE;
