--------------------------------------------------------
--  DDL for Trigger GMA_IC_TEXT_TBL_T3
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMA_IC_TEXT_TBL_T3" 
instead of delete on IC_TEXT_TBL_VL
referencing old as IC_TEXT_TBL
for each row
begin
  GMA_IC_TEXT_TBL_PKG.DELETE_ROW(
    X_TEXT_CODE => :IC_TEXT_TBL.TEXT_CODE,
    X_LANG_CODE => :IC_TEXT_TBL.LANG_CODE,
    X_PARAGRAPH_CODE => :IC_TEXT_TBL.PARAGRAPH_CODE,
    X_SUB_PARACODE => :IC_TEXT_TBL.SUB_PARACODE,
    X_LINE_NO => :IC_TEXT_TBL.LINE_NO,
    X_ROW_ID => :IC_TEXT_TBL.ROW_ID);
-- Bug #1806284 (JKB)
end DELETE_ROW;


/
ALTER TRIGGER "APPS"."GMA_IC_TEXT_TBL_T3" ENABLE;
