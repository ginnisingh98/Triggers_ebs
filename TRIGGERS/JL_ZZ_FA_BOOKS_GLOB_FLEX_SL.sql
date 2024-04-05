--------------------------------------------------------
--  DDL for Trigger JL_ZZ_FA_BOOKS_GLOB_FLEX_SL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JL_ZZ_FA_BOOKS_GLOB_FLEX_SL" 
       AFTER INSERT ON "FA"."FA_BOOKS"

/* $Header: jlzzffbi.sql 120.3 2006/03/06 22:16:01 svaze ship $ */

DECLARE

 x_country_code VARCHAR2(10);

BEGIN

  -------------------------------------------------------------------------
  -- BUG 4650081. Profile for country is replaced by call to JG Shared pkg.
  -------------------------------------------------------------------------
  x_country_code := JG_ZZ_SHARED_PKG.GET_COUNTRY;


     IF x_country_code in ('AR','CO','CL','MX') THEN

         IF jl_zz_fa_books_pkg.update_insert OR jl_zz_fa_books_pkg.insert_update THEN
             jl_zz_fa_books_pkg.update_row;
         ELSE
             jl_zz_fa_books_pkg.get_dist_book;
             jl_zz_fa_books_pkg.get_flag_category;
             jl_zz_fa_books_pkg.get_ga_dist_book;
             jl_zz_fa_books_pkg.update_row;
         END IF;

     END IF; -- country code

END jl_zz_fa_books_glob_flex_sl;


/
ALTER TRIGGER "APPS"."JL_ZZ_FA_BOOKS_GLOB_FLEX_SL" ENABLE;
