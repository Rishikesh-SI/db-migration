-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_upd_session_feedback(jsonb)
-- Type: FUNCTION

-- Name: labbsc_upd_session_feedback(jsonb); Type: FUNCTION; Schema: labbsc; Owner: -
--

CREATE FUNCTION labbsc.labbsc_upd_session_feedback(p_json jsonb, OUT p_out numeric, OUT p_feedback_json jsonb) RETURNS record
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
       p_json->>'save_as_draft' ,
       p_json->>'feedback',
	   p_json->>'user_id',
	   p_json->>'counseller_id'
 into
 v_session_id,
 v_feedback_status,
 v_feedback_json,
 v_user_id,
 v_counseller_id
 ;

 update labbsc.labbsc_user_counselling_session
 set feedback_status=v_feedback_status,
  feedback=v_feedback_json,
  status=case when v_feedback_status =1 then 1 else 0 end
 where session_id=v_session_id;
 
 p_out:=1;
 
 if p_out =1
 then
 
 p_feedback_json:=p_json;
 
 end if;

end;

 $$;


--
