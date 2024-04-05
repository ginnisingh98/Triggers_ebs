--------------------------------------------------------
--  DDL for Trigger XTR_BI_DEALS_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_BI_DEALS_T" 
 BEFORE INSERT on "XTR"."XTR_DEALS"
 FOR EACH ROW
--
begin
--
NULL;  --RVALLAMS FX REARCH 28-SEP-2001
/*
xtr_debug_pkg.debug('Before XTR_BI_DEALS_T on:'||to_char(sysdate,'MM:DD:HH24:MI:SS'));
  if :NEW.FX_PD_DEAL_NO is NOT NULL then
     XTR_JOURNAL_PROCESS_P.UPDATE_JOURNALS(:NEW.FX_PD_DEAL_NO,
                                  1,
                                  :NEW.DEAL_TYPE);

     XTR_REVAL_PROCESS_P.Update_FX_Revals (
  			:NEW.fx_pd_deal_no,
  			1,
  			:NEW.deal_type);

  elsif :NEW.FX_RO_DEAL_NO is NOT NULL then
     XTR_JOURNAL_PROCESS_P.UPDATE_JOURNALS(:NEW.FX_RO_DEAL_NO,
                                  1,
                                  :NEW.DEAL_TYPE);
     XTR_REVAL_PROCESS_P.Update_FX_Revals (
  			:NEW.fx_ro_deal_no,
  			1,
  			:NEW.deal_type);
 end if;
xtr_debug_pkg.debug('After XTR_BI_DEALS_T on:'||to_char(sysdate,'MM:DD:HH24:MI:SS'));
*/
end;
/
ALTER TRIGGER "APPS"."XTR_BI_DEALS_T" ENABLE;
