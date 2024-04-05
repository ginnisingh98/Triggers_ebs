--------------------------------------------------------
--  DDL for Trigger CM_CLDR_HDR_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CM_CLDR_HDR_DL" 
/* $Header: gmfcldtg.sql 120.1 2005/06/17 13:58:08 appldev  $ */
INSTEAD OF DELETE ON CM_CLDR_HDR_VL
REFERENCING OLD AS CM_CLDR_HDR
FOR EACH ROW
BEGIN
  CM_CLDR_HDR_PKG.DELETE_ROW(
    X_CALENDAR_CODE => :CM_CLDR_HDR.CALENDAR_CODE);
END DELETE_ROW;


/
ALTER TRIGGER "APPS"."CM_CLDR_HDR_DL" ENABLE;
