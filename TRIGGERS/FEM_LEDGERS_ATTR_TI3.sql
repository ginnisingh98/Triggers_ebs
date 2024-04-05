--------------------------------------------------------
--  DDL for Trigger FEM_LEDGERS_ATTR_TI3
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_LEDGERS_ATTR_TI3" 
after insert on "FEM"."FEM_LEDGERS_ATTR"
referencing new as FEM_LEDGERS_ATTR
for each row
declare

v_calphier_attr_id fem_dim_attributes_b.attribute_id%type;
v_calphier_id fem_ledgers_attr.dim_attribute_numeric_member%type;
v_calendar_id fem_ledger_dim_vs_maps.calendar_id%type;


begin

   SELECT A.attribute_id
   INTO v_calphier_attr_id
   FROM fem_dim_attributes_b A, fem_dimensions_b D
   WHERE D.dimension_varchar_label='LEDGER'
   AND D.dimension_id = A.dimension_id
   AND A.attribute_varchar_label='CAL_PERIOD_HIER_OBJ_DEF_ID';

IF :FEM_LEDGERS_ATTR.attribute_id = v_calphier_attr_id THEN

   SELECT H.calendar_id
   INTO v_calendar_id
   FROM fem_hierarchies H, fem_object_definition_b O
   WHERE O.object_definition_id = :FEM_LEDGERS_ATTR.dim_attribute_numeric_member
   AND O.object_id = H.hierarchy_obj_id;


      MERGE INTO fem_ledger_dim_vs_maps L
      USING (SELECT
        :FEM_LEDGERS_ATTR.ledger_id as ledger_id
	             ,v_calendar_id as calendar_id
        FROM dual) A
       ON (A.ledger_id = L.ledger_id)
       WHEN MATCHED THEN UPDATE SET
      L.calendar_id = v_calendar_id
      WHEN NOT MATCHED THEN INSERT (
      L.LEDGER_ID,
      L.CALENDAR_ID
      )
      VALUES    (:FEM_LEDGERS_ATTR.ledger_id
                 ,v_calendar_id
 );


END IF;

exception
   WHEN others THEN null;

end;

/
ALTER TRIGGER "APPS"."FEM_LEDGERS_ATTR_TI3" ENABLE;
