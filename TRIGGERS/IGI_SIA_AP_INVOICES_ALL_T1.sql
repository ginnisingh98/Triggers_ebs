--------------------------------------------------------
--  DDL for Trigger IGI_SIA_AP_INVOICES_ALL_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."IGI_SIA_AP_INVOICES_ALL_T1" 
 AFTER UPDATE ON "AP"."AP_INVOICES_ALL"
 FOR EACH ROW
 DECLARE
  Cursor cur_get_core_hold_count(p_inv_id ap_holds.invoice_id%type)
  is
  select count(1)
  from ap_holds
  where invoice_id = p_inv_id
  and  hold_lookup_code <>'AWAIT_SEC_APP'
  And  release_lookup_code is null;

  Cursor cur_get_hold(p_inv_id ap_holds.invoice_id%type)
  is
  Select hold_lookup_code
  From   AP_HOLDS
  Where  invoice_id = p_inv_id
  And    release_lookup_code is null;

  Cursor cur_get_SIA_hold_count(p_inv_id ap_holds.invoice_id%type)
  is
  select count(1)
  from ap_holds
  where invoice_id = p_inv_id
  and hold_lookup_code = 'AWAIT_SEC_APP'
  And    release_lookup_code is null;

  l_cnt number;
  l_SapStatusFlag VARCHAR2(1);
  l_SapErrorNum   NUMBER;
  l_count number;
  l_hold_lookup_code AP_HOLDS.hold_lookup_code%TYPE := NULL;

  BEGIN
--Fixed GSCC Warnings
 l_cnt := 0;
 l_count := 0;

  IGI_GEN.get_option_status('SIA'
                            ,l_SapStatusFlag
                            ,l_SapErrorNum);
  IF (l_SapStatusFlag='Y' ) and (:new.cancelled_date is not null)
  and (:old.cancelled_date is NULL) then
  	  IGI_SIA.REVERSE_HOLDS(:new.invoice_id, :new.last_updated_by);
  END IF;

	-- Bug 3409394 Start --

    IF (l_SapStatusFlag='Y') THEN

	 OPEN cur_get_core_hold_count(:new.invoice_id);
 	 FETCH cur_get_core_hold_count into l_count;
	    if cur_get_core_hold_count%NOTFOUND then
	       l_count := 0;
            end if;
 	 CLOSE cur_get_core_hold_count;

	    if l_count <> 0 then

	       OPEN cur_get_hold(:new.invoice_id);
               LOOP
		FETCH cur_get_hold into l_hold_lookup_code;
        	EXIT when cur_get_hold%NOTFOUND;

        		if cur_get_hold%FOUND then
          			 if  l_hold_lookup_code = 'AWAIT_SEC_APP' then

				     DELETE from AP_HOLDS_ALL
					 WHERE invoice_id = :OLD.INVOICE_ID
				  	 AND Hold_Lookup_Code ='AWAIT_SEC_APP'
					 AND Release_Lookup_Code IS NULL;

       			     end if;
            		end if;

       	       END LOOP;
       	       CLOSE cur_get_hold;

	     elsif l_count =0 then

   		OPEN cur_get_SIA_hold_count(:new.invoice_id);
		FETCH cur_get_SIA_hold_count into l_cnt;
          	CLOSE cur_get_SIA_hold_count;

		     if l_cnt <> 0 then
			     IGI_SIA.SET_INVOICE_ID  (:NEW.INVOICE_ID,:NEW.LAST_UPDATED_BY,0);
   				 IGI_SIA.PROCESS_HOLDS;
       			 end if;
	     end if;
    END IF;
	-- Bug 3409394 End --
END;

/
ALTER TRIGGER "APPS"."IGI_SIA_AP_INVOICES_ALL_T1" ENABLE;
