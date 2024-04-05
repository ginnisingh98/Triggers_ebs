--------------------------------------------------------
--  DDL for Trigger spDistLastChildEffort90$xd1250
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."spDistLastChildEffort90$xd1250" after delete or update on "APPS"."spDistLastChildEffort906_TAB" for each row BEGIN  IF (deleting) THEN xdb.xdb_pitrig_pkg.pitrig_del('APPS','spDistLastChildEffort906_TAB', :old.sys_nc_oid$, 'E526183CD4DA10ECE04426EC7DA871FC' ); END IF;   IF (updating) THEN xdb.xdb_pitrig_pkg.pitrig_upd('APPS','spDistLastChildEffort906_TAB', :old.sys_nc_oid$, 'E526183CD4DA10ECE04426EC7DA871FC', user ); END IF; END;

/
ALTER TRIGGER "APPS"."spDistLastChildEffort90$xd1250" ENABLE;
