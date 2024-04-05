--------------------------------------------------------
--  DDL for Trigger FNDSM
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FNDSM" 
	AFTER INSERT OR UPDATE ON "APPLSYS"."FND_NODES"
	FOR EACH ROW
	BEGIN
		if ( :new.NODE_NAME <> 'AUTHENTICATION' ) then
                    if ( (:new.SUPPORT_CP='Y')
                      or (:new.SUPPORT_FORMS='Y')
                      or (:new.SUPPORT_WEB='Y') ) then
			fnd_cp_fndsm.register_fndsm_fcq(:new.NODE_NAME);
                    end if;
                    if (:new.SUPPORT_CP = 'Y') then
			fnd_cp_fndsm.register_fndim_fcq(:new.NODE_NAME);
                    end if;
		end if;
	END;

/
ALTER TRIGGER "APPS"."FNDSM" ENABLE;
