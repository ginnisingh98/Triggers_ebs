--------------------------------------------------------
--  DDL for Trigger CN_DIM_HIERARCHIES_T2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CN_DIM_HIERARCHIES_T2" 
AFTER UPDATE ON "CN"."CN_DIM_HIERARCHIES_ALL"
REFERENCING OLD AS old
	    NEW AS new
FOR EACH ROW
DECLARE
  x_head_name 	varchar2(30);
BEGIN

/* 11/22/99 - SK

  DELETE cn_dim_hier_periods WHERE dim_hierarchy_id = :old.dim_hierarchy_id;

  IF :new.end_period_id IS NULL THEN
    INSERT INTO cn_dim_hier_periods
	(header_hierarchy_id, period_id, dim_hierarchy_id)
	SELECT	:new.header_dim_hierarchy_id,
	      	mid.period_id,
	   	:new.dim_hierarchy_id
	  FROM  cn_periods mid
	 WHERE
	   	NOT(mid.period_id < :new.start_period_id);

  ELSE

    INSERT INTO cn_dim_hier_periods
	(header_hierarchy_id, period_id, dim_hierarchy_id)
	SELECT	:new.header_dim_hierarchy_id,
	      	mid.period_id,
	   	:new.dim_hierarchy_id
	  FROM  cn_periods mid
	 WHERE
	        NOT(mid.period_id > :new.end_period_id)
	   AND	NOT(mid.period_id < :new.start_period_id);

  END IF;

*/

  -- invoke mark_event here
  IF (:NEW.start_date <> :old.start_date)
    OR ( :old.end_date IS NULL AND :NEW.end_date IS NOT NULL )
      OR ( :old.end_date IS NOT NULL AND :NEW.end_date IS NULL)
	OR (:old.end_date IS NOT NULL AND :NEW.end_date IS NOT NULL
	    AND :old.end_date <> :new.end_date )
	  THEN

     BEGIN
	select name into x_head_name
	  from cn_head_hierarchies headHier -- MOAC
	  where head_hierarchy_id = :new.header_dim_hierarchy_id
      AND headHier.org_id = :new.org_id;

     IF cn_mark_events_pkg.check_cls_hier(:new.header_dim_hierarchy_id,:new.org_id) = 1 THEN
	cn_mark_events_pkg.mark_event_cls_hier
	              ('CHANGE_CLS_HIER_DATE', x_head_name,
		       :new.dim_hierarchy_id, :NEW.header_dim_hierarchy_id,
		       :new.start_date, :old.start_date,
		       :new.end_date, :old.end_date,:new.org_id);

      ELSIF cn_mark_events_pkg.check_rev_hier(:new.header_dim_hierarchy_id,:new.org_id) = 1 THEN
	cn_mark_events_pkg.mark_event_rc_hier
	              ('CHANGE_RC_HIER_DATE', x_head_name,
		       :new.dim_hierarchy_id,:NEW.header_dim_hierarchy_id,
		       :new.start_date, :old.start_date,
		       :new.end_date, :old.end_date,:new.org_id);
     END IF;

     EXCEPTION WHEN OTHERS THEN
	-- if header hiearchy doesn't exist, --don't need to mark
	NULL;
     END;

  END IF;

END cn_dim_hierarchies_t2;
/
ALTER TRIGGER "APPS"."CN_DIM_HIERARCHIES_T2" ENABLE;
