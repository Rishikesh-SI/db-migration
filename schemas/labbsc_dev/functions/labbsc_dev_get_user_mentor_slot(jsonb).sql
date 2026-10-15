-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_get_user_mentor_slot(jsonb)
-- Type: FUNCTION

-- Name: labbsc_dev_get_user_mentor_slot(jsonb); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_get_user_mentor_slot(p_input_json jsonb, OUT p_user_slot_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare 
v_user_email_id text;
v_mentor_email_id text;
v_mentor_name text;
v_user_name text;
v_session_slot_json jsonb;
v_session_date date;
v_user_id numeric;
v_mentor_id numeric;
v_module_name varchar(500);
v_session_name varchar(500);
v_exists numeric ;
 
begin
select p_input_json->>'session_date',
 p_input_json->>'user_email_id',
 p_input_json->>'module_name',
  p_input_json->>'session_name'
 into v_session_date,
 v_user_email_id, 
 v_module_name,
 v_session_name;
 
 raise notice '%',v_user_email_id;
--select 1/0;

begin

select  user_full_name,email_id,user_id
from labbsc_dev.labbsc_dev_web_user 
where email_id=v_user_email_id
into v_user_name,v_user_email_id,v_user_id;

select mentor_id
from labbsc_dev.labbsc_dev_user_mentor_mapping
where user_id=v_user_id
into v_mentor_id;

  select full_name,email_id,user_id
from labbsc_dev.labbsc_dev_user 
where user_id=v_mentor_id
into v_mentor_name,v_mentor_email_id,v_mentor_id; 

exception when others then
null;

end;

select  array_to_json(array_agg(row))
from (select
s.session_slot,
  cs.status,
	us.session_id 
 from labbsc_dev.labbsc_dev_slot s

left join labbsc_dev.labbsc_dev_mentor_slot cs
on cs.session_slot=s.session_slot
and cs.mentor_id=v_mentor_id	
and cs.session_date=v_session_date
and cs.session_name=v_session_name
and cs.module_name=v_module_name	
left join labbsc_dev.labbsc_dev_user_mentor_session us
on us.session_slot=cs.session_slot
and us.mentor_id=cs.mentor_id	
and us.session_date=cs.session_date 
and us.user_id=v_user_id
and us.session_name=cs.session_name
and us.module_name=cs.module_name	 ) as row
into v_session_slot_json;


if exists (select 1 from labbsc_dev.labbsc_dev_user_mentor_session
where user_id = v_user_id and  mentor_id = v_mentor_id 
and lower(session_name) = lower(v_session_name) 
and lower(module_name)= lower(v_module_name)) then

v_exists := 1 ;

else

v_exists := 0 ;

end if;
 

select '{"data":'||row_to_json(row)||'}'
		from (select 
 v_user_id as user_id,
 v_mentor_id as mentor_id,
 v_session_date as session_date,
v_mentor_name as mentor_name,
v_mentor_email_id as mentor_email,
v_user_name as user_name,
v_user_email_id as user_email,
 v_session_slot_json as session_slot,
 v_module_name as module_name,
v_session_name as session_name,	
v_exists as is_session_booked			  
			  
) as row 
into p_user_slot_json
 ;
 
	
end;
$$;


--
