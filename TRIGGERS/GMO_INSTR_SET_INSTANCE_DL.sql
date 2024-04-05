--------------------------------------------------------
--  DDL for Trigger GMO_INSTR_SET_INSTANCE_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMO_INSTR_SET_INSTANCE_DL" 
/* $Header: GMOINTDT.sql 120.0 2005/06/29 04:22 shthakke noship $ */

instead of delete on GMO_INSTR_SET_INSTANCE_VL
referencing old as GMO_INSTR_SET_INSTANCE_B
for each row
begin
  GMO_INSTR_SET_INSTANCE_PKG.DELETE_ROW(
    X_INSTRUCTION_SET_ID => :GMO_INSTR_SET_INSTANCE_B.INSTRUCTION_SET_ID);
end DELETE_ROW;


/
ALTER TRIGGER "APPS"."GMO_INSTR_SET_INSTANCE_DL" ENABLE;
