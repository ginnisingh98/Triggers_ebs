--------------------------------------------------------
--  DDL for Trigger FEM_DIMENSION_GRPS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_DIMENSION_GRPS_DL" 
instead of delete on FEM_DIMENSION_GRPS_VL
referencing old as DIMENSION_GROUP
for each row
begin
  FEM_DIMENSION_GRPS_PKG.DELETE_ROW(
    X_DIMENSION_GROUP_ID => :DIMENSION_GROUP.DIMENSION_GROUP_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_DIMENSION_GRPS_DL" ENABLE;
