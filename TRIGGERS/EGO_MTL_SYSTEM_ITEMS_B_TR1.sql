--------------------------------------------------------
--  DDL for Trigger EGO_MTL_SYSTEM_ITEMS_B_TR1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."EGO_MTL_SYSTEM_ITEMS_B_TR1" 
/* $Header: EGOTISB1.sql 115.1 2003/06/18 04:38:30 anakas noship $ */

AFTER UPDATE OF SEGMENT1, SEGMENT2, SEGMENT3, SEGMENT4, SEGMENT5,
                SEGMENT6, SEGMENT7, SEGMENT8, SEGMENT9, SEGMENT10,
                SEGMENT11, SEGMENT12, SEGMENT13, SEGMENT14, SEGMENT15,
                SEGMENT16, SEGMENT17, SEGMENT18, SEGMENT19, SEGMENT20,
                ITEM_CATALOG_GROUP_ID
ON "INV"."MTL_SYSTEM_ITEMS_B"
FOR EACH ROW

DECLARE
   l_table_name          VARCHAR2(30)    :=  'MTL_SYSTEM_ITEMS_B';
   l_event               VARCHAR2(30);
   l_scope               VARCHAR2(30)    :=  'ROW';
   l_process_event       BOOLEAN         :=  FALSE;

   TYPE Segment_Tbl_Type IS TABLE OF mtl_system_items_b.SEGMENT1%TYPE
                            INDEX BY BINARY_INTEGER;

   Old_Segment_Tbl       Segment_Tbl_Type;
   New_Segment_Tbl       Segment_Tbl_Type;

   Old_Item_Name         VARCHAR2(2000)  :=  NULL;
   New_Item_Name         VARCHAR2(2000)  :=  NULL;

   l_application_id      NUMBER(10)      :=  401;
   l_id_flex_code        VARCHAR2(4)     :=  'MSTK';
   l_id_flex_num         NUMBER(15)      :=  101;
   l_enabled_flag        VARCHAR2(1)     :=  'Y';

   l_delimiter           VARCHAR2(1);
   l_seg_col_num         NUMBER;

   CURSOR Flex_Segments_cur
   IS
      SELECT segment_num, application_column_name, required_flag
      FROM fnd_id_flex_segments
      WHERE
             application_id = l_application_id
         AND id_flex_code   = l_id_flex_code
         AND id_flex_num    = l_id_flex_num
         AND enabled_flag   = l_enabled_flag
      ORDER BY segment_num;

BEGIN

   IF ( INSERTING ) THEN
      l_event := 'INSERT';

   ELSIF ( UPDATING ) THEN
      l_event := 'UPDATE';

      Old_Segment_Tbl(1)  := :old.SEGMENT1;
      Old_Segment_Tbl(2)  := :old.SEGMENT2;
      Old_Segment_Tbl(3)  := :old.SEGMENT3;
      Old_Segment_Tbl(4)  := :old.SEGMENT4;
      Old_Segment_Tbl(5)  := :old.SEGMENT5;
      Old_Segment_Tbl(6)  := :old.SEGMENT6;
      Old_Segment_Tbl(7)  := :old.SEGMENT7;
      Old_Segment_Tbl(8)  := :old.SEGMENT8;
      Old_Segment_Tbl(9)  := :old.SEGMENT9;
      Old_Segment_Tbl(10) := :old.SEGMENT10;
      Old_Segment_Tbl(11) := :old.SEGMENT11;
      Old_Segment_Tbl(12) := :old.SEGMENT12;
      Old_Segment_Tbl(13) := :old.SEGMENT13;
      Old_Segment_Tbl(14) := :old.SEGMENT14;
      Old_Segment_Tbl(15) := :old.SEGMENT15;
      Old_Segment_Tbl(16) := :old.SEGMENT16;
      Old_Segment_Tbl(17) := :old.SEGMENT17;
      Old_Segment_Tbl(18) := :old.SEGMENT18;
      Old_Segment_Tbl(19) := :old.SEGMENT19;
      Old_Segment_Tbl(20) := :old.SEGMENT20;

      New_Segment_Tbl(1)  := :new.SEGMENT1;
      New_Segment_Tbl(2)  := :new.SEGMENT2;
      New_Segment_Tbl(3)  := :new.SEGMENT3;
      New_Segment_Tbl(4)  := :new.SEGMENT4;
      New_Segment_Tbl(5)  := :new.SEGMENT5;
      New_Segment_Tbl(6)  := :new.SEGMENT6;
      New_Segment_Tbl(7)  := :new.SEGMENT7;
      New_Segment_Tbl(8)  := :new.SEGMENT8;
      New_Segment_Tbl(9)  := :new.SEGMENT9;
      New_Segment_Tbl(10) := :new.SEGMENT10;
      New_Segment_Tbl(11) := :new.SEGMENT11;
      New_Segment_Tbl(12) := :new.SEGMENT12;
      New_Segment_Tbl(13) := :new.SEGMENT13;
      New_Segment_Tbl(14) := :new.SEGMENT14;
      New_Segment_Tbl(14) := :new.SEGMENT14;
      New_Segment_Tbl(15) := :new.SEGMENT15;
      New_Segment_Tbl(16) := :new.SEGMENT16;
      New_Segment_Tbl(17) := :new.SEGMENT17;
      New_Segment_Tbl(18) := :new.SEGMENT18;
      New_Segment_Tbl(19) := :new.SEGMENT19;
      New_Segment_Tbl(20) := :new.SEGMENT20;

      SELECT concatenated_segment_delimiter
        INTO l_delimiter
      FROM fnd_id_flex_structures
      WHERE
             application_id = l_application_id
         AND id_flex_code   = l_id_flex_code
         AND id_flex_num    = l_id_flex_num
         AND enabled_flag   = l_enabled_flag;

      FOR segment_rec IN Flex_Segments_cur
      LOOP
         l_seg_col_num := TO_NUMBER(SUBSTR(segment_rec.application_column_name, 8));

         IF ( New_Item_Name IS NOT NULL ) THEN
            Old_Item_Name := Old_Item_Name || l_delimiter || Old_Segment_Tbl(l_seg_col_num);
            New_Item_Name := New_Item_Name || l_delimiter || New_Segment_Tbl(l_seg_col_num);
         ELSE
            Old_Item_Name := Old_Segment_Tbl(l_seg_col_num);
            New_Item_Name := New_Segment_Tbl(l_seg_col_num);
         END IF;
      END LOOP;  -- Flex_Segments_cur

      IF ( New_Item_Name <> Old_Item_Name ) THEN
         l_process_event := TRUE;
      END IF;

      l_process_event := l_process_event OR ( NVL(:old.ITEM_CATALOG_GROUP_ID, -1) <> NVL(:new.ITEM_CATALOG_GROUP_ID, -1) );

   ELSIF ( DELETING ) THEN
      l_event := 'DELETE';

   END IF;  -- event

   -- Call the event handler

   IF ( l_process_event ) THEN

      EGO_ITEM_TEXT_UTIL.Process_Source_Table_Event
      (  p_table_name         =>  l_table_name
      ,  p_event              =>  l_event
      ,  p_scope              =>  l_scope
      ,  p_item_id            =>  :new.INVENTORY_ITEM_ID
      ,  p_org_id             =>  :new.ORGANIZATION_ID
      ,  p_last_update_date   =>  :new.LAST_UPDATE_DATE
      ,  p_last_updated_by    =>  :new.LAST_UPDATED_BY
      ,  p_last_update_login  =>  :new.LAST_UPDATE_LOGIN
      ,  p_item_code               =>  New_Item_Name
      ,  p_item_catalog_group_id   =>  :new.ITEM_CATALOG_GROUP_ID
      );

   END IF;

EXCEPTION
   WHEN others THEN
      NULL;

END EGO_MTL_SYSTEM_ITEMS_B_TR1;



/
ALTER TRIGGER "APPS"."EGO_MTL_SYSTEM_ITEMS_B_TR1" ENABLE;
