--------------------------------------------------------
--  DDL for Trigger FEM_STUDSCHL_YR_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_STUDSCHL_YR_DL" 
instead of delete on FEM_STUDSCHL_YR_VL
referencing old as FEM_STUDSCHL_YR_B
for each row
begin
  FEM_STUDSCHL_YR_PKG.DELETE_ROW(
    X_STUDENT_YR_IN_SCHOOL_CODE => :FEM_STUDSCHL_YR_B.STUDENT_YR_IN_SCHOOL_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_STUDSCHL_YR_DL" ENABLE;
