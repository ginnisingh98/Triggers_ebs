--------------------------------------------------------
--  DDL for Trigger JTF_TERRITORIES_BIUD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JTF_TERRITORIES_BIUD" 
BEFORE INSERT  OR DELETE  OR UPDATE
ON "JTF"."JTF_TERR_ALL"
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
  Trigger_Mode             varchar2(20);
  terr_id                  number;
  lo_start_date            date;
  lo_end_date              date;
  lo_rank                  number;
  lo_num_winners           number;
  lo_parent_territory_id   number;
  ln_start_date            date;
  ln_end_date              date;
  ln_rank                  number;
  ln_num_winners           number;
  ln_parent_territory_id   number;
  record_change            number;

BEGIN
  -- whether or not we should record this change on the territory table
  record_change := 0;

  -- instantiate local variables so we don't have to make references repeatedly
  lo_start_date            := :old.start_date_active;
  lo_end_date              := :old.end_date_active;
  lo_rank                  := :old.rank;
  lo_num_winners           := :old.num_winners;
  lo_parent_territory_id   := :old.parent_territory_id;
  ln_start_date            := :new.start_date_active;
  ln_end_date              := :new.end_date_active;
  ln_rank                  := :new.rank;
  ln_num_winners           := :new.num_winners;
  ln_parent_territory_id   := :new.parent_territory_id;

  IF (record_change = 0) THEN
    IF (lo_start_date is null and ln_start_date is not null) OR
       (lo_start_date is not null and ln_start_date is null) OR
       (lo_start_date <> ln_start_date) THEN
         record_change := 1;
    END IF;
  END IF;

  IF (record_change = 0) THEN
    IF (lo_end_date is null and ln_end_date is not null) OR
       (lo_end_date is not null and ln_end_date is null) OR
       (lo_end_date <> ln_end_date) THEN
         record_change := 1;
    END IF;
  END IF;

  IF (record_change = 0) THEN
    IF (lo_rank is null and ln_rank is not null) OR
       (lo_rank is not null and ln_rank is null) OR
       (lo_rank <> ln_rank) THEN
         record_change := 1;
    END IF;
  END IF;

  IF (record_change = 0) THEN
    IF (lo_num_winners is null and ln_num_winners is not null) OR
       (lo_num_winners is not null and ln_num_winners is null) OR
       (lo_num_winners <> ln_num_winners) THEN
         record_change := 1;
    END IF;
  END IF;

  IF (record_change = 0) THEN
    IF (lo_parent_territory_id is null and ln_parent_territory_id is not null) OR
       (lo_parent_territory_id is not null and ln_parent_territory_id is null) OR
       (lo_parent_territory_id <> ln_parent_territory_id) THEN
         record_change := 1;
    END IF;
  END IF;

  IF (record_change = 1) THEN
    IF INSERTING THEN
      Trigger_Mode := 'ON-INSERT';
      terr_id      := :new.terr_id;
    ELSIF UPDATING THEN
      Trigger_Mode := 'ON-UPDATE';
      terr_id      := :new.terr_id;
    ELSIF DELETING THEN
      Trigger_Mode := 'ON-DELETE';
      terr_id      := :old.terr_id;
    END IF;

    JTY_TERR_TRIGGER_HANDLERS.Territory_Trigger_Handler(
      terr_id,
      :old.parent_territory_id,
      :old.start_date_active,
      :old.end_date_active,
      :old.rank,
      :old.num_winners,
      :old.named_account_flag,
      :new.parent_territory_id,
      :new.start_date_active,
      :new.end_date_active,
      :new.rank,
      :new.num_winners,
      :new.named_account_flag,
	  Trigger_Mode );

  END IF; /* end IF (record_change = 1) */

EXCEPTION
  when others then
    FND_MSG_PUB.Add_Exc_Msg( 'JTF_TERRITORIES_BUID', 'Others exception inside TERR trigger: ' || sqlerrm);
END JTF_TERRITORIES_BUID;


/
ALTER TRIGGER "APPS"."JTF_TERRITORIES_BIUD" ENABLE;
