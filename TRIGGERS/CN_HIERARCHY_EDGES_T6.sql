--------------------------------------------------------
--  DDL for Trigger CN_HIERARCHY_EDGES_T6
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CN_HIERARCHY_EDGES_T6" 
AFTER UPDATE ON "CN"."CN_HIERARCHY_EDGES_ALL"
REFERENCING	NEW as new
 		OLD as old
FOR EACH ROW
DECLARE

  child_exist   varchar2(1);
  X_header_id	NUMBER(15);
  X_period_id	NUMBER(15);

  -- for marking event
  CURSOR l_dim_hier_csr IS
     SELECT head.name, head.head_hierarchy_id,
       dim.start_date, dim.end_date,dim.org_id
       FROM cn_dim_hierarchies dim,
       cn_head_hierarchies head
       WHERE dim.dim_hierarchy_id = :old.dim_hierarchy_id
       AND head.head_hierarchy_id = dim.header_dim_hierarchy_id
       AND  head.org_id = dim.org_id
       AND dim.org_id = :old.org_id;

BEGIN
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


  IF ( :new.parent_value_id IS NOT NULL ) THEN

    cn_debug.print_msg('after update: parent not null', 1);

    child_exist := cn_dim_hierarchy_utilities.node_exist
			(:new.dim_hierarchy_id,
			 :new.value_id);


    IF ( child_exist = 'N' ) THEN

    INSERT INTO cn_dim_explosion
	   (dim_hierarchy_id,
	    value_id,
	    ancestor_id,
	    hierarchy_level,
	    ancestor_external_id,
	    value_external_id
	   )
   (SELECT :new.dim_hierarchy_id,
	   :new.value_id,
	   :new.value_id,
	   0,
	   val.external_id,
	   val.external_id
      FROM cn_hierarchy_nodes val
     WHERE val.value_id = :new.value_id
       AND val.dim_hierarchy_id = :new.dim_hierarchy_id);

    END IF;

    IF :new.parent_value_id IS NOT NULL THEN

      child_exist := cn_dim_hierarchy_utilities.node_exist
			(:new.dim_hierarchy_id,
			 :new.parent_value_id);

      IF ( child_exist = 'N' ) THEN

    INSERT INTO cn_dim_explosion
	   (dim_hierarchy_id,
	    value_id,
	    ancestor_id,
	    hierarchy_level,
	    ancestor_external_id,
	    value_external_id
	   )
   (SELECT :new.dim_hierarchy_id,
	   :new.parent_value_id,
	   :new.parent_value_id,
	   0,
	   val.external_id,
	   val.external_id
      FROM cn_hierarchy_nodes val
     WHERE val.value_id = :new.parent_value_id
       AND val.dim_hierarchy_id = :new.dim_hierarchy_id);

      END IF;

    END IF;

    INSERT INTO cn_dim_explosion
       (dim_hierarchy_id,
	value_id,
	ancestor_id,
        hierarchy_level,
	value_external_id,
	ancestor_external_id)
    SELECT :new.dim_hierarchy_id,
	   exp1.value_id,
	   exp2.ancestor_id,
	   exp2.hierarchy_level + 1,
	   exp1.value_external_id,
	   exp2.ancestor_external_id
      FROM cn_dim_explosion	exp1,
	   cn_dim_explosion	exp2
     WHERE exp1.ancestor_id	 = :new.value_id
       AND exp1.dim_hierarchy_id = :new.dim_hierarchy_id
       AND exp2.value_id    	 = :new.parent_value_id
       AND exp2.dim_hierarchy_id = :new.dim_hierarchy_id;

  END IF;

  IF ( :old.parent_value_id IS NOT NULL) THEN

    DELETE cn_dim_explosion
     WHERE value_id in (SELECT value_id
  		          FROM cn_dim_explosion
		         WHERE ancestor_id      = :old.value_id
			   AND dim_hierarchy_id = :old.dim_hierarchy_id)
       AND ancestor_id in (SELECT ancestor_id
	  	  	     FROM cn_dim_explosion
  			    WHERE value_id   	   = :old.parent_value_id
			      AND dim_hierarchy_id = :old.dim_hierarchy_id)
       AND dim_hierarchy_id = :old.dim_hierarchy_id;

    -- only delete the identity record from explosion if the
    -- value is not part of a distinguished hierarchy.
    DELETE cn_dim_explosion
     WHERE value_id         = :old.value_id
       AND ancestor_id      = :old.value_id
       AND dim_hierarchy_id = :old.dim_hierarchy_id
       AND EXISTS (SELECT ref_count
		     FROM cn_hierarchy_nodes
		    WHERE value_id 	   = :old.value_id
		      AND dim_hierarchy_id = :old.dim_hierarchy_id
 		      AND ref_count        = 0);
  END IF;


END cn_hierarchy_edges_t6;
/
ALTER TRIGGER "APPS"."CN_HIERARCHY_EDGES_T6" ENABLE;
