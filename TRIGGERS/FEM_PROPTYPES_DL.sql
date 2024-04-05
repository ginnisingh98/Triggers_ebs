--------------------------------------------------------
--  DDL for Trigger FEM_PROPTYPES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_PROPTYPES_DL" 
instead of delete on FEM_PROPTYPES_VL
referencing old as FEM_PROPTYPES_B
for each row
begin
  FEM_PROPTYPES_PKG.DELETE_ROW(
    X_PROPERTY_TYPE_CODE => :FEM_PROPTYPES_B.PROPERTY_TYPE_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_PROPTYPES_DL" ENABLE;
