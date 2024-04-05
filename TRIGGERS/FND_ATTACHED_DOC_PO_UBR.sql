--------------------------------------------------------
--  DDL for Trigger FND_ATTACHED_DOC_PO_UBR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_ATTACHED_DOC_PO_UBR" 
/* $Header: poatt04t.sql 115.2 99/07/17 02:20:19 porting shi $ */
BEFORE UPDATE ON          "APPLSYS"."FND_ATTACHED_DOCUMENTS"
FOR EACH ROW
/* only seq number and flexfields can be updated. */


DECLARE
usg_type varchar2(1);

BEGIN

  IF :new.app_source_version IS NULL THEN
    UPDATE po_note_references
    SET    app_source_version = 'PO_10SC',
           LAST_UPDATE_DATE = sysdate,
           SEQUENCE_NUM = :new.seq_num,
           ATTRIBUTE_CATEGORY = :new.attribute_category,
           ATTRIBUTE1 = :new.ATTRIBUTE1,
           ATTRIBUTE2 = :new.ATTRIBUTE2,
           ATTRIBUTE3 = :new.ATTRIBUTE3,
           ATTRIBUTE4 = :new.ATTRIBUTE4,
           ATTRIBUTE5 = :new.ATTRIBUTE5,
           ATTRIBUTE6 = :new.ATTRIBUTE6,
           ATTRIBUTE7 = :new.ATTRIBUTE7,
           ATTRIBUTE8 = :new.ATTRIBUTE8,
           ATTRIBUTE9 = :new.ATTRIBUTE9,
           ATTRIBUTE10 = :new.ATTRIBUTE10,
           ATTRIBUTE11 = :new.ATTRIBUTE11,
           ATTRIBUTE12 = :new.ATTRIBUTE12,
           ATTRIBUTE13 = :new.ATTRIBUTE13,
           ATTRIBUTE14 = :new.ATTRIBUTE14,
           ATTRIBUTE15 = :new.ATTRIBUTE15
    WHERE  attached_doc_id = :new.attached_document_id;

   select fd.usage_type
     into   usg_type
     from   fnd_documents fd
     where  fd.document_id = :old.document_id;

 /* the following part of the code was necessary to deal
  with the case where in a template document after begin created could
 be updated in which case it becomes a one-time attachment. A new row
 is created in fnd_documents and the document_id is updated in
 fnd_attached_documents. This was causing the po_note_references to have
 duplicate values of attached_doc_id. So when we update fnd_attached_documents
 we should delete the original row from po_note_references which was
 referring to the template document and the new row would be created as
 a result of insert into fnd_documents and fnd_documents_short/long_text */

  if (:old.document_id is not null and :new.document_id is not null) then

   if (:old.document_id <> :new.document_id) then

    if (usg_type = 'T') then /* it was a template and is now being updated*/

         po_att.mark_record(1,NULL,'TEMPLATE',NULL,NULL);

/* Bug 797904 : Making changes to the following Delete to improve performance
   The modified DELETE is below this commented section.

          DELETE FROM  PO_NOTE_REFERENCES PNR
          WHERE EXISTS (SELECT 1 FROM PO_NOTES pon
                        WHERE  pnr.attached_doc_id = :old.attached_document_id
                              AND  pon.po_note_id = pnr.po_note_id
                              AND   pon.document_id = :old.document_id);
*/
          DELETE FROM  PO_NOTE_REFERENCES PNR
          WHERE  pnr.attached_doc_id = :old.attached_document_id
          AND EXISTS (SELECT 1 FROM PO_NOTES pon
                      WHERE  pon.po_note_id = pnr.po_note_id
                      AND   pon.document_id = :old.document_id);

    end if;
  end if;
 end if;

  ELSIF :new.app_source_version = 'PO_R10' THEN
    :new.app_source_version := '';

  END IF;

END;



/
ALTER TRIGGER "APPS"."FND_ATTACHED_DOC_PO_UBR" DISABLE;
