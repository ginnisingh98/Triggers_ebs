--------------------------------------------------------
--  DDL for Trigger GMO_INSTR_DEFN_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMO_INSTR_DEFN_DL" 
/* $Header: GMOINDDT.sql 120.0 2005/06/29 04:23 shthakke noship $ */

instead of delete on GMO_INSTR_DEFN_VL
referencing old as GMO_INSTR_DEFN_B
for each row
begin
  GMO_INSTR_DEFN_PKG.DELETE_ROW(
    X_INSTRUCTION_ID => :GMO_INSTR_DEFN_B.INSTRUCTION_ID);
end DELETE_ROW;


/
ALTER TRIGGER "APPS"."GMO_INSTR_DEFN_DL" ENABLE;
