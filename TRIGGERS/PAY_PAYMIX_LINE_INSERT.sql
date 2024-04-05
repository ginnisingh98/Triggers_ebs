--------------------------------------------------------
--  DDL for Trigger PAY_PAYMIX_LINE_INSERT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_PAYMIX_LINE_INSERT" 
INSTEAD OF INSERT ON pay_pdt_batch_lines
FOR EACH ROW

DECLARE

   TYPE tab_value IS TABLE OF pay_batch_lines.value_1%TYPE INDEX BY BINARY_INTEGER;
   l_value                 tab_value;
   l_effective_date        DATE;

  /* In order to map from view pay_pdt_batch_lines to table pay_batch_lines,
   the Input Values must first be determined. The Input Values map to columns
   value_1 to value_15 on table pay_batch_lines. The Input Values' names map
   to specific columns on pay_pdt_batch_lines according to the rules in
   function get_value(). */
  CURSOR c_iv IS
    SELECT iv.name
    ,      et.processing_type
    FROM pay_input_values_f  iv
    ,    pay_element_types_f et
    ,    pay_batch_headers   bh
    ,    per_business_groups bg
    WHERE iv.element_type_id = et.element_type_id
    AND   bg.business_group_id = bh.business_group_id
    AND et.element_name = :new.element_name
    AND bh.batch_id = :new.batch_id
    AND ( ( iv.business_group_id IS NULL AND et.legislation_code = bg.legislation_code )
          OR iv.business_group_id = bh.business_group_id )
    AND NVL( :new.from_date, l_effective_date )
        BETWEEN iv.effective_start_date AND iv.effective_end_date
    AND NVL( :new.from_date, l_effective_date )
        BETWEEN et.effective_start_date AND et.effective_end_date
    ORDER BY iv.display_sequence, iv.name;

  /* This function returns the value of an Input Value identified by its name by
     matching specific Input Value names to specific columns in view
     pay_pdt_batch_lines. */
  FUNCTION get_value
  ( p_name                   VARCHAR2
  , p_processing_type        VARCHAR2
  ) RETURN VARCHAR2
  IS

    /* Determine geo-code from state_worked (location_code) */
    FUNCTION get_jurisdiction_value
    ( p_session_date DATE )
    RETURN VARCHAR2
    IS
      -- Cursor to select location details.
      CURSOR csr_get_location_details IS
      SELECT region_2,
             region_1,
             town_or_city,
             postal_code
      FROM   hr_locations
      WHERE  UPPER(location_code) = UPPER( :new.state_worked )
      AND    country = 'US'
      AND    location_use = 'HR'
      AND    NVL(inactive_date,TO_DATE('31-12-4712','DD-MM-YYYY') ) > p_session_date;

      l_state_code         VARCHAR2(120);
      l_county_name        VARCHAR2(120);
      l_city_name          VARCHAR2(80);
      l_zip_code           VARCHAR2(80);

    BEGIN

      hr_utility.set_location('VIEW pay_pdt_batch_lines, INSTEAD OF INSERT TRIGGER', 221);

      -- To get geocode for a given location, need to query HR_LOCATIONS and
      -- get state, county, city and zip for the given location.
      OPEN  csr_get_location_details;

      FETCH csr_get_location_details
       INTO  l_state_code, l_county_name, l_city_name, l_zip_code;

      CLOSE csr_get_location_details;

      hr_utility.set_location('VIEW pay_pdt_batch_lines, INSTEAD OF INSERT TRIGGER', 222);

      -- return geocode for current address.
      RETURN hr_us_ff_udfs.addr_val( p_state_abbrev => l_state_code,
                                     p_county_name  => l_county_name,
                                     p_city_name    => l_city_name,
                                     p_zip_code     => l_zip_code );

    END get_jurisdiction_value;

  BEGIN /* Start of get_value() */

    hr_utility.set_location('VIEW pay_pdt_batch_lines, INSTEAD OF INSERT TRIGGER', 210);

    IF p_name = 'Separate Check' THEN
      RETURN hr_general.decode_lookup( 'YES_NO', :new.separate_check_flag );
    ELSIF p_name = 'Rate' THEN
      RETURN fnd_number.number_to_canonical( :new.hourly_rate );
    ELSIF p_name = 'Hours' THEN
      RETURN fnd_number.number_to_canonical( :new.hours_worked );
    ELSIF p_name = 'Rate Code' THEN
      RETURN :new.rate_code;
    ELSIF p_name = 'Multiple' THEN
      RETURN fnd_number.number_to_canonical( :new.rate_multiple );
    ELSIF p_name = 'Shift' THEN
      RETURN :new.shift_type;
    ELSIF p_name IN ( 'Amount', 'Percentage', 'Net Amount', 'Pay Value' )
      AND p_processing_type <> 'R'
      AND ( UPPER( :new.adjustment_type_code ) IS NULL OR UPPER( :new.adjustment_type_code ) = 'REP' ) THEN
      RETURN fnd_number.number_to_canonical( :new.amount );
    ELSIF p_name = 'Replace Amt'
      AND p_processing_type = 'R'
      AND ( UPPER( :new.adjustment_type_code ) IS NULL OR UPPER( :new.adjustment_type_code ) = 'REP' ) THEN
      RETURN fnd_number.number_to_canonical( :new.amount );
    ELSIF p_name = 'Addl Amt'
      AND p_processing_type = 'R'
      AND UPPER( :new.adjustment_type_code ) IS NOT NULL
      AND UPPER( :new.adjustment_type_code ) = 'INC' THEN
      RETURN fnd_number.number_to_canonical( :new.amount );
    ELSIF p_name = 'Addl Amt'
      AND p_processing_type = 'R'
      AND UPPER( :new.adjustment_type_code ) IS NOT NULL
      AND UPPER( :new.adjustment_type_code ) NOT IN ( 'REP', 'INC') THEN
      RETURN fnd_number.number_to_canonical( :new.amount * -1 );
    ELSIF p_name = 'Jurisdiction' THEN
      hr_utility.set_location('VIEW pay_pdt_batch_lines, INSTEAD OF INSERT TRIGGER', 220);
      RETURN get_jurisdiction_value( NVL( :new.from_date, l_effective_date ) );
    ELSIF p_name = 'Tax Separately' THEN
      RETURN hr_general.decode_lookup( 'YES_NO', :new.tax_separately_flag );
    ELSIF p_name = 'Deduction Processing' THEN
      RETURN hr_general.decode_lookup( 'US_DEDUCTION_PROCESSING', :new.vol_ded_proc_ovd );
    ELSIF p_name = 'Towards Owed' THEN
      RETURN hr_general.decode_lookup( 'YES_NO', :new.inc_asc_balance );
    /* A special case is added to cope for 'Child Support' element */
    ELSIF p_name  = 'Amount'
      AND p_processing_type = 'R' THEN
      RETURN fnd_number.number_to_canonical( :new.amount );
    ELSE
      RETURN NULL;
    END IF;
  END get_value;

BEGIN /************************** Start of Trigger Block *******************************/

  hr_utility.set_location('VIEW pay_pdt_batch_lines, INSTEAD OF INSERT TRIGGER', 100);

  /* Use session effective date if from_date is null */
  IF :new.from_date IS NULL THEN
    SELECT effective_date
    INTO l_effective_date
    FROM fnd_sessions
    WHERE session_id = USERENV( 'SESSIONID' );
  END IF;

  /* Initialise PLSQL table of Input Value values */
  FOR idx IN 1..15 LOOP
    l_value( idx ) := NULL;
  END LOOP;

  hr_utility.set_location('VIEW pay_pdt_batch_lines, INSTEAD OF INSERT TRIGGER', 200);

  /* First fetch list of Input Value names */
  FOR c_iv_rec IN c_iv LOOP
    /* Next map value from view pay_pdt_batch_lines to each Input Value name. */
    l_value(c_iv%ROWCOUNT) := get_value( c_iv_rec.name, c_iv_rec.processing_type );
  END LOOP;

  hr_utility.set_location('VIEW pay_pdt_batch_lines, INSTEAD OF INSERT TRIGGER', 300);

  /* Finally insert row into pay_batch_lines */
  INSERT INTO pay_batch_lines
  (  batch_line_id
  ,  cost_allocation_keyflex_id
  ,  element_type_id
  ,  assignment_id
  ,  batch_id
  ,  batch_line_status
  ,  assignment_number
  ,  batch_sequence
  ,  concatenated_segments
  ,  effective_date
  ,  element_name
  ,  entry_type
  ,  reason
  ,  effective_start_date
  ,  effective_end_date
  ,  segment1
  ,  segment2
  ,  segment3
  ,  segment4
  ,  segment5
  ,  segment6
  ,  segment7
  ,  segment8
  ,  segment9
  ,  segment10
  ,  segment11
  ,  segment12
  ,  segment13
  ,  segment14
  ,  segment15
  ,  segment16
  ,  segment17
  ,  segment18
  ,  segment19
  ,  segment20
  ,  segment21
  ,  segment22
  ,  segment23
  ,  segment24
  ,  segment25
  ,  segment26
  ,  segment27
  ,  segment28
  ,  segment29
  ,  segment30
  ,  value_1
  ,  value_2
  ,  value_3
  ,  value_4
  ,  value_5
  ,  value_6
  ,  value_7
  ,  value_8
  ,  value_9
  ,  value_10
  ,  value_11
  ,  value_12
  ,  value_13
  ,  value_14
  ,  value_15
  ,  attribute_category
  ,  attribute1
  ,  attribute2
  ,  attribute3
  ,  attribute4
  ,  attribute5
  ,  attribute6
  ,  attribute7
  ,  attribute8
  ,  attribute9
  ,  attribute10
  ,  attribute11
  ,  attribute12
  ,  attribute13
  ,  attribute14
  ,  attribute15
  ,  attribute16
  ,  attribute17
  ,  attribute18
  ,  attribute19
  ,  attribute20
  )
  VALUES
  (  :new.line_id                       -- batch_line_id
  ,  :new.cost_allocation_keyflex_id    -- cost_allocation_keyflex_id
  ,  NULL                               -- element_type_id
  ,  NULL                               -- assignment_id
  ,  :new.batch_id                      -- batch_id
  ,  'U'                                -- batch line status. 'U'nprocessed.
  ,  :new.assignment_number             -- assignment_number
  ,  NULL                               -- batch_sequence
  ,  :new.concatenated_segments         -- concatenated_segments
  ,  NVL( :new.from_date, l_effective_date )
                                        -- effective_date
  ,  :new.element_name                  -- element_name
  ,  NULL                               -- entry_type
  ,  NULL                               -- reason
  ,  :new.from_date                     -- absence start date
  ,  :new.to_date                       -- absence end date
  ,  :new.segment1
  ,  :new.segment2
  ,  :new.segment3
  ,  :new.segment4
  ,  :new.segment5
  ,  :new.segment6
  ,  :new.segment7
  ,  :new.segment8
  ,  :new.segment9
  ,  :new.segment10
  ,  :new.segment11
  ,  :new.segment12
  ,  :new.segment13
  ,  :new.segment14
  ,  :new.segment15
  ,  :new.segment16
  ,  :new.segment17
  ,  :new.segment18
  ,  :new.segment19
  ,  :new.segment20
  ,  :new.segment21
  ,  :new.segment22
  ,  :new.segment23
  ,  :new.segment24
  ,  :new.segment25
  ,  :new.segment26
  ,  :new.segment27
  ,  :new.segment28
  ,  :new.segment29
  ,  :new.segment30
  ,  l_value(1)
  ,  l_value(2)
  ,  l_value(3)
  ,  l_value(4)
  ,  l_value(5)
  ,  l_value(6)
  ,  l_value(7)
  ,  l_value(8)
  ,  l_value(9)
  ,  l_value(10)
  ,  l_value(11)
  ,  l_value(12)
  ,  l_value(13)
  ,  l_value(14)
  ,  l_value(15)
  ,  NULL                          -- attribute_category
  ,  NULL                          -- attribute1
  ,  NULL                          -- attribute2
  ,  NULL                          -- attribute3
  ,  NULL                          -- attribute4
  ,  NULL                          -- attribute5
  ,  NULL                          -- attribute6
  ,  NULL                          -- attribute7
  ,  NULL                          -- attribute8
  ,  NULL                          -- attribute9
  ,  NULL                          -- attribute10
  ,  NULL                          -- attribute11
  ,  NULL                          -- attribute12
  ,  NULL                          -- attribute13
  ,  NULL                          -- attribute14
  ,  NULL                          -- attribute15
  ,  NULL                          -- attribute16
  ,  NULL                          -- attribute17
  ,  NULL                          -- attribute18
  ,  NULL                          -- attribute19
  ,  NULL                          -- attribute20
  );

END;



/
ALTER TRIGGER "APPS"."PAY_PAYMIX_LINE_INSERT" ENABLE;
