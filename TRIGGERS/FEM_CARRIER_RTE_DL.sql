--------------------------------------------------------
--  DDL for Trigger FEM_CARRIER_RTE_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_CARRIER_RTE_DL" 
instead of delete on FEM_CARRIER_RTE_VL
referencing old as FEM_CARRIER_RTE_B
for each row
begin
  FEM_CARRIER_RTE_PKG.DELETE_ROW(
    X_CARRIER_ROUTE_CODE => :FEM_CARRIER_RTE_B.CARRIER_ROUTE_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_CARRIER_RTE_DL" ENABLE;
