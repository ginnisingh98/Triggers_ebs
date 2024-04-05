--------------------------------------------------------
--  DDL for Trigger GMA_SY_PARA_CDS_T3
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMA_SY_PARA_CDS_T3" 
instead of delete on SY_PARA_CDS_VL
referencing old as SY_PARA_CDS
for each row
begin
  GMA_SY_PARA_CDS_PKG.DELETE_ROW(
    X_TABLE_NAME => :SY_PARA_CDS.TABLE_NAME,
    X_LANG_CODE => :SY_PARA_CDS.LANG_CODE,
    X_PARAGRAPH_CODE => :SY_PARA_CDS.PARAGRAPH_CODE,
    X_SUB_PARACODE => :SY_PARA_CDS.SUB_PARACODE);
end DELETE_ROW;


/
ALTER TRIGGER "APPS"."GMA_SY_PARA_CDS_T3" ENABLE;
