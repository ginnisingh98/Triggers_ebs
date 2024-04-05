--------------------------------------------------------
--  DDL for Trigger XXAH_PO_HEADERS_ALL_TRI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XXAH_PO_HEADERS_ALL_TRI" 
BEFORE INSERT ON po.po_headers_all
FOR EACH ROW
DECLARE
  l_type_lookup_code po_headers_all.type_lookup_code%TYPE;
BEGIN
  l_type_lookup_code:= :new.type_lookup_code;

  IF l_type_lookup_code = 'BLANKET' THEN
    :new.global_agreement_flag:= 'Y';
  END IF;

END xxah_po_headers_all_TRI;


/
ALTER TRIGGER "APPS"."XXAH_PO_HEADERS_ALL_TRI" ENABLE;
