--------------------------------------------------------
--  DDL for Trigger IGI_MPP_AP_INVOICE_DISTS_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."IGI_MPP_AP_INVOICE_DISTS_T1" 
BEFORE  INSERT  ON "IGI"."IGI_MPP_AP_INVOICE_DISTS"
REFERENCING
 NEW AS NEW
 OLD AS OLD
FOR EACH ROW
Begin
 declare
     function IsRecognized ( fp_invoice_id in number
                           , fp_distribution_line_num in number
                           )
     return boolean
     is
          cursor c_exists is
            select 'x'
            from   igi_mpp_ap_invoice_dists_det
            where  invoice_id = fp_invoice_id
            and    distribution_line_number =
                   fp_distribution_line_num
            and    nvl(expense_recognized_flag,'N') = 'Y'
            UNION
            select 'x'
            from   igi_mpp_subledger
            where  invoice_id = fp_invoice_id
            and    distribution_line_number =
                   fp_distribution_line_num
            and    nvl(expense_recognized_flag,'N') = 'Y'
            ;
     begin
        for l_exists in C_exists loop
            return TRUE;
        end loop;
        return FALSE;
     exception when others then
        return FALSE;
     end IsRecognized;
 Begin
    IF NOT isRecognized ( :new.invoice_id, :new.distribution_line_number)
    THEN
      IGIPMSMD.Create_MPP_details
         ( :new.invoice_id,
           :new.distribution_line_number,
           :new.accounting_rule_id,
           :new.start_date,
           :new.duration
         );
       IGIPMSLR.Create_MPPSLR_Details
         ( :new.invoice_id
         , :new.distribution_line_number
         )  ;
    END IF;
 End;
End;



/
ALTER TRIGGER "APPS"."IGI_MPP_AP_INVOICE_DISTS_T1" DISABLE;
