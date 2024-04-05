--------------------------------------------------------
--  DDL for Trigger GMDFMTRG_UPD_FS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMDFMTRG_UPD_FS" 
AFTER UPDATE
ON "GMD"."FM_FORM_MST_B"
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
   WHEN ( NEW.orgn_code <> OLD.orgn_code ) DECLARE
    l_formula_security_id   gmd_formula_security.formula_security_id%TYPE;
    CURSOR P2 IS SELECT  formula_security_id FROM    GMD_FORMULA_SECURITY fsp
                                             WHERE   fsp.orgn_code = :OLD.orgn_code
                                             AND     fsp.formula_id = :OLD.formula_id;
BEGIN

--
--	Delete the rows in GMD_FORMULA_SECURITY for the formula_id
--	created by the profiles defined for the old Owning Organization.
--
    OPEN P2;
    LOOP
        FETCH P2 INTO l_formula_security_id;
        EXIT WHEN P2%NOTFOUND;
    	DELETE gmd_formula_security
    	WHERE formula_security_id = l_formula_security_id;
    END Loop;
    CLOSE P2;
 END;


/
ALTER TRIGGER "APPS"."GMDFMTRG_UPD_FS" ENABLE;
