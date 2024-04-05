--------------------------------------------------------
--  DDL for Trigger FEM_ROLLOVER_FAC_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_ROLLOVER_FAC_DL" 
instead of delete on FEM_ROLLOVER_FAC_VL
referencing old as FEM_ROLLOVER_FAC_B
for each row
begin
  FEM_ROLLOVER_FAC_PKG.DELETE_ROW(
    X_ROLL_FACILITY_ID => :FEM_ROLLOVER_FAC_B.ROLL_FACILITY_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_ROLLOVER_FAC_DL" ENABLE;
