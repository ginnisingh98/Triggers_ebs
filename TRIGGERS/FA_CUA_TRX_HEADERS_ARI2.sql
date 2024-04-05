--------------------------------------------------------
--  DDL for Trigger FA_CUA_TRX_HEADERS_ARI2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FA_CUA_TRX_HEADERS_ARI2" 
AFTER  INSERT ON "FA"."FA_TRANSACTION_HEADERS"
REFERENCING
 NEW AS NEW
 OLD AS OLD
FOR EACH ROW
BEGIN
/* $Header: FACTRG01.sql 120.0 2002/08/24 06:29:50 appldev noship $ */

  fa_cua_trx_headers_ext_pkg.facuas1(:new.transaction_header_id,
                                     :new.asset_id,
                                     :new.book_type_code);

END fa_cua_trx_headers_ari2;


/
ALTER TRIGGER "APPS"."FA_CUA_TRX_HEADERS_ARI2" ENABLE;
