--------------------------------------------------------
--  DDL for Trigger FND_ATTACHED_DOC_PO_IBR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_ATTACHED_DOC_PO_IBR" 
/* $Header: poatt04t.sql 115.2 99/07/17 02:20:19 porting shi $ */
BEFORE INSERT ON          "APPLSYS"."FND_ATTACHED_DOCUMENTS"
FOR EACH ROW


DECLARE
  x_note_id NUMBER;
  x_table_name VARCHAR2(30);
  x_column_name VARCHAR2(50);
  x_foreign_id VARCHAR2(100);

BEGIN

  IF :new.app_source_version IS NULL THEN
    BEGIN
      SELECT po_note_id
      INTO   x_note_id
      FROM   po_notes
      WHERE  document_id = :new.document_id;

      EXCEPTION
      WHEN NO_DATA_FOUND THEN
  /* if cannot find document_id in po_notes table, then this document
     is first time created. the long/short text table triggers will
     create the po_note_references entry. So we can simply return here.
     if document_id already in po_notes table, we know this is just
     another reference. the long/short table will not touched, so we
     need to create the entry in po_note_references here.
  */
        RETURN;
      WHEN OTHERS THEN
        RAISE;
    END;

    x_table_name := po_att.get_table_name(:new.entity_name);
    x_column_name := po_att.get_column_name(:new.entity_name);

   IF x_table_name = 'NOT_PO_TABLE'
     OR x_column_name = 'NOT_PO_COLUMN' THEN
      NULL; -- might be a standard document
  ELSE
      IF x_table_name = 'MTL_SYSTEM_ITEMS' THEN
         x_foreign_id := :new.pk2_value;
      ELSE
         x_foreign_id := :new.pk1_value;
      END IF;
  END IF;

   /* Bug 469635. Hvadlamu: Added the above conditions to take care
       of the condition where table name is MTL_SYSTEM_ITEMS.
       Added the variable x_foreign_id */


    INSERT INTO po_note_references (
      po_note_reference_id, last_update_date,
      last_updated_by,      last_update_login,
      creation_date,        created_by,
      po_note_id,           table_name,
      column_name,          foreign_id,
      sequence_num,         attribute_category,
      attribute1,           attribute2,
      attribute3,           attribute4,
      attribute5,           attribute6,
      attribute7,           attribute8,
      attribute9,           attribute10,
      attribute11,          attribute12,
      attribute13,          attribute14,
      attribute15,          app_source_version,
      attached_doc_id )
    SELECT
      po_note_references_s.nextval, sysdate,
      1,                    1,
      sysdate,              1,
      x_note_id,            x_table_name,
      x_column_name,        x_foreign_id,
      :new.seq_num,         :new.attribute_category,
      :new.attribute1,      :new.attribute2,
      :new.attribute3,      :new.attribute4,
      :new.attribute5,      :new.attribute6,
      :new.attribute7,      :new.attribute8,
      :new.attribute9,      :new.attribute10,
      :new.attribute11,     :new.attribute12,
      :new.attribute13,     :new.attribute14,
      :new.attribute15,     'PO_10SC',
      :new.attached_document_id
    FROM  sys.dual;

  ELSIF :new.app_source_version = 'PO_R10' THEN
    :new.app_source_version := '';

  END IF;

END;



/
ALTER TRIGGER "APPS"."FND_ATTACHED_DOC_PO_IBR" DISABLE;
