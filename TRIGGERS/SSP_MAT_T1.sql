--------------------------------------------------------
--  DDL for Trigger SSP_MAT_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."SSP_MAT_T1" 
AFTER DELETE
OR UPDATE
OF ACTUAL_BIRTH_DATE
,  DUE_DATE
,  LIVE_BIRTH_FLAG
,  MPP_START_DATE
,  NOTIFICATION_OF_BIRTH_DATE
,  PAY_SMP_AS_LUMP_SUM
,  START_DATE_WITH_NEW_EMPLOYER
ON "SSP"."SSP_MATERNITIES"
FOR EACH ROW
DECLARE
  l_temp date;
  l_max_period date;
BEGIN
  if ssp_ssp_pkg.ssp_is_installed then
    l_temp := sysdate;
    if (nvl(:new.stated_return_date,l_temp) <> nvl(:old.stated_return_date,l_temp)) then
      l_max_period := ssp_smp_pkg.get_max_SMP_date(:old.maternity_id,:new.due_date,:new.mpp_start_date);
      if (:old.stated_return_date is null and :new.stated_return_date is not null) OR
         (:old.stated_return_date is not null and :new.stated_return_date is not null) then
         if :new.stated_return_date <= l_max_period then
            ssp_smp_pkg.maternity_control (:old.maternity_id);
         end if;
      end if;
    end if;
    if (:old.due_date <> :new.due_date OR
        nvl(:old.start_date_maternity_allowance,l_temp) <> nvl(:new.start_date_maternity_allowance,l_temp) OR
        nvl(:old.notification_of_birth_date,l_temp) <> nvl(:new.notification_of_birth_date,l_temp) OR
        :old.unfit_for_scheduled_return <> :new.unfit_for_scheduled_return OR
        :old.intend_to_return_flag  <> :new.intend_to_return_flag OR
        nvl(:old.start_date_with_new_employer,l_temp) <> nvl(:new.start_date_with_new_employer,l_temp) OR
        nvl(:old.smp_must_be_paid_by_date,l_temp) <> nvl(:new.smp_must_be_paid_by_date,l_temp) OR
        :old.pay_smp_as_lump_sum <> :new.pay_smp_as_lump_sum OR
        :old.live_birth_flag <> :new.live_birth_flag OR
        nvl(:old.actual_birth_date,l_temp) <> nvl(:new.actual_birth_date,l_temp) OR
        nvl(:old.mpp_start_date,l_temp) <> nvl(:new.mpp_start_date,l_temp) OR
        nvl(:old.LEAVE_TYPE,' ') <> nvl(:new.LEAVE_TYPE,' ') OR
        nvl(:old.MATCHING_DATE,l_temp) <> nvl(:new.MATCHING_DATE,l_temp) OR
        nvl(:old.PLACEMENT_DATE,l_temp) <> nvl(:new.PLACEMENT_DATE,l_temp)  OR
        nvl(:old.DISRUPTED_PLACEMENT_DATE,l_temp) <> nvl(:new.DISRUPTED_PLACEMENT_DATE,l_temp)) then
      ssp_smp_pkg.maternity_control (:old.maternity_id);
    end if;
  end if;
END;


/
ALTER TRIGGER "APPS"."SSP_MAT_T1" ENABLE;
