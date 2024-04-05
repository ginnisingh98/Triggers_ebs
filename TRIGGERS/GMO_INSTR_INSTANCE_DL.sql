--------------------------------------------------------
--  DDL for Trigger GMO_INSTR_INSTANCE_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMO_INSTR_INSTANCE_DL" 
/* $Header: GMOINIDT.sql 120.1 2005/06/29 07:10 shthakke noship $ */

instead of delete on GMO_INSTR_INSTANCE_VL
referencing old as GMO_INSTR_INSTANCE_B
for each row
begin
  GMO_INSTR_INSTANCE_PKG.DELETE_ROW(
    X_INSTRUCTION_ID => :GMO_INSTR_INSTANCE_B.INSTRUCTION_ID);
end DELETE_ROW;


/
ALTER TRIGGER "APPS"."GMO_INSTR_INSTANCE_DL" ENABLE;
