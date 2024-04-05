--------------------------------------------------------
--  DDL for Trigger FEM_SCHOOLS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_SCHOOLS_DL" 
instead of delete on FEM_SCHOOLS_VL
referencing old as FEM_SCHOOLS_B
for each row
begin
  FEM_SCHOOLS_PKG.DELETE_ROW(
    X_SCHOOL_ID_CODE => :FEM_SCHOOLS_B.SCHOOL_ID_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_SCHOOLS_DL" ENABLE;
