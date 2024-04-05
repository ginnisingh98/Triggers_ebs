--------------------------------------------------------
--  DDL for Trigger spMaxDistToSkipActual92$xd1184
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."spMaxDistToSkipActual92$xd1184" after delete or update on "APPS"."spMaxDistToSkipActual927_TAB" for each row BEGIN  IF (deleting) THEN xdb.xdb_pitrig_pkg.pitrig_del('APPS','spMaxDistToSkipActual927_TAB', :old.sys_nc_oid$, 'E526183CD4C510ECE04426EC7DA871FC' ); END IF;   IF (updating) THEN xdb.xdb_pitrig_pkg.pitrig_upd('APPS','spMaxDistToSkipActual927_TAB', :old.sys_nc_oid$, 'E526183CD4C510ECE04426EC7DA871FC', user ); END IF; END;

/
ALTER TRIGGER "APPS"."spMaxDistToSkipActual92$xd1184" ENABLE;
