--------------------------------------------------------
--  DDL for Trigger BOMTSTRC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."BOMTSTRC" 

/* $Header: BOMTSTRC.sql 120.1 2006/06/01 08:57:06 hgelli noship $ */

BEFORE INSERT OR UPDATE ON "BOM"."BOM_COMPONENTS_B"
FOR EACH ROW
DECLARE
    error_msg	VARCHAR2(80);
BEGIN

  IF INSERTING
  THEN
    IF :new.OBJ_NAME IS NULL AND
       :new.pk1_value IS NULL AND
       :new.pk2_value IS NULL
    THEN
      :new.PK1_VALUE := :new.component_item_id;
      SELECT organization_id
        INTO :new.pk2_value
        FROM bom_structures_b
      WHERE bill_sequence_id = :new.bill_sequence_id;
    END IF;
  ELSE
    IF :new.OBJ_NAME IS NULL AND
       :new.pk1_value <>  :new.component_item_id
    THEN
      :new.PK1_VALUE := :new.component_item_id;
    END IF;
  END IF;

EXCEPTION
    when others then
	error_msg := 'BOMTSTRC ' || substrb(SQLERRM, 1, 60);
	raise_application_error(-20500, error_msg);
END;


/
ALTER TRIGGER "APPS"."BOMTSTRC" ENABLE;
