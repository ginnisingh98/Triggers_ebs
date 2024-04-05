--------------------------------------------------------
--  DDL for Trigger FEM_LEDGERS_ATTR_TI2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_LEDGERS_ATTR_TI2" 
after insert on "FEM"."FEM_LEDGERS_ATTR"
referencing new as FEM_LEDGERS_ATTR
for each row
declare

   v_func_currency_attr_id fem_dim_attributes_b.attribute_id%type;
begin

SELECT A.attribute_id
INTO v_func_currency_attr_id
FROM fem_dim_attributes_b A, fem_dimensions_b D
WHERE D.dimension_varchar_label='LEDGER'
AND D.dimension_id = A.dimension_id
AND A.attribute_varchar_label='LEDGER_FUNCTIONAL_CRNCY_CODE';


IF :FEM_LEDGERS_ATTR.attribute_id = v_func_currency_attr_id THEN

      MERGE INTO fem_ledger_dim_vs_maps L
      USING (SELECT
        :FEM_LEDGERS_ATTR.ledger_id as ledger_id
	             ,:FEM_LEDGERS_ATTR.dim_attribute_varchar_member as functional_currency_code
        FROM dual) A
       ON (A.ledger_id = L.ledger_id)
       WHEN MATCHED THEN UPDATE SET
      L.functional_currency_code = :FEM_LEDGERS_ATTR.dim_attribute_varchar_member
      WHEN NOT MATCHED THEN INSERT (
      L.LEDGER_ID,
      L.FUNCTIONAL_CURRENCY_CODE
      )
      VALUES    (:FEM_LEDGERS_ATTR.ledger_id
                 ,:FEM_LEDGERS_ATTR.dim_attribute_varchar_member
 );


END IF;

exception
   WHEN others THEN null;

end;

/
ALTER TRIGGER "APPS"."FEM_LEDGERS_ATTR_TI2" ENABLE;
