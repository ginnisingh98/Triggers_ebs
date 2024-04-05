--------------------------------------------------------
--  DDL for Trigger GME_RESOURCE_TXNS_D1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GME_RESOURCE_TXNS_D1" 
BEFORE  DELETE ON "GME"."GME_RESOURCE_TXNS"
FOR EACH ROW
DECLARE
-- pawan kumar changed orgn_code to organization_id for bug 4999940
  CURSOR Cur_get_resource_id (p_orgn_id NUMBER,
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

  /* We are dealing with a pending transaction */
  IF :old.completed_ind = 0 THEN

    OPEN Cur_get_resource_id (:old.organization_id,
                              :old.resources);
    FETCH Cur_get_resource_id INTO l_resource_id;

    IF Cur_get_resource_id%FOUND THEN

      --- Update the table by decrementing the number
      --- of required units for the deleted interval
       UPDATE
          gme_resource_txns_summary
       SET
          required_units    = required_units - 1,
          last_updated_by   = :old.last_updated_by,
          last_update_date  = :old.last_update_date,
          last_update_login = :old.last_update_login
       WHERE
          start_date                     = :old.start_date AND
          end_date                       = :old.end_date   AND
          resource_id                    = l_resource_id   AND
          NVL(instance_id, -1)           = NVL(:old.instance_id, -1) AND
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
          required_units                 <= 0;

    END IF;

    CLOSE Cur_get_resource_id;

  END IF;

  EXCEPTION
    WHEN OTHERS THEN
      FND_MESSAGE.SET_NAME('GME', 'GME_UNEXPECTED_ERROR');
      FND_MESSAGE.SET_TOKEN('ERROR', sqlerrm);
      APP_EXCEPTION.raise_exception;

END GME_RESOURCE_TXNS_D1;


/
ALTER TRIGGER "APPS"."GME_RESOURCE_TXNS_D1" ENABLE;
