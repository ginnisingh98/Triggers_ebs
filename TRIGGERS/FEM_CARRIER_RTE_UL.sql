--------------------------------------------------------
--  DDL for Trigger FEM_CARRIER_RTE_UL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_CARRIER_RTE_UL" 
instead of update on FEM_CARRIER_RTE_VL
referencing new as FEM_CARRIER_RTE_B
for each row
begin
  FEM_CARRIER_RTE_PKG.UPDATE_ROW(
    X_CARRIER_ROUTE_CODE => :FEM_CARRIER_RTE_B.CARRIER_ROUTE_CODE,
    X_ENABLED_FLAG => :FEM_CARRIER_RTE_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_CARRIER_RTE_B.PERSONAL_FLAG,
    X_READ_ONLY_FLAG => :FEM_CARRIER_RTE_B.READ_ONLY_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_CARRIER_RTE_B.OBJECT_VERSION_NUMBER,
    X_CARRIER_ROUTE_NAME => :FEM_CARRIER_RTE_B.CARRIER_ROUTE_NAME,
    X_DESCRIPTION => :FEM_CARRIER_RTE_B.DESCRIPTION,
    X_LAST_UPDATE_DATE => :FEM_CARRIER_RTE_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_CARRIER_RTE_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_CARRIER_RTE_B.LAST_UPDATE_LOGIN);
 ---
end UPDATE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_CARRIER_RTE_UL" ENABLE;
