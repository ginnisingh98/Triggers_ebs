--------------------------------------------------------
--  DDL for Trigger GL_DAILY_RATES_INTERFACE_ASIT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GL_DAILY_RATES_INTERFACE_ASIT" 
  AFTER INSERT ON "GL"."GL_DAILY_RATES_INTERFACE"
  DECLARE
    ab_used      VARCHAR2(1);
    run_program  VARCHAR2(1);
    euro_code    VARCHAR2(30);
    result       BOOLEAN;
    user_id      NUMBER;
    req_id       NUMBER;

     ekey			VARCHAR2(100);
     from_currency 		VARCHAR2(15);
     to_currency 		VARCHAR2(15);
     from_conversion_date 	DATE;
     to_conversion_date		DATE;
     conversion_type		VARCHAR2(30);
     conversion_rate		NUMBER;
     inverse_conversion_rate	NUMBER;
     mode_flag			VARCHAR2(1);

     CURSOR rate_change IS
       SELECT from_currency, to_currency, from_conversion_date,
              to_conversion_date, conv.conversion_type, conversion_rate,
              nvl(inverse_conversion_rate, 1/conversion_rate), mode_flag
       FROM GL_DAILY_RATES_INTERFACE int,
            GL_DAILY_CONVERSION_TYPES conv
       WHERE mode_flag IN ('I', 'D')
       AND   conv.user_conversion_type = int.user_conversion_type;

  BEGIN
--Bug 4493250 JVARKEY Added the if loop
    IF GL_CRM_UTILITIES_PKG.enable_trigger THEN
    -- Validate the following:
    --
    --   o Conversion_type exists,
    --   o Conversion_rate is not a negative number
    --   o Inverse_conversion_rate is not a negative number
    --   o From_Currency and To_Currency:
    --     a. Currency exists in the FND_CURRENCIES table
    --     b. Currency is enabled
    --     c. Currency is not a statistical currency
    --     d. Currency is not out of date
    --     e. Currency is not an EMU currency
    --   o Range of dates specified does not exceeds 366 days
    --
    -- If there is any error, an appropriate error_code will be set.

    UPDATE GL_DAILY_RATES_INTERFACE RI
    SET    error_code =
      (SELECT decode(CT.rowid, null, 'NONEXISTANT_CONVERSION_TYPE',
              decode(least(  trunc(RI2.to_conversion_date)
                           - trunc(RI2.from_conversion_date),
                           367),
                367, 'DATE_RANGE_TOO_LARGE',
              decode(least(RI.conversion_rate, 0),
                RI.conversion_rate, 'NEGATIVE_CONVERSION_RATE',
              decode(least(nvl(RI.inverse_conversion_rate, 1), 0),
                RI.inverse_conversion_rate, 'NEGATIVE_INVERSE_RATE',
              decode(FROM_CURR.rowid,
                null, 'NONEXISTANT_FROM_CURRENCY',
              decode(FROM_CURR.enabled_flag,
                'N', 'DISABLED_FROM_CURRENCY',
              decode(FROM_CURR.currency_flag,
                'N', 'STATISTICAL_FROM_CURRENCY',
	      decode(FROM_CURR.currency_code,
                'STAT', 'STATISTICAL_FROM_CURRENCY',
              decode(  sign(trunc(sysdate)
                     - nvl(trunc(FROM_CURR.start_date_active),
                           trunc(sysdate))),
                -1, 'OUT_OF_DATE_FROM_CURRENCY',
              decode(  sign(trunc(sysdate)
                     - nvl(trunc(FROM_CURR.end_date_active),
                           trunc(sysdate))),
                1, 'OUT_OF_DATE_FROM_CURRENCY',
              decode(decode(FROM_CURR.derive_type,
                              'EMU', sign(  trunc(FROM_CURR.derive_effective)
                                          - trunc(RI2.to_conversion_date)),
                              1),
                -1, 'EMU_FROM_CURRENCY',
                0,  'EMU_FROM_CURRENCY',
              decode(TO_CURR.rowid,
                null, 'NONEXISTANT_TO_CURRENCY',
              decode(TO_CURR.enabled_flag,
                'N', 'DISABLED_TO_CURRENCY',
              decode(TO_CURR.currency_flag,
                'N', 'STATISTICAL_TO_CURRENCY',
	      decode(TO_CURR.currency_code,
                'STAT', 'STATISTICAL_TO_CURRENCY',
              decode(  sign(trunc(sysdate)
                     - nvl(trunc(TO_CURR.start_date_active),
                           trunc(sysdate))),
                -1, 'OUT_OF_DATE_TO_CURRENCY',
              decode(  sign(trunc(sysdate)
                     - nvl(trunc(TO_CURR.end_date_active),
                           trunc(sysdate))),
                1, 'OUT_OF_DATE_TO_CURRENCY',
             decode(decode(TO_CURR.derive_type,
                              'EMU', sign(  trunc(TO_CURR.derive_effective)
                                          - trunc(RI2.to_conversion_date)),
                              1),
                -1, 'EMU_TO_CURRENCY',
                0,  'EMU_TO_CURRENCY',
	        ''))))))))))))))))))
              FROM GL_DAILY_RATES_INTERFACE RI2,
                   GL_DAILY_CONVERSION_TYPES CT,
                   FND_CURRENCIES FROM_CURR,
                   FND_CURRENCIES TO_CURR
              WHERE RI2.rowid = RI.rowid
              AND   CT.user_conversion_type(+) = RI2.user_conversion_type
              AND   FROM_CURR.currency_code(+) = RI2.from_currency
              AND   TO_CURR.currency_code(+) = RI2.to_currency)
    WHERE  RI.mode_flag IN ('I', 'D');

  UPDATE GL_DAILY_RATES_INTERFACE T1
         SET T1.error_code = 'DUPLICATE_ROWS'
       WHERE
             (T1.USER_CONVERSION_TYPE,
              T1.FROM_CONVERSION_DATE, T1.TO_CONVERSION_DATE)
         IN
             (SELECT T2.USER_CONVERSION_TYPE,
                     T2.FROM_CONVERSION_DATE, T2.TO_CONVERSION_DATE
              FROM GL_DAILY_RATES_INTERFACE  T2
		WHERE (T2.FROM_CURRENCY =   T1.FROM_CURRENCY
	      OR  T2.FROM_CURRENCY =   T1.TO_CURRENCY)
		AND (T2.TO_CURRENCY =   T1.TO_CURRENCY
		OR  T2.TO_CURRENCY =   T1.FROM_CURRENCY)
              GROUP BY T2.USER_CONVERSION_TYPE,
                       T2.FROM_CONVERSION_DATE, T2.TO_CONVERSION_DATE
              HAVING count(*) > 1)
         AND mode_flag IN ('I','D');

    -- Update mode flag to 'X' for each erroneous row
    UPDATE GL_DAILY_RATES_INTERFACE
    SET    mode_flag = 'X'
    WHERE  mode_flag IN ('I','D')
    AND    error_code IS NOT NULL;

    -- Update used_for_ab_translation = 'Y' if the currency and conversion
    -- type is used in standard or average translation in the system
    UPDATE GL_DAILY_RATES_INTERFACE RI
    SET used_for_ab_translation =
        ( SELECT nvl(max('Y'), 'N')
          FROM   GL_DAILY_CONVERSION_TYPES  CT,
                 GL_LEDGERS                 LED,
                 GL_LEDGER_RELATIONSHIPS    REL
          WHERE  CT.user_conversion_type = RI.user_conversion_type
          AND    REL.source_ledger_id = LED.ledger_id
          AND    REL.target_ledger_id = LED.ledger_id
          AND    REL.target_ledger_category_code = 'ALC'
          AND    REL.application_id = 101
          AND    LED.currency_code IN (RI.from_currency, RI.to_currency)
          AND    REL.target_currency_code IN (RI.from_currency, RI.to_currency)
          AND    (   LED.daily_translation_rate_type = CT.conversion_type
                  OR nvl(REL.alc_period_average_rate_type,
                         LED.period_average_rate_type) = CT.conversion_type
                  OR nvl(REL.alc_period_end_rate_type,
                         LED.period_end_rate_type) = CT.conversion_type)
          AND    RI.mode_flag IN ('I', 'D'));

    -- For each row with conversion rate in
    -- GL_DAILY_RATES_INTERFACE where mode = 'D',
    -- set status_code to 'D' in the corresponding row in GL_DAILY_RATES.
    UPDATE GL_DAILY_RATES DR
    SET    status_code = 'D'
    WHERE  ( DR.from_currency, DR.to_currency, DR.conversion_type,
	     DR.conversion_date ) IN
           ( SELECT RI.from_currency, RI.to_currency, CT.conversion_type,
	            trunc(RI.from_conversion_date) + RM.multiplier - 1
  	     FROM   GL_ROW_MULTIPLIERS        RM,
                    GL_DAILY_CONVERSION_TYPES CT,
		    GL_DAILY_RATES_INTERFACE  RI
             WHERE  RI.mode_flag = 'D'
             AND    RI.used_for_ab_translation = 'Y'
             AND    CT.user_conversion_type = RI.user_conversion_type || ''
             AND    RM.multiplier BETWEEN 1 AND
                                        trunc(RI.to_conversion_date) -
			                trunc(RI.from_conversion_date) + 1 );

    -- For each row with inverse conversion rate in
    -- GL_DAILY_RATES_INTERFACE where mode = 'D',
    -- set status_code to 'D' in the corresponding row in GL_DAILY_RATES.
    UPDATE GL_DAILY_RATES DR
    SET    status_code = 'D'
    WHERE  ( DR.from_currency, DR.to_currency, DR.conversion_type,
	     DR.conversion_date ) IN
           ( SELECT RI.to_currency, RI.from_currency, CT.conversion_type,
	            trunc(RI.from_conversion_date) + RM.multiplier - 1
  	     FROM   GL_ROW_MULTIPLIERS        RM,
                    GL_DAILY_CONVERSION_TYPES CT,
		    GL_DAILY_RATES_INTERFACE  RI
             WHERE  RI.mode_flag = 'D'
             AND    RI.used_for_ab_translation = 'Y'
             AND    CT.user_conversion_type = RI.user_conversion_type || ''
             AND    RM.multiplier BETWEEN 1 AND
                                        trunc(RI.to_conversion_date) -
			                trunc(RI.from_conversion_date) + 1 );

    -- Delete existing rows with conversion rate in GL_DAILY_RATES
    DELETE GL_DAILY_RATES DR
    WHERE ( DR.from_currency, DR.to_currency, DR.conversion_type,
	    DR.conversion_date ) IN
          ( SELECT RI.from_currency, RI.to_currency, CT.conversion_type,
	           trunc(RI.from_conversion_date) + RM.multiplier - 1
 	    FROM   GL_ROW_MULTIPLIERS        RM,
                   GL_DAILY_CONVERSION_TYPES CT,
                   GL_DAILY_RATES_INTERFACE  RI
            WHERE  (RI.mode_flag = 'I' OR
		    ( RI.mode_flag = 'D' AND
		      RI.used_for_ab_translation <> 'Y'))
            AND    CT.user_conversion_type = RI.user_conversion_type || ''
            AND    RM.multiplier BETWEEN 1 AND
                                        trunc(RI.to_conversion_date) -
					trunc(RI.from_conversion_date) + 1 );

    -- Delete existing rows with inverse conversion rate in GL_DAILY_RATES
    DELETE GL_DAILY_RATES DR
    WHERE ( DR.from_currency, DR.to_currency, DR.conversion_type,
	    DR.conversion_date ) IN
          ( SELECT RI.to_currency, RI.from_currency, CT.conversion_type,
	           trunc(RI.from_conversion_date) + RM.multiplier - 1
 	    FROM   GL_ROW_MULTIPLIERS        RM,
                   GL_DAILY_CONVERSION_TYPES CT,
                   GL_DAILY_RATES_INTERFACE  RI
            WHERE  (RI.mode_flag = 'I' OR
		    ( RI.mode_flag = 'D' AND
		      RI.used_for_ab_translation <> 'Y'))
            AND    CT.user_conversion_type = RI.user_conversion_type || ''
            AND    RM.multiplier BETWEEN 1 AND
                                        trunc(RI.to_conversion_date) -
					trunc(RI.from_conversion_date) + 1);

    -- Insert all rows with conversion rate
    INSERT INTO GL_DAILY_RATES
          ( from_currency, to_currency,
	    conversion_date,
	    conversion_type, conversion_rate,
	    status_code,
  	    creation_date, created_by, last_update_date,
	    last_updated_by, last_update_login, context,
            attribute1, attribute2, attribute3, attribute4,
	    attribute5, attribute6, attribute7, attribute8,
	    attribute9, attribute10, attribute11, attribute12,
	    attribute13, attribute14, attribute15 )
    SELECT
            RI.from_currency, RI.to_currency,
	    trunc(RI.from_conversion_date) + RM.multiplier - 1,
	    CT.conversion_type, RI.conversion_rate,
	    decode( RI.used_for_ab_translation, 'Y', 'O', 'C' ),
            SYSDATE, nvl( RI.user_id, 1 ), SYSDATE,
	    nvl( RI.user_id, 1 ), 1, RI.context,
            RI.attribute1, RI.attribute2, RI.attribute3, RI.attribute4,
	    RI.attribute5, RI.attribute6, RI.attribute7, RI.attribute8,
	    RI.attribute9, RI.attribute10, RI.attribute11, RI.attribute12,
            RI.attribute13, RI.attribute14, RI.attribute15
    FROM
            GL_ROW_MULTIPLIERS        RM,
            GL_DAILY_CONVERSION_TYPES CT,
            GL_DAILY_RATES_INTERFACE  RI
    WHERE
            RI.mode_flag = 'I'
    AND     CT.user_conversion_type = RI.user_conversion_type || ''
    AND     RM.multiplier BETWEEN 1 AND
                                trunc(RI.to_conversion_date) -
	                        trunc(RI.from_conversion_date) + 1
    AND NOT EXISTS (
	    SELECT 1
	    FROM   GL_DAILY_RATES DR
	    WHERE  DR.from_currency   = RI.from_currency
   	    AND    DR.to_currency     = RI.to_currency
	    AND    DR.conversion_type = CT.conversion_type
	    AND    DR.conversion_date = trunc(RI.from_conversion_date) +
						RM.multiplier - 1 );

    -- Insert all rows with inverse conversion rate
    INSERT INTO GL_DAILY_RATES
          ( from_currency, to_currency,
	    conversion_date,
	    conversion_type,
            conversion_rate,
	    status_code,
            creation_date, created_by, last_update_date,
	    last_updated_by, last_update_login, context,
            attribute1, attribute2, attribute3, attribute4,
	    attribute5, attribute6, attribute7, attribute8,
	    attribute9, attribute10, attribute11, attribute12,
	    attribute13, attribute14, attribute15 )
    SELECT
            RI.to_currency, RI.from_currency,
	    trunc(RI.from_conversion_date) + RM.multiplier - 1,
	    CT.conversion_type,
	    nvl( RI.inverse_conversion_rate, 1/RI.conversion_rate),
	    decode( RI.used_for_ab_translation, 'Y', 'O', 'C' ),
            SYSDATE, nvl( RI.user_id, 1 ), SYSDATE,
	    nvl( RI.user_id, 1 ), 1, RI.context,
            RI.attribute1, RI.attribute2, RI.attribute3, RI.attribute4,
	    RI.attribute5, RI.attribute6, RI.attribute7, RI.attribute8,
            RI.attribute9, RI.attribute10, RI.attribute11, RI.attribute12,
	    RI.attribute13, RI.attribute14, RI.attribute15
    FROM
            GL_ROW_MULTIPLIERS        RM,
            GL_DAILY_CONVERSION_TYPES CT,
            GL_DAILY_RATES_INTERFACE  RI
    WHERE
            RI.mode_flag = 'I'
    AND     CT.user_conversion_type = RI.user_conversion_type || ''
    AND     RM.multiplier BETWEEN 1 AND
                                trunc(RI.to_conversion_date) -
				trunc(RI.from_conversion_date) + 1
    AND NOT EXISTS (
	    SELECT 1
	    FROM   GL_DAILY_RATES DR
	    WHERE  DR.from_currency   = RI.to_currency
  	    AND    DR.to_currency     = RI.from_currency
	    AND    DR.conversion_type = CT.conversion_type
	    AND    DR.conversion_date = trunc(RI.from_conversion_date) +
						RM.multiplier - 1 );

    -- Find out user_id for launching a concurrenct request
    -- if there is any valide rows in GL_DAILY_RATES_INTERFACE with
    -- launch_rate_change = 'Y'
    SELECT nvl( max( nvl(user_id, -1) ), -2 )
    INTO   user_id
    FROM   GL_DAILY_RATES_INTERFACE
    WHERE  launch_rate_change = 'Y'
    AND    mode_flag IN ('I', 'D');

    -- Launch the Rate Change Program if needed
    IF ( user_id <> -2 ) THEN

      -- Call this rountine so that a failure in a database trigger call
      -- of FND_REQUEST.submit_request will not rollback changes
      -- as it is not allowed in a database trigger.
      result := FND_REQUEST.set_mode( TRUE );

      --  Set up FDWHOAMI information for launching concurrent request
      IF (user_id <> -1) THEN
        FND_PROFILE.put('USER_ID', user_id );
      END IF;

      FND_PROFILE.put('RESP_ID', '20420');
      FND_PROFILE.put('RESP_APPL_ID', '1');

      -- Launch concurrent request to run the Rate Change Program
      req_id := FND_REQUEST.submit_request(
                            'SQLGL','GLTTRC','','',FALSE,
                  	    'D','',chr(0),
                            '','','','','','','',
                            '','','','','','','','','','',
                            '','','','','','','','','','',
                            '','','','','','','','','','',
                            '','','','','','','','','','',
                            '','','','','','','','','','',
                            '','','','','','','','','','',
                            '','','','','','','','','','',
                            '','','','','','','','','','',
                            '','','','','','','','','','');
    END IF;

    OPEN rate_change;

    LOOP
       FETCH rate_change INTO from_currency, to_currency,
                              from_conversion_date, to_conversion_date,
                              conversion_type, conversion_rate,
                              inverse_conversion_rate, mode_flag;
       EXIT WHEN rate_change%NOTFOUND;

       ekey := From_Currency||':'||To_Currency||':'||Conversion_Type||':'
               ||to_char(From_Conversion_Date,'RRDDDSSSSS')||':'
               ||to_char(To_Conversion_date,'RRDDDSSSSS')||':'
               ||to_char(sysdate, 'RRDDDSSSSS');

       IF (mode_flag = 'D') THEN
         -- Raise the remove conversion event
         gl_business_events.raise(
           p_event_name =>
             'oracle.apps.gl.CurrencyConversionRates.dailyRate.remove',
           p_event_key => ekey,
           p_parameter_name1 => 'FROM_CURRENCY',
           p_parameter_value1 => From_Currency,
           p_parameter_name2 => 'TO_CURRENCY',
           p_parameter_value2 => To_Currency,
           p_parameter_name3 => 'FROM_CONVERSION_DATE',
           p_parameter_value3 => to_char(from_Conversion_Date,'YYYY/MM/DD'),
           p_parameter_name4 => 'TO_CONVERSION_DATE',
           p_parameter_value4 => to_char(to_Conversion_Date,'YYYY/MM/DD'),
           p_parameter_name5 => 'CONVERSION_TYPE',
           p_parameter_value5 => Conversion_Type);
       ELSE
         -- Raise the specify conversion event
         gl_business_events.raise(
           p_event_name =>
             'oracle.apps.gl.CurrencyConversionRates.dailyRate.specify',
           p_event_key => ekey,
           p_parameter_name1 => 'FROM_CURRENCY',
           p_parameter_value1 => From_Currency,
           p_parameter_name2 => 'TO_CURRENCY',
           p_parameter_value2 => To_Currency,
           p_parameter_name3 => 'FROM_CONVERSION_DATE',
           p_parameter_value3 => to_char(from_Conversion_Date,'YYYY/MM/DD'),
           p_parameter_name4 => 'TO_CONVERSION_DATE',
           p_parameter_value4 => to_char(to_Conversion_Date,'YYYY/MM/DD'),
           p_parameter_name5 => 'CONVERSION_TYPE',
           p_parameter_value5 => Conversion_Type,
           p_parameter_name6 => 'CONVERSION_RATE',
           p_parameter_value6 => to_char(Conversion_Rate,
                                '99999999999999999999.99999999999999999999'),
           p_parameter_name7 => 'INVERSE_CONVERSION_RATE',
           p_parameter_value7 => to_char(Inverse_Conversion_Rate,
                                '99999999999999999999.99999999999999999999'));
       END IF;
    END LOOP;

    CLOSE rate_change;

    -- Delete all valid rows in GL_DAILY_RATES_INTERFACE
    DELETE FROM GL_DAILY_RATES_INTERFACE
    WHERE mode_flag IN ('I', 'D');
--End if for Bug 4493250
    END IF;
  END;

/
ALTER TRIGGER "APPS"."GL_DAILY_RATES_INTERFACE_ASIT" ENABLE;
