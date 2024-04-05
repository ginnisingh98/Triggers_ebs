--------------------------------------------------------
--  DDL for Trigger GMD_OPERATIONS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMD_OPERATIONS_DL" 
/* $Header: gmdopdtg.sql 120.1 2005/06/09 05:18:16 appldev  $ */
instead of delete on GMD_OPERATIONS_VL
referencing old as GMD_OPERATIONS
for each row
begin
  GMD_OPERATIONS_PKG.DELETE_ROW(
    X_OPRN_ID => :GMD_OPERATIONS.OPRN_ID);
end DELETE_ROW;


/
ALTER TRIGGER "APPS"."GMD_OPERATIONS_DL" ENABLE;
