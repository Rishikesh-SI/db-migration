-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_get_user_mentor_session_listing(text)
-- Type: FUNCTION

-- Name: labbsc_dev_get_user_mentor_session_listing(text); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_get_user_mentor_session_listing(p_user_guid text, OUT p_user_session_json jsonb) RETURNS jsonb
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
begin


begin

select  user_full_name,email_id,user_id
from labbsc_dev.labbsc_dev_web_user 
where user_guid=p_user_guid
into v_user_name,v_user_email_id,v_user_id;

--raise notice '%',p_user_guid;
--select 1/0;
select um.mentor_id
from labbsc_dev.labbsc_dev_user_mentor_mapping um
join labbsc_dev.labbsc_dev_cart c
on c.cart_id=um.cart_id
where um.user_id=v_user_id
into v_mentor_id;

  select full_name,email_id,user_id
from labbsc_dev.labbsc_dev_user 
where user_id=v_mentor_id
into v_mentor_name,v_mentor_email_id,v_mentor_id; 


exception when others then
null;

end;

select '{"data":['||string_agg(row_to_json(row)::text,',')||']}'
from (
select v_user_id as user_id ,
     v_mentor_name as mentor_name,
	um.session_date,
	um.session_slot,
	um.status,
	um.session_name,
	um.module_name,
	um.session_id
from   labbsc_dev.labbsc_dev_user_mentor_session um
	where um.user_id=v_user_id
	
 order by created_date desc) row
into p_user_session_json
;
  
end;
$$;


--
