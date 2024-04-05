--------------------------------------------------------
--  DDL for Trigger CN_HIERARCHY_EDGES_T2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CN_HIERARCHY_EDGES_T2" 
AFTER INSERT ON "CN"."CN_HIERARCHY_EDGES_ALL"
REFERENCING 	NEW as new
	OLD as old
FOR EACH ROW
DECLARE

  child_exist   varchar2(1);
  X_header_id	NUMBER(15);
  X_period_id	NUMBER(15);

  -- for marking event
  CURSOR l_dim_hier_csr IS
     SELECT head.name, head.head_hierarchy_id,
        head.org_id, -- MOAC changes
       dim.start_date, dim.end_date
       FROM cn_dim_hierarchies dim,
       cn_head_hierarchies head
       WHERE dim.dim_hierarchy_id = :new.dim_hierarchy_id
       AND head.head_hierarchy_id = dim.header_dim_hierarchy_id
       AND head.org_id = dim.org_id;

BEGIN

  child_exist := cn_dim_hierarchy_utilities.node_exist
			(:new.dim_hierarchy_id,
			 :new.value_id);


  IF ( child_exist = 'N' ) THEN

    cn_debug.print_msg('child not exist',1);
    INSERT INTO cn_dim_explosion
	   (dim_hierarchy_id,
	    value_id,
	    ancestor_id,
	    hierarchy_level,
	    ancestor_external_id,
	    value_external_id,
	    org_id
	   )
   (SELECT :new.dim_hierarchy_id,
	   :new.value_id,
	   :new.value_id,
	   0,
	   val.external_id,
	   val.external_id,
	   :new.org_id
      FROM cn_hierarchy_nodes val
     WHERE val.value_id = :new.value_id
       AND val.dim_hierarchy_id = :new.dim_hierarchy_id
       AND val.org_id = :new.org_id);

  END IF;

  IF :new.parent_value_id IS NOT NULL THEN

    child_exist := cn_dim_hierarchy_utilities.node_exist
			(:new.dim_hierarchy_id,
			 :new.parent_value_id);

    IF ( child_exist = 'N' ) THEN

      cn_debug.print_msg('child not exist',1);
      INSERT INTO cn_dim_explosion
	   (dim_hierarchy_id,
	    value_id,
	    ancestor_id,
	    hierarchy_level,
	    ancestor_external_id,
	    value_external_id,
	    org_id
	   )
     (SELECT :new.dim_hierarchy_id,
	     :new.parent_value_id,
	     :new.parent_value_id,
	     0,
	     val.external_id,
	     val.external_id,
	     :new.org_id
        FROM cn_hierarchy_nodes val
       WHERE val.value_id = :new.parent_value_id
         AND val.dim_hierarchy_id = :new.dim_hierarchy_id
         AND val.org_id = :new.org_id);

    END IF;

  END IF;


  IF ( :new.parent_value_id IS NOT NULL ) THEN

    -- for a new edge connecting two not null nodes, insert all
    -- the ancestors for the new value
    cn_debug.print_msg('inserting edges',1);
    cn_debug.print_msg('dim_hierarchy_id = '||:new.dim_hierarchy_id,1);
    INSERT INTO cn_dim_explosion
       (dim_hierarchy_id,
	value_id,
	ancestor_id,
	hierarchy_level,
	value_external_id,
	ancestor_external_id,
    org_id)
    SELECT :new.dim_hierarchy_id,
	   exp1.value_id,
	   exp2.ancestor_id,
           exp2.hierarchy_level + 1,
	   exp1.value_external_id,
	   exp2.ancestor_external_id,
	   :new.org_id
      FROM cn_dim_explosion	exp1,
	   cn_dim_explosion	exp2
     WHERE exp1.ancestor_id 	 = :new.value_id
       AND exp2.value_id    	 = :new.parent_value_id
       AND exp1.dim_hierarchy_id = :new.dim_hierarchy_id
       AND exp2.dim_hierarchy_id = :new.dim_hierarchy_id
       AND exp1.org_id = :new.org_id
       AND exp2.org_id = :new.org_id;

  END IF;

  -- marking event here
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

EXCEPTION
  WHEN OTHERS THEN
    cn_debug.print_msg(sqlerrm,1);
    RAISE;

END cn_hierarchy_edges_t2;
/
ALTER TRIGGER "APPS"."CN_HIERARCHY_EDGES_T2" ENABLE;
