--------------------------------------------------------
--  DDL for Trigger FND_ADG_LOGOFF_TRIGGER
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_ADG_LOGOFF_TRIGGER" 
   before logoff on schema
/* $Header: AFDGLOTR.sql 120.0.12010000.2 2010/09/17 16:27:49 rsanders noship $ */
declare
begin

    if ( fnd_adg_utility.is_session_simulated_standby )
    then
       fnd_adg_utility.process_adg_violations(true);
    end if;

end;
/
ALTER TRIGGER "APPS"."FND_ADG_LOGOFF_TRIGGER" DISABLE;
