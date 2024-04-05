--------------------------------------------------------
--  DDL for Trigger IGI_RPI_COMPONENT_PERIODS_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."IGI_RPI_COMPONENT_PERIODS_T1" 
BEFORE  UPDATE  ON "IGI"."IGI_RPI_COMPONENT_PERIODS"
REFERENCING
 NEW AS NEW
 OLD AS OLD
FOR EACH ROW
Begin
   if :old.period_name <> :new.period_name then
      update igi_rpi_bill_charge_periods
      set    billing_period_name = :new.period_name
      where  billing_period_name = :old.period_name
      ;
      update igi_rpi_bill_charge_periods
      set    charge_period_name = :new.period_name
      where  charge_period_name = :old.period_name
      ;

   else
      null;
   end if;
End;


/
ALTER TRIGGER "APPS"."IGI_RPI_COMPONENT_PERIODS_T1" ENABLE;
