--------------------------------------------------------
--  DDL for Trigger FEM_ACCT_OWNSHP_IL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_ACCT_OWNSHP_IL" 
instead of insert on FEM_ACCT_OWNSHP_VL
referencing new as FEM_ACCT_OWNSHP_B
for each row
declare
  row_id rowid;
 ---
begin
  FEM_ACCT_OWNSHP_PKG.INSERT_ROW(
    X_ROWID => ROW_ID,
    X_ACCT_OWNERSHIP_ID => :FEM_ACCT_OWNSHP_B.ACCT_OWNERSHIP_ID,
    X_ACCT_OWNERSHIP_DISPLAY_CODE => :FEM_ACCT_OWNSHP_B.ACCT_OWNERSHIP_DISPLAY_CODE,
    X_ENABLED_FLAG => :FEM_ACCT_OWNSHP_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_ACCT_OWNSHP_B.PERSONAL_FLAG,
    X_READ_ONLY_FLAG => :FEM_ACCT_OWNSHP_B.READ_ONLY_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_ACCT_OWNSHP_B.OBJECT_VERSION_NUMBER,
    X_ACCT_OWNERSHIP_NAME => :FEM_ACCT_OWNSHP_B.ACCT_OWNERSHIP_NAME,
    X_DESCRIPTION => :FEM_ACCT_OWNSHP_B.DESCRIPTION,
    X_CREATION_DATE => :FEM_ACCT_OWNSHP_B.CREATION_DATE,
    X_CREATED_BY => :FEM_ACCT_OWNSHP_B.CREATED_BY,
    X_LAST_UPDATE_DATE => :FEM_ACCT_OWNSHP_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_ACCT_OWNSHP_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_ACCT_OWNSHP_B.LAST_UPDATE_LOGIN);
 ---
end INSERT_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_ACCT_OWNSHP_IL" ENABLE;
