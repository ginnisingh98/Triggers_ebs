--------------------------------------------------------
--  DDL for Trigger CS_FORUM_CATEGORIES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CS_FORUM_CATEGORIES_DL" 
/* $Header: csfcvd.sql 115.0 2000/11/17 11:18:39 pkm ship     $ */
instead of delete on CS_FORUM_CATEGORIES_VL
referencing old as CATEGORIES
for each row

begin
  CS_FORUM_CATEGORIES_PKG.DELETE_ROW(
    X_CATEGORY_ID => :CATEGORIES.CATEGORY_ID);
end DELETE_ROW;



/
ALTER TRIGGER "APPS"."CS_FORUM_CATEGORIES_DL" ENABLE;
