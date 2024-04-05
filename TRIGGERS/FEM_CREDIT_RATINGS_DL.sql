--------------------------------------------------------
--  DDL for Trigger FEM_CREDIT_RATINGS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_CREDIT_RATINGS_DL" 
instead of delete on FEM_CREDIT_RATINGS_VL
referencing old as FEM_CREDIT_RATINGS_B
for each row
begin
  FEM_CREDIT_RATINGS_PKG.DELETE_ROW(
    X_CREDIT_RATING_ID => :FEM_CREDIT_RATINGS_B.CREDIT_RATING_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_CREDIT_RATINGS_DL" ENABLE;
