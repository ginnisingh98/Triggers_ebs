--------------------------------------------------------
--  DDL for Trigger PA_PJI_PROJ_CUST_T3
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PA_PJI_PROJ_CUST_T3" 
AFTER DELETE ON "PA"."PA_PROJECT_CUSTOMERS"
FOR EACH ROW
DECLARE
	l_event_id NUMBER;
        l_row_id VARCHAR2(18);
BEGIN
null;
/* commented for bug 7374489
    PA_PJI_PROJ_EVENTS_LOG_PKG.Insert_Row(
	X_ROW_ID                => l_row_id,
	X_EVENT_ID       	=> l_event_id,
	X_EVENT_TYPE		=> 'Customers',
	X_EVENT_OBJECT	      	=> :OLD.project_id,
	X_OPERATION_TYPE	=> 'D',
	X_STATUS        	=> 'X',  --NULL
	X_ATTRIBUTE_CATEGORY	=> NULL,
	X_ATTRIBUTE1	        => :OLD.CUSTOMER_ID,
	X_ATTRIBUTE2	        => NULL,
	X_ATTRIBUTE3	        => NULL,
	X_ATTRIBUTE4	        => NULL,
	X_ATTRIBUTE5	        => NULL,
	X_ATTRIBUTE6	        => NULL,
	X_ATTRIBUTE7	        => NULL,
	X_ATTRIBUTE8	        => NULL,
	X_ATTRIBUTE9	        => NULL,
	X_ATTRIBUTE10	        => NULL,
	X_ATTRIBUTE11	        => NULL,
	X_ATTRIBUTE12	        => NULL,
	X_ATTRIBUTE13	        => NULL,
	X_ATTRIBUTE14	        => NULL,
	X_ATTRIBUTE15	        => NULL,
	X_ATTRIBUTE16	        => NULL,
	X_ATTRIBUTE17	        => NULL,
	X_ATTRIBUTE18	        => NULL,
	X_ATTRIBUTE19	        => NULL,
	X_ATTRIBUTE20	        => NULL
    );
*/
END;

/
ALTER TRIGGER "APPS"."PA_PJI_PROJ_CUST_T3" ENABLE;
