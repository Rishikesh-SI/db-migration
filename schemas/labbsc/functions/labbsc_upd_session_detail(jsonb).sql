-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_upd_session_detail(jsonb)
-- Type: FUNCTION

-- Name: labbsc_upd_session_detail(jsonb); Type: FUNCTION; Schema: labbsc; Owner: -
--

CREATE FUNCTION labbsc.labbsc_upd_session_detail(p_json jsonb, OUT p_out numeric, OUT p_google_meet_info jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$ 

declare 

 v_feedback_status numeric;
v_session_id numeric;
v_feedback_json jsonb;
v_current_timestamp timestamp := current_timestamp at time zone 'utc';
v_user_id numeric;
v_counseller_id numeric;
begin
select p_json->>'session_id' ,
       
	   p_json->>'google_meet_info'
 into
 v_session_id,
  
 v_feedback_json;
 
 

 update labbsc.labbsc_user_counselling_session
 set 
  schedule_json=v_feedback_json
   
 where session_id=v_session_id;
 
 p_out:=1;
 
 if p_out =1
 then
 
 p_google_meet_info:=p_json;
 
 end if;

end;

 $$;


--
