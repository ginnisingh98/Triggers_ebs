--------------------------------------------------------
--  DDL for Trigger FEM_FIN_ELEM_PRC_GRPS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_FIN_ELEM_PRC_GRPS_DL" 
instead of delete on FEM_FIN_ELEM_PRC_GRPS_VL
referencing old as FEM_FIN_ELEM_PRC_GRPS_B
for each row
begin
  FEM_FIN_ELEM_PRC_GRPS_PKG.DELETE_ROW(
    X_FIN_ELEM_PRC_GRP_CODE => :FEM_FIN_ELEM_PRC_GRPS_B.FIN_ELEM_PRC_GRP_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_FIN_ELEM_PRC_GRPS_DL" ENABLE;
