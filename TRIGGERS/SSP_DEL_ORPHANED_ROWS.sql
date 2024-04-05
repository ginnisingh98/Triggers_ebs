--------------------------------------------------------
--  DDL for Trigger SSP_DEL_ORPHANED_ROWS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."SSP_DEL_ORPHANED_ROWS" 
   before delete
   on     "HR"."PER_ABSENCE_ATTENDANCES"
   for each row

begin
if hr_general.g_data_migrator_mode <> 'Y' then
--
  if :old.maternity_id is null then
--
   hr_utility.set_location('ssp_del_orphaned_rows',1);
   delete from ssp_stoppages
   where absence_attendance_id = :old.absence_attendance_id;
--
   hr_utility.set_location('ssp_del_orphaned_rows',2);
   delete from ssp_medicals
   where absence_attendance_id = :old.absence_attendance_id;
--
   hr_utility.set_location('ssp_del_orphaned_rows',3);
  end if;
end if;
end ssp_del_orphaned_rows;


/
ALTER TRIGGER "APPS"."SSP_DEL_ORPHANED_ROWS" ENABLE;
