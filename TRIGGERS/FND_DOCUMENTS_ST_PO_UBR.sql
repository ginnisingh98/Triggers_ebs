--------------------------------------------------------
--  DDL for Trigger FND_DOCUMENTS_ST_PO_UBR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_DOCUMENTS_ST_PO_UBR" 
/* $Header: poatt04t.sql 115.2 99/07/17 02:20:19 porting shi $ */
BEFORE UPDATE OF short_text ON "APPLSYS"."FND_DOCUMENTS_SHORT_TEXT"
FOR EACH ROW


DECLARE
  x_document_id NUMBER;

BEGIN

  IF :new.app_source_version IS NULL THEN
    po_att.get_document_id (:new.media_id, 'S', x_document_id);

    UPDATE po_notes
    SET    app_source_version = 'PO_10SC',
           note = :new.short_text
    WHERE  document_id = x_document_id;

  ELSIF :new.app_source_version = 'PO_R10' THEN
    :new.app_source_version := '';

  END IF;

END;



/
ALTER TRIGGER "APPS"."FND_DOCUMENTS_ST_PO_UBR" DISABLE;
