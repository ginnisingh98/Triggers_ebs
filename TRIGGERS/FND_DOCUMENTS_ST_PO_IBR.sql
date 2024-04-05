--------------------------------------------------------
--  DDL for Trigger FND_DOCUMENTS_ST_PO_IBR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_DOCUMENTS_ST_PO_IBR" 
/* $Header: poatt04t.sql 115.2 99/07/17 02:20:19 porting shi $ */
BEFORE INSERT ON          "APPLSYS"."FND_DOCUMENTS_SHORT_TEXT"
FOR EACH ROW


DECLARE
  x_note_id     NUMBER;
  x_language fnd_documents_tl.language%TYPE;
  x_document_id NUMBER;
  x_category_id NUMBER;
  x_usage_id    NUMBER;
  x_note_type   fnd_documents.usage_type%TYPE;
  x_column_name VARCHAR2(50);
  x_table_name  VARCHAR2(30);
  x_foreign_id  VARCHAR2(100);

BEGIN

  IF :new.app_source_version IS NULL THEN
    x_language := fnd_global.current_language;

    po_att.get_note_info (
      :new.media_id,
      'S', -- short note
      x_document_id,
      x_category_id,
      x_usage_id,
      x_note_type );

    x_table_name := po_att.get_table_name(x_document_id);
    x_column_name := po_att.get_column_name(x_document_id);

    IF x_usage_id = -1
    OR x_table_name = 'NOT_PO_TABLE'
    OR x_column_name = 'NOT_PO_COLUMN' THEN
      RETURN; -- not a po document
    END IF;

    SELECT po_notes_s.nextval
    INTO   x_note_id
    FROM   sys.dual;

    INSERT INTO po_notes (
      document_id,        app_source_version,
      po_note_id,         last_update_date,
      last_updated_by,    last_update_login,
      creation_date,      created_by,
      title,              usage_id,
      note_type,          note,
      attribute_category, attribute1,
      attribute2,         attribute3,
      attribute4,         attribute5,
      attribute6,         attribute7,
      attribute8,         attribute9,
      attribute10,        attribute11,
      attribute12,        attribute13,
      attribute14,        attribute15 )
    SELECT
      x_document_id,          'PO_10SC',
      x_note_id,              sysdate,
      1,                      1,
      sysdate,                1,
/* zxzhang, bug#742681, truncating description */
      substrb(fdt.description,1,80), x_usage_id,
      x_note_type,            :new.short_text,
      fdt.doc_attribute_category, fdt.doc_attribute1,
      fdt.doc_attribute2,     fdt.doc_attribute3,
      fdt.doc_attribute4,     fdt.doc_attribute5,
      fdt.doc_attribute6,     fdt.doc_attribute7,
      fdt.doc_attribute8,     fdt.doc_attribute9,
      fdt.doc_attribute10,    fdt.doc_attribute11,
      fdt.doc_attribute12,    fdt.doc_attribute13,
      fdt.doc_attribute14,    fdt.doc_attribute15
    FROM  fnd_documents_tl fdt
    WHERE fdt.language = x_language
    AND   fdt.document_id = x_document_id;

    IF x_table_name = 'NOT_ATTACHED'
    OR x_column_name = 'NOT_ATTACHED' THEN
      NULL; -- creating a standard document
    ELSE
     IF x_table_name = 'MTL_SYSTEM_ITEMS' THEN
        select fad.pk2_value
        into x_foreign_id
        from fnd_attached_documents fad
        where fad.document_id = x_document_id;
     ELSE
        select fad.pk1_value
        into x_foreign_id
        from fnd_attached_documents fad
        where fad.document_id = x_document_id;
    END IF;

      /* Bug 469635. Hvadlamu: Added the above conditions to take care
       of the condition where table name is MTL_SYSTEM_ITEMS.
       Added the variable x_foreign_id. Using this variable in
       the INSERT rather than fad.pk1_value which was there before. */

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
        fad.seq_num,          fad.attribute_category,
        fad.attribute1,       fad.attribute2,
        fad.attribute3,       fad.attribute4,
        fad.attribute5,       fad.attribute6,
        fad.attribute7,       fad.attribute8,
        fad.attribute9,       fad.attribute10,
        fad.attribute11,      fad.attribute12,
        fad.attribute13,      fad.attribute14,
        fad.attribute15,      'PO_10SC',
      fad.attached_document_id
      FROM  fnd_attached_documents fad
      WHERE fad.document_id = x_document_id;
    END IF;

  ELSIF :new.app_source_version = 'PO_R10' THEN
    :new.app_source_version := '';

  END IF;

END;



/
ALTER TRIGGER "APPS"."FND_DOCUMENTS_ST_PO_IBR" DISABLE;
