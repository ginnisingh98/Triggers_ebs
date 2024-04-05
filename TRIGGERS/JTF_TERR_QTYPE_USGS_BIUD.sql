--------------------------------------------------------
--  DDL for Trigger JTF_TERR_QTYPE_USGS_BIUD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JTF_TERR_QTYPE_USGS_BIUD" 
BEFORE INSERT  OR DELETE  OR UPDATE
ON "JTF"."JTF_TERR_QTYPE_USGS_ALL"
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
  terr_id           NUMBER;

BEGIN
  IF INSERTING THEN
     terr_id           := :new.terr_id;
  ELSIF UPDATING THEN
     terr_id           := :new.terr_id;
  ELSIF DELETING THEN
     terr_id           := :old.terr_id;
  END IF;

  JTY_TERR_TRIGGER_HANDLERS.Terr_QType_Trigger_Handler(
    terr_id);

EXCEPTION
  when others then
    FND_MSG_PUB.Add_Exc_Msg( 'jtf_terr_qtype_usgs_biud', 'Others exception inside TERR_QUAL_TYPE_USGS trigger: ' || sqlerrm);
END jtf_terr_qtype_usgs_biud;


/
ALTER TRIGGER "APPS"."JTF_TERR_QTYPE_USGS_BIUD" ENABLE;
