--------------------------------------------------------
--  DDL for Trigger FEM_FIN_ELEMS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_FIN_ELEMS_DL" 
instead of delete on FEM_FIN_ELEMS_VL
referencing old as FEM_FIN_ELEMS_B
for each row
begin
  FEM_FIN_ELEMS_PKG.DELETE_ROW(
    X_FINANCIAL_ELEM_ID => :FEM_FIN_ELEMS_B.FINANCIAL_ELEM_ID,
    X_VALUE_SET_ID => :FEM_FIN_ELEMS_B.VALUE_SET_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_FIN_ELEMS_DL" ENABLE;
