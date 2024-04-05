--------------------------------------------------------
--  DDL for Trigger FND_ADG_CONCURRENT_REQUEST_I
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_ADG_CONCURRENT_REQUEST_I" 
   before insert on "APPLSYS"."FND_CONCURRENT_REQUESTS" for each row
/* $Header: AFDGCRTI.sql 120.0.12010000.2 2010/09/17 16:23:31 rsanders noship $ */
declare
begin

$if fnd_adg_compile_directive.enable_rpc
$then

    fnd_adg_support.handle_request_row_change(true,
                                             :new.program_application_id,
                                             :new.concurrent_program_id,
                                             :new.connstr1,
                                             :new.node_name1,
                                             :new.request_class_application_id,
                                             :new.concurrent_request_class_id,
                                             :new.phase_code,
                                             :new.status_code
                                            );
$else

    null;

$end

end;
/
ALTER TRIGGER "APPS"."FND_ADG_CONCURRENT_REQUEST_I" ENABLE;
