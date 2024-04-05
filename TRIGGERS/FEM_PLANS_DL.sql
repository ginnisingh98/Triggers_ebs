--------------------------------------------------------
--  DDL for Trigger FEM_PLANS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_PLANS_DL" 
instead of delete on FEM_PLANS_VL
referencing old as FEM_PLANS_B
for each row
begin
  FEM_PLANS_PKG.DELETE_ROW(
    X_PLAN_CODE => :FEM_PLANS_B.PLAN_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_PLANS_DL" ENABLE;
