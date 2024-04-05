--------------------------------------------------------
--  DDL for Trigger PSB_ACCOUNT_POSITION_SETS_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PSB_ACCOUNT_POSITION_SETS_T1" 
/*$Header: PSBTAPST.sql 115.5 2002/11/22 07:38:31 pmamdaba ship $*/

  BEFORE INSERT OR UPDATE OR DELETE ON "PSB"."PSB_ACCOUNT_POSITION_SETS"
  REFERENCING new AS new
              old AS old
FOR EACH ROW
--
DECLARE
  --
  l_return_status   VARCHAR2(1) ;
  l_msg_count       NUMBER ;
  l_msg_data        VARCHAR2(2000) ;
  l_msg_index_out   NUMBER ;
  --
  l_tmp_boolean     BOOLEAN ;
  l_req_id          NUMBER ;
  --
  l_set_id          psb_account_position_sets.account_position_set_id%TYPE ;

  l_account_or_position_type
                    psb_account_position_sets.account_or_position_type%TYPE ;
  --
  l_debug_message   VARCHAR2(2000) ;
BEGIN
  --
  -- Initialize the message list.
  --
  FND_MSG_PUB.initialize ;

  l_return_status := FND_API.G_RET_STS_SUCCESS ;

  IF INSERTING THEN
    --
    l_set_id                   := :new.account_position_set_id ;
    l_account_or_position_type := :new.account_or_position_type ;
    --
  ELSIF UPDATING THEN
    --
    l_set_id                   := :old.account_position_set_id ;
    l_account_or_position_type := :old.account_or_position_type ;

    --
    -- Trigger must not fire when the concurrent program performs any UPDATE
    -- or INSERT operation on the psb_account_position_sets table.
    --
    IF NVL( :new.maintain_status, 'X') = 'C' THEN
      :new.maintain_status := 'D' ;
      RETURN ;
    END IF ;

  ELSIF DELETING THEN
    --
    -- Delete psb_budget_accounts or psb_budget_positions and return. Do not
    -- call the concurrent program as the account_position_set_id is no more
    -- in the system.
    --
    IF  :old.account_or_position_type = 'A' THEN
      --
      DELETE psb_budget_accounts
      WHERE  account_position_set_id = :old.account_position_set_id ;
      --
   ELSIF :old.account_or_position_type = 'P' THEN
      --
      DELETE psb_budget_positions
      WHERE  account_position_set_id = :old.account_position_set_id ;
      --
    END IF ;

    RETURN ;

  END IF ;

  /* Commenting as it was relevant only in PHASE-1
  IF l_account_or_position_type <> 'A' THEN
    RETURN ;
  END IF ;
  */

  --
  -- Starting the concurrent program
  --
  l_tmp_boolean :=  Fnd_Request.Set_Mode( TRUE ) ;

  IF l_account_or_position_type = 'A' THEN

    l_req_id :=  Fnd_Request.Submit_Request
                 (  application   => 'PSB'                      ,
                    program       => 'PSBCMBAC'                 ,
                    description   => 'Maintain account sets'    ,
                    start_time    =>  NULL                      ,
                    sub_request   =>  FALSE                     ,
                    argument1     =>  NULL                      ,
                    argument2     =>  l_set_id
                 ) ;

  ELSIF l_account_or_position_type = 'P' THEN

    l_req_id :=  Fnd_Request.Submit_Request
                 (  application   => 'PSB'                      ,
                    program       => 'PSBCMBPC'                 ,
                    description   => 'Maintain position sets'   ,
                    start_time    =>  NULL                      ,
                    sub_request   =>  FALSE                     ,
                    argument1     =>  NULL                      ,
                    argument2     =>  l_set_id
                 ) ;

  END IF ;
  --

  IF l_req_id = 0 THEN
    l_debug_message := 'The psb_account_position_sets_t1 trigger failed.' ;
  ELSE
    l_debug_message := 'The psb_account_position_sets_t1 trigger executed.' ;
  END IF ;

  -- DBMS_OUTPUT.Put_Line(l_debug_message) ;

EXCEPTION
  WHEN OTHERS THEN
    --
    IF FND_MSG_PUB.Check_Msg_Level ( FND_MSG_PUB.G_MSG_LVL_UNEXP_ERROR ) THEN
      FND_MSG_PUB.Add_Exc_Msg (  'Maintain Account Position Sets' ,
                                 'PSBTAPST.sql ' ) ;
    END IF ;
    --
    FND_MSG_PUB.Get( p_msg_index     => FND_MSG_PUB.G_FIRST  ,
                     p_encoded       => FND_API.G_FALSE      ,
                     p_data          => l_msg_data           ,
                     p_msg_index_out => l_msg_index_out
                   ) ;
    --
    l_debug_message := 'The program failed with the error :' || l_msg_data ;
    --
    -- DBMS_OUTPUT.Put_Line(l_debug_message) ;
    --
    RAISE ;
END ;



/
ALTER TRIGGER "APPS"."PSB_ACCOUNT_POSITION_SETS_T1" ENABLE;
