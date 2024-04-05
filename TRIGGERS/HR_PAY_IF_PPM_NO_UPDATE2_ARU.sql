--------------------------------------------------------
--  DDL for Trigger HR_PAY_IF_PPM_NO_UPDATE2_ARU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."HR_PAY_IF_PPM_NO_UPDATE2_ARU" after update
on "HR"."PAY_PERSONAL_PAYMENT_METHODS_F" for each row
declare
  /* declare the cursors */
  CURSOR csr_get_event_id IS
  SELECT event_id
  FROM pay_trigger_events
  WHERE short_name = 'HR_PAY_IF_PPM_NO_UPDATE2_ARU';
  --
  CURSOR csr_get_payroll_id IS
  SELECT aa.payroll_id
  FROM per_all_assignments_f aa
  WHERE
  :old.assignment_id = aa.assignment_id        AND
  nvl(HR_PAY_INTERFACE_PKG.g_payroll_extract_date, sysdate) >= aa.effective_start_date AND
  nvl(HR_PAY_INTERFACE_PKG.g_payroll_extract_date, sysdate) <= aa.effective_end_date;
  --
  CURSOR csr_get_old_segments IS
  SELECT ea.segment3, ea.segment2, ea.segment4
  FROM pay_external_accounts ea
  WHERE :old.external_account_id = ea.external_account_id;
  --
  CURSOR csr_get_new_segments IS
  SELECT ea.segment3, ea.segment2, ea.segment4
  FROM pay_external_accounts ea
  WHERE :new.external_account_id = ea.external_account_id;
  --
  /*  Establish whether PPM being deleted is of type 'NACHA'  */
  CURSOR csr_ppm_type_check IS
  SELECT
       1
  FROM
       PAY_ORG_PAYMENT_METHODS_F pop,
       PAY_PAYMENT_TYPES ppt
  WHERE
       :old.ORG_PAYMENT_METHOD_ID = pop.ORG_PAYMENT_METHOD_ID AND
       pop.payment_type_id = ppt.payment_type_id AND
       ppt.category = 'MT' AND
       ppt.territory_code = 'US';
--
l_event_id   NUMBER;
l_business_group_id NUMBER;
l_legislation_code VARCHAR2(10);
l_payroll_id NUMBER;
l_account_number_old VARCHAR2(60);
l_account_type_old VARCHAR2(60);
l_transit_code_old VARCHAR2(60);
l_account_number_new VARCHAR2(60);
l_account_type_new VARCHAR2(60);
l_transit_code_new VARCHAR2(60);
l_nacha NUMBER;
begin
/* Check whether PPM is of 'NACHA' type */
  OPEN csr_ppm_type_check;
  FETCH csr_ppm_type_check INTO l_nacha;
  IF csr_ppm_type_check%FOUND THEN
  IF HR_GENERAL.g_data_migrator_mode <> 'Y' THEN
    /* Initialise the variables to ensure the triggers work */
    --
    l_business_group_id := :new.business_group_id;
    --
    IF l_business_group_id IS NULL THEN
         return;
    END IF;
    --
    l_legislation_code := pay_core_utils.get_legislation_code(
            p_bg_id                        => l_business_group_id
    );
    --
    /* Is the trigger in an enabled functional area */
    OPEN csr_get_event_id;
    FETCH csr_get_event_id INTO l_event_id;
    CLOSE csr_get_event_id ;
    --
    OPEN csr_get_payroll_id;
    FETCH csr_get_payroll_id INTO l_payroll_id;
    CLOSE csr_get_payroll_id;
    --
    IF paywsfgt_pkg.trigger_is_not_enabled(
      p_event_id          => l_event_id,
      p_legislation_code  => l_legislation_code,
      p_business_group_id => l_business_group_id,
      p_payroll_id        => l_payroll_id
    ) THEN
      RETURN;
    END IF;
    --
    OPEN csr_get_old_segments;
    FETCH csr_get_old_segments
    INTO l_account_number_old, l_account_type_old, l_transit_code_old;
    CLOSE csr_get_old_segments;
    --
    OPEN csr_get_new_segments;
    FETCH csr_get_new_segments
    INTO l_account_number_new, l_account_type_new, l_transit_code_new;
    CLOSE csr_get_new_segments;
    --
    /* If the procedure hasn't exited at this point, run the trigger code*/
    --
    IF (l_account_number_old <> l_account_number_new) OR
                                          /*Check account number not updated*/
       (l_account_type_old <> l_account_type_new) OR
                                          /* Check account type not updated */
       (l_transit_code_old <> l_transit_code_new)
                                          /* Check transit code not updated */
       THEN
	hr_utility.set_message
        (800, 'PER_PPM_AC_DIS_UPDATE');
        hr_utility.raise_error;
     END IF;
   END IF;
END IF;
  CLOSE csr_ppm_type_check;
End hr_pay_if_ppm_no_update2_aru;


/
ALTER TRIGGER "APPS"."HR_PAY_IF_PPM_NO_UPDATE2_ARU" ENABLE;
