--------------------------------------------------------
--  DDL for Trigger FEM_AUTHDEV_TYPES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_AUTHDEV_TYPES_DL" 
instead of delete on FEM_AUTHDEV_TYPES_VL
referencing old as FEM_AUTHDEV_TYPES_B
for each row
begin
  FEM_AUTHDEV_TYPES_PKG.DELETE_ROW(
    X_AUTH_DEVICE_TYPE_CODE => :FEM_AUTHDEV_TYPES_B.AUTH_DEVICE_TYPE_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_AUTHDEV_TYPES_DL" ENABLE;
