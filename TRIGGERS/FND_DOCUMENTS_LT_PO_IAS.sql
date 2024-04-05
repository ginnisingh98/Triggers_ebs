--------------------------------------------------------
--  DDL for Trigger FND_DOCUMENTS_LT_PO_IAS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_DOCUMENTS_LT_PO_IAS" 
/* $Header: poatt04t.sql 115.2 99/07/17 02:20:19 porting shi $ */
AFTER INSERT ON           "APPLSYS"."FND_DOCUMENTS_LONG_TEXT"


DECLARE
  x_attached_doc_id NUMBER;
  x_table_name  VARCHAR2(30);
  x_column_name VARCHAR2(50);
  x_note_id     NUMBER;
  x_language fnd_documents_tl.language%TYPE;
  x_media_id    NUMBER;
  x_version     VARCHAR2(10);
  x_doc_type    VARCHAR2(1);
  x_document_id NUMBER;
  x_category_id NUMBER;
  x_usage_id    NUMBER;
  x_note_type   fnd_documents.usage_type%TYPE;
  x_long_text   VARCHAR2(32767);
/* selecting a long text > 32760 into a long varchar2 variable will raise
   VALUE_ERROR exception.
*/
x_foreign_id VARCHAR2(100);

  CURSOR x_mark_c IS
    SELECT src_id, version
    FROM   po_att_tmp_records
    WHERE  source     = 'DOCUMENT'
    AND    short_long = 'L'
    AND    operation  = 'INSERT';

/*Mdas, Bug#407770, 10/23/96, use cursor to insert into long_text.
  this would ensure the inserts of values greater than 2K.
*/

  CURSOR sel_fad_data IS
    SELECT fdt.created_by, fdt.last_updated_by, fdt.last_update_login,
           fdt.description,     fdt.doc_attribute_category, fdt.doc_attribute1,
           fdt.doc_attribute2,     fdt.doc_attribute3,
           fdt.doc_attribute4,     fdt.doc_attribute5,
           fdt.doc_attribute6,     fdt.doc_attribute7,
           fdt.doc_attribute8,     fdt.doc_attribute9,
           fdt.doc_attribute10,    fdt.doc_attribute11,
           fdt.doc_attribute12,    fdt.doc_attribute13,
           fdt.doc_attribute14,    fdt.doc_attribute15,
           fd.start_date_active,   fd.end_date_active
    FROM  fnd_documents_tl fdt, fnd_documents fd
    WHERE fdt.document_id = x_document_id
    AND   fdt.language    = x_language
    AND   fdt.document_id = fd.document_id;

  fadrec sel_fad_data%ROWTYPE;


BEGIN

  x_language := fnd_global.current_language;

  OPEN x_mark_c;
  LOOP
    FETCH x_mark_c INTO x_media_id, x_version;
    EXIT WHEN x_mark_c%NOTFOUND;

    po_att.get_note_info (
      x_media_id,
      'L',
      x_document_id,
      x_category_id,
      x_usage_id,
      x_note_type );

    x_table_name := po_att.get_table_name(x_document_id);
    x_column_name := po_att.get_column_name(x_document_id);

    IF x_usage_id = -1
    OR x_table_name = 'NOT_PO_TABLE'
    OR x_column_name = 'NOT_PO_COLUMN' THEN
      NULL; -- not a po document
    ELSE
      BEGIN
        SELECT long_text
        INTO   x_long_text
        FROM   fnd_documents_long_text
        WHERE  media_id = x_media_id;

        EXCEPTION
        WHEN VALUE_ERROR THEN -- long exceeds 32760
          x_long_text := 'This long text exceeds 32760. ' ||
                         'Refer to fnd_documents_long_text. ' ||
                         'Media Id = ' || to_char(x_media_id);
        WHEN OTHERS THEN
          RAISE;
      END;

      SELECT po_notes_s.nextval
      INTO   x_note_id
      FROM   sys.dual;

/* Mdas, bug# 407770, 10/23/96; open cursor 'sel_fad_data'
  ' Insert into select'was limiting the value of po_notes.note to 2K - Pl Sql
  problem. So, now useing cursor to select all the values and use
 'insert into values (..)'.
*/
   OPEN sel_fad_data;
   FETCH sel_fad_data INTO fadrec;
   CLOSE sel_fad_data;

-- doc and note have 1-1 relationship
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
        attribute14,        attribute15,
	start_date_active,  end_date_active)
      VALUES(
        x_document_id,      x_version,
        x_note_id,          sysdate,
        1,                  1,
        sysdate,            1,
/* zxzhang, bug#742681, truncating description */
        substrb(fadrec.description,1,80), x_usage_id,
        x_note_type,        x_long_text,
        fadrec.doc_attribute_category, fadrec.doc_attribute1,
        fadrec.doc_attribute2,     fadrec.doc_attribute3,
        fadrec.doc_attribute4,     fadrec.doc_attribute5,
        fadrec.doc_attribute6,     fadrec.doc_attribute7,
        fadrec.doc_attribute8,     fadrec.doc_attribute9,
        fadrec.doc_attribute10,    fadrec.doc_attribute11,
        fadrec.doc_attribute12,    fadrec.doc_attribute13,
        fadrec.doc_attribute14,    fadrec.doc_attribute15,
        fadrec.start_date_active, fadrec.end_date_active );


-- ref and doc have n-1 relation, but if we INSERT a new doc, there should be
-- 0 or 1 ref entry with this document_id. if 0, no records will be inserted.
-- but be very cautious when using get_table_name and get_column_name using
-- document_id as parameter. you may get more records (ORA-01422).

      IF x_table_name = 'NOT_ATTACHED'
      OR x_column_name = 'NOT_ATTACHED' THEN
        NULL; -- might be a standard document
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
       insertion rather than fad.pk1_value which was used before. */

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
    END IF;
  END LOOP;

  po_att.clear_mark ('L', 'DOCUMENT', 'INSERT', x_version);

END;


/
ALTER TRIGGER "APPS"."FND_DOCUMENTS_LT_PO_IAS" DISABLE;
