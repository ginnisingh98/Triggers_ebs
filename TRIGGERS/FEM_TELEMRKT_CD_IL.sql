--------------------------------------------------------
--  DDL for Trigger FEM_TELEMRKT_CD_IL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_TELEMRKT_CD_IL" 
instead of insert on FEM_TELEMRKT_CD_VL
referencing new as FEM_TELEMRKT_CD_B
for each row
declare
  row_id rowid;
 ---
begin
  FEM_TELEMRKT_CD_PKG.INSERT_ROW(
    X_ROWID => ROW_ID,
    X_TELEMARKET_CD_CODE => :FEM_TELEMRKT_CD_B.TELEMARKET_CD_CODE,
    X_ENABLED_FLAG => :FEM_TELEMRKT_CD_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_TELEMRKT_CD_B.PERSONAL_FLAG,
    X_READ_ONLY_FLAG => :FEM_TELEMRKT_CD_B.READ_ONLY_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_TELEMRKT_CD_B.OBJECT_VERSION_NUMBER,
    X_TELEMARKET_CD_NAME => :FEM_TELEMRKT_CD_B.TELEMARKET_CD_NAME,
    X_DESCRIPTION => :FEM_TELEMRKT_CD_B.DESCRIPTION,
    X_CREATION_DATE => :FEM_TELEMRKT_CD_B.CREATION_DATE,
    X_CREATED_BY => :FEM_TELEMRKT_CD_B.CREATED_BY,
    X_LAST_UPDATE_DATE => :FEM_TELEMRKT_CD_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_TELEMRKT_CD_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_TELEMRKT_CD_B.LAST_UPDATE_LOGIN);
 ---
end INSERT_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_TELEMRKT_CD_IL" ENABLE;
