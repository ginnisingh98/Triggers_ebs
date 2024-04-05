--------------------------------------------------------
--  DDL for Trigger JL_ZZ_FA_BOOKS_GLOB_FLEX_RL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JL_ZZ_FA_BOOKS_GLOB_FLEX_RL" 
       BEFORE INSERT ON "FA"."FA_BOOKS"
       FOR EACH ROW
   WHEN ((sys_context('JG','JGZZ_COUNTRY_CODE') IN ('AR','CO','CL','MX'))
OR (new.book_type_code <> nvl(sys_context('JG','JGZZ_BOOK_TYPE_CODE'),'XX'))) DECLARE
l_ledger_id  fa_book_controls.set_of_books_id%TYPE;
l_country_code VARCHAR2(30);
BEGIN

  IF (:new.book_type_code <> nvl(sys_context('JG','JGZZ_BOOK_TYPE_CODE'),'XX')) THEN

    BEGIN
      select set_of_books_id into l_ledger_id
      from fa_book_controls fbc
      where
      book_type_code = :new.book_type_code;
    EXCEPTION
      WHEN OTHERS THEN
        l_ledger_id := -99;
    END;
  FND_PROFILE.get('JGZZ_COUNTRY_CODE',l_country_code);
/*    dbms_session.set_context(
        'JG'
       ,'JGZZ_COUNTRY_CODE'
    -- ,JG_ZZ_SHARED_PKG.GET_COUNTRY(NULL,l_ledger_id,NULL));
       ,l_country_code);
*/
    JG_CONTEXT.name_value('JGZZ_COUNTRY_CODE',l_country_code);

/*    dbms_session.set_context(
        'JG'
       ,'JGZZ_BOOK_TYPE_CODE'
       , to_char(:new.book_type_code));
*/
    JG_CONTEXT.name_value('JGZZ_BOOK_TYPE_CODE',:new.book_type_code);

  END IF;

 IF (sys_context('JG','JGZZ_COUNTRY_CODE') in ('AR','CO','CL','MX')) THEN

       jl_zz_fa_books_pkg.v_asset_id  := :new.asset_id;

       jl_zz_fa_books_pkg.v_book_type_code  := :new.book_type_code;

       jl_zz_fa_books_pkg.v_transaction_header_id_in  := :new.transaction_header_id_in;

 END IF;

END jl_zz_fa_books_glob_flex_rl;


/
ALTER TRIGGER "APPS"."JL_ZZ_FA_BOOKS_GLOB_FLEX_RL" ENABLE;
