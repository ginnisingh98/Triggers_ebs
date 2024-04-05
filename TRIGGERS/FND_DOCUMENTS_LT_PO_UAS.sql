--------------------------------------------------------
--  DDL for Trigger FND_DOCUMENTS_LT_PO_UAS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_DOCUMENTS_LT_PO_UAS" 
/* $Header: poatt04t.sql 115.2 99/07/17 02:20:19 porting shi $ */
AFTER UPDATE OF long_text ON  "APPLSYS"."FND_DOCUMENTS_LONG_TEXT"


DECLARE
  x_media_id    NUMBER;
  x_version     VARCHAR2(10);
  x_document_id NUMBER;
  x_long_text   VARCHAR2(32767);
/* selecting a long text > 32760 into a long varchar2 variable will raise
   VALUE_ERROR exception.
*/
  CURSOR x_mark_c IS
    SELECT src_id, version
    FROM   po_att_tmp_records
    WHERE  source     = 'DOCUMENT'
    AND    short_long = 'L'
    AND    operation  = 'UPDATE';

BEGIN

  OPEN x_mark_c;
  LOOP
    FETCH x_mark_c INTO x_media_id, x_version;
    EXIT WHEN x_mark_c%NOTFOUND;

    po_att.get_document_id (x_media_id, 'L', x_document_id);

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

    UPDATE po_notes
    SET    app_source_version = x_version,
           note = x_long_text
    WHERE  document_id = x_document_id;
  END LOOP;

  po_att.clear_mark ('L', 'DOCUMENT', 'UPDATE', x_version);

END;


/
ALTER TRIGGER "APPS"."FND_DOCUMENTS_LT_PO_UAS" DISABLE;
