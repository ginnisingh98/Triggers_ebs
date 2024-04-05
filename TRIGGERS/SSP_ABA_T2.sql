--------------------------------------------------------
--  DDL for Trigger SSP_ABA_T2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."SSP_ABA_T2" 
AFTER INSERT OR DELETE OR UPDATE
OF ACCEPT_LATE_NOTIFICATION_FLAG
,  DATE_END
,  DATE_NOTIFICATION
,  DATE_START
,  PREGNANCY_RELATED_ILLNESS
,  SICKNESS_END_DATE
,  SICKNESS_START_DATE
ON "HR"."PER_ABSENCE_ATTENDANCES"
FOR EACH ROW
DECLARE
  l_max_period date;
  l_temp       date;
BEGIN
if hr_general.g_data_migrator_mode <> 'Y' then
  if ssp_ssp_pkg.ssp_is_installed then
     if nvl (:old.sickness_start_date, :new.sickness_start_date) is not null
     then
         ssp_ssp_pkg.absence_control (
                p_absence_attendance_id => nvl (:new.absence_attendance_id,:old.absence_attendance_id),
                p_linked_absence_id => nvl (:new.linked_absence_id,:old.linked_absence_id),
                p_sickness_start_date => nvl (:new.sickness_start_date,:old.sickness_start_date),
                p_person_id => nvl (:new.person_id, :old.person_id),
                p_deleting => (deleting));
     elsif nvl (:new.maternity_id, :old.maternity_id) is not null then
        if UPDATING then  /* begin bug 5105039 */
           l_temp := sysdate;
           if (nvl(:new.date_start,l_temp) <> nvl(:old.date_start,l_temp)) then
              ssp_smp_pkg.absence_control (nvl(:new.maternity_id, :old.maternity_id),p_deleting => (deleting));
           elsif nvl(:old.date_end,l_temp) <> nvl(:new.date_end,l_temp) then
              l_max_period := ssp_smp_pkg.get_max_SMP_date(nvl(:new.maternity_id, :old.maternity_id));
              if (:old.date_end is null and :new.date_end is not null) or
                 (:old.date_end is not null and :new.date_end is not null) then
                 if :new.date_end <= l_max_period then
                    ssp_smp_pkg.absence_control(nvl(:new.maternity_id, :old.maternity_id),p_deleting => (deleting));
                 end if;
              elsif :old.date_end is not null and :new.date_end is null then
                 if :old.date_end <= l_max_period then
                    ssp_smp_pkg.absence_control(nvl(:new.maternity_id, :old.maternity_id),p_deleting => (deleting));
                 end if;
              end if;
           end if;
        else /* end bug 5105039 */
           ssp_smp_pkg.absence_control(nvl(:new.maternity_id, :old.maternity_id),p_deleting => (deleting));
        end if;
     end if;
  end if;
end if;
END;

/
ALTER TRIGGER "APPS"."SSP_ABA_T2" ENABLE;
