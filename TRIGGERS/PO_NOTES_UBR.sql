--------------------------------------------------------
--  DDL for Trigger PO_NOTES_UBR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PO_NOTES_UBR" 
/* $Header: poatt04t.sql 115.2 99/07/17 02:20:19 porting shi $ */
BEFORE UPDATE ON          "PO"."PO_NOTES"
FOR EACH ROW


DECLARE
  x_document_id NUMBER;

BEGIN

  IF :new.app_source_version IS NULL THEN
    po_att.mark_record (:new.po_note_id, 'L', 'NOTE', 'UPDATE', 'PO_R10');
  END IF;

  :new.app_source_version := '';
END;


/
ALTER TRIGGER "APPS"."PO_NOTES_UBR" DISABLE;
