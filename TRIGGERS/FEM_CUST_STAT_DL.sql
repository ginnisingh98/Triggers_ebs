--------------------------------------------------------
--  DDL for Trigger FEM_CUST_STAT_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_CUST_STAT_DL" 
instead of delete on FEM_CUST_STAT_VL
referencing old as FEM_CUST_STAT_B
for each row
begin
  FEM_CUST_STAT_PKG.DELETE_ROW(
    X_CUSTOMER_STATUS_ID => :FEM_CUST_STAT_B.CUSTOMER_STATUS_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_CUST_STAT_DL" ENABLE;
