--------------------------------------------------------
--  DDL for Trigger CN_HIERARCHY_EDGES_T4
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CN_HIERARCHY_EDGES_T4" 
AFTER DELETE ON "CN"."CN_HIERARCHY_EDGES_ALL"
REFERENCING	NEW as new
		OLD as old
FOR EACH ROW
DECLARE
  -- for marking event
   l_flag		varchar2(1);

  CURSOR l_dim_hier_csr IS
     SELECT head.name, head.head_hierarchy_id,
       dim.start_date, dim.end_date,head.org_id
       FROM cn_dim_hierarchies dim,
       cn_head_hierarchies head
       WHERE dim.dim_hierarchy_id = :old.dim_hierarchy_id
       AND head.head_hierarchy_id = dim.header_dim_hierarchy_id
       AND dim.org_id = head.org_id;

BEGIN
  --before delete entries in cn_dim_explosion, invoke mark_event_
  l_flag := fnd_profile.value('CN_HIERARCHY_EDGES_T4_ENABLE');

  IF l_flag IS NULL OR l_flag = 'Y' THEN
     FOR l_dim IN l_dim_hier_csr LOOP
	IF cn_mark_events_pkg.check_cls_hier(l_dim.head_hierarchy_id,l_dim.org_id) = 1 THEN
	   cn_mark_events_pkg.mark_event_cls_hier
	               ('CHANGE_CLS_HIER', l_dim.name,
			:old.dim_hierarchy_id, l_dim.head_hierarchy_id,
			NULL, l_dim.start_date, NULL, l_dim.end_date,l_dim.org_id);
	 ELSIF cn_mark_events_pkg.check_rev_hier(l_dim.head_hierarchy_id,l_dim.org_id) = 1 THEN
	   cn_mark_events_pkg.mark_event_rc_hier
	               ('CHANGE_RC_HIER', l_dim.name,
			:old.dim_hierarchy_id, l_dim.head_hierarchy_id,
			NULL, l_dim.start_date, NULL, l_dim.end_date,l_dim.org_id);
	END IF;
     END LOOP;
  END IF; /* trigger enable flag */

  -- after marking event, delete entries in cn_dim_explosion
  DELETE cn_dim_explosion
   WHERE value_id in (SELECT value_id
		        FROM cn_dim_explosion
		       WHERE ancestor_id      = :old.value_id
			 AND dim_hierarchy_id = :old.dim_hierarchy_id
             AND org_id = :old.org_id)
     AND ancestor_id in (SELECT ancestor_id
			   FROM cn_dim_explosion
  			  WHERE value_id   	 = :old.parent_value_id
			    AND dim_hierarchy_id = :old.dim_hierarchy_id
                AND org_id = :old.org_id)
     AND dim_hierarchy_id = :old.dim_hierarchy_id;

END;
/
ALTER TRIGGER "APPS"."CN_HIERARCHY_EDGES_T4" ENABLE;
