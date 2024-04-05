--------------------------------------------------------
--  DDL for Trigger PAY_PAYMIX_HEADER_INSERT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_PAYMIX_HEADER_INSERT" 
INSTEAD OF INSERT ON pay_pdt_batch_headers
FOR EACH ROW

DECLARE

  l_batch_type_meaning  hr_lookups.meaning%TYPE := NULL;
  l_business_group_id   pay_payrolls_f.business_group_id%TYPE := NULL;

  CURSOR c_batch_types IS
    SELECT meaning
    FROM hr_lookups
    WHERE lookup_type = 'PAY_PDT_BATCH_TYPES'
    AND lookup_code = :new.batch_type;

  CURSOR c_bg_id IS
    SELECT p.business_group_id
    FROM pay_payrolls_f p
    ,    fnd_sessions   s
    WHERE p.payroll_id = :new.payroll_id
    AND   s.effective_date BETWEEN p.effective_start_date AND p.effective_end_date
    AND   s.session_id = USERENV( 'SESSIONID' );

BEGIN

  hr_utility.set_location('VIEW pay_pdt_batch_headers, INSTEAD OF INSERT TRIGGER', 10);

  /* Map batch_type lookup code in pay_pdt_batch_headers to
     batch_type meaning in pay_batch_headers */
  OPEN c_batch_types;
  FETCH c_batch_types INTO l_batch_type_meaning;
  CLOSE c_batch_types;

  hr_utility.set_location('VIEW pay_pdt_batch_headers, INSTEAD OF INSERT TRIGGER', 20);

  /* Determine business_group_id from payroll_id */
  OPEN c_bg_id;
  FETCH c_bg_id INTO l_business_group_id;
  CLOSE c_bg_id;

  hr_utility.set_location('VIEW pay_pdt_batch_headers, INSTEAD OF INSERT TRIGGER', 30);

  INSERT INTO pay_batch_headers
  (  batch_id
  ,  business_group_id
  ,  batch_name
  ,  batch_status
  ,  action_if_exists
  ,  batch_reference
  ,  batch_source
  ,  comments
  ,  date_effective_changes
  ,  purge_after_transfer
  ,  reject_if_future_changes
  ,  last_update_date
  ,  last_updated_by
  ,  last_update_login
  ,  created_by
  ,  creation_date
  )
  VALUES
  (  :new.batch_id
  ,  l_business_group_id
  ,  'Batch '||TO_CHAR( :new.batch_id ) --batch_name
  ,  DECODE( :new.batch_status, 'R', 'U', :new.batch_status )
  ,  'I' --action_if_exists
  ,  :new.reference_num
  ,  NULL  --batch_source
  ,  l_batch_type_meaning --comments
  ,  'O' --date_effective_changes ?
  ,  'N' --purge_after_transfer
  ,  'N' --reject_if_future_changes
  ,  :new.last_update_date
  ,  :new.last_updated_by
  ,  :new.last_update_login
  ,  :new.created_by
  ,  :new.creation_date
  );

END;



/
ALTER TRIGGER "APPS"."PAY_PAYMIX_HEADER_INSERT" ENABLE;
