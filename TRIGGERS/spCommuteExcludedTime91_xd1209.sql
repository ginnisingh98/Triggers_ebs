--------------------------------------------------------
--  DDL for Trigger spCommuteExcludedTime91$xd1209
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."spCommuteExcludedTime91$xd1209" after delete or update on "APPS"."spCommuteExcludedTime919_TAB" for each row BEGIN  IF (deleting) THEN xdb.xdb_pitrig_pkg.pitrig_del('APPS','spCommuteExcludedTime919_TAB', :old.sys_nc_oid$, 'E526183CD4CD10ECE04426EC7DA871FC' ); END IF;   IF (updating) THEN xdb.xdb_pitrig_pkg.pitrig_upd('APPS','spCommuteExcludedTime919_TAB', :old.sys_nc_oid$, 'E526183CD4CD10ECE04426EC7DA871FC', user ); END IF; END;

/
ALTER TRIGGER "APPS"."spCommuteExcludedTime91$xd1209" ENABLE;
