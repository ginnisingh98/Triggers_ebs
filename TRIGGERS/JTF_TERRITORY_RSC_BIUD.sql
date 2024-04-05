--------------------------------------------------------
--  DDL for Trigger JTF_TERRITORY_RSC_BIUD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JTF_TERRITORY_RSC_BIUD" 
BEFORE INSERT  OR DELETE  OR UPDATE
ON "JTF"."JTF_TERR_RSC_ALL"
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
  terr_id          NUMBER;
BEGIN

  IF INSERTING THEN
     terr_id      := :new.terr_id;
  ELSIF UPDATING THEN
     terr_id      := :new.terr_id;
  ELSIF DELETING THEN
     terr_id      := :old.terr_id;
  END IF;

  JTY_TERR_TRIGGER_HANDLERS.Terr_Rsc_Trigger_Handler(
    TERR_ID);
EXCEPTION
  when others then
    FND_MSG_PUB.Add_Exc_Msg( 'JTF_TERRITORY_RSC_BUID', 'Others exception inside TERRITORY_RSC trigger: ' || sqlerrm);
END JTF_TERRITORY_RSC_BIUD;


/
ALTER TRIGGER "APPS"."JTF_TERRITORY_RSC_BIUD" ENABLE;
