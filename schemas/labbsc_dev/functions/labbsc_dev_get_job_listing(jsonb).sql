-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_get_job_listing(jsonb)
-- Type: FUNCTION

-- Name: labbsc_dev_get_job_listing(jsonb); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_get_job_listing(p_json jsonb, OUT p_job_list jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
v_created_date timestamp;
v_updated_date timestamp;
v_page_number numeric;
v_item_number numeric;
v_fromrownumber numeric;
v_torownumber numeric;
v_count numeric;
v_location jsonb;
	v_function jsonb;
	v_type jsonb;
	v_exprience jsonb;
	v_company jsonb;
begin
select p_json->>'created_date',
        p_json->>'updated_date',
		p_json->>'page_number',
		p_json->>'item_number'
		into v_created_date,
		v_updated_date,
		v_page_number,
		v_item_number;
		
		
		
v_fromrownumber := (v_page_number * v_item_number - (v_item_number - 1));
v_torownumber   := (v_page_number * v_item_number);

  
	 
	 select '{"items":'||jsonb_agg(tab)::text||',"count":'||cnt||'}' 
	 into p_job_list
			 	  from(select count(1) over() as cnt,a.job_profile_id ,a.job_profile,a.slug_url,c.entity_name as location,
			 	  		d.entity_name as department,a.job_desc,g.entity_name as job_type,a.pub_date,a.test_id, i.entity_name as company_name,
						row_number() over ( order by pub_date desc) as rn,
						i.player_image_path as company_url,
						a.job_summary , a.job_category,
						a.joining_date ,
						a.minimum_salary,
						a.maximum_salary ,
						a.company_website ,
						a.suggested_companies ,
						a.suggested_industries  ,
						a.miscellaneous_info ,
						a.reporting_to  ,
						a.good_to_have_skill,
						a.must_have_skills,
						a.work_on_weekends,
						a.hours_per_week,
						a.age_bracket,
						a.description
				  		from labbsc_dev.labbsc_dev_job_profile a
						join labbsc_dev.labbsc_dev_entity_role_map b on a.job_location::numeric=b.entity_role_map_id
						join labbsc_dev.labbsc_dev_entity_master c on b.entity_master_id = c.entity_master_id
						join labbsc_dev.labbsc_dev_entity_role_map e on a.job_function::numeric=e.entity_role_map_id
						join labbsc_dev.labbsc_dev_entity_master d on e.entity_master_id = d.entity_master_id
						join labbsc_dev.labbsc_dev_entity_role_map f on a.job_type::numeric=f.entity_role_map_id
						join labbsc_dev.labbsc_dev_entity_master g on f.entity_master_id = g.entity_master_id
						join labbsc_dev.labbsc_dev_entity_role_map h on a.company_name::numeric=h.entity_role_map_id
						join labbsc_dev.labbsc_dev_entity_master i on h.entity_master_id = i.entity_master_id
						where  a.is_published= 1
						and a.is_trashed=0
				and a.created_date::date =  coalesce(v_created_date, a.created_date::date)  
			and ( a.updated_date::date=	  case when v_created_date is null then  v_updated_date 
			else  a.updated_date::date end )
			)tab
						where rn between v_fromrownumber and v_torownumber
						group by cnt
			;
		
		
		

	end;
$$;


--
