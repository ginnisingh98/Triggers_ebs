--------------------------------------------------------
--  DDL for Trigger FA_DEPRN_OVERRIDE_BRIUD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FA_DEPRN_OVERRIDE_BRIUD" 
   BEFORE
   INSERT OR DELETE OR UPDATE
   ON "FA"."FA_DEPRN_OVERRIDE"
   FOR EACH ROW


DECLARE
   invalid_column  varchar2(20);
   h_calendar_type varchar2(30);
   h_fy_name     varchar2(30);
   h_num_per_fy  number;
   matching_name   varchar2(15);
   matching_number number(15);
   open_period    number;
   count_num        number(15);
   reporting_flag   boolean;
   l_tracking_method    fa_books.tracking_method%TYPE;
   l_member_rollup_flag fa_books.member_rollup_flag%TYPE;
   l_group_asset_id     fa_books.group_asset_id%TYPE;
 --
 -- Bug 7308424
 -- ===========
 -- we need to validate depreciation posted record
 -- as we now allow changes to POSTED record as long as deprn has not been run
 -- and the period closed.
 --
 FUNCTION validate_posted_record return BOOLEAN IS
      l_count_posted NUMBER :=0;  /* If there are POSTED records with use_by = DEPRECIATION */
      l_period_counter NUMBER := 0; /* period counter that is open as Deprn override uses PERIOD NAMES */
      l_deprn_summary_count NUMBER := 0; /* Check if deprn is run without closing period */
  BEGIN
    -- bug 7308424
    -- Check if we are dealing with DEPRECIATION entries.

    IF ( nvl(:old.used_by,:new.used_by) <> 'DEPRECIATION' )
    THEN
       return FALSE;
    END IF;

    -- check if a POSTED record exists already.
    -- IF there is no DEPRECIATION record with POSTED Status we return FALSE.
      BEGIN
        SELECT count(*)
        INTO l_count_posted
        FROM fa_deprn_override
        WHERE book_type_code = nvl(:old.book_type_code,:new.book_type_code)
          AND  asset_id      = nvl(:old.asset_id,:new.asset_id)
          AND  period_name   = nvl(:old.period_name,:new.period_name)
          AND  used_by       = 'DEPRECIATION'
          AND  nvl(:old.used_by,:new.used_by)  = 'DEPRECIATION'
          AND  status  = 'POSTED';
      EXCEPTION WHEN OTHERS THEN l_count_posted := 0;
      END;

      IF l_count_posted = 0  THEN
          return FALSE;
      END IF;
      -- check whether the period is closed for the asset's book.
      -- IF period is not closed, we are ok, else return FALSE.
      BEGIN
          l_period_counter := 0;
          SELECT period_counter
           INTO  l_period_counter
          FROM   fa_deprn_periods
          WHERE   book_type_code = nvl(:old.book_type_code,:new.book_type_code)
            AND   period_name    = nvl(:old.period_name,:new.period_name)
            AND   period_close_date is null;
      EXCEPTION
          WHEN NO_DATA_FOUND THEN
               l_period_counter := 0;
          WHEN others then l_period_counter := 0;
      END;
      IF l_period_counter = 0 THEN
         return FALSE;
      END IF;
      -- check if Deprn has been run for this asset for open period
      -- return FALSE if no deprn record exists.
      BEGIN
         l_deprn_summary_count := 0;
         SELECT count(*)
         INTO l_deprn_summary_count
         FROM FA_DEPRN_SUMMARY
         WHERE asset_id       = nvl(:old.asset_id,:new.asset_id)
           AND book_type_code = nvl(:old.book_type_code,:new.book_type_code)
           AND period_counter = l_period_counter
         ;
      EXCEPTION WHEN OTHERS THEN
           l_deprn_summary_count := 0;
      END;
      if l_deprn_summary_count = 0 then
         return FALSE;
      end if;

      -- A posted record exists and the period is not closed.
      return TRUE;
  EXCEPTION WHEN others THEN  return FALSE;
  END;
-- Bug 7308424



BEGIN

/* This trigger is executed when you perform an insert, update, or delete
   statement on the table FA_DEPRN_OVERRIDE.
   For each record being inserted, updated or deleted from FA_DEPRN_OVERRIDE,
   this trigger performs the data validation, and ensures that updates is
   enabled only through depreciation and adjustment programs. Users are
   not allowed to update the stored record manually.
   Also,if the user tries to manually delete the posted status record,
   this trigger returns an alert message, and users cannot delete the record.

   modified by ynatsui
   user can update status 'NEW' override data for the following columns.
     1. status (NEW to POST)
     2. override depreciation amount
     3. override bonus depreciation amount
 */

IF fa_std_types.deprn_override_trigger_enabled THEN  -- manually access the data
   IF DELETING THEN
     IF (:old.status <> 'NEW' AND :old.status <> 'POST') THEN
       fnd_message.set_name('OFA', 'FA_INVALID_DELETE_STATUS');
       raise_application_error(-20000,fnd_message.get);
     END IF;

   ELSIF UPDATING THEN
   -- Bug 7308424: we allow update from POSTED to POST after calling rollback from the form.
     IF :old.status = 'POSTED' AND validate_posted_record AND :new.status = 'POST' THEN
        NULL;
     ELSIF :old.status = 'POSTED' AND NOT VAlidate_posted_record AND :new.status = 'POST' THEN
       fnd_message.set_name('OFA', 'FA_NO_UPDATES');
       raise_application_error(-20000,fnd_message.get);
     ELSIF  :old.status = 'POST' and :new.status = 'POSTED' THEN
       NULL;
     ELSIF :old.status = 'POST' and :new.status = 'NEW' THEN
       fnd_message.set_name('OFA', 'FA_NO_UPDATES');
       raise_application_error(-20000,fnd_message.get);
     END IF;
     IF (:new.status <> 'NEW' AND :new.status <> 'POST') or (:new.status = 'NEW' and :old.status = 'POSTED') THEN
       fnd_message.set_name('OFA', 'FA_NO_UPDATES');
       raise_application_error(-20000,fnd_message.get);
     END IF;

     IF (:old.deprn_override_id <> :new.deprn_override_id
      OR :old.book_type_code <> :new.book_type_code
      OR :old.asset_id <> :new.asset_id
      OR :old.period_name <> :new.period_name
      OR :old.used_by <> :new.used_by
      OR NVL(:old.subtraction_flag, ' ') <> NVL(:new.subtraction_flag, ' ')
      OR NVL(:old.subtract_ytd_flag, ' ') <> NVL(:new.subtract_ytd_flag, ' ')
      OR :new.transaction_header_id IS NOT NULL) THEN
       fnd_message.set_name('OFA', 'FA_NO_UPDATES');
       raise_application_error(-20000,fnd_message.get);
     END IF;
   END IF;

   IF INSERTING THEN

      -- Data validation for status
      IF :new.status IS NULL THEN
        :new.status:= 'POST';
      END IF;
      IF (:new.status <> 'NEW' AND :new.status <> 'POST') THEN
        fnd_message.set_name('OFA','FA_INVALID_DATA');
        fnd_message.set_token('COLUMN','STATUS');
        raise_application_error(-20000,fnd_message.get);
      END IF;

   /* This trigger is executed when you perform an an insert or update statement on the table FA_DEPRN_OVERRIDE.
      In this trigger, data validation (period_name and asset_id) is
      performed.
   */

      /* Data validation for book type code */
      invalid_column:= 'BOOK_TYPE_CODE';
      SELECT book_type_code INTO matching_name FROM fa_book_controls
      WHERE book_type_code = :new.book_type_code;

      /* Validation for MRC Book.  */
      SELECT count(*) INTO count_num FROM fa_mc_book_controls
      WHERE book_type_code = :new.book_type_code;

      reporting_flag:= FALSE;
      IF count_num > 0 then
         reporting_flag:= TRUE;
      END IF;


   -- Get calendar Info: type, fy_name and num_per_fiscal_year
      SELECT bc.deprn_calendar, bc.fiscal_year_name,
             ct.number_per_fiscal_year
      into h_calendar_type, h_fy_name, h_num_per_fy
      from fa_book_controls bc, fa_calendar_types ct
      where bc.book_type_code = :new.book_type_code
      and bc.deprn_calendar = ct.calendar_type;

      /* Data validation for period name and period counter */
      IF :new.period_name is not null THEN
         invalid_column:= 'PERIOD_NAME';

/*
      select fy.fiscal_year * h_num_per_fy + cp.period_num
      into matching_number
      from fa_calendar_periods cp, fa_fiscal_year fy
      where cp.period_name = :new.period_name
            and cp.calendar_type = h_calendar_type
            and cp.start_date >= fy.start_date
            and cp.end_date <= fy.end_date
            and fy.fiscal_year_name = h_fy_name;
*/

         SELECT period_name INTO matching_name FROM fa_calendar_periods
         WHERE calendar_type = h_calendar_type and
               period_name = :new.period_name;
      END IF;

      /* data validation for asset_id  */
      invalid_column:= 'ASSET_ID';

      SELECT a.asset_number INTO matching_name
      FROM fa_additions_b a, fa_books b
      WHERE a.asset_id = b.asset_id AND
            b.asset_id = :new.asset_id AND
            b.book_type_code = :new.book_type_code AND
            b.date_ineffective is null AND
            b.transaction_header_id_out is null;


      /* data validation for used_by */
      IF :new.used_by <> 'ADJUSTMENT' and :new.used_by <> 'DEPRECIATION' THEN
         fnd_message.set_name('OFA','FA_INVALID_DATA');
         fnd_message.set_token('COLUMN','USED_BY');
         raise_application_error(-20000,fnd_message.get);
      END IF;


      -- Subtract year to date flag
      IF :new.subtract_ytd_flag IS NOT NULL
         and :new.subtract_ytd_flag <> 'Y'
         and :new.subtract_ytd_flag <> 'N' THEN
         fnd_message.set_name('OFA','FA_INVALID_DATA');
         fnd_message.set_token('COLUMN','SUBTRACT_YTD_FLAG');
         raise_application_error(-20000,fnd_message.get);
      END IF;


      /* Amount validation */
      IF :new.deprn_amount is null and :new.bonus_deprn_amount is null THEN
         fnd_message.set_name('OFA','FA_INVALID_COMBINATION');
         fnd_message.set_token('COLUMN1','DEPRN_AMOUNT');
         fnd_message.set_token('COLUMN2','BONUS_DEPRN_AMOUNT');
         raise_application_error(-20000,fnd_message.get);
      END IF;

      IF :new.used_by = 'ADJUSTMENT' then
        /* cannot declare 0 override amount for reporting books if it's going
           to be used for adjustments  */
        IF reporting_flag = TRUE THEN
           IF :new.deprn_amount = 0 THEN
              fnd_message.set_name('OFA','FA_INVALID_DATA');
              fnd_message.set_token('COLUMN','DEPRN_AMOUNT');
              raise_application_error(-20000,fnd_message.get);
           ELSIF :new.bonus_deprn_amount = 0 THEN
              fnd_message.set_name('OFA','FA_INVALID_DATA');
              fnd_message.set_token('COLUMN','BONUS_DEPRN_AMOUNT');
              raise_application_error(-20000,fnd_message.get);
           END IF;
        END IF;
      END IF;

     -- Regardless of status we allow only 1 deprn record per period
     -- as users can change from POSTED to POST, if required.
     -- Users can delete a record with POST status (at any time!).
     --
     -- For Adjustments we allow multiple records if there are no POSTED
     -- records
     --
        SELECT count(*)
        INTO count_num
        FROM fa_deprn_override
       WHERE book_type_code = :new.book_type_code
         AND asset_id = :new.asset_id
         AND period_name = :new.period_name
	 AND used_by = :new.used_by
         AND (( used_by = 'ADJUSTMENT'  and status <> 'POSTED') OR ( used_by = 'DEPRECIATION')) ;

      IF count_num > 0 THEN
        fnd_message.set_name('OFA','FA_OVERRIDE_DATA_EXISTS');
        raise_application_error(-20000,fnd_message.get);
      END IF;

        SELECT count(*)
        INTO count_num
        FROM fa_deprn_override
       WHERE book_type_code = :new.book_type_code
         AND asset_id = :new.asset_id
         AND period_name = :new.period_name
         AND used_by = :new.used_by
	 AND used_by = 'DEPRECIATION'
	 ;

      IF count_num > 0 THEN
        fnd_message.set_name('OFA','FA_OVERRIDE_DATA_EXISTS');
        raise_application_error(-20000,fnd_message.get);
      END IF;




      -- Validation for member tracking
      -- 1. Allocate: Group or Member
      -- 2. Calculate: Group and Member are both OK
      -- 3. Calculate + Sum up: Member only
      -- 4. No tracking: Group and individual only

      SELECT tracking_method,
             member_rollup_flag,
             group_asset_id
        INTO l_tracking_method,
             l_member_rollup_flag,
             l_group_asset_id
        FROM fa_books
       WHERE asset_id = :new.asset_id
         AND book_type_code = :new.book_type_code
         AND date_ineffective IS NULL
         AND transaction_header_id_out IS NULL;

      IF l_tracking_method = 'ALLOCATE' THEN
        IF l_group_asset_id IS NULL THEN
          SELECT count(*)
            INTO count_num
            FROM fa_deprn_override ov
           WHERE ov.book_type_code = :new.book_type_code
             AND ov.asset_id IN
                 (SELECT bk.asset_id
                    FROM fa_books bk
                   WHERE bk.book_type_code = ov.book_type_code
                     AND bk.group_asset_id = :new.asset_id
                     AND bk.date_ineffective IS NULL
                     AND bk.transaction_header_id_out IS NULL)
             AND ov.period_name = :new.period_name
             AND ov.used_by = :new.used_by
             AND ( (ov.used_by = 'DEPRECIATION') OR (ov.used_by = 'ADJUSTMENT' and ov.status <> 'POSTED') )
          ;
          IF count_num > 0 THEN
            fnd_message.set_name('OFA','FA_MEMBER_OVERRIDE_DATA_EXISTS');
            raise_application_error(-20000,fnd_message.get);
          END IF;
        ELSE
          SELECT count(*) INTO count_num
            FROM fa_deprn_override
           WHERE book_type_code = :new.book_type_code
             AND asset_id = l_group_asset_id
             AND period_name = :new.period_name
             AND used_by = :new.used_by
             AND ( (used_by = 'DEPRECIATION') OR (used_by = 'ADJUSTMENT' and status <> 'POSTED') );

          IF count_num > 0 THEN
            fnd_message.set_name('OFA','FA_GROUP_OVERRIDE_DATA_EXISTS');
            raise_application_error(-20000,fnd_message.get);
          END IF;
        END IF;

      ELSIF l_tracking_method = 'CALCULATE' THEN
        IF l_member_rollup_flag = 'Y' AND l_group_asset_id IS NULL THEN
          fnd_message.set_name('OFA','FA_CANNOT_OVERRIDE_GROUP');
          raise_application_error(-20000,fnd_message.get);
        END IF;

      ELSE
        IF l_group_asset_id IS NOT NULL THEN
          fnd_message.set_name('OFA','FA_CANNOT_OVERRIDE_MEMBER');
          raise_application_error(-20000,fnd_message.get);
        END IF;
      END IF;


      IF :new.deprn_override_id IS NULL THEN
        SELECT fa_deprn_override_s.nextval
          INTO :new.deprn_override_id
          FROM dual;
      END IF;

     END IF; -- inserting

   END IF; -- trigger_enabled

 EXCEPTION
    WHEN no_data_found THEN
       fnd_message.set_name('OFA','FA_INVALID_DATA');
       fnd_message.set_token('COLUMN',invalid_column);
       raise_application_error(-20000,fnd_message.get);

END;

/
ALTER TRIGGER "APPS"."FA_DEPRN_OVERRIDE_BRIUD" ENABLE;
