--------------------------------------------------------
--  DDL for Trigger GME_RESOURCE_TXNS_I1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GME_RESOURCE_TXNS_I1" 
BEFORE  INSERT ON "GME"."GME_RESOURCE_TXNS"
FOR EACH ROW
DECLARE
-- pawan kumar changed orgn_code to organization_id for bug 4999940
  CURSOR Cur_get_resource_id (p_orgn_id   NUMBER,
                              p_resource  VARCHAR2) IS
    SELECT
       resource_id
    FROM
       cr_rsrc_dtl
    WHERE
       resources = p_resource AND
       organization_id = p_orgn_id;

  l_resource_id NUMBER(15);

BEGIN

  -- We are creating a pending transaction */
  IF :new.completed_ind = 0 AND :new.start_date < :new.end_date THEN

    OPEN Cur_get_resource_id (:new.organization_id,
                              :new.resources);
    FETCH Cur_get_resource_id INTO l_resource_id;

    IF Cur_get_resource_id%FOUND THEN

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

    CLOSE Cur_get_resource_id;

  END IF;

    EXCEPTION
      WHEN OTHERS THEN
        FND_MESSAGE.SET_NAME('GME', 'GME_UNEXPECTED_ERROR');
        FND_MESSAGE.SET_TOKEN('ERROR', sqlerrm);
        APP_EXCEPTION.raise_exception;

END GME_RESOURCE_TXNS_I1;


/
ALTER TRIGGER "APPS"."GME_RESOURCE_TXNS_I1" ENABLE;
