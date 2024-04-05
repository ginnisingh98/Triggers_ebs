--------------------------------------------------------
--  DDL for Trigger GMD_ACTIVITIES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMD_ACTIVITIES_DL" 
/* $Header: gmdatdtg.sql 120.1 2005/06/09 05:06:42 appldev  $ */
instead of delete on GMD_ACTIVITIES_VL
referencing old as FM_ACTV_MST
for each row
begin
  GMD_ACTIVITIES_PKG.DELETE_ROW(
    X_ACTIVITY => :FM_ACTV_MST.ACTIVITY);
end DELETE_ROW;


/
ALTER TRIGGER "APPS"."GMD_ACTIVITIES_DL" ENABLE;
