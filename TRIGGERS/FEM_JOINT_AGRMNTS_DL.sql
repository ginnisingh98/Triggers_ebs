--------------------------------------------------------
--  DDL for Trigger FEM_JOINT_AGRMNTS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_JOINT_AGRMNTS_DL" 
instead of delete on FEM_JOINT_AGRMNTS_VL
referencing old as FEM_JOINT_AGRMNTS_B
for each row
begin
  FEM_JOINT_AGRMNTS_PKG.DELETE_ROW(
    X_JOINT_AGREEMENT_CODE => :FEM_JOINT_AGRMNTS_B.JOINT_AGREEMENT_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_JOINT_AGRMNTS_DL" ENABLE;
