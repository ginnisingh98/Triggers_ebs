--------------------------------------------------------
--  DDL for Trigger FND_ADG_CONCURRENT_REQUEST_U
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_ADG_CONCURRENT_REQUEST_U" 
   after update on "APPLSYS"."FND_CONCURRENT_REQUESTS" for each row
/* $Header: AFDGCRTU.sql 120.0.12010000.2 2010/09/17 16:24:50 rsanders noship $ */
declare
l_request_class_application_id number;
l_concurrent_request_class_id  number;
l_connstr1 varchar2(255);
l_node_name1 varchar2(30);
begin

$if fnd_adg_compile_directive.enable_rpc
$then

    l_request_class_application_id := :new.request_class_application_id;
    l_concurrent_request_class_id  := :new.concurrent_program_id;
    l_connstr1                     := :new.connstr1;
    l_node_name1                   := :new.node_name1;

    fnd_adg_support.handle_request_row_change(false,
                                             :new.program_application_id,
                                             :new.concurrent_program_id,
                                             l_connstr1,
                                             l_node_name1,
                                             l_request_class_application_id,
                                             l_concurrent_request_class_id,
                                             :new.phase_code,
                                             :new.status_code
                                            );
$else

    null;

$end

end;
/
ALTER TRIGGER "APPS"."FND_ADG_CONCURRENT_REQUEST_U" ENABLE;
