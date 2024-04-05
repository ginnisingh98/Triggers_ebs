--------------------------------------------------------
--  DDL for Trigger PO_NOTES_DAR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PO_NOTES_DAR" 
/* $Header: poatt04t.sql 115.2 99/07/17 02:20:19 porting shi $ */
AFTER DELETE ON           "PO"."PO_NOTES"
FOR EACH ROW


DECLARE
  x_usage_type VARCHAR2(1) := '';
  x_media_id NUMBER;
  x_datatype_id NUMBER;
  x_mutate exception;
  PRAGMA EXCEPTION_INIT (x_mutate, -4091);

BEGIN

  SELECT usage_type
  INTO   x_usage_type
  FROM   fnd_documents
  WHERE  document_id = :old.document_id;

  IF x_usage_type = 'O' THEN -- delete only when one-time note
    po_att.delete_document (:old.document_id);
  END IF;


  EXCEPTION
  WHEN x_mutate THEN
--    dbms_output.put_line ('mutating at po_notes_dar');
    NULL;
  WHEN NO_DATA_FOUND THEN
    NULL; -- no document need to be deleted
  WHEN OTHERS THEN
    RAISE;
END;


/
ALTER TRIGGER "APPS"."PO_NOTES_DAR" DISABLE;
