--------------------------------------------------------
--  DDL for Trigger XXAH_OBL_BIR_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XXAH_OBL_BIR_T1" 
  BEFORE INSERT OR UPDATE ON ONT.OE_BLANKET_LINES_ALL
REFERENCING OLD AS OLD
            NEW AS NEW
  FOR EACH ROW
DECLARE
  CURSOR c_mcr(b_inventory_item_id mtl_cross_references.inventory_item_id%TYPE
              ,b_org_id hr_organization_information.organization_id%TYPE) IS
  SELECT mcr.attribute5
  ,      mcr.attribute6
  FROM   mtl_cross_references mcr
  ,      hr_organization_information  hoi
  WHERE  inventory_item_id = b_inventory_item_id
  AND    hoi.org_information19  = mcr.cross_reference_type
	AND    hoi.org_information_context = 'Operating Unit Information'
  AND    hoi.organization_id = b_org_id
  ;
  v_mcr c_mcr%ROWTYPE;
  v_found BOOLEAN;
BEGIN
  IF :new.inventory_item_id IS NOT NULL THEN
    OPEN c_mcr(:new.inventory_item_id
               ,:new.org_id);
    FETCH c_mcr INTO v_mcr;
    v_found := c_mcr%FOUND;
    CLOSE c_mcr;
    IF v_found THEN
      IF :new.attribute8 = 'A' THEN
        :new.attribute6 := v_mcr.attribute5;
      ELSE
        :new.attribute6 := v_mcr.attribute6;
      END IF;
    END IF;
  END IF;
  :new.attribute7 := :new.line_id;
EXCEPTION
  WHEN OTHERS THEN
    NULL;
END xxah_obl_bir_t1;

/
ALTER TRIGGER "APPS"."XXAH_OBL_BIR_T1" ENABLE;
