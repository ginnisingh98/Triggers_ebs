--------------------------------------------------------
--  DDL for Trigger CM_CMPT_MST_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CM_CMPT_MST_DL" 
/* $Header: gmfccdtg.sql 120.1 2005/06/17 13:41:13 appldev  $ */
INSTEAD OF DELETE ON CM_CMPT_MST_VL
REFERENCING OLD AS CM_CMPT_MST
FOR EACH ROW
BEGIN
  CM_CMPT_MST_PKG.DELETE_ROW(
    X_COST_CMPNTCLS_ID => :CM_CMPT_MST.COST_CMPNTCLS_ID);
END DELETE_ROW;


/
ALTER TRIGGER "APPS"."CM_CMPT_MST_DL" ENABLE;
