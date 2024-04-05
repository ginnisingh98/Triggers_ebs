--------------------------------------------------------
--  DDL for Trigger FEM_GEOGRAPHY_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_GEOGRAPHY_DL" 
instead of delete on FEM_GEOGRAPHY_VL
referencing old as FEM_GEOGRAPHY_B
for each row
begin
  FEM_GEOGRAPHY_PKG.DELETE_ROW(
    X_GEOGRAPHY_ID => :FEM_GEOGRAPHY_B.GEOGRAPHY_ID,
    X_VALUE_SET_ID => :FEM_GEOGRAPHY_B.VALUE_SET_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_GEOGRAPHY_DL" ENABLE;
