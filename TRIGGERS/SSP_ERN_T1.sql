--------------------------------------------------------
--  DDL for Trigger SSP_ERN_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."SSP_ERN_T1" 
AFTER UPDATE
OF AVERAGE_EARNINGS_AMOUNT
ON "SSP"."SSP_EARNINGS_CALCULATIONS"
FOR EACH ROW
    WHEN (
old.average_earnings_amount <> new.average_earnings_amount
) DECLARE
BEGIN
if hr_general.g_data_migrator_mode <> 'Y' then
 if ssp_ssp_pkg.ssp_is_installed
  then
    if
       -- the change in amount crosses the NI LEL boundary
       ((:old.average_earnings_amount
                   < ssp_smp_support_pkg.NI_lower_earnings_limit (:old.effective_date)
           and :new.average_earnings_amount
                         >= ssp_smp_support_pkg.NI_lower_earnings_limit (:new.effective_date))
      or  ((:old.average_earnings_amount
                        >= ssp_smp_support_pkg.NI_lower_earnings_limit (:old.effective_date)
           and :new.average_earnings_amount
                              < ssp_smp_support_pkg.NI_lower_earnings_limit
			      (:new.effective_date))))
    then

      -- Recalculate SSP only if the change will affect entitlement
      ssp_ssp_pkg.earnings_control (:new.person_id, :new.effective_date);

    end if;

    -- Recalculate SMP in all cases where the amount changes
    ssp_smp_pkg.earnings_control (:new.person_id, :new.effective_date);

  end if;
end if;
END;



/
ALTER TRIGGER "APPS"."SSP_ERN_T1" ENABLE;
