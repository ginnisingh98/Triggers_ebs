--------------------------------------------------------
--  DDL for Trigger FEM_TIME_GROUP_TYPES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_TIME_GROUP_TYPES_DL" 
instead of delete on FEM_TIME_GROUP_TYPES_VL
referencing old as FEM_TIME_GROUP_TYPES_B
for each row
begin
  FEM_TIME_GROUP_TYPES_PKG.DELETE_ROW(
    X_TIME_GROUP_TYPE_CODE => :FEM_TIME_GROUP_TYPES_B.TIME_GROUP_TYPE_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_TIME_GROUP_TYPES_DL" ENABLE;
