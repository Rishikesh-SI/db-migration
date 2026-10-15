-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_upd_company_project_feedback(jsonb)
-- Type: FUNCTION

-- Name: labbsc_upd_company_project_feedback(jsonb); Type: FUNCTION; Schema: labbsc; Owner: -
--

CREATE FUNCTION labbsc.labbsc_upd_company_project_feedback(p_json jsonb, OUT p_out numeric, OUT p_company_feedback_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare 
/*

 SELECT * from labbsc.labbsc_ins_upd_user_project(
	 '{
  "user_guid": "46f173f0-e9f5-44f6-a572-a0217e9f2370",
  "project_id": "342"}');*/
 
 
 
v_project_id numeric;
v_user_guid text;
v_user_id numeric;
 
v_feedback_json jsonb;
v_save_as_draft numeric;
begin

select   p_json->>'user_guid' ,
	   p_json->>'project_id',
	   p_json->>'feedback',
	       p_json->>'save_as_draft'
 into
 v_user_guid,
 v_project_id,
 v_feedback_json,
 v_save_as_draft;
 
 

select user_id
from labbsc.labbsc_web_user
where user_guid=v_user_guid
into v_user_id;

 if v_user_id is not null then
--- raise notice '%',v_session_video_json;
		 
 update labbsc.labbsc_user_project_detail
 set company_feedback=v_feedback_json,
 save_as_draft_company=v_save_as_draft
where user_id=v_user_id
and project_id=v_project_id;
 
  
  p_out:=1;
		
 else

 p_out:=2;
 end if;
p_company_feedback_json:=p_json;
 
 
exception when no_data_found 
then 
p_out:=2;
when others then 
p_out:=-1; 

end;
$$;


--
