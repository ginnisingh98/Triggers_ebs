--------------------------------------------------------
--  DDL for Trigger EDR_FWK_TEST_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."EDR_FWK_TEST_DL" 
/* $Header: EDRFTDTG.sql 120.0.12000000.1 2007/01/18 05:52:55 appldev ship $ */
instead of delete on EDR_FWK_TEST_VL
referencing old as EDR_FWK_TEST
for each row
begin
/************************************************
 ***  Instead of Trigger to delete a row from  **
 ***  EDR_FWK_TEST_VL this intern deletes rows **
 ***  from EDR_FWK_TEST_B and EDR_FWK_TEST_TL  **
 ************************************************/
  EDR_FWK_TEST_PKG.DELETE_ROW(
    X_FWK_TEST_ID => :EDR_FWK_TEST.FWK_TEST_ID);
end DELETE_ROW;


/
ALTER TRIGGER "APPS"."EDR_FWK_TEST_DL" ENABLE;
