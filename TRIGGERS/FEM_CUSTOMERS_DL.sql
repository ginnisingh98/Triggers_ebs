--------------------------------------------------------
--  DDL for Trigger FEM_CUSTOMERS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_CUSTOMERS_DL" 
instead of delete on FEM_CUSTOMERS_VL
referencing old as FEM_CUSTOMERS_B
for each row
begin
  FEM_CUSTOMERS_PKG.DELETE_ROW(
    X_CUSTOMER_ID => :FEM_CUSTOMERS_B.CUSTOMER_ID,
    X_VALUE_SET_ID => :FEM_CUSTOMERS_B.VALUE_SET_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_CUSTOMERS_DL" ENABLE;
