--------------------------------------------------------
--  DDL for Trigger IGI_RPI_PERIOD_SCHEDULES_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."IGI_RPI_PERIOD_SCHEDULES_T1" 
BEFORE  INSERT  ON "IGI"."IGI_RPI_PERIOD_SCHEDULES"
REFERENCING
 NEW AS NEW
 OLD AS OLD
FOR EACH ROW
Begin
  declare
     cursor c_exists is
        select 'x'
        from   igi_rpi_period_schedules
        where  :new.period_name = period_name
        ;
     lv_mesg VARCHAR2(2000);
  begin
     for l_exists in c_exists loop
         fnd_message.set_name( 'IGI', 'IGI_AR_RPI_SCHEDULES_EXIST');
         lv_mesg := fnd_message.get;
         raise_application_error ( -20000, lv_mesg );
     end loop
     ;

     update igi_rpi_component_periods
     set    schedule_id = :new.schedule_id
     where    period_name = :new.period_name
     ;
  end;
End;


/
ALTER TRIGGER "APPS"."IGI_RPI_PERIOD_SCHEDULES_T1" ENABLE;
