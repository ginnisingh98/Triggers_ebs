--------------------------------------------------------
--  DDL for Trigger IGI_MHC_FA_BOOK_CONTROLS_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."IGI_MHC_FA_BOOK_CONTROLS_T1" 
BEFORE  UPDATE  OF
   DEPRN_STATUS
 ON "FA"."FA_BOOK_CONTROLS"
REFERENCING
 NEW AS NEW
 OLD AS OLD
FOR EACH ROW
    WHEN (
(
new.book_class = 'TAX'
AND  nvl( new.deprn_status,'X')  =  'R'
AND  nvl( old.deprn_status,'X') <>  'R'
)
) DECLARE
   l_book_is_mhca   VARCHAR2(3);
   l_period_name    VARCHAR2(15);
   l_count          NUMBER;

   l_errbuf         VARCHAR2(200);
   l_retcode        NUMBER ;
Begin
--Fixed for GSCC warnings
 l_book_is_mhca := 'NO';
 l_count := 0;

  IF NOT ( igi_gen.is_req_installed ( 'MHC' ))  THEN
       RETURN ;
  END IF;

  BEGIN
    SELECT 'YES'
    INTO    l_book_is_mhca
    FROM   igi_mhc_book_controls
    WHERE  book_type_code = :new.book_type_code ;
  EXCEPTION
    WHEN OTHERS THEN
        l_book_is_mhca := 'NO' ;
  END;

  IF l_book_is_mhca = 'NO' THEN
      RETURN ;
  END IF;


  -- retrieve period name

  SELECT period_name
  INTO   l_period_name
  FROM   fa_deprn_periods
  WHERE  book_type_code = :new.book_type_code
  AND    period_close_date is NULL;

  -- do the check
  IF         l_book_is_mhca = 'YES'     THEN
--igi_mhc_common_utils.is_mhca_book(:new.book_type_code)

         SELECT COUNT(*)
         INTO   l_count
         FROM   FA_BOOKS BK , FA_ADDITIONS AD
         WHERE  BK.BOOK_TYPE_CODE = :new.book_type_code AND
                BK.DATE_INEFFECTIVE IS NULL AND
                BK.ASSET_ID = AD.ASSET_ID AND
                BK.PERIOD_COUNTER_FULLY_RETIRED IS NULL AND
                NVL(BK.PERIOD_COUNTER_FULLY_RESERVED,99) =
                               NVL(BK.PERIOD_COUNTER_LIFE_COMPLETE,99)
                AND EXISTS( SELECT 'x'
                            FROM  IGI_MHC_CATEGORY_BOOKS cb
                            WHERE cb.CATEGORY_ID = AD.ASSET_CATEGORY_ID
                            AND cb.BOOK_TYPE_CODE = BK.BOOK_TYPE_CODE
                        AND NVL ( cb.ALLOW_REVALUATION_FLAG ,'NO') = 'YES'
                            )
                AND BK.CONVERSION_DATE IS NULL
                AND BK.PERIOD_COUNTER_FULLY_RESERVED IS NULL
                AND NOT EXISTS ( SELECT 'x'
                               FROM  IGI_MHC_revaluation_summary rs ,
                                     fa_deprn_periods dp
                               WHERE RS.asset_id = AD.asset_id
                               AND RS.BOOK_TYPE_CODE = BK.BOOK_TYPE_CODE
                               AND dp.book_type_code = BK.BOOK_TYPE_CODE
                               AND dp.period_Close_Date IS NULL
                               AND dp.period_counter = rs.period_counter
                               AND rs.run_mode = 'L'
                               AND rs.active_flag = 'Y'
                              );



        -- Records which have not been revalued exists.
        IF l_count > 0
        THEN
             declare
               lv_mesg varchar2(400);
             begin
                Fnd_Message.set_name('IGI','IGI_MHC_NO_REVALUATION');
                :new.deprn_status := 'C';
                lv_mesg := substr(fnd_message.get,1,400);
                raise_application_error(-20001, lv_mesg );
             end;
       END IF;

END IF; -- Check if MHCA book.

End;




/
ALTER TRIGGER "APPS"."IGI_MHC_FA_BOOK_CONTROLS_T1" DISABLE;
