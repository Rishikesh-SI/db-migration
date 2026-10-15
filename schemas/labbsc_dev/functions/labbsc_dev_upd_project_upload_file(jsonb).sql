-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_upd_project_upload_file(jsonb)
-- Type: FUNCTION

-- Name: labbsc_dev_upd_project_upload_file(jsonb); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_upd_project_upload_file(p_json jsonb, OUT p_out numeric, OUT p_upload_file_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare 
/*

 SELECT * from labbsc_dev.labbsc_dev_ins_upd_user_project(
	 '{
  "user_guid": "46f173f0-e9f5-44f6-a572-a0217e9f2370",
  "project_id": "342"}');*/
 
 
 
v_project_id numeric;
v_user_guid text;
v_user_id numeric;
 
v_upload_file jsonb;
v_project_complete numeric;
v_project_title varchar(4000);
v_project_url varchar(4000);
v_first_name text;
v_last_name text;
v_user_email text;
v_user_sponscorr_report text;
v_company_name varchar(4000);
v_company_spoc_name varchar(4000);
v_company_spoc_contact varchar(4000);
v_company_spoc_email varchar(4000);
v_project_apply_date date;
 
begin

select   p_json->>'user_guid' ,
	   p_json->>'project_id',
	   p_json->>'uploaded_items' ,
	    p_json->>'final_projectreport_submission'
 into
 v_user_guid,
 v_project_id,
 v_upload_file,
 v_project_complete;
 
 
select jb.job_profile,jb.slug_url,
 em.entity_json->>'company_spoc_name' ,
 em.entity_json->>'company_spoc_contact',
 em.entity_json->>'company_spoc_email',
 em.entity_name 
 from labbsc_dev.labbsc_dev_job_profile jb
 join labbsc_dev.labbsc_dev_entity_master em
 on em.entity_master_id=jb.company_name
 where jb.job_profile_id=v_project_id
 into v_project_title,
 v_project_url,
 v_company_spoc_name,
 v_company_spoc_contact,
 v_company_spoc_email,
 v_company_name;

select user_id,email_id,first_name,last_name
from labbsc_dev.labbsc_dev_web_user
where user_guid=v_user_guid
into v_user_id,v_user_email,v_first_name,v_last_name;
if v_user_id is not null then
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
 
--- raise notice '%',v_session_video_json;
		 
 update labbsc_dev.labbsc_dev_user_project_detail
 set  upload_file=v_upload_file,
 project_complete=v_project_complete
where user_id=v_user_id
and project_id=v_project_id;

select created_date::date
from labbsc_dev.labbsc_dev_user_project_detail
where user_id=v_user_id
and project_id=v_project_id
into v_project_apply_date ;
 
  
  p_out:=1;
  else
  p_out:=2;
  
  end if;
		
 
select row_to_json(row)
from (
select v_user_guid as user_guid,
	v_project_id as project_id,
	v_upload_file as uploaded_items,
	v_project_complete as final_projectreport_submission,
	v_project_title as project_title,
 v_project_url as project_url ,
 v_company_spoc_name as company_spoc_name,
 v_company_spoc_contact as company_spoc_contact,
 v_company_spoc_email as company_spoc_email,
	v_user_sponscorr_report as user_sponscorr_report,
v_project_apply_date as project_apply_date,
	v_first_name as first_name,
	v_last_name as last_name,
	v_company_name as company_name,
	v_user_id as user_id,
	v_user_email as user_email
) as row into
p_upload_file_json;
 
 
 
exception when no_data_found 
then 
p_out:=2;
when others then 
p_out:=-1; 

end;
$$;


--
