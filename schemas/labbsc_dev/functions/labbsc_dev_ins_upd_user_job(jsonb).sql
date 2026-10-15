-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_ins_upd_user_job(jsonb)
-- Type: FUNCTION

-- Name: labbsc_dev_ins_upd_user_job(jsonb); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_ins_upd_user_job(p_json jsonb, OUT p_out numeric, OUT p_job_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare 
/*

 SELECT * from labbsc_dev.labbsc_dev_ins_upd_user_job(
	 '{
  "user_guid": "46f173f0-e9f5-44f6-a572-a0217e9f2370",
  "job_id": "342"}');*/
 
v_counseller_id numeric;
 
v_current_timestamp timestamp := current_timestamp at time zone 'utc';
 
v_job_id numeric;
v_user_guid text;
v_user_id numeric;
v_current_date date:= current_date;
v_expiry_date date; 
v_valid_job numeric;
v_job_complete numeric;
v_job_title varchar(4000);
v_job_url varchar(4000);
v_first_name text;
v_last_name text;
v_user_email text;
v_user_sponscorr_report text;
v_company_name varchar(4000);
v_company_spoc_name varchar(4000);
v_company_spoc_contact varchar(4000);
v_company_spoc_email varchar(4000);
v_job_apply_date date;
 
begin

select   p_json->>'user_guid' ,
	   p_json->>'job_id'  
 into
 v_user_guid,
 v_job_id ;
 
 
  
select user_id,email_id,first_name,last_name
from labbsc_dev.labbsc_dev_web_user
where user_guid=v_user_guid
into v_user_id,v_user_email,v_first_name,v_last_name;

begin
select report_url from (
select report_url,created_date
from 
labbsc_dev.labbsc_dev_user_tests
where user_id=v_user_id
and report_url is not null
order by created_date desc) tb
limit 1
into v_user_sponscorr_report;
exception when no_data_found then
v_user_sponscorr_report:=null;
end;

begin
select jb.job_profile,jb.slug_url,
 em.entity_json->>'company_spoc_name' ,
 em.entity_json->>'company_spoc_contact',
 em.entity_json->>'company_spoc_email',
 em.entity_name 
 from labbsc_dev.labbsc_dev_job_profile jb
 join labbsc_dev.labbsc_dev_entity_master em
 on em.entity_master_id=jb.company_name
 where jb.job_profile_id=v_job_id
 into v_job_title,
 v_job_url,
 v_company_spoc_name,
 v_company_spoc_contact,
 v_company_spoc_email,
 v_company_name;
 
 if v_job_title is not null then 
 v_valid_job:=1;
 else
 v_valid_job:=0;
 end if;
 exception when no_data_found then
  v_valid_job:=0;
end;
 

if v_valid_job >0 then
if (exists(select 1 from   labbsc_dev.labbsc_dev_user_job_detail
		 where job_id=v_job_id and user_id=v_user_id))
		 then
		 p_out:=3;
		 
 else
 
--- raise notice '%',v_session_video_json;
		 
 insert into labbsc_dev.labbsc_dev_user_job_detail
 (user_job_id,
  user_id,
 job_id)
 select nextval('labbsc_dev.seq_labbsc_dev_user_job_detail_id'),
  v_user_id,
 v_job_id;
  
  p_out:=1;
		
end if;

else
p_out:=4;
end if;

if p_out=1 then
select row_to_json(row)
from (
select v_user_guid as user_guid,
	v_job_id as job_id,
	v_job_title as job_title,
 v_job_url as job_url ,
 v_company_spoc_name as company_spoc_name,
 v_company_spoc_contact as company_spoc_contact,
 v_company_spoc_email as company_spoc_email,
	v_user_sponscorr_report as user_sponscorr_report,
	v_first_name as first_name,
	v_last_name as last_name,
	v_company_name as company_name,
		v_user_id as user_id,
	v_user_email as user_email

) as row into
p_job_json; 
end if;
 /*
exception when no_data_found 
then 
p_out:=2;
when others then 
p_out:=-1; */

end;
$$;


--
