--------------------------------------------------------
--  DDL for Trigger GME_RESOURCE_TXNS_U1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GME_RESOURCE_TXNS_U1" 
BEFORE  UPDATE ON "GME"."GME_RESOURCE_TXNS"
FOR EACH ROW
DECLARE
-- pawan kumar changed orgn_code to organization_id for bug 4999940
  l_resource_id NUMBER(15);

  FUNCTION Get_Resource_Id (p_orgn_id NUMBER,
                            p_resource_code VARCHAR2) RETURN NUMBER IS


    l_resource_id NUMBER(15);

    CURSOR Cur_get_resource_id IS
      SELECT
        resource_id
      FROM
        cr_rsrc_dtl
      WHERE
        resources = p_resource_code AND
        organization_id = p_orgn_id;

  BEGIN

    OPEN Cur_get_resource_id;

    FETCH Cur_get_resource_id INTO l_resource_id;

    IF Cur_get_resource_id%NOTFOUND THEN
      l_resource_id := NULL;
    END IF;

    CLOSE Cur_get_resource_id;

    RETURN l_resource_id;

  END Get_Resource_Id;


BEGIN

  /* We have changed a pending transaction */
  IF :new.completed_ind = 0 AND :old.completed_ind = 0 THEN

    l_resource_id := Get_Resource_Id (:new.organization_id, :new.resources);

    IF (:old.start_date    <> :new.start_date OR
        :old.end_date      <> :new.end_date) AND l_resource_id IS NOT NULL THEN

      --- First try to update the table by decrementing the number
      --- of required units for the old interval.

      UPDATE
         gme_resource_txns_summary
      SET
         required_units    = required_units - 1,
         last_updated_by   = :new.last_updated_by,
         last_update_date  = :new.last_update_date,
         last_update_login = :new.last_update_login
      WHERE
         start_date                     = :old.start_date AND
         end_date                       = :old.end_date   AND
         resource_id                    = l_resource_id   AND
         NVL(instance_id, -1)           = NVL(:old.instance_id, -1) AND
         sequence_dependent_ind         = NVL(:old.sequence_dependent_ind, 0);

      --- Next, delete the interval if the required units are null
      DELETE
         gme_resource_txns_summary
      WHERE
         start_date                     = :old.start_date  AND
         end_date                       = :old.end_date    AND
         resource_id                    = l_resource_id    AND
         NVL(instance_id, -1)           = NVL(:old.instance_id, -1) AND
         sequence_dependent_ind         = NVL(:old.sequence_dependent_ind, 0) AND
         required_units                <= 0;

      IF :new.start_date < :new.end_date THEN

        --- Try to update the table by incrementing the required units
        --- within the new interval
        UPDATE
         gme_resource_txns_summary
        SET
         required_units    = required_units + 1,
         last_updated_by   = :new.last_updated_by,
         last_update_date  = :new.last_update_date,
         last_update_login = :new.last_update_login
        WHERE
         start_date                     = :new.start_date AND
         end_date                       = :new.end_date   AND
         resource_id                    = l_resource_id   AND
         NVL(instance_id, -1)           = NVL(:new.instance_id, -1) AND
         sequence_dependent_ind         = NVL(:new.sequence_dependent_ind, 0);


        IF (SQL%NOTFOUND AND
          :new.start_date < :new.end_date) THEN

          --- This new interval does not exist, we need to create it

          INSERT INTO gme_resource_txns_summary
                    ( resource_id
                     ,instance_id
                     ,start_date
                     ,end_date
                     ,required_units
                     ,sequence_dependent_ind
                     ,creation_date
                     ,last_update_date
                     ,created_by
                     ,last_updated_by
                     ,last_update_login)
             VALUES
                    ( l_resource_id
                     ,:new.instance_id
                     ,:new.start_date
                     ,:new.end_date
                     ,1
                     ,NVL(:new.sequence_dependent_ind, 0)
                     ,:new.creation_date
                     ,:new.last_update_date
                     ,:new.created_by
                     ,:new.last_updated_by
                     ,:new.last_update_login);
        END IF;

      END IF;

    END IF;

  /* We are completing a transaction. This is treated as a delete */
  ELSIF :old.completed_ind = 0 AND :new.completed_ind = 1 THEN

    l_resource_id := Get_Resource_Id (:new.organization_id, :new.resources);

    IF l_resource_id IS NOT NULL THEN

      --- Update the table by decrementing the number
      --- of required units for the deleted interval
      UPDATE
         gme_resource_txns_summary
      SET
         required_units    = required_units - 1,
         last_updated_by   = :new.last_updated_by,
         last_update_date  = :new.last_update_date,
         last_update_login = :new.last_update_login
      WHERE
         start_date                     = :old.start_date AND
         end_date                       = :old.end_date   AND
         resource_id                    = l_resource_id   AND
         NVL(instance_id, -1)           = NVL(:old.instance_id, -1)  AND
         sequence_dependent_ind         = NVL(:old.sequence_dependent_ind, 0);


      --- Delete this row in case the required unit is null
      DELETE
         gme_resource_txns_summary
      WHERE
         start_date                     = :old.start_date  AND
         end_date                       = :old.end_date    AND
         resource_id                    = l_resource_id    AND
         NVL(instance_id, -1)           = NVL(:old.instance_id, -1) AND
         sequence_dependent_ind         = NVL(:old.sequence_dependent_ind, 0) AND
         required_units                <= 0;

    END IF;

  /* We are reversing a compleed transaction to a pending transaction. */
  /* This is treated as an insert */
  ELSIF :old.completed_ind = 1 AND :new.completed_ind = 0 THEN

    l_resource_id := Get_Resource_Id (:new.organization_id, :new.resources);

    IF :new.start_date < :new.end_date AND l_resource_id IS NOT NULL THEN

      --- First try to update the table by incrementing the number
      --- of required units.
      UPDATE
         gme_resource_txns_summary
      SET
         required_units    = required_units + 1,
         last_updated_by   = :new.last_updated_by,
         last_update_date  = :new.last_update_date,
         last_update_login = :new.last_update_login
      WHERE
         start_date                     = :new.start_date AND
         end_date                       = :new.end_date   AND
         resource_id                    = l_resource_id   AND
         NVL(instance_id, -1)           = NVL(:new.instance_id, -1) AND
         sequence_dependent_ind         = NVL(:new.sequence_dependent_ind, 0);


      IF (SQL%NOTFOUND) THEN

        --- This new interval does not exist, we need to create it

        INSERT INTO gme_resource_txns_summary
                    ( resource_id
                     ,instance_id
                     ,start_date
                     ,end_date
                     ,required_units
                     ,sequence_dependent_ind
                     ,creation_date
                     ,last_update_date
                     ,created_by
                     ,last_updated_by
                     ,last_update_login)
             VALUES
                    ( l_resource_id
                     ,:new.instance_id
                     ,:new.start_date
                     ,:new.end_date
                     ,1
                     ,NVL(:new.sequence_dependent_ind, 0)
                     ,:new.creation_date
                     ,:new.last_update_date
                     ,:new.created_by
                     ,:new.last_updated_by
                     ,:new.last_update_login);
      END IF;

    END IF;

  END IF;

  EXCEPTION
      WHEN OTHERS THEN
        FND_MESSAGE.SET_NAME('GME', 'GME_UNEXPECTED_ERROR');
        FND_MESSAGE.SET_TOKEN('ERROR', sqlerrm);
        APP_EXCEPTION.raise_exception;

END GME_RESOURCE_TXNS_U1;


/
ALTER TRIGGER "APPS"."GME_RESOURCE_TXNS_U1" ENABLE;
