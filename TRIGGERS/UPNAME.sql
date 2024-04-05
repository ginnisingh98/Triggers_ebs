--------------------------------------------------------
--  DDL for Trigger UPNAME
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."UPNAME" 
	BEFORE INSERT ON "APPLSYS"."FND_NODES"
	FOR EACH ROW
	BEGIN
	      	:new.NODE_NAME := upper(:new.NODE_NAME);

	END;

/
ALTER TRIGGER "APPS"."UPNAME" ENABLE;
