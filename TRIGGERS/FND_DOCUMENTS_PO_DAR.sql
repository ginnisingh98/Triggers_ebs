--------------------------------------------------------
--  DDL for Trigger FND_DOCUMENTS_PO_DAR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_DOCUMENTS_PO_DAR" 
/* $Header: poatt04t.sql 115.2 99/07/17 02:20:19 porting shi $ */
AFTER DELETE ON           "APPLSYS"."FND_DOCUMENTS"
FOR EACH ROW


DECLARE
  x_note_type VARCHAR2(25) := '';
  x_mutate exception;
  PRAGMA EXCEPTION_INIT (x_mutate, -4091);

BEGIN

  SELECT note_type
  INTO   x_note_type
  FROM   po_notes
  WHERE  document_id = :old.document_id;

  IF x_note_type = 'O' THEN -- only delete existing 'one-time' note
    DELETE FROM po_notes
    WHERE       document_id = :old.document_id;
  END IF;


  EXCEPTION
  when x_mutate then
--    dbms_output.put_line ('Mutating at fnd_documents_po_dar');
    NULL;
  WHEN NO_DATA_FOUND THEN
    NULL; -- no corresponding note exist, do nothing
  WHEN OTHERS THEN
    RAISE;
END;



/
ALTER TRIGGER "APPS"."FND_DOCUMENTS_PO_DAR" DISABLE;
