--------------------------------------------------------
--  DDL for Trigger FEM_CAL_PERIODS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_CAL_PERIODS_DL" 
instead of delete on FEM_CAL_PERIODS_VL
referencing old as FEM_CAL_PERIODS_B
for each row
begin
  FEM_CAL_PERIODS_PKG.DELETE_ROW(
    X_CAL_PERIOD_ID => :FEM_CAL_PERIODS_B.CAL_PERIOD_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_CAL_PERIODS_DL" ENABLE;
