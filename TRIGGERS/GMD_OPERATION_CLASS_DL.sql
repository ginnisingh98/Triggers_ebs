--------------------------------------------------------
--  DDL for Trigger GMD_OPERATION_CLASS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMD_OPERATION_CLASS_DL" 
/* $Header: gmdocdtg.sql 120.1 2005/06/09 05:17:03 appldev  $ */
instead of delete on GMD_OPERATION_CLASS_VL
referencing old as FM_OPRN_CLS
for each row
begin
  GMD_OPERATION_CLASS_PKG.DELETE_ROW(
    X_OPRN_CLASS => :FM_OPRN_CLS.OPRN_CLASS);
end DELETE_ROW;


/
ALTER TRIGGER "APPS"."GMD_OPERATION_CLASS_DL" ENABLE;
