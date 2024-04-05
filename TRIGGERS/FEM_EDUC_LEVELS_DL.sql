--------------------------------------------------------
--  DDL for Trigger FEM_EDUC_LEVELS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_EDUC_LEVELS_DL" 
instead of delete on FEM_EDUC_LEVELS_VL
referencing old as FEM_EDUC_LEVELS_B
for each row
begin
  FEM_EDUC_LEVELS_PKG.DELETE_ROW(
    X_EDUCATION_LEVEL_CODE => :FEM_EDUC_LEVELS_B.EDUCATION_LEVEL_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_EDUC_LEVELS_DL" ENABLE;
