--------------------------------------------------------
--  DDL for Trigger FA_CUA_TRANSACTION_HEADERS_BRI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FA_CUA_TRANSACTION_HEADERS_BRI" 
BEFORE INSERT ON "FA"."FA_TRANSACTION_HEADERS"
REFERENCING
 NEW AS NEW
 OLD AS OLD
FOR EACH ROW
DECLARE

  v_error_message       varchar2(100);
  application_exception exception;

BEGIN
/* $Header: FACTRG02.sql 120.0 2002/08/24 06:29:53 appldev noship $ */

  if not(fa_cua_trx_approval_ext_pkg.facuas1(:new.transaction_type_code,
                                             :new.book_type_code,
                                             :new.asset_id)) then
    raise application_exception;

  end if;

  -- added 24-NOV-99 msiddiqu
  if (fa_cua_asset_apis.g_process_batch = 'Y') then
    :new.transaction_name       := fa_cua_asset_apis.g_transaction_name;
    :new.attribute_category_code:= fa_cua_asset_apis.g_attribute_category;
    :new.attribute1             := fa_cua_asset_apis.g_attribute1;
    :new.attribute2             := fa_cua_asset_apis.g_attribute2;
    :new.attribute3             := fa_cua_asset_apis.g_attribute3;
    :new.attribute4             := fa_cua_asset_apis.g_attribute4;
    :new.attribute5             := fa_cua_asset_apis.g_attribute5;
    :new.attribute6             := fa_cua_asset_apis.g_attribute6;
    :new.attribute7             := fa_cua_asset_apis.g_attribute7;
    :new.attribute8             := fa_cua_asset_apis.g_attribute8;
    :new.attribute9             := fa_cua_asset_apis.g_attribute9;
    :new.attribute10            := fa_cua_asset_apis.g_attribute10;
    :new.attribute11            := fa_cua_asset_apis.g_attribute11;
    :new.attribute12            := fa_cua_asset_apis.g_attribute12;
    :new.attribute13            := fa_cua_asset_apis.g_attribute13;
    :new.attribute14            := fa_cua_asset_apis.g_attribute14;
    :new.attribute15            := fa_cua_asset_apis.g_attribute15;
  end if;

EXCEPTION

  when application_exception then
    fnd_message.set_name('FA', 'FA_CUA_PENDING_BOOK');
    raise_application_error(-20001, 'FA_CUA_PENDING_BOOK');

  when others then
      fnd_message.set_name('FA', 'FA_CUA_DBT_ERROR_ENCOUNTERED');
      fnd_message.set_token('TABLE', 'fa_transaction_headers');
      fnd_message.set_token('TRIGGER', 'fa_cua_transaction_headers_bri');
      fnd_message.set_token('ERROR',sqlerrm);
      raise_application_error(-20001,fnd_message.get);

END;


/
ALTER TRIGGER "APPS"."FA_CUA_TRANSACTION_HEADERS_BRI" ENABLE;
