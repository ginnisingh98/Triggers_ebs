--------------------------------------------------------
--  DDL for Trigger FND_ADG_ERROR_TRIGGER
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_ADG_ERROR_TRIGGER" 
   after servererror on schema
/* $Header: AFDGERTR.sql 120.0.12010000.2 2010/09/17 16:25:20 rsanders noship $ */
declare
l_request_id number;
begin

$if fnd_adg_compile_directive.enable_rpc
$then

    if ( ora_is_servererror(fnd_adg_support.C_READ_ONLY_ERROR) )
    then

       if ( fnd_adg_support.is_standby and
            fnd_adg_support.is_true_standby )
       then

          begin
            l_request_id := fnd_global.conc_request_id;
          exception
             when others then
                  l_request_id := null;
          end;

          if ( l_request_id is not null and
                  fnd_adg_utility.is_standby_error_checking )
          then
             fnd_adg_manage.rpc_invoke_standby_error(l_request_id);
          end if;

       end if;
    end if;

$else

    null;

$end

end;
/
ALTER TRIGGER "APPS"."FND_ADG_ERROR_TRIGGER" DISABLE;
