--------------------------------------------------------
--  DDL for Trigger FEM_OUTINFO_SRC_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_OUTINFO_SRC_DL" 
instead of delete on FEM_OUTINFO_SRC_VL
referencing old as FEM_OUTINFO_SRC_B
for each row
begin
  FEM_OUTINFO_SRC_PKG.DELETE_ROW(
    X_OUTSIDE_INFO_SOURCE_CODE => :FEM_OUTINFO_SRC_B.OUTSIDE_INFO_SOURCE_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_OUTINFO_SRC_DL" ENABLE;
