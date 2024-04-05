--------------------------------------------------------
--  DDL for Trigger FND_ATTACHED_DOC_PO_DAR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_ATTACHED_DOC_PO_DAR" 
/* $Header: poatt04t.sql 115.2 99/07/17 02:20:19 porting shi $ */
AFTER DELETE ON           "APPLSYS"."FND_ATTACHED_DOCUMENTS"
FOR EACH ROW


DECLARE
  x_reference_id NUMBER;
  x_mutate exception;
  PRAGMA EXCEPTION_INIT (x_mutate, -4091);

BEGIN

  SELECT po_note_reference_id
  INTO   x_reference_id
  FROM   po_note_references
  WHERE  attached_doc_id = :old.attached_document_id;

  -- if above select statement found no data, an exception will be
  -- raised and the following delete will never executed.

  DELETE FROM po_note_references
  WHERE       po_note_reference_id = x_reference_id;


  EXCEPTION
  WHEN x_mutate THEN
--    dbms_output.put_line ('mutating at fnd_attached_doc_po_dar');
    NULL;
  WHEN NO_DATA_FOUND THEN
    NULL; -- do nothing. note ref already deleted.
  WHEN OTHERS THEN
    RAISE;
END;



/
ALTER TRIGGER "APPS"."FND_ATTACHED_DOC_PO_DAR" DISABLE;
