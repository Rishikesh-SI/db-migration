-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_get_job_profile_detail_r(character varying, character varying)
-- Type: FUNCTION

-- Name: labbsc_dev_get_job_profile_detail_r(character varying, character varying); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_get_job_profile_detail_r(p_url character varying, p_user_guid character varying, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare

     v_version_number numeric;
     v_image_path varchar(4000);
     --v_authorjsonarr jsonb[];
     --v_authorjson jsonb;
     --v_json1 varchar(30000) := '{"authors":[';
     v_author_count numeric;
	v_title_alias text ;
	v_json jsonb;
	p_applied_job jsonb;
	v_job_json jsonb;
	v_applied_job numeric;
	p_job_profile_id numeric;
	p_versionnumber numeric;
	v_url text;
	v_tot_exp text;
	v_job_location text;
	v_job_type text ;
	v_job_function text;
	v_company_name text;
	v_asset_type_id numeric;
	v_joining_date character varying(500) ;
    v_minimum_salary  character varying(500);
    v_maximum_salary character varying(500) ;
    v_company_website  text;
   v_suggested_companies  text;
    v_suggested_industries  text;
    v_miscellaneous_info text;
   v_reporting_to    text;
    v_good_to_have_skill  text;
    v_must_have_skills  text;
    v_work_on_weekends character varying(500);
    v_hours_per_week  character varying(500);
    v_age_bracket  character varying(500);
     v_job_status numeric;
   
     v_min_experience character varying(500);
     v_max_experience character varying(500);
	v_job_closing_date timestamp;
	v_candidate_hired text;
begin

				v_url := p_url;
				/*raise notice 'v_url:%',v_url;
				select 1/0;*/
				
			if  exists (select 1 from    labbsc_dev.labbsc_dev_job_profile where    slug_url::text = v_url ) 
            then
				
				select job_profile_id,asset_type_id,version_number
				from    labbsc_dev.labbsc_dev_job_profile
				where    slug_url::text = v_url 
				 into   p_job_profile_id,v_asset_type_id,v_version_number ;
				
				

				if p_user_guid is not null then

						if p_job_profile_id in (select unnest(job_id)::numeric from labbsc_dev.labbsc_dev_web_user 
												where user_guid=p_user_guid) then 

						v_applied_job:=1;

						else
						
						v_applied_job:=0;
						
						end if;

				end if;

         

     select  asset_data
			 from  labbsc_dev.labbsc_dev_asset_draft
			 where  asset_type_id  = v_asset_type_id
			 and asset_id = p_job_profile_id
			 and version_number = v_version_number
			  into   v_json;
			 ---	raise notice 'v_asset_type_id %,p_job_profile_id %',v_asset_type_id,p_job_profile_id;
		
 			 
			 select c.entity_name as location,i.entity_name as total_exp,
			 	  		d.entity_name as department,g.entity_name as job_type,
						k.entity_name as company_name,
						  
    
    a.joining_date  ,
    a.minimum_salary  ,
    a.maximum_salary  ,
    a.company_website  ,
    a.suggested_companies  ,
    a.suggested_industries  ,
    a.miscellaneous_info ,
    a.reporting_to    ,
    a.good_to_have_skill  ,
    a.must_have_skills  ,
    a.work_on_weekends  ,
    a.hours_per_week  ,
    a.age_bracket  ,
    a.job_status ,
   
    a.min_experience  ,
    a.max_experience ,
	a.job_exp as job_closing_date
						into v_job_location,v_tot_exp,v_job_function,v_job_type,v_company_name 	,
						v_joining_date  ,
    v_minimum_salary  ,
    v_maximum_salary  ,
   v_company_website  ,
    v_suggested_companies  ,
    v_suggested_industries  ,
    v_miscellaneous_info ,
    v_reporting_to    ,
    v_good_to_have_skill  ,
    v_must_have_skills  ,
    v_work_on_weekends  ,
    v_hours_per_week  ,
    v_age_bracket  ,
    v_job_status ,
   
    v_min_experience  ,
    v_max_experience ,
						v_job_closing_date
						from labbsc_dev.labbsc_dev_job_profile a
						left join labbsc_dev.labbsc_dev_entity_role_map b 
						on a.job_location::numeric=b.entity_role_map_id
						left join labbsc_dev.labbsc_dev_entity_master c 
						on b.entity_master_id = c.entity_master_id
						left join labbsc_dev.labbsc_dev_entity_role_map e 
						on a.job_function::numeric=e.entity_role_map_id
						left join labbsc_dev.labbsc_dev_entity_master d 
						on e.entity_master_id = d.entity_master_id
						left join labbsc_dev.labbsc_dev_entity_role_map f 
						on a.job_type::numeric=f.entity_role_map_id
						left join labbsc_dev.labbsc_dev_entity_master g 
						on f.entity_master_id = g.entity_master_id
						left join labbsc_dev.labbsc_dev_entity_role_map h 
						on a.tot_exp::numeric=h.entity_role_map_id												
						left join labbsc_dev.labbsc_dev_entity_master i 
						on h.entity_master_id = i.entity_master_id						
						left join labbsc_dev.labbsc_dev_entity_role_map j 
						on a.company_name::numeric=j.entity_role_map_id												
						left join labbsc_dev.labbsc_dev_entity_master k 
						on j.entity_master_id = k.entity_master_id
						where a.job_profile_id=p_job_profile_id;
	---select 1/0; 
						
			v_json:=jsonb_set(v_json,'{data,tot_exp}',to_jsonb(coalesce(v_tot_exp, '')),true);
			v_json:=jsonb_set(v_json,'{data,job_type}',to_jsonb(coalesce(v_job_type, '')),true);
			v_json:=jsonb_set(v_json,'{data,job_location}',to_jsonb(coalesce(v_job_location,'')),true);
			v_json:=jsonb_set(v_json,'{data,job_function}',to_jsonb(coalesce(v_job_function, '')),true);
			v_json:=jsonb_set(v_json,'{data,company_name}',to_jsonb(coalesce(v_company_name,'')),true);
			v_json:=jsonb_set(v_json,'{data,applied_job}',to_jsonb(coalesce(v_applied_job,0)),true);
			 v_json:=jsonb_set(v_json,'{data,joining_date}',to_jsonb( coalesce(v_joining_date,'') ),true);
			 v_json:=jsonb_set(v_json,'{data,minimum_salary}',to_jsonb( coalesce(v_minimum_salary,'') ),true);
			 v_json:=jsonb_set(v_json,'{data,maximum_salary}',to_jsonb( coalesce(v_maximum_salary,'') ),true);
			 v_json:=jsonb_set(v_json,'{data,company_website}',to_jsonb( coalesce(v_company_website,'') ),true);
			 v_json:=jsonb_set(v_json,'{data,suggested_companies}',to_jsonb( coalesce(v_suggested_companies,'') ),true);
			 v_json:=jsonb_set(v_json,'{data,suggested_industries}',to_jsonb( coalesce(v_suggested_industries,'') ),true);
			 v_json:=jsonb_set(v_json,'{data,miscellaneous_info}',to_jsonb(coalesce( v_miscellaneous_info ,'') ),true);
			 v_json:=jsonb_set(v_json,'{data,reporting_to}',to_jsonb( coalesce(v_reporting_to,'')),true);
			 v_json:=jsonb_set(v_json,'{data,good_to_have_skill}',to_jsonb( coalesce(v_good_to_have_skill,'')),true);
			 v_json:=jsonb_set(v_json,'{data,must_have_skills}',to_jsonb( coalesce(v_must_have_skills,'')),true);
			 v_json:=jsonb_set(v_json,'{data,work_on_weekends}',to_jsonb( coalesce(v_work_on_weekends,'')),true);
			 v_json:=jsonb_set(v_json,'{data,hours_per_week}',to_jsonb( coalesce(v_hours_per_week,'')),true);
			 v_json:=jsonb_set(v_json,'{data,age_bracket}',to_jsonb( coalesce(v_age_bracket,'')),true);
			 v_json:=jsonb_set(v_json,'{data,job_status}',to_jsonb( coalesce(v_job_status,0)),true);
			 v_json:=jsonb_set(v_json,'{data,min_experience}',to_jsonb( coalesce(v_min_experience,'') ),true);
			 v_json:=jsonb_set(v_json,'{data,max_experience}',to_jsonb( coalesce(v_max_experience,'') ),true);
			 v_json:=jsonb_set(v_json,'{data,candidate_hired}',to_jsonb( coalesce(v_candidate_hired,'') ),true);
		  
		
		p_data:= v_json  ;

     	p_result := 1;
	else 
	    p_data:= null  ;

     	p_result := 0;
    end if;

	
	end;
$$;


--
