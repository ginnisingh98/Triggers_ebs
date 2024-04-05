--------------------------------------------------------
--  DDL for Trigger WMS_WP_PLANNING_CRITERIA_IL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."WMS_WP_PLANNING_CRITERIA_IL" 
 

instead of insert on WMS_WP_PLANNING_CRITERIA_VL
referencing new as PW_BLK
for each row
declare
  row_id rowid;
begin
  WMS_WP_PLANNING_CRITERIA_PKG.INSERT_ROW(
    X_ROWID => ROW_ID,
    X_PLANNING_CRITERIA_ID => :PW_BLK.PLANNING_CRITERIA_ID,
    X_LABOR_SETUP_MODE => :PW_BLK.LABOR_SETUP_MODE,
    X_PLANNING_METHOD => :PW_BLK.PLANNING_METHOD,
    X_TYPE => :PW_BLK.TYPE,
    X_BACKORDER_FLAG => :PW_BLK.BACKORDER_FLAG,
    X_REJECT_ORDER_LINE_FLAG => :PW_BLK.REJECT_ORDER_LINE_FLAG,
    X_REJECT_ALL_LINES_SHIPSET_FLA => :PW_BLK.REJECT_ALL_LINES_SHIPSET_FLAG,
    X_REJECT_ALL_LINES_MODEL_FLAG => :PW_BLK.REJECT_ALL_LINES_MODEL_FLAG,
    X_REJECT_ORDER_FLAG => :PW_BLK.REJECT_ORDER_FLAG,
    X_RESERVE_STOCK_FLAG => :PW_BLK.RESERVE_STOCK_FLAG,
    X_AUTO_CREATE_DELIVERIES_FLAG => :PW_BLK.AUTO_CREATE_DELIVERIES_FLAG,
    X_CREDIT_CHECK_HOLD_FLAG => :PW_BLK.CREDIT_CHECK_HOLD_FLAG,
    X_PICKING_SUBINVENTORY => :PW_BLK.PICKING_SUBINVENTORY,
    X_DESTINATION_SUBINVENTORY => :PW_BLK.DESTINATION_SUBINVENTORY,
    X_BULK_LABOR_PLANNING_FLAG => :PW_BLK.BULK_LABOR_PLANNING_FLAG,
    X_TIME_UOM => :PW_BLK.TIME_UOM,
    X_DEPARTMENT_CODE => :PW_BLK.DEPARTMENT_CODE,
    X_DEPARTMENT_ID => :PW_BLK.DEPARTMENT_ID,
    X_ENABLE_LABOR_PLANNING => :PW_BLK.ENABLE_LABOR_PLANNING,
    X_CROSSDOCK_CRITERIA => :PW_BLK.CROSSDOCK_CRITERIA,
    X_CROSSDOCK_CRITERIA_ID => :PW_BLK.CROSSDOCK_CRITERIA_ID,
    X_ALLOCATION_METHOD => :PW_BLK.ALLOCATION_METHOD,
    X_PLANNING_CRITERIA => :PW_BLK.PLANNING_CRITERIA,
    X_CREATION_DATE => :PW_BLK.CREATION_DATE,
    X_CREATED_BY => :PW_BLK.CREATED_BY,
    X_LAST_UPDATE_DATE => :PW_BLK.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :PW_BLK.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :PW_BLK.LAST_UPDATE_LOGIN);
end INSERT_ROW;

   

/
ALTER TRIGGER "APPS"."WMS_WP_PLANNING_CRITERIA_IL" ENABLE;
