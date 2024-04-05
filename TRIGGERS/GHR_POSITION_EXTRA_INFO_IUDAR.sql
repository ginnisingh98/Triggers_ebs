--------------------------------------------------------
--  DDL for Trigger GHR_POSITION_EXTRA_INFO_IUDAR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GHR_POSITION_EXTRA_INFO_IUDAR" 
after insert or update or delete
on "HR"."PER_POSITION_EXTRA_INFO"
for each row
DECLARE
l_sess_var	  		ghr_history_api.g_session_var_type;
l_effective_date        date;
l_session_id            fnd_sessions.session_id%type;
l_fire_trigger		varchar2(30);

  Cursor c_session_id is
    select userenv('sessionid') sessionid
    from   dual;

  Cursor c_session_data is
    select effective_date,
           session_id
    from   fnd_sessions
    where  session_id = l_session_id;

   CURSOR c_pos IS
       SELECT  1
       FROM    hr_all_positions_f pos
       WHERE   pos.position_id = NVL(:NEW.position_id,:OLD.position_id)
       AND     l_effective_date
       BETWEEN pos.effective_start_date and pos.effective_end_date
       AND     NVL(UPPER(pos.status),'VALID') = 'VALID'
       FOR UPDATE OF pos.status;

BEGIN
-- Only do any of this if we are GHR!

IF ghr_utility.is_ghr = 'TRUE' THEN

  IF ghr_utility.g_position_being_deleted THEN
    RETURN;
  END IF;
  ghr_history_api.get_g_session_var(l_sess_var);

  l_fire_trigger := l_sess_var.fire_trigger;
  l_sess_var.fire_trigger := 'N';
  ghr_history_api.set_g_session_var(l_sess_var);


  for session_id in C_session_id loop
     l_session_id    :=  session_id.sessionid;
  end loop;

  for session in c_session_data loop
     l_effective_date :=  session.effective_date;
  end loop;

  -- Only set the master record to invalid if it is currently VALID
  IF NOT ghr_api.return_upd_hr_dml_status THEN

    FOR c_pos_rec in c_pos LOOP
      UPDATE hr_all_positions_f
      SET    status = 'INVALID'
      WHERE CURRENT OF c_pos;
    END LOOP;
  END IF;

  l_sess_var.fire_trigger := l_fire_trigger;
  ghr_history_api.set_g_session_var(l_sess_var);
END IF;

EXCEPTION
  WHEN others THEN
    l_sess_var.fire_trigger := l_fire_trigger;
    ghr_history_api.set_g_session_var(l_sess_var);
    raise;

END;




/
ALTER TRIGGER "APPS"."GHR_POSITION_EXTRA_INFO_IUDAR" ENABLE;
