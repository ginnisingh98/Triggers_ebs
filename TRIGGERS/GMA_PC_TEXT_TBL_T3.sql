--------------------------------------------------------
--  DDL for Trigger GMA_PC_TEXT_TBL_T3
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMA_PC_TEXT_TBL_T3" 
instead of delete on PC_TEXT_TBL_VL
referencing old as PC_TEXT_TBL
for each row
begin
  GMA_PC_TEXT_TBL_PKG.DELETE_ROW(
    X_TEXT_CODE => :PC_TEXT_TBL.TEXT_CODE,
    X_LANG_CODE => :PC_TEXT_TBL.LANG_CODE,
    X_PARAGRAPH_CODE => :PC_TEXT_TBL.PARAGRAPH_CODE,
    X_SUB_PARACODE => :PC_TEXT_TBL.SUB_PARACODE,
    X_LINE_NO => :PC_TEXT_TBL.LINE_NO,
    X_ROW_ID => :PC_TEXT_TBL.ROW_ID);
-- Bug #1806284 (JKB)
end DELETE_ROW;


/
ALTER TRIGGER "APPS"."GMA_PC_TEXT_TBL_T3" ENABLE;
