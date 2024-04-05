--------------------------------------------------------
--  DDL for Trigger FND_DOCUMENTS_PO_UBR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_DOCUMENTS_PO_UBR" 
/* $Header: poatt04t.sql 115.2 99/07/17 02:20:19 porting shi $ */
BEFORE UPDATE OF category_id ON "APPLSYS"."FND_DOCUMENTS"
FOR EACH ROW


DECLARE
  x_usage_id NUMBER;

BEGIN

  IF :new.app_source_version IS NULL THEN
    po_att.get_usage_id (:new.category_id, x_usage_id);

    UPDATE po_notes
    SET    app_source_version = 'PO_10SC',
           usage_id = x_usage_id
    WHERE document_id = :new.document_id;

  ELSIF :new.app_source_version = 'PO_R10' THEN
    :new.app_source_version := '';

  END IF;

END;



/
ALTER TRIGGER "APPS"."FND_DOCUMENTS_PO_UBR" DISABLE;
