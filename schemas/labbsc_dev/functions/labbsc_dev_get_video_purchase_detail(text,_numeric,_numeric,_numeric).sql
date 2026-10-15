-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_get_video_purchase_detail(text, numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: labbsc_dev_get_video_purchase_detail(text, numeric, numeric, numeric); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_get_video_purchase_detail(p_user_guid text, p_video_id numeric, p_project_id numeric, p_job_id numeric, OUT p_out numeric, OUT p_proj_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
v_video_payment numeric;
v_proj_flag numeric;
v_user_id numeric;
v_total_video_paid numeric;
v_proj_applied numeric;
v_proj_count numeric;
v_job_detail jsonb;
v_test_payment numeric;

v_job_count numeric;
v_partner_name text;
v_code text;
v_module_name varchar(500); 
v_upload_video_count numeric;
v_activity_id numeric;
begin

select user_id,partner_name,university_code,module_name
from labbsc_dev.labbsc_dev_web_user
where user_guid=p_user_guid
into v_user_id,v_partner_name,v_code,v_module_name;

if v_module_name ='Sporjo Mentor'
then
v_activity_id=8;
end if;

 
select count(1),sum(case when p_video_id is not null and video_id=p_video_id then 1 else 0 end)
from labbsc_dev.labbsc_dev_cart
where status=2
and user_id=v_user_id
---and video_id=v_video_id
and activity_id in(4,8,13)
into v_total_video_paid ,v_video_payment; 

select count(1)
from labbsc_dev.labbsc_dev_user_project_detail
where user_id=v_user_id
into v_proj_applied;

if v_partner_name is not null then
select count(1)
from labbsc_dev.labbsc_dev_cart
where activity_id in (4,8,13)
and status=2
and upload_flag=1
and user_id=v_user_id
and video_id is not null
into 
v_upload_video_count;
else
if v_activity_id in (8,13) then
select count(1)
from labbsc_dev.labbsc_dev_cart
where activity_id=v_activity_id
and status=2
and user_id=v_user_id
and video_id is not null
into 
v_upload_video_count;
end if;

end if;

if p_project_id is not null then
select count(1)
from labbsc_dev.labbsc_dev_user_project_detail
where user_id=v_user_id
and project_id=p_project_id
into v_proj_count;
else
v_proj_count:=0;
end if;
 
 
 
select count(1)
from labbsc_dev.labbsc_dev_cart
where status=2
and user_id=v_user_id
and activity_id in (1,6) 
into v_test_payment;

if v_test_payment >0 then
/*
select jsonb_agg(row_to_json(row))
from (
select job_id
from labbsc_dev.labbsc_dev_user_job_detail
where user_id=v_user_id
)row
into v_job_detail;*/

select count(1)
from labbsc_dev.labbsc_dev_user_job_detail
where user_id=v_user_id
and job_id=p_job_id
into v_job_count;

end if;

select row_to_json(row)
from(
	select v_total_video_paid as total_video_paid,
	       v_video_payment as video_payment_status,
	       v_proj_applied as project_applied_count,
	v_proj_count as proj_flag,
	v_test_payment as test_payment_status,
	v_job_count as job_flag,
	v_partner_name as partner_name,
	v_code as sporjo_code,
	case when v_module_name in ('Sporjo+','Sporjo Mentor') then v_module_name
	else 'Sporjo' end as module_name,
	v_upload_video_count as upload_video_count
	--v_job_detail as job_json
	
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
