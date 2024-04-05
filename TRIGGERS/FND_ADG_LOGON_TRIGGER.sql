--------------------------------------------------------
--  DDL for Trigger FND_ADG_LOGON_TRIGGER
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_ADG_LOGON_TRIGGER" 
   after logon on schema
/* $Header: AFDGLNTR.sql 120.0.12010000.2 2010/09/17 16:27:22 rsanders noship $ */
declare
begin

  if ( fnd_adg_utility.is_session_simulated_standby )
  then
     fnd_adg_utility.enable_violation_trace;
  end if;

end;
/
ALTER TRIGGER "APPS"."FND_ADG_LOGON_TRIGGER" DISABLE;
