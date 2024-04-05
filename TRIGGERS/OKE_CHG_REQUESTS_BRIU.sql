--------------------------------------------------------
--  DDL for Trigger OKE_CHG_REQUESTS_BRIU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."OKE_CHG_REQUESTS_BRIU" 
/* $Header: OKETCRQ1.sql 115.7 2002/12/02 21:04:12 alaw ship $ */
BEFORE INSERT OR UPDATE ON "OKE"."OKE_CHG_REQUESTS"
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
   WHEN ( NVL( OLD.CHG_STATUS_CODE , '@' ) <> NVL( NEW.CHG_STATUS_CODE , '@' )
     ) BEGIN

  OKE_CHG_REQ_UTILS.Status_Change
  ( 'TRIGGER'
  , :NEW.K_Header_ID
  , :NEW.Chg_Request_ID
  , :NEW.Chg_Request_Num
  , :NEW.Requested_By_Person_ID
  , :NEW.Effective_Date
  , :OLD.Chg_Status_Code
  , :NEW.Chg_Status_Code
  , :NEW.Chg_Type_Code
  , :NEW.Chg_Reason_Code
  , :NEW.Impact_Funding_Flag
  , :NEW.Description
  , :NEW.Chg_Text
  , :NEW.Last_Updated_By
  , :NEW.Last_Update_Date
  , :NEW.Last_Update_Login
  , :NEW.Last_Chg_Log_ID
  , :NEW.Approve_Date
  , :NEW.Implement_Date
  );

END;



/
ALTER TRIGGER "APPS"."OKE_CHG_REQUESTS_BRIU" ENABLE;
