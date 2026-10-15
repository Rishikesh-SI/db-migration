-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_ingest_tracking_data(jsonb)
-- Type: FUNCTION

-- Name: labdms_ingest_tracking_data(jsonb); Type: FUNCTION; Schema: labdms; Owner: -
--

CREATE FUNCTION labdms.labdms_ingest_tracking_data(p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
	
	v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	v_year numeric := date_part('year',v_current_timestamp)::numeric;
	v_year_month numeric := to_char(v_current_timestamp,'yyyymm')::numeric;
	v_year_table_name text := 'labdms_user_action_tracking_'||v_year;
	v_year_month_table_name text := 'labdms_user_action_tracking_'||v_year_month;
	v_table_script text;
	v_user_data_array jsonb;
	v_asset_id_ar numeric[];
	v_asset_type_id_ar numeric[];
	v_url_ar text[];
	v_user_guid_ar text[];
	v_guest_guid_ar text[];
	v_action_ar text[];
	v_extra_ar text[];
	v_guid_ar text[];
	v_referrer_ar text[];
	v_user_agent_ar text[];
	
begin
	
	p_result := 0;
	
	if not exists(select 1 from pg_class
				  where relname = v_year_table_name) then
		
		v_table_script := 'create table '||v_year_table_name||
							' partition of labdms.labdms_user_action_tracking
							for values in('||v_year||')
							partition by list(action_year_month)';
		
		call labdms.labdms_create_partition_table(v_table_script);
		
	end if;
	
	if not exists(select 1 from pg_class
				  where relname = v_year_month_table_name) then
		
		v_table_script := 'create table '||v_year_month_table_name||
							' partition of labdms.'||v_year_table_name||
							' for values in('||v_year_month||')';
		
		call labdms.labdms_create_partition_table(v_table_script);
		
	end if;
	
-- 	select p_json->'data'->'userdata' into v_user_data_array;
	
-- 	select array_agg(obj.value->>'asset_id'),
-- 			array_agg(obj.value->>'asset_type_id'),
-- 			array_agg(obj.value->>'url'::text),
-- 			array_agg(obj.value->>'user_id'),
-- 			array_agg(obj.value->>'guest_guid'),
-- 			array_agg(obj.value->>'action'),
-- 			array_agg(obj.value->'extra'),
-- 			array_agg(obj.value->>'data_guid'),
-- 			array_agg(obj.value->>'referer'),
-- 			array_agg(obj.value->>'user_agent')
-- 	from jsonb_array_elements(v_user_data_array) obj(value)
-- 	into v_asset_id_ar, v_asset_type_id_ar, v_url_ar, v_user_guid_ar, v_guest_guid_ar, v_action_ar, v_extra_ar, v_guid_ar, v_referrer_ar,
-- 			v_user_agent_ar;
	
-- 	insert into labdms.labdms_user_action_tracking(asset_id, asset_type_id, url, user_guid, guest_guid, action_type, action_url, guid,
-- 												   referral_url, user_agent)
-- 	select unnest(v_asset_id_ar), unnest(v_asset_type_id_ar), unnest(v_url_ar::text[]), unnest(v_user_guid_ar), unnest(v_guest_guid_ar),
-- 			unnest(v_action_ar), unnest(v_extra_ar), unnest(v_guid_ar), unnest(v_referrer_ar), unnest(v_user_agent_ar);
	
-- 	update labdms.labdms_user_action_tracking uat
-- 	set user_guid = glum.user_guid
-- 	from labdms.labdms_guest_login_user_map glum
-- 	where glum.guest_guid = uat.guest_guid
-- 	and uat.action_year_month = v_year_month
-- 	and uat.user_guid is null;
	
	p_result := 1;
	
exception
	when others then
		p_result := -1;
	
end;
$$;


--
