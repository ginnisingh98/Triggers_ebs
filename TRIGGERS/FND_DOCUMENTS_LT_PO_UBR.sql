--------------------------------------------------------
--  DDL for Trigger FND_DOCUMENTS_LT_PO_UBR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_DOCUMENTS_LT_PO_UBR" 
/* $Header: poatt04t.sql 115.2 99/07/17 02:20:19 porting shi $ */
BEFORE UPDATE OF long_text ON "APPLSYS"."FND_DOCUMENTS_LONG_TEXT"
FOR EACH ROW


DECLARE
  x_document_id NUMBER;

BEGIN

  IF :new.app_source_version IS NULL THEN
    po_att.mark_record (:new.media_id, 'L', 'DOCUMENT', 'UPDATE', 'PO_10SC');

  ELSIF :new.app_source_version = 'PO_R10' THEN
    :new.app_source_version := '';

  END IF;

END;


/
ALTER TRIGGER "APPS"."FND_DOCUMENTS_LT_PO_UBR" DISABLE;
