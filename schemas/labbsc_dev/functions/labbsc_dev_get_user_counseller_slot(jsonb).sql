-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_get_user_counseller_slot(jsonb)
-- Type: FUNCTION

-- Name: labbsc_dev_get_user_counseller_slot(jsonb); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_get_user_counseller_slot(p_input_json jsonb, OUT p_user_slot_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$ 
declare 
v_user_email_id text;
v_counseller_email_id text;
v_counseller_name text;
v_user_name text;
v_session_slot_json jsonb;
v_session_date date;
v_user_id numeric;
v_counseller_id numeric;
v_user_guid text;
v_curr_date timestamp;
begin
select p_input_json->>'session_date',
 p_input_json->>'user_guid',
 p_input_json->>'counseller_id'
 into v_session_date,
 v_user_guid,
 v_counseller_id;
 
 select current_timestamp at time zone 'utc' + interval '330 minute'
into v_curr_date;

begin
select full_name,email_id,user_id
from labbsc_dev.labbsc_dev_user 
where user_id=v_counseller_id
into v_counseller_name,v_counseller_email_id,v_counseller_id;

select  user_full_name,email_id,user_id
from labbsc_dev.labbsc_dev_web_user 
where user_guid=v_user_guid
into v_user_name,v_user_email_id,v_user_id;

exception when others then
null;

end;
 

select  array_to_json(array_agg(row))
from (
select
s.session_slot,
  case when (v_session_date||' '||s.start_time)::timestamp < v_curr_date then 2 else  cs.status end as status,
	us.session_id 
 from labbsc_dev.labbsc_dev_slot s
 left join labbsc_dev.labbsc_dev_counseller_slot cs
on cs.session_slot=s.session_slot
and cs.counseller_user_id=v_counseller_id
and cs.session_date=v_session_date 
left join labbsc_dev.labbsc_dev_user_counselling_session us
on us.session_slot=s.session_slot
and us.counseller_id=cs.counseller_user_id	
and us.session_date=cs.session_date
and us.user_id=v_user_id
) as row
into v_session_slot_json;

 

select '{"data":'||row_to_json(row)||'}'
		from (select 
 v_user_id as user_id,
 v_counseller_id as counseller_id,
 v_session_date as session_date,
v_counseller_name as counseller_name,
v_counseller_email_id as counseller_email,
v_user_name as user_name,
v_user_email_id as user_email,
 v_session_slot_json as session_slot 		  
) as row 
into p_user_slot_json
 ;
 
	
end;

 $$;


--
