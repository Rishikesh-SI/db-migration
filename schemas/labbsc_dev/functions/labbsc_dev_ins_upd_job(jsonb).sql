-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_ins_upd_job(jsonb)
-- Type: FUNCTION

-- Name: labbsc_dev_ins_upd_job(jsonb); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_ins_upd_job(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
--do
--$$

declare
 

		       v_sysdate 		timestamp;
		
		       v_job_profile_id numeric;
			   v_job_profile text;
			   v_slug_url varchar(1000);
			   v_job_id text;
			   v_tot_exp text;
			   v_job_descr text;
			   v_email_id text;
			   v_job_location text;
			   v_job_function text;
			   v_job_type text;
			   v_created_by numeric;
			   v_updated_by numeric;
			   v_status numeric;
			   v_is_deleted numeric;
			   v_job_guid varchar(1000);
			   v_exp_date timestamp;
			   v_pub_date timestamp;
			   v_assetdraftid numeric;
			   v_assetdraftguid varchar(1000);
			   v_versionnumber numeric :=1;
			   v_is_trashed numeric;
			   v_pubversionnumber numeric;
			   v_seojson jsonb;
				v_seodataid numeric;
				v_seodataguid text;
				v_json jsonb;
				v_jobentityjson jsonb;
				v_entity jsonb;
				v_entityrolemapid numeric;
				v_priority numeric;
				v_is_linkable numeric;
				v_is_visible numeric;
				v_assetentitymapid numeric;
				v_assetentitymapguid varchar(1000);
				v_array numeric[]; 
				v_asset_list_id numeric;
				v_company_name numeric;
				v_dont_expire_job numeric;
				v_test_id numeric;
				v_assettypeid numeric;
				
				v_entityjson jsonb;
				v_job_entity numeric;
				
				v_job_summary  text;
			 
			v_job_category varchar(500);
			 
			v_joining_date varchar(500);
			v_min_experience varchar(500);
			v_max_experience varchar(500);
			v_description text;
			v_minimum_salary varchar(500);
			v_maximum_salary varchar(500);
			v_company_website  text;
			v_suggested_companies  text;
			v_suggested_industries  text;
			v_age_bracket varchar(500);
			v_must_have_skills text;
			v_good_to_have_skill text;
			v_hours_per_week varchar(500);
			v_work_on_weekends varchar(500);
			v_reporting_to text;
			v_miscellaneous_info text;
				
BEGIN

	select current_timestamp  at time zone 'utc'
	into   v_sysdate;    
   --- v_json:=p_json;
   ---raise notice '%',p_json;
	
	for v_json in (select * from jsonb_array_elements(p_json))
	loop
	
	
	select 	    v_json->'data'->>'job_profile_id',  
			    v_json->'data'->>'job_profile',
			    v_json->'data'->>'slug_url',
			    v_json->'data'->>'job_id',
			    v_json->'data'->>'tot_exp',
			    v_json->'data'->>'job_descr',
		        v_json->'data'->>'email_id',
			    v_json->'data'->>'job_location',
			    v_json->'data'->>'job_function',
			    v_json->'data'->>'job_type',
			    v_json->'data'->>'created_by',
			   -- p_json->'data'->>'created_date',
			    v_json->'data'->>'updated_by',
               -- p_json->'data'->>'updated_date',
                v_json->'data'->>'status',
				v_json->'data'->>'is_deleted',
				v_json->'data'->>'job_guid',
				v_json->'data'->>'job_exp_date',
				v_json->'data'->>'published_data',
				v_json->'data'->>'is_trashed',
				v_json->'data'->>'seo',
				v_json->'data'->>'company_name',
				v_json->'data'->>'dont_expire_job',
				v_json->'data'->>'test_id',
				v_json->'data'->>'asset_type',
				v_json->'data'->>'description',
				v_json->'data'->>'job_category',
				v_json->'data'->>'job_summary',
				v_json->'data'->>'joining_date',
				v_json->'data'->>'company_website',
				v_json->'data'->>'min_exp',
				v_json->'data'->>'max_exp',
				v_json->'data'->>'min_salary',
				v_json->'data'->>'max_salary',
				v_json->'data'->>'suggest_company_hire',
				v_json->'data'->>'suggest_industry_hire',
				v_json->'data'->>'age_bracket',
				v_json->'data'->>'hours_week',
				v_json->'data'->>'work_weekend',
				v_json->'data'->>'report_to',
				v_json->'data'->>'miscellaneous_info',
				v_json->'data'->>'have_skills',
				v_json->'data'->>'good_skills'
		into 
		       v_job_profile_id,
			   v_job_profile,
			   v_slug_url,
			   v_job_id,
			   v_tot_exp,
			   v_job_descr,
			   v_email_id,
			   v_job_location,
			   v_job_function,
			   v_job_type,
			   v_created_by,
			   v_updated_by,
			   v_status,
			   v_is_deleted,
			   v_job_guid,
			   v_exp_date,
			   v_pub_date,
			   v_is_trashed,
				v_seojson,
				v_company_name,
				v_dont_expire_job,
				v_test_id,
				v_assettypeid,
				v_description,
				v_job_category,
				v_job_summary,
				v_joining_date,
				v_company_website,
				v_min_experience,
				v_max_experience,
				v_minimum_salary,
				v_maximum_salary,
				v_suggested_companies,
				v_suggested_industries,
				v_age_bracket,
				v_hours_per_week,
				v_work_on_weekends,
				v_reporting_to,
				v_miscellaneous_info,
				v_must_have_skills,
				v_good_to_have_skill
				;
				
			---	raise notice '%',v_job_profile;

	
	v_pub_date := coalesce(v_pub_date,v_sysdate);
	v_assetdraftid   := nextval('labbsc_dev.seq_labbsc_dev_asset_draft_id');
	v_assetdraftguid := uuid_generate_v4();
	
	
	
	if v_dont_expire_job = 1 then 
	
		v_exp_date := '2099-12-31';
		
	end if;	

	  select v_json->'data'->>'entitydata'
			into   v_entityjson;
			

		 
	 if not exists(select 1 from labbsc_dev.labbsc_dev_job_profile
				  where  job_profile = v_job_profile) then 
            
			--select 1/0;
		
			v_asset_list_id := nextval ('labbsc_dev.seq_labbsc_dev_asset_list_id');
			v_job_profile_id := nextval('labbsc_dev.seq_labbsc_dev_job_profile_id');
			v_job_guid      :=  uuid_generate_v4();
			v_seodataid      := nextval('labbsc_dev.seq_labbsc_dev_seo_data_id');
		    v_seodataguid    := uuid_generate_v4();
			v_slug_url := v_slug_url || '-'||v_job_profile_id;
			
			raise notice '%',v_job_profile_id;	
			
			    insert into labbsc_dev.labbsc_dev_job_profile
				select v_job_profile_id,v_job_profile,v_slug_url,v_job_id,v_tot_exp,v_job_descr,v_job_location,v_job_function,v_job_type,v_assettypeid,
					   v_sysdate,v_created_by,v_updated_by,v_sysdate,v_job_guid,null,v_pub_date,v_email_id,v_versionnumber,v_is_trashed,
					   v_status,null,v_exp_date,v_company_name,v_dont_expire_job,v_test_id,
					    v_job_summary , v_job_category,
						v_joining_date ,
						v_minimum_salary,
						v_maximum_salary ,
						v_company_website ,
						v_suggested_companies ,
						v_suggested_industries  ,
						v_miscellaneous_info ,
						v_reporting_to  ,
						v_good_to_have_skill,
						v_must_have_skills,
						v_work_on_weekends,
						v_hours_per_week,
						v_age_bracket ,
						0 ,
						1 ,
						v_description,
						v_min_experience,
						v_max_experience
					   ;
				
				insert into labbsc_dev.labbsc_dev_asset_list(asset_list_id, asset_id, asset_type_id, asset_title, title_alias, author_id, short_desc, tags,
                                           primary_entity_role_map_id, secondary_entity_role_map_id, total_assets, image_file_name, image_path,
                                           duration, show_in_web, show_in_mobile, show_in_app, published_version_number, is_trashed, created_date, 
                                           updated_date, created_by, updated_by, is_active, is_deleted, is_published, published_date, asset_guid,
                                           show_copyright, order_number,short_title)
			   values(v_asset_list_id, v_job_profile_id, v_assettypeid, v_job_profile, v_slug_url, null, v_job_descr, null, 121, 41, null, null,
                   null, null, null, null, 0, v_versionnumber, v_is_trashed, v_sysdate, v_sysdate,
                   1, 1, 1, 0, v_status, v_sysdate, v_job_guid, null, null,null);
			

                v_json := jsonb_set(v_json, '{data,job_guid}', ('"'||v_job_guid||'"')::text::jsonb, true);
				v_json := jsonb_set(v_json, '{data,job_profile_id}', ('"'||v_job_profile_id||'"')::text::jsonb, true);
				v_json := jsonb_set(v_json, '{data,slug_url}', ('"'||v_slug_url||'"')::text::jsonb, true);
                -- p_json := jsonb_set(p_json, '{data,contact_id}', ('"'||v_contact_id||'"')::text::jsonb, true);
                -- p_json := jsonb_set(p_json, '{data,attachment}', ('"'||coalesce(v_attachment,'')||'"')::text::jsonb, true);
			 	-- p_result := 1;
	 		 
			-- p_contactjson := p_json;

				--p_contactjson := null;
			--end if ;
			
			   insert into labbsc_dev.labbsc_dev_asset_draft
				(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date, 
				updated_date, created_by,updated_by, is_active, is_deleted, asset_draft_guid)
				values
				(v_assetdraftid, v_job_profile_id, v_assettypeid, v_versionnumber, v_json, v_sysdate, 
				v_sysdate, v_updated_by, v_created_by, 1, 0, v_assetdraftguid);
				
				
				
				
				
				insert into labbsc_dev.labbsc_dev_seo_data
				(seo_data_id, asset_id, asset_type_id, meta_info, published_version_number, created_date, 
				updated_date, created_by, updated_by, is_active, is_deleted, is_published, seo_data_guid)
				values
				(v_seodataid, v_job_profile_id, v_assettypeid, v_seojson,v_versionnumber,  v_sysdate, 
				v_sysdate, v_updated_by, v_updated_by, 1, 0, v_status, v_seodataguid);
				else 
				v_job_profile_id:=null;
				v_status:=0;
	end if;
 
 
	if v_job_profile_id is not null then 
		
 	--	raise notice '%',v_jobentityjson;
		if v_entityjson is not null then
			
			delete
			from   labbsc_dev.labbsc_dev_asset_entity_map
			where  asset_type_id = v_assettypeid
			and    asset_id      = v_job_profile_id;
			
			for v_entity in select * from jsonb_array_elements(v_entityjson)
			loop
				
				select v_entity->>'entity_role_map_id', v_entity->>'priority',
						v_entity->>'is_linkable', v_entity->>'is_visible'
				into   v_entityrolemapid, v_priority,v_is_linkable,v_is_visible;
				
				if v_entityrolemapid is not null then
					
					v_assetentitymapid   := nextval('labbsc_dev.seq_labbsc_dev_asset_entity_map_id');
					v_assetentitymapguid := uuid_generate_v4();
					
					insert into labbsc_dev.labbsc_dev_asset_entity_map
					(asset_entity_map_id, asset_id, asset_type_id, entity_role_map_id, is_linkable, is_visible,
					priority, created_date, updated_date, created_by, updated_by, is_active, is_deleted,
					is_published, aemap_guid)
					values
					(v_assetentitymapid, v_job_profile_id, v_assettypeid,
					v_entityrolemapid, v_is_linkable, v_is_visible, v_priority, v_sysdate,
					v_sysdate, v_updated_by, v_updated_by, 1, 0, 1, v_assetentitymapguid);
					

					update labbsc_dev.labbsc_dev_asset_list
						set    primary_entity_role_map_id 	= case when v_priority = 1 then v_entityrolemapid else primary_entity_role_map_id end,
							   secondary_entity_role_map_id = case when v_priority = 2 then v_entityrolemapid else secondary_entity_role_map_id end
						where  asset_id 				    = v_job_profile_id
           				and    asset_type_id                = v_assettypeid;

								
				end if;     
				
			end loop;
			
		end if;

end if;

			--if  v_status = 1 then
		
			select array(select entity_role_map_id 
						 from labbsc_dev.labbsc_dev_asset_entity_map
						 where asset_id = v_job_profile_id
						 and asset_type_id = v_assettypeid

						)	a into v_array; 
						
				v_array := 	array_append(v_array,v_tot_exp::numeric);	
				v_array := 	array_append(v_array,v_job_location::numeric);
				v_array := 	array_append(v_array,v_job_function::numeric);
				v_array := 	array_append(v_array,v_job_type::numeric);
				v_array := 	array_append(v_array,v_company_name::numeric);
				
			  update labbsc_dev.labbsc_dev_job_profile 
			  set tagged_entity=v_array
			  where job_profile_id=v_job_profile_id;

			---end if;
			
			end loop;
			
			
			 
			
		
p_result:=1;
p_data:=p_json;
END;
$_$;


--
