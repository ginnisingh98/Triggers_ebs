--------------------------------------------------------
--  DDL for Trigger JTF_TERRITORY_VALUES_BIUD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JTF_TERRITORY_VALUES_BIUD" 
BEFORE INSERT  OR DELETE  OR UPDATE
ON "JTF"."JTF_TERR_VALUES_ALL"
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
  terr_qual_id  NUMBER;

BEGIN

  IF INSERTING THEN
     terr_qual_id := :new.terr_qual_id;
  ELSIF UPDATING THEN
     terr_qual_id := :new.terr_qual_id;
  ELSIF DELETING THEN
     terr_qual_id := :old.terr_qual_id;
  END IF;

  JTY_TERR_TRIGGER_HANDLERS.Terr_Values_Trigger_Handler(
    TERR_QUAL_ID);

EXCEPTION
  when others then
    FND_MSG_PUB.Add_Exc_Msg( 'JTF_TERRITORY_VALUES_BUID', 'Others exception inside TERRITORY_VALUE trigger: ' || sqlerrm);
END JTF_TERRITORY_VALUES_BUID;


/
ALTER TRIGGER "APPS"."JTF_TERRITORY_VALUES_BIUD" ENABLE;
