--------------------------------------------------------
--  DDL for Trigger CZ_PS_NODES_T4
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CZ_PS_NODES_T4" 
  BEFORE  INSERT OR UPDATE
  ON "CZ"."CZ_PS_NODES"
  REFERENCING OLD AS OLD NEW AS NEW
  FOR EACH ROW
DECLARE
  msg varchar2(200);
BEGIN
  IF ((INSERTING OR (UPDATING AND :new.deleted_flag = '0')) AND
       :new.ps_node_type IN (436,263,259,258) AND
      (:new.instantiable_flag IS NULL OR
       :new.instantiable_flag NOT IN ('1','2','4'))) THEN
    IF INSERTING THEN
      msg := 'Error in inserting ps node ';
    ELSE
      msg := 'Error in updating ps node ';
    END IF;
    msg := msg || :new.ps_node_id || ' with node type of ' || :new.ps_node_type
           || ': instantiable_flag value ';

    IF (:new.instantiable_flag IS NULL) THEN
      msg := msg || 'is null.';
    ELSE
      msg := msg || :new.instantiable_flag || ' is invalid.';
    END IF;

    raise_application_error(-20101, msg);
  END IF;
END;

/
ALTER TRIGGER "APPS"."CZ_PS_NODES_T4" ENABLE;
