--------------------------------------------------------
--  DDL for Trigger PER_ALL_PEOPLE_F_ARIU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PER_ALL_PEOPLE_F_ARIU" AFTER INSERT
  or update of person_type_id
  ON "HR"."PER_ALL_PEOPLE_F"
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
   e_ResourceBusy      EXCEPTION;
      PRAGMA EXCEPTION_INIT(e_ResourceBusy, -54);

   e_NumOutSync        EXCEPTION;
   g_db_trigger        varchar2(30) := 'per_all_people_f_ari trigger';

   g_bg_context_name   varchar2(30) := 'Business Group Information';

   l_emp_method        HR_ORGANIZATION_INFORMATION.Org_information2%TYPE;
   l_apl_method        HR_ORGANIZATION_INFORMATION.Org_information3%TYPE;
   l_cwk_method        HR_ORGANIZATION_INFORMATION.Org_information16%TYPE;

   l_next_value        per_number_generation_controls.NEXT_VALUE%TYPE;
   l_sys_person_type   per_person_types.system_person_type%TYPE;
   --
   cursor csr_method(cp_bg_id per_all_people.business_group_id%TYPE) is
      SELECT Org_information3        -- method_of_generation_apl_num
           , Org_information2        -- method_of_generation_emp_num
           , Org_information16       -- method_of_generation_cwk_num
        from hr_organization_information
       where organization_id = cp_bg_id
         and ORG_INFORMATION_CONTEXT  = g_bg_context_name;
   --
   cursor csr_next_value(cp_bg_id per_all_people.business_group_id%TYPE,
                         cp_type varchar2) is
      SELECT next_value
      FROM   per_number_generation_controls
      WHERE  business_group_id = cp_bg_id
      AND    type              = cp_type;
  --
  FUNCTION person_exists (p_person_id          IN number
                        , p_system_person_type IN varchar2
                         )
    return boolean
  is
  l_dummy varchar2(1) := 'N';

    CURSOR csr_person_type
    IS
    SELECT 'Y'
      FROM  per_person_types typ
           ,per_person_type_usages_f ptu
      WHERE typ.system_person_type = p_system_person_type
       AND  typ.person_type_id = ptu.person_type_id
       AND  ptu.person_id = p_person_id;

  begin
     open csr_person_type;
     fetch csr_person_type into l_dummy;
     close csr_person_type;
     if l_dummy = 'Y' then
       return(TRUE);
     else
       return(FALSE);
     end if;
  END person_exists;
  --
  -- Added this function to handle scenario when "Global person numbering"
  -- profile option is set (enhancement 2931775).
  --
  FUNCTION get_next_value(p_business_group_id IN number
                         ,p_person_type       IN varchar2)
     return number is
     l_person_number     number := -2;
     l_session_date date;

  BEGIN
     l_session_date := HR_GENERAL.Effective_Date;

     if PER_BG_NUMBERING_METHOD_PKG.Global_person_numbering(p_person_type)
        or PER_BG_NUMBERING_METHOD_PKG.Get_PersonNumber_Formula
                   (p_person_type,l_session_date) is not null
     then
        -- we cannot check current value of the sequence
        -- since this is not being locked when generating the numbers
        -- if custom algorithm is being used, then ignore check as well
        --
        l_person_number := -1;
     else
        open csr_next_value(p_business_group_id,p_person_type);
        fetch csr_next_value into l_person_number;
        close csr_next_value;
     end if;
     return(l_person_number);
  END get_next_value;
--
BEGIN
 hr_utility.set_location('Entering:'||g_db_trigger,100);

 If hr_general.g_data_migrator_mode in ( 'Y','P') then --6365083
   hr_utility.set_location('Data Migrator mode= '||hr_general.g_data_migrator_mode,101);
   hr_utility.set_location('Leaving:'||g_db_trigger,996);
   return;
 Else
 open csr_method(:NEW.business_group_id);
 fetch csr_method into l_apl_method, l_emp_method, l_cwk_method;
 close csr_method;

-- -------------------------------------------------------------------------+
--                         Processing EMPLOYEES                             +
-- -------------------------------------------------------------------------+
 IF :NEW.CURRENT_EMPLOYEE_FLAG = 'Y'
     AND ((inserting) OR
         (updating and :OLD.person_type_id <> :NEW.person_type_id)
        )
    AND not person_exists(:NEW.person_id, 'EMP')
 then

    hr_utility.set_location(g_db_trigger,101);

    -- Special case for SSHR if the profile is set
    -- as we need to make sure that the generation controls table is not
    -- locked.
    -- if profile option is set that the employee number will not be generated and
    -- instead a null employee number will be returned. (see bug 2552720)

    if fnd_profile.value('PER_SSHR_NO_EMPNUM_GENERATION') = 'Y' then
      hr_utility.set_location('Leaving:'||g_db_trigger,996);
      return;
    end if;

   hr_utility.trace('>>> method found : '||l_emp_method);

   if l_emp_method = 'A' then

      hr_utility.set_location(g_db_trigger,105);
      l_next_value := get_next_value(:NEW.business_group_id,'EMP');
      if  l_next_value < 0 then -- global sequence has been used
         hr_utility.set_location('Leaving:'||g_db_trigger,997);
         return;
      elsif l_next_value <> (to_number(:NEW.employee_number) + 1) then

       hr_utility.trace('>>>       l_next_value = '||to_char(l_next_value));
       hr_utility.trace('>>>new employee number = '||:NEW.employee_number);

         -- method is already Automatic and employee number is out of sync ...

        hr_utility.set_location(g_db_trigger,110);

         RAISE e_NumOutSync;
      end if; -- next value check
    end if; -- method check
 END IF; -- current emp flag
-- -------------------------------------------------------------------------+
--                         Processing APPLICANTS                            +
-- -------------------------------------------------------------------------+
 IF :NEW.CURRENT_APPLICANT_FLAG = 'Y'
       AND ((inserting) OR
            (updating and :OLD.person_type_id <> :NEW.person_type_id)
           )
       AND not person_exists(:NEW.person_id, 'APL')
 THEN
   hr_utility.set_location(g_db_trigger,121);
   hr_utility.trace('>>> method found : '||l_apl_method);

   if l_apl_method = 'A' then

      hr_utility.set_location(g_db_trigger,125);
      l_next_value := get_next_value(:NEW.business_group_id,'APL');
      if l_next_value < 0 then -- global sequence has been used
         hr_utility.set_location('Leaving:'||g_db_trigger,998);
         return;
      elsif l_next_value <> (to_number(:NEW.applicant_number) + 1) then

         hr_utility.trace('>>>       l_next_value = '||to_char(l_next_value));
         hr_utility.trace('>>>new applicant number = '||:NEW.applicant_number);

         -- method is already Automatic and employee number is out of sync ...

         hr_utility.set_location(g_db_trigger,127);

         RAISE e_NumOutSync;
      end if; -- next value check
    end if; -- method check
 END IF; -- current apl flag
-- -------------------------------------------------------------------------+
--                    Processing CONTINGENT WORKERS                         +
-- -------------------------------------------------------------------------+
 IF :NEW.CURRENT_NPW_FLAG = 'Y'
    AND ((inserting) OR
         (updating and :OLD.person_type_id <> :NEW.person_type_id)
        )
    AND not person_exists(:NEW.person_id, 'CWK')
 THEN
   hr_utility.set_location(g_db_trigger,131);
   hr_utility.trace('>>> method found : '||l_cwk_method);

   if l_cwk_method = 'A' then

      hr_utility.set_location(g_db_trigger,135);
      l_next_value := get_next_value(:NEW.business_group_id,'CWK');
      if l_next_value < 0 then
         hr_utility.set_location('Leaving:'||g_db_trigger,999);
         return;
      elsif l_next_value <> (to_number(:NEW.npw_number) + 1) then
         hr_utility.trace('>>>  l_next_value = '||to_char(l_next_value));
         hr_utility.trace('>>>new CWK number = '||:NEW.npw_number);

         -- method is already Automatic and employee number is out of sync ...
         hr_utility.set_location(g_db_trigger,137);

         RAISE e_NumOutSync;
      end if; -- next value check
    end if; -- method check
 END IF;

 hr_utility.set_location('Leaving:'||g_db_trigger,140);
END IF; --6365083
 EXCEPTION
     when VALUE_ERROR then
     -- error converting the employee number to numeric
     -- raise error since it is already different from "sequence"

         hr_utility.set_message(800,'PER_289850_NUM_OUT_OF_SYNC');
         hr_utility.raise_error;

      when e_NumOutSync then
      --
      -- number does not match "sequence"
      --
         hr_utility.set_message(800,'PER_289850_NUM_OUT_OF_SYNC');
         hr_utility.raise_error;

      when OTHERS then
      -- error: abnormal condition

         RAISE;

END PER_ALL_PEOPLE_F_ARIU;

/
ALTER TRIGGER "APPS"."PER_ALL_PEOPLE_F_ARIU" ENABLE;
