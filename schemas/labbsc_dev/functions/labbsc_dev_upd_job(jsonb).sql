-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_upd_job(jsonb)
-- Type: FUNCTION

-- Name: labbsc_dev_upd_job(jsonb); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_upd_job(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
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
			v_job_status numeric;

begin
select current_timestamp  at time zone 'utc'
	into   v_sysdate;    
    v_json:=p_json;
	
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
				v_good_to_have_skill ;

	
	v_pub_date := coalesce(v_pub_date,v_sysdate);
	v_assetdraftid   := nextval('labbsc_dev.seq_labbsc_dev_asset_draft_id');
	v_assetdraftguid := uuid_generate_v4();
	
	if v_dont_expire_job = 1 then 
	
		v_exp_date := '2099-12-31';
		
	end if;	

	if (v_status = 0  and v_job_profile_id is not null) then
		
		
				if v_is_trashed = 0 then
						select coalesce(max(version_number),1)
						into   strict v_pubversionnumber
						from   labbsc_dev.labbsc_dev_job_profile
						where  job_profile_id      = v_job_profile_id; 
						
						
						select max(version_number)
						into   strict v_versionnumber
						from   labbsc_dev.labbsc_dev_asset_draft
						where  asset_type_id = v_assettypeid
						and    asset_id      = v_job_profile_id;
						
						update labbsc_dev.labbsc_dev_job_profile
						set  is_trashed=v_is_trashed,  
							 is_published=v_status ,
							  updated_date=v_sysdate
							  --job_status=v_job_status
						where job_profile_id  = v_job_profile_id;
						
						if v_versionnumber > v_pubversionnumber then
								
								update labbsc_dev.labbsc_dev_asset_draft ad
								set     asset_data        = v_json,
										updated_date      = v_sysdate
								where  asset_id      = v_job_profile_id
								and    asset_type_id = v_assettypeid
								and    ad.version_number = (select max(ad1.version_number)
								from   labbsc_dev.labbsc_dev_asset_draft ad1
								where  ad1.asset_id = ad.asset_id
								and    ad1.asset_type_id = v_assettypeid);
						else
								v_versionnumber := v_versionnumber + 1;
								insert into labbsc_dev.labbsc_dev_asset_draft
								(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date, 
								updated_date, created_by,updated_by, is_active, is_deleted, asset_draft_guid)
								values
										(v_assetdraftid, v_job_profile_id, v_assettypeid, v_versionnumber, v_json, v_sysdate, 
									v_sysdate, v_updated_by, v_created_by, 1, 0, v_assetdraftguid);

						end if;
			   -- select * from labbsc_dev.labbsc_dev_job_profile;
			   else 
			
					
			
					update labbsc_dev.labbsc_dev_job_profile
					set is_trashed=v_is_trashed,  
				       is_published=v_status ,
				        updated_date=v_sysdate
					----	asset_type_id = v_assettypeid
				    where job_profile_id        	  = v_job_profile_id;
				
                    update labbsc_dev.labbsc_dev_asset_draft ad
					set    asset_data        = v_json,
					updated_date      = v_sysdate
				---	asset_type_id = v_assettypeid
					where  asset_id      = v_job_profile_id
					and    asset_type_id = v_assettypeid
					and    ad.version_number = (select max(ad1.version_number)
					from   labbsc_dev.labbsc_dev_asset_draft ad1
					where  ad1.asset_id = ad.asset_id
					and    ad1.asset_type_id = v_assettypeid);
          
           
          		select max(ad1.version_number)
                  into v_versionnumber
                  from   labbsc_dev.labbsc_dev_asset_draft ad1
                  where  ad1.asset_id = v_job_profile_id
                  and    ad1.asset_type_id = v_assettypeid;          
			
				end if;
				
		else 
			
			select max(version_number)
			into   strict v_versionnumber
			from   labbsc_dev.labbsc_dev_asset_draft
			where  asset_type_id = v_assettypeid
			and    asset_id      = v_job_profile_id;

			v_versionnumber := v_versionnumber + 1;
			
			insert into labbsc_dev.labbsc_dev_asset_draft
								(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date, 
								updated_date, created_by,updated_by, is_active, is_deleted, asset_draft_guid)
								values
										(v_assetdraftid, v_job_profile_id, v_assettypeid, v_versionnumber, v_json, v_sysdate, 
									v_sysdate, v_updated_by, v_created_by, 1, 0, v_assetdraftguid);
				
				
				
 				update labbsc_dev.labbsc_dev_job_profile
				set job_profile=v_job_profile,
					slug_url=v_slug_url,
					job_id=v_job_id,
					tot_exp=v_tot_exp,
					job_desc=v_job_descr,
					job_function=v_job_function,
					job_location =v_job_location,
					job_type=v_job_type,
					email_id=v_email_id,
					version_number=v_versionnumber,
					updated_by=v_updated_by,
					updated_date=v_sysdate,
					is_published = v_status,
					is_trashed = v_is_trashed,
					job_exp = v_exp_date,
					company_name = v_company_name,
					do_not_expired = v_dont_expire_job,
					test_id = v_test_id,
					--job_status=v_job_status,
					  description=v_description,
				job_category=v_job_category,
			  job_summary=v_job_summary,
				joining_date=v_joining_date,
				company_website=v_company_website,
				min_experience=v_min_experience,
				max_experience=v_max_experience,
				minimum_salary=v_minimum_salary,
				maximum_salary=v_maximum_salary,
				suggested_companies=v_suggested_companies,
				suggested_industries=v_suggested_industries,
				age_bracket=v_age_bracket,
				hours_per_week=v_hours_per_week,
				work_on_weekends=v_work_on_weekends,
				reporting_to=v_reporting_to,
				miscellaneous_info=v_miscellaneous_info,
				must_have_skills=v_must_have_skills,
				good_to_have_skill=v_good_to_have_skill
				---	asset_type_id = v_assettypeid
				where job_profile_id=v_job_profile_id;
 				
				update labbsc_dev.labbsc_dev_asset_list
				set   asset_title        	   = v_job_profile,
					  title_alias       	   = v_slug_url,
                      short_desc    	       = v_job_descr,
                      published_version_number = v_versionnumber,
                      updated_date      	   = v_sysdate,
                      is_published      	   = v_status,
                      is_trashed        	   = v_is_trashed,
                      published_date           = v_sysdate,
					  primary_entity_role_map_id=121,
					  secondary_entity_role_map_id=41
					
                     --- asset_type_id = v_assettypeid
				where asset_id        	       = v_job_profile_id
        		and   asset_type_id            = v_assettypeid;
				
				update labbsc_dev.labbsc_dev_seo_data
				set    meta_info 	 = v_seojson,
				       updated_date  = v_sysdate,
					   published_version_number=v_versionnumber
				where  asset_type_id = v_assettypeid
				and    asset_id      = v_job_profile_id;
 
     end if;
	 	
p_result:=1;
p_data:=v_json;
END;
$$;


--
