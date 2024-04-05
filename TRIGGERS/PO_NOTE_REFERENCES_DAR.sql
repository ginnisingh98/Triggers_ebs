--------------------------------------------------------
--  DDL for Trigger PO_NOTE_REFERENCES_DAR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PO_NOTE_REFERENCES_DAR" 
/* $Header: poatt04t.sql 115.2 99/07/17 02:20:19 porting shi $ */
AFTER DELETE ON           "PO"."PO_NOTE_REFERENCES"
FOR EACH ROW


DECLARE
  x_attached_doc_id NUMBER := 0;
  x_source varchar2(10);
  x_mutate exception;
  PRAGMA EXCEPTION_INIT (x_mutate, -4091);

BEGIN

  BEGIN

   SELECT source
   INTO x_source
   FROM po_att_tmp_records
   WHERE source = 'TEMPLATE';

  po_att.clear_mark('L', 'NOTE', 'UPDATE', null);

 EXCEPTION
   WHEN NO_DATA_FOUND THEN
    /* this would happen if the trigger is fired in the course of a normal
     delete as opposed to delete executed when the on-update trigger
     is fired on the fnd_attached_documents table
    look at the trigger fnd_attached_doc_po_ubr */


  SELECT attached_document_id
  INTO   x_attached_doc_id
  FROM   fnd_attached_documents
  WHERE  attached_document_id = :old.attached_doc_id;


  po_att.delete_attached_document (:old.attached_doc_id);
 END;


  EXCEPTION
  WHEN x_mutate THEN
--    dbms_output.put_line ('mutating at po_note_references_dar');
    NULL;
  WHEN NO_DATA_FOUND THEN
    NULL;
-- record in attached documents table already deleted.
  WHEN OTHERS THEN
    RAISE;
END;



/
ALTER TRIGGER "APPS"."PO_NOTE_REFERENCES_DAR" DISABLE;
