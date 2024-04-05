--------------------------------------------------------
--  DDL for Trigger GMD_FORMULA_CLASS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMD_FORMULA_CLASS_DL" 
/* $Header: gmdfcdtg.sql 120.1 2005/06/09 05:10:15 appldev  $ */
instead of delete on GMD_FORMULA_CLASS_VL
referencing old as FM_FORM_CLS
for each row
begin
  GMD_FORMULA_CLASS_PKG.DELETE_ROW(
    X_FORMULA_CLASS => :FM_FORM_CLS.FORMULA_CLASS);
end DELETE_ROW;


/
ALTER TRIGGER "APPS"."GMD_FORMULA_CLASS_DL" ENABLE;
