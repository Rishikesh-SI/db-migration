-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_get_video_purchase_detail(text, numeric, numeric)
-- Type: FUNCTION

-- Name: labbsc_get_video_purchase_detail(text, numeric, numeric); Type: FUNCTION; Schema: labbsc; Owner: -
--

CREATE FUNCTION labbsc.labbsc_get_video_purchase_detail(p_user_guid text, p_video_id numeric, p_project_id numeric, OUT p_out numeric, OUT p_proj_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
v_video_payment numeric;
v_proj_flag numeric;
v_user_id numeric;
v_total_video_paid numeric;
v_proj_applied numeric;
v_proj_count numeric;
begin

select user_id
from labbsc.labbsc_web_user
where user_guid=p_user_guid
into v_user_id;
 
select count(1),sum(case when p_video_id is not null and video_id=p_video_id then 1 else 0 end)
from labbsc.labbsc_cart
where status=2
and user_id=v_user_id
---and video_id=v_video_id
and activity_id=4
into v_total_video_paid ,v_video_payment; 

select count(1)
from labbsc.labbsc_user_project_detail
where user_id=v_user_id
into v_proj_applied;

if p_project_id is not null then
select count(1)
from labbsc.labbsc_user_project_detail
where user_id=v_user_id
and project_id=p_project_id
into v_proj_count;
else
v_proj_count:=0;
end if;
 
/*
select count(1)
from labbsc.labbsc_cart
where status=2
and user_id=v_user_id
and activity_id=4
and video_id is not null
into v_total_video_paid;*/

select row_to_json(row)
from(
	select v_total_video_paid as total_video_paid,
	       v_video_payment as video_payment_status,
	       v_proj_applied as project_applied_count,
	v_proj_count as proj_flag
	
) as row 
into p_proj_json;

p_out:=1;

exception 
when no_data_found then
p_out:=2;
when others then 
p_out:=-1;
	
end;
$$;


--
