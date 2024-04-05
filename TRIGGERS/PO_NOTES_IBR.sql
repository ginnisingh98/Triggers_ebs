--------------------------------------------------------
--  DDL for Trigger PO_NOTES_IBR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PO_NOTES_IBR" 
/* $Header: poatt04t.sql 115.2 99/07/17 02:20:19 porting shi $ */
BEFORE INSERT ON          "PO"."PO_NOTES"
FOR EACH ROW


DECLARE
  x_document_id NUMBER;
  x_media_id    NUMBER;
  x_datatype_id NUMBER;

BEGIN

  IF :new.app_source_version IS NULL THEN
    SELECT fnd_documents_s.nextval
    INTO   x_document_id
    FROM   sys.dual;

    po_att.mark_record (:new.po_note_id, 'L', 'NOTE', 'INSERT', 'PO_R10');
    :new.document_id := x_document_id;

  END IF;

  :new.app_source_version := '';

END;


/
ALTER TRIGGER "APPS"."PO_NOTES_IBR" DISABLE;
