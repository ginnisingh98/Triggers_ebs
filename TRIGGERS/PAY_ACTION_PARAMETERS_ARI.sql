--------------------------------------------------------
--  DDL for Trigger PAY_ACTION_PARAMETERS_ARI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_ACTION_PARAMETERS_ARI" 
   AFTER INSERT
      ON "HR"."PAY_ACTION_PARAMETER_VALUES"
     FOR EACH ROW
BEGIN
  if hr_general.g_data_migrator_mode <> 'Y' then

   hr_utility.set_location('pay_action_parameters_ari',1);

   if (pay_action_parameters_pkg.check_act_param(:new.parameter_name)=false)
    then
      pay_core_utils.assert_condition(
             'pay_action_parameters_ari:1',
             1 = 2);
   end if;

   hr_utility.set_location('pay_action_parameters_ari',2);

  end if;
END pay_action_parameters_ari;


/
ALTER TRIGGER "APPS"."PAY_ACTION_PARAMETERS_ARI" ENABLE;
