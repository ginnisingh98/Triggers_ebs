--------------------------------------------------------
--  DDL for Trigger HR_PAY_IF_ELE_ENT_BRD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."HR_PAY_IF_ELE_ENT_BRD" BEFORE DELETE
on "HR"."PAY_ELEMENT_ENTRIES_F"
FOR EACH ROW
DECLARE
  --
  CURSOR csr_get_bg IS
    SELECT pa.business_group_id
    FROM   per_all_assignments_f pa
    WHERE  pa.assignment_id =  :old.assignment_id
    AND    rownum=1;

  CURSOR csr_get_pid IS
    SELECT pa.payroll_id
    FROM   per_all_assignments_f pa
    WHERE  pa.assignment_id = :old.assignment_id       AND
           nvl(HR_PAY_INTERFACE_PKG.g_payroll_extract_date, sysdate)
            >= pa.effective_start_date                  AND
           nvl(HR_PAY_INTERFACE_PKG.g_payroll_extract_date, sysdate)
            <= pa.effective_end_date;
  CURSOR csr_get_person_id IS
    SELECT paa.person_id
    FROM	 per_all_assignments_f paa
    WHERE
		 paa.assignment_id = :old.assignment_id;
  --
  l_person_id per_all_assignments.person_id%TYPE;
BEGIN
  --
  IF HR_GENERAL.g_data_migrator_mode <> 'Y' THEN
    OPEN csr_get_bg;
    FETCH csr_get_bg
      INTO HR_PAY_INTERFACE_PKG.g_element_entry_rec_var.business_group_id;
    CLOSE csr_get_bg;

    OPEN csr_get_pid;
    FETCH csr_get_pid
      INTO HR_PAY_INTERFACE_PKG.g_element_entry_rec_var.payroll_id;
    CLOSE csr_get_pid;

    OPEN csr_get_person_id;
    FETCH csr_get_person_id
	 INTO l_person_id;
    CLOSE csr_get_person_id;
    --

    HR_PAY_INTERFACE_PKG.set_ele_var_ids(:old.element_link_id,
                                         :old.element_entry_id,
					 :old.effective_start_date,
					 l_person_id);
  END IF;
  --
END hr_pay_if_ele_ent_brd;


/
ALTER TRIGGER "APPS"."HR_PAY_IF_ELE_ENT_BRD" ENABLE;
