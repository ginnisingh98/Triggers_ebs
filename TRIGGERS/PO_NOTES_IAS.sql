--------------------------------------------------------
--  DDL for Trigger PO_NOTES_IAS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PO_NOTES_IAS" 
/* $Header: poatt04t.sql 115.2 99/07/17 02:20:19 porting shi $ */
AFTER INSERT ON           "PO"."PO_NOTES"


DECLARE
  x_media_id    NUMBER;
  x_note_id     NUMBER;
  x_version     VARCHAR2(10);
  x_datatype_id NUMBER;

  CURSOR x_mark_c IS
    SELECT src_id, version
    FROM   po_att_tmp_records
    WHERE  source     = 'NOTE'
    AND    short_long = 'L'
    AND    operation  = 'INSERT';

BEGIN

  OPEN x_mark_c;
  LOOP
    FETCH x_mark_c INTO x_note_id, x_version;
    EXIT WHEN x_mark_c%NOTFOUND;

    po_att.insert_document (x_note_id, x_version);
  END LOOP;

  po_att.clear_mark ('L', 'NOTE', 'INSERT', x_version);

END;


/
ALTER TRIGGER "APPS"."PO_NOTES_IAS" DISABLE;
