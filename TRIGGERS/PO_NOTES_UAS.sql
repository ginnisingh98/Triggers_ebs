--------------------------------------------------------
--  DDL for Trigger PO_NOTES_UAS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PO_NOTES_UAS" 
/* $Header: poatt04t.sql 115.2 99/07/17 02:20:19 porting shi $ */
AFTER UPDATE ON           "PO"."PO_NOTES"


DECLARE
  x_note_id     NUMBER;
  x_media_id    NUMBER;
  x_datatype_id NUMBER;
  x_operation   VARCHAR2(20);
  x_version     VARCHAR2(10);

  CURSOR x_mark_c IS
    SELECT src_id, operation, version
    FROM   po_att_tmp_records
    WHERE  source      = 'NOTE'
    AND    short_long  = 'L'
    AND    operation = 'UPDATE';

BEGIN

  OPEN x_mark_c;
  LOOP
    FETCH x_mark_c INTO x_note_id, x_operation, x_version;
    EXIT WHEN x_mark_c%NOTFOUND;

    IF x_operation = 'UPDATE' THEN
      po_att.update_document (x_note_id, x_version);
    END IF;
  END LOOP;

  po_att.clear_mark ('L', 'NOTE', 'UPDATE', x_version);

END;


/
ALTER TRIGGER "APPS"."PO_NOTES_UAS" DISABLE;
