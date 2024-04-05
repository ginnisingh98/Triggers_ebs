--------------------------------------------------------
--  DDL for Trigger XXAH_PON_BID_HEADERS_BU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XXAH_PON_BID_HEADERS_BU" 
BEFORE UPDATE ON "PON"."PON_BID_HEADERS"
FOR EACH ROW
BEGIN
  IF  :old.po_header_id IS NULL
  AND :new.po_header_id IS NOT NULL
  THEN
    BEGIN
      xxah_attch_pkg.remove_terms( :new.po_header_id );
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;
  END IF;
END XXAH_PON_BID_HEADERS_BU;


/
ALTER TRIGGER "APPS"."XXAH_PON_BID_HEADERS_BU" ENABLE;
