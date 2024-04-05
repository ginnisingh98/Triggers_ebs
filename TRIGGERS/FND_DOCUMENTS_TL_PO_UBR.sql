--------------------------------------------------------
--  DDL for Trigger FND_DOCUMENTS_TL_PO_UBR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_DOCUMENTS_TL_PO_UBR" 
/* $Header: poatt04t.sql 115.2 99/07/17 02:20:19 porting shi $ */
BEFORE UPDATE ON          "APPLSYS"."FND_DOCUMENTS_TL"
FOR EACH ROW


BEGIN

  IF :new.app_source_version IS NULL THEN
    UPDATE po_notes
    SET    app_source_version = 'PO_10SC',
/* zxzhang, bug#742681, truncating description */
           title       = substrb(:new.description,1,80),
           attribute_category = :new.doc_attribute_category,
           attribute1  = :new.doc_attribute1,
           attribute2  = :new.doc_attribute2,
           attribute3  = :new.doc_attribute3,
           attribute4  = :new.doc_attribute4,
           attribute5  = :new.doc_attribute5,
           attribute6  = :new.doc_attribute6,
           attribute7  = :new.doc_attribute7,
           attribute8  = :new.doc_attribute8,
           attribute9  = :new.doc_attribute9,
           attribute10 = :new.doc_attribute10,
           attribute11 = :new.doc_attribute11,
           attribute12 = :new.doc_attribute12,
           attribute13 = :new.doc_attribute13,
           attribute14 = :new.doc_attribute14,
           attribute15 = :new.doc_attribute15
    WHERE  document_id = :new.document_id;

  ELSIF :new.app_source_version = 'PO_R10' THEN
    :new.app_source_version := '';

  END IF;

END;



/
ALTER TRIGGER "APPS"."FND_DOCUMENTS_TL_PO_UBR" DISABLE;
