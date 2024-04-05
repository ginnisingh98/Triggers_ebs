--------------------------------------------------------
--  DDL for Trigger PA_PJI_PROJ_CLASS_T3
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PA_PJI_PROJ_CLASS_T3" 
AFTER DELETE ON "PA"."PA_PROJECT_CLASSES"
FOR EACH ROW
DECLARE
	l_event_id NUMBER;
        l_row_id VARCHAR2(18);
    l_include_in_pji_flag varchar2(1); -- Bug 7301657
    l_template_flag   varchar2(1);--Bug 6603019

    cursor c_check_pji_flag(c_class_category PA_PROJECT_CLASSES.CLASS_CATEGORY%type)
    is
    	select include_in_pji_flag
    	from pa_class_categories
    	where class_category =  c_class_category;

    cursor c_check_proj_template(c_project_id PA_PROJECTS_ALL.PROJECT_ID%type) --Bug 6603019
    is
    	select template_flag
    	from pa_projects_All
    	where project_id =  c_project_id;

BEGIN

	open c_check_pji_flag(:OLD.CLASS_CATEGORY);
	fetch c_check_pji_flag into l_include_in_pji_flag;
	close c_check_pji_flag;

	 open c_check_proj_template(:OLD.project_id); --Bug 6603019
         fetch c_check_proj_template into l_template_flag;
         close c_check_proj_template;


	if l_include_in_pji_flag = 'Y' and  l_template_flag <> 'Y' then --Bug 6603019

	    PA_PJI_PROJ_EVENTS_LOG_PKG.Insert_Row(
		X_ROW_ID                => l_row_id,
		X_EVENT_ID       	=> l_event_id,
		X_EVENT_TYPE		=> 'Classifications',
		X_EVENT_OBJECT	      	=> :OLD.project_id,
		X_OPERATION_TYPE	=> 'D',
		X_STATUS        	=> 'X',  --NULL
		X_ATTRIBUTE_CATEGORY	=> NULL,
		X_ATTRIBUTE1	        => :OLD.CLASS_CODE,
		X_ATTRIBUTE2	        => :OLD.CLASS_CATEGORY,
		X_ATTRIBUTE3	        => :OLD.CODE_PERCENTAGE,
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

    end if;

END;

/
ALTER TRIGGER "APPS"."PA_PJI_PROJ_CLASS_T3" ENABLE;
