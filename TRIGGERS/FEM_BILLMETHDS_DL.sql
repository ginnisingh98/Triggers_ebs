--------------------------------------------------------
--  DDL for Trigger FEM_BILLMETHDS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_BILLMETHDS_DL" 
instead of delete on FEM_BILLMETHDS_VL
referencing old as FEM_BILLMETHDS_B
for each row
begin
  FEM_BILLMETHDS_PKG.DELETE_ROW(
    X_BILLING_METHOD_CODE => :FEM_BILLMETHDS_B.BILLING_METHOD_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_BILLMETHDS_DL" ENABLE;
