--------------------------------------------------------
--  DDL for Trigger FEM_OCCUPATIONS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_OCCUPATIONS_DL" 
instead of delete on FEM_OCCUPATIONS_VL
referencing old as FEM_OCCUPATIONS_B
for each row
begin
  FEM_OCCUPATIONS_PKG.DELETE_ROW(
    X_OCCUPATION_CODE => :FEM_OCCUPATIONS_B.OCCUPATION_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_OCCUPATIONS_DL" ENABLE;
