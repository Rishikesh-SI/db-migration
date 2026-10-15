-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_get_job_profile_detail_r(character varying, character varying)
-- Type: FUNCTION

-- Name: labbsc_get_job_profile_detail_r(character varying, character varying); Type: FUNCTION; Schema: labbsc; Owner: -
--

CREATE FUNCTION labbsc.labbsc_get_job_profile_detail_r(p_url character varying, p_user_guid character varying, OUT p_result numeric, OUT p_data jsonb) RETURNS record
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
begin

				v_url := p_url;
				/*raise notice 'v_url:%',v_url;
				select 1/0;*/
				
			if  exists (select 1 from    labbsc.labbsc_job_profile where    slug_url::text = v_url ) 
            then
				
				select job_profile_id,asset_type_id,version_number
				from    labbsc.labbsc_job_profile
				where    slug_url::text = v_url 
				 into   p_job_profile_id,v_asset_type_id,v_version_number ;
				
				

				if p_user_guid is not null then

						if p_job_profile_id in (select unnest(job_id)::numeric from labbsc.labbsc_web_user 
												where user_guid=p_user_guid) then 

						v_applied_job:=1;

						else
						
						v_applied_job:=0;
						
						end if;

				end if;

         

     select  asset_data
			 from  labbsc.labbsc_asset_draft
			 where  asset_type_id  = v_asset_type_id
			 and asset_id = p_job_profile_id
			 and version_number = v_version_number
			  into   v_json;
 			 
			 select c.entity_name as location,i.entity_name as total_exp,
			 	  		d.entity_name as department,g.entity_name as job_type,
						k.entity_name as company_name
						into v_job_location,v_tot_exp,v_job_function,v_job_type,v_company_name 						
						from labbsc.labbsc_job_profile a
						join labbsc.labbsc_entity_role_map b 
						on a.job_location::numeric=b.entity_role_map_id
						join labbsc.labbsc_entity_master c 
						on b.entity_master_id = c.entity_master_id
						join labbsc.labbsc_entity_role_map e 
						on a.job_function::numeric=e.entity_role_map_id
						join labbsc.labbsc_entity_master d 
						on e.entity_master_id = d.entity_master_id
						join labbsc.labbsc_entity_role_map f 
						on a.job_type::numeric=f.entity_role_map_id
						join labbsc.labbsc_entity_master g 
						on f.entity_master_id = g.entity_master_id
						join labbsc.labbsc_entity_role_map h 
						on a.tot_exp::numeric=h.entity_role_map_id												
						join labbsc.labbsc_entity_master i 
						on h.entity_master_id = i.entity_master_id						
						join labbsc.labbsc_entity_role_map j 
						on a.company_name::numeric=j.entity_role_map_id												
						join labbsc.labbsc_entity_master k 
						on j.entity_master_id = k.entity_master_id
						where a.job_profile_id=p_job_profile_id;
		
						
			v_json:=jsonb_set(v_json,'{data,tot_exp}',to_jsonb(v_tot_exp),true);
			v_json:=jsonb_set(v_json,'{data,job_type}',to_jsonb(v_job_type),true);
			v_json:=jsonb_set(v_json,'{data,job_location}',to_jsonb(v_job_location),true);
			v_json:=jsonb_set(v_json,'{data,job_function}',to_jsonb(v_job_function),true);
			v_json:=jsonb_set(v_json,'{data,company_name}',to_jsonb(v_company_name),true);
			v_json:=jsonb_set(v_json,'{data,applied_job}',to_jsonb(coalesce(v_applied_job,0)),true);
			 
		
		p_data:= v_json  ;

     	p_result := 1;
	else 
	    p_data:= null  ;

     	p_result := 0;
    end if;

	
	end;
$$;


--
