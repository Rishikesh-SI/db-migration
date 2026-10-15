-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_old
-- Object: labbsc_get_job_profile_filters()
-- Type: FUNCTION

-- Name: labbsc_get_job_profile_filters(); Type: FUNCTION; Schema: labbsc_old; Owner: -
--

CREATE FUNCTION labbsc_old.labbsc_get_job_profile_filters(OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

	declare

	v_json jsonb;
	v_function jsonb;
	v_type jsonb;
	v_exprience jsonb;
	v_company jsonb;

	begin

	select '{"location":'||json_agg(row)||'}' into v_json from
	(
	select b.entity_role_map_id,a.entity_name  from labbsc.labbsc_entity_master a
	join labbsc.labbsc_entity_role_map b on a.entity_master_id = b.entity_master_id
	where b.entity_role_id in (23)
	order by b.entity_role_map_id	
	)row;

	select json_agg(row) into v_function from
	(
	select b.entity_role_map_id,a.entity_name  from labbsc.labbsc_entity_master a
	join labbsc.labbsc_entity_role_map b on a.entity_master_id = b.entity_master_id
	where b.entity_role_id in (24)
	order by b.entity_role_map_id	
	)row;

	select json_agg(row) into v_type from
	(
	select b.entity_role_map_id,a.entity_name  from labbsc.labbsc_entity_master a
	join labbsc.labbsc_entity_role_map b on a.entity_master_id = b.entity_master_id
	where b.entity_role_id in (25)
	order by b.entity_role_map_id	
	)row;

	select json_agg(row) into v_exprience from
	(
	select b.entity_role_map_id,a.entity_name  from labbsc.labbsc_entity_master a
	join labbsc.labbsc_entity_role_map b on a.entity_master_id = b.entity_master_id
	where b.entity_role_id in (26)
	order by b.entity_role_map_id 	
	)row;
	
		select json_agg(row) into v_company from
	(
	select b.entity_role_map_id,a.entity_name  from labbsc.labbsc_entity_master a
	join labbsc.labbsc_entity_role_map b on a.entity_master_id = b.entity_master_id
	where b.entity_role_id in (27)
	order by b.entity_role_map_id 	
	)row;

	v_json := jsonb_set(v_json,'{job_function}',v_function,true);
	v_json := jsonb_set(v_json,'{job_type}',v_type,true);
	v_json := jsonb_set(v_json,'{total_exprience}',v_exprience,true);
	v_json := jsonb_set(v_json,'{Company}',v_company,true);
	
	p_data := v_json;
	

	end;

	$$;


--
