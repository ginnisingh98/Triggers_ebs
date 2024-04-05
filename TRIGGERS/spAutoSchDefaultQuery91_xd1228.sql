--------------------------------------------------------
--  DDL for Trigger spAutoSchDefaultQuery91$xd1228
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."spAutoSchDefaultQuery91$xd1228" after delete or update on "APPS"."spAutoSchDefaultQuery913_TAB" for each row BEGIN  IF (deleting) THEN xdb.xdb_pitrig_pkg.pitrig_del('APPS','spAutoSchDefaultQuery913_TAB', :old.sys_nc_oid$, 'E526183CD4D310ECE04426EC7DA871FC' ); END IF;   IF (updating) THEN xdb.xdb_pitrig_pkg.pitrig_upd('APPS','spAutoSchDefaultQuery913_TAB', :old.sys_nc_oid$, 'E526183CD4D310ECE04426EC7DA871FC', user ); END IF; END;

/
ALTER TRIGGER "APPS"."spAutoSchDefaultQuery91$xd1228" ENABLE;
