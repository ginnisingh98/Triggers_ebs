--------------------------------------------------------
--  DDL for Trigger GMO_INSTR_TASK_ATTR_COLS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMO_INSTR_TASK_ATTR_COLS_DL" 
/* $Header: GMOTSADT.sql 120.0 2005/06/29 04:25 shthakke noship $ */

instead of delete on GMO_INSTR_TASK_ATTR_COLS_VL
referencing old as GMO_INSTR_TASK_ATTR_COLS_B
for each row
begin
  GMO_INSTR_TASK_ATTR_COLS_PKG.DELETE_ROW(
    X_ATTR_COL_SEQ => :GMO_INSTR_TASK_ATTR_COLS_B.ATTR_COL_SEQ);
end DELETE_ROW;


/
ALTER TRIGGER "APPS"."GMO_INSTR_TASK_ATTR_COLS_DL" ENABLE;
