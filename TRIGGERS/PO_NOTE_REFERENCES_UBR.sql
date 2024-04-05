--------------------------------------------------------
--  DDL for Trigger PO_NOTE_REFERENCES_UBR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PO_NOTE_REFERENCES_UBR" 
/* $Header: poatt04t.sql 115.2 99/07/17 02:20:19 porting shi $ */
BEFORE UPDATE ON          "PO"."PO_NOTE_REFERENCES"
FOR EACH ROW


DECLARE
  x_attached_doc_id NUMBER;
  x_entity_name fnd_attached_documents.entity_name%TYPE;

BEGIN

  IF :new.app_source_version IS NULL THEN
    po_att.update_attached_document (
      :new.attached_doc_id,
      :new.creation_date,
      :new.created_by,
      :new.po_note_id,
      :new.table_name,
      :new.column_name,
      :new.foreign_id,
      :new.sequence_num,
      :new.attribute_category,
      :new.attribute1,
      :new.attribute2,
      :new.attribute3,
      :new.attribute4,
      :new.attribute5,
      :new.attribute6,
      :new.attribute7,
      :new.attribute8,
      :new.attribute9,
      :new.attribute10,
      :new.attribute11,
      :new.attribute12,
      :new.attribute13,
      :new.attribute14,
      :new.attribute15,
      'PO_R10' );
  END IF;

  :new.app_source_version := '';

END;



/
ALTER TRIGGER "APPS"."PO_NOTE_REFERENCES_UBR" DISABLE;
