--------------------------------------------------------
--  DDL for Trigger WMS_WP_PLANNING_CRITERIA_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."WMS_WP_PLANNING_CRITERIA_DL" 
 

instead of delete on WMS_WP_PLANNING_CRITERIA_VL
referencing old as PW_BLK
for each row
begin
  WMS_WP_PLANNING_CRITERIA_PKG.DELETE_ROW(
    X_PLANNING_CRITERIA_ID => :PW_BLK.PLANNING_CRITERIA_ID);
end DELETE_ROW;

   

/
ALTER TRIGGER "APPS"."WMS_WP_PLANNING_CRITERIA_DL" ENABLE;
