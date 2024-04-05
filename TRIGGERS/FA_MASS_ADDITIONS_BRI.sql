--------------------------------------------------------
--  DDL for Trigger FA_MASS_ADDITIONS_BRI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FA_MASS_ADDITIONS_BRI" 
BEFORE  INSERT  ON "FA"."FA_MASS_ADDITIONS"
REFERENCING
 NEW AS NEW
 OLD AS OLD
FOR EACH ROW

DECLARE

v_asset_id number;
Begin
 /* $Header: faxtrg01.sql 120.1.12010000.1 2008/07/28 13:28:08 appldev ship $ */

 if ( :NEW.transaction_type_code = 'FUTURE ADD') then

      if ( :NEW.asset_id is null AND
           :NEW.posting_status = 'POST' ) then

           select fa_additions_s.nextval
           into v_asset_id
           from dual;

            :NEW.asset_id := v_asset_id ; --fa_additions_s.nextval;

      if :NEW.asset_number is null then
         :NEW.asset_number := v_asset_id;
      end if;
     end if;

     -- we need this check to make sure asset_number is populated
     -- if the user deletes the asset_number after the row was set to POST
     --
     if ( :NEW.asset_id is not null AND
          :NEW.asset_number is null ) then

        :NEW.asset_number := :NEW.asset_id;
     end if;
 end if;

End;

/
ALTER TRIGGER "APPS"."FA_MASS_ADDITIONS_BRI" ENABLE;
