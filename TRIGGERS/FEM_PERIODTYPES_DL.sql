--------------------------------------------------------
--  DDL for Trigger FEM_PERIODTYPES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_PERIODTYPES_DL" 
instead of delete on FEM_PERIODTYPES_VL
referencing old as FEM_PERIODTYPES_B
for each row
begin
  FEM_PERIODTYPES_PKG.DELETE_ROW(
    X_PERIOD_TYPE_CODE => :FEM_PERIODTYPES_B.PERIOD_TYPE_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_PERIODTYPES_DL" ENABLE;
