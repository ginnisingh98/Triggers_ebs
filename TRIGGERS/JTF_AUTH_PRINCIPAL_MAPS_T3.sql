--------------------------------------------------------
--  DDL for Trigger JTF_AUTH_PRINCIPAL_MAPS_T3
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JTF_AUTH_PRINCIPAL_MAPS_T3" 
AFTER DELETE ON JTF.JTF_AUTH_PRINCIPAL_MAPS
FOR EACH ROW
BEGIN
  DELETE FROM JTF_AUTH_MAPS_SOURCES
  WHERE JTF_AUTH_MAPS_SOURCES.JTF_AUTH_PRINCIPAL_MAPPING_ID = :old.JTF_AUTH_PRINCIPAL_MAPPING_ID;
EXCEPTION
  WHEN NO_DATA_FOUND THEN NULL;
END ;


/
ALTER TRIGGER "APPS"."JTF_AUTH_PRINCIPAL_MAPS_T3" ENABLE;
