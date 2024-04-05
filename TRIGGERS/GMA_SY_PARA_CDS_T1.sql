--------------------------------------------------------
--  DDL for Trigger GMA_SY_PARA_CDS_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMA_SY_PARA_CDS_T1" 
/*       $Header: GMAMLSTG.sql 120.1 2005/06/08 05:03:55 appldev  $ */
instead of insert on SY_PARA_CDS_VL
referencing new as SY_PARA_CDS
for each row
declare
  row_id rowid;
begin
  GMA_SY_PARA_CDS_PKG.INSERT_ROW(
    X_ROWID => ROW_ID,
    X_TABLE_NAME => :SY_PARA_CDS.TABLE_NAME,
    X_LANG_CODE => :SY_PARA_CDS.LANG_CODE,
    X_PARAGRAPH_CODE => :SY_PARA_CDS.PARAGRAPH_CODE,
    X_SUB_PARACODE => :SY_PARA_CDS.SUB_PARACODE,
    X_NONPRINTABLE_IND => :SY_PARA_CDS.NONPRINTABLE_IND,
    X_PARA_DESC => :SY_PARA_CDS.PARA_DESC,
    X_CREATION_DATE => :SY_PARA_CDS.CREATION_DATE,
    X_CREATED_BY => :SY_PARA_CDS.CREATED_BY,
    X_LAST_UPDATE_DATE => :SY_PARA_CDS.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :SY_PARA_CDS.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :SY_PARA_CDS.LAST_UPDATE_LOGIN);
end INSERT_ROW;


/
ALTER TRIGGER "APPS"."GMA_SY_PARA_CDS_T1" ENABLE;
