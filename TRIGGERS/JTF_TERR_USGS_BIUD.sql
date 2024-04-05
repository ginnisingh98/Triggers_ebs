--------------------------------------------------------
--  DDL for Trigger JTF_TERR_USGS_BIUD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JTF_TERR_USGS_BIUD" 
BEFORE INSERT  OR DELETE  OR UPDATE
ON "JTF"."JTF_TERR_USGS_ALL"
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
  terr_id      NUMBER;
  Trigger_Mode varchar2(20);
  source_id    NUMBER;
BEGIN
  IF INSERTING THEN
     Trigger_Mode := 'ON-INSERT';
     terr_id      := :new.terr_id;
     source_id    := :new.source_id;
  ELSIF UPDATING THEN
     Trigger_Mode := 'ON-UPDATE';
     terr_id      := :new.terr_id;
     source_id    := :new.source_id;
  ELSIF DELETING THEN
     Trigger_Mode := 'ON-DELETE';
     terr_id      := :old.terr_id;
     source_id    := :old.source_id;
  END IF;

  JTY_TERR_TRIGGER_HANDLERS.Terr_Usgs_Trigger_Handler(
     terr_id
    ,source_id
    ,Trigger_Mode);
EXCEPTION
  when others then
    FND_MSG_PUB.Add_Exc_Msg( 'JTF_TERR_USGS_BIUD', 'Others exception inside TERR_USGS trigger: ' || sqlerrm);
END JTF_TERR_QUAL_BIUD;


/
ALTER TRIGGER "APPS"."JTF_TERR_USGS_BIUD" ENABLE;
