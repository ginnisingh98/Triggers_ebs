--------------------------------------------------------
--  DDL for Trigger FEM_INTPAYMTHDS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_INTPAYMTHDS_DL" 
instead of delete on FEM_INTPAYMTHDS_VL
referencing old as FEM_INTPAYMTHDS_B
for each row
begin
  FEM_INTPAYMTHDS_PKG.DELETE_ROW(
    X_INT_PAYMENT_METHOD_CODE => :FEM_INTPAYMTHDS_B.INT_PAYMENT_METHOD_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_INTPAYMTHDS_DL" ENABLE;
