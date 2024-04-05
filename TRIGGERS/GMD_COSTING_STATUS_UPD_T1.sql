--------------------------------------------------------
--  DDL for Trigger GMD_COSTING_STATUS_UPD_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMD_COSTING_STATUS_UPD_T1" 
	AFTER UPDATE of PERIOD_STATUS
	ON "GMF"."GMF_PERIOD_STATUSES"
	FOR EACH ROW
          WHEN (new.period_status = 'F') DECLARE

 l_conc_id NUMBER;
 l_boolean BOOLEAN;
 l_cost_mthd_type NUMBER(5);

BEGIN

  IF (:new.period_status = 'F') THEN
	SELECT cost_type
	INTO   l_cost_mthd_type
	FROM   cm_mthd_mst
	WHERE  cost_type_id = :new.cost_type_id;

      IF (l_cost_mthd_type = 0) THEN
	  l_boolean := fnd_request.set_mode(TRUE);
         /* Submit concurrent process that updates status of relevant GMD tables to frozen */
	  l_conc_id := FND_REQUEST.SUBMIT_REQUEST('GMD','GMD_COSTING_STATUS_UPDATE',
	 					  '','',FALSE,
	 					  :new.legal_entity_id,
	 					  :new.calendar_code,
					          :new.Period_code,
					          :new.cost_type_id,
					          chr(0),'','','','','','',
					          '','','','','','','','','','',
					          '','','','','','','','','','',
					          '','','','','','','','','','',
					          '','','','','','','','','','',
					          '','','','','','','','','','',
					          '','','','','','','','','','',
					          '','','','','','','','','','',
					          '','','','','','','','','','',
					          '','','','','','','','','');
      END IF;
  END IF;

END;
--End Bug 7027512

/
ALTER TRIGGER "APPS"."GMD_COSTING_STATUS_UPD_T1" ENABLE;
