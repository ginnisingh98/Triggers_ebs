--------------------------------------------------------
--  DDL for Trigger FEM_INTDIV_OPTN_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_INTDIV_OPTN_DL" 
instead of delete on FEM_INTDIV_OPTN_VL
referencing old as FEM_INTDIV_OPTN_B
for each row
begin
  FEM_INTDIV_OPTN_PKG.DELETE_ROW(
    X_INT_DIVIDENDS_OPTION_CODE => :FEM_INTDIV_OPTN_B.INT_DIVIDENDS_OPTION_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_INTDIV_OPTN_DL" ENABLE;
