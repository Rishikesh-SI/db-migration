-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: labisp_ins_article_migration_log(jsonb)
-- Type: FUNCTION

-- Name: labisp_ins_article_migration_log(jsonb); Type: FUNCTION; Schema: labisp; Owner: -
--

CREATE FUNCTION labisp.labisp_ins_article_migration_log(p_input_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
	
	v_asset_id numeric;
	v_asset_type_id numeric;
	v_asset_slug text;
	v_is_article_saved numeric;
	v_error_on_save text;
	v_image_source_path text;
	v_image_new_path text;
	v_image_ratio text;
	v_image_type text;
	v_error_on_image_save text;
	v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	
begin
	
	select p_input_json->>'asset_id', p_input_json->>'asset_type_id', p_input_json->>'asset_slug', p_input_json->>'is_article_saved',
			p_input_json->>'error_on_save', p_input_json->'image'->>'source_path', p_input_json->'image'->>'new_path',
			p_input_json->'image'->>'ratio', p_input_json->'image'->>'image_type', p_input_json->'image'->>'error_on_image_save'
	into v_asset_id, v_asset_type_id, v_asset_slug, v_is_article_saved, v_error_on_save, v_image_source_path, v_image_new_path, v_image_ratio,
			v_image_type, v_error_on_image_save;
	
	if exists(select 1 from labisp.labisp_migration_asset_log_temp where asset_id = v_asset_id and asset_type_id = 1) then
		
		update labisp.labisp_migration_asset_log_temp
		set asset_slug = case coalesce(v_asset_slug,'') when '' then asset_slug else v_asset_slug end,
-- 			image_count = case coalesce(v_error_on_image_save,'') when '' then (coalesce(image_count,0) + 1) else image_count end,
			has_featured_image = case v_image_type when 'featured' then 1 else has_featured_image end,
			is_asset_saved = case v_is_article_saved when null then is_asset_saved else v_is_article_saved end,
			error_if_any = case coalesce(v_error_on_save,'') when '' then error_if_any else v_error_on_save end,
			updated_date = v_current_timestamp
		where asset_id = v_asset_id
		and asset_type_id = 1;
		
		if (coalesce(v_image_source_path,'') <> '' or coalesce(v_image_new_path,'') <> '' or coalesce(v_image_ratio,'') <> ''
			or coalesce(v_image_type,'') <> '') then
			insert into labisp.labisp_migration_image_log_temp(asset_id, asset_type_id, source_path, new_path, ratio, image_type, error_if_any,
															   created_date)
			select v_asset_id, v_asset_type_id, v_image_source_path, v_image_new_path, v_image_ratio, v_image_type, v_error_on_image_save,
					v_current_timestamp;
		end if;
		
	else
		
		insert into labisp.labisp_migration_asset_log_temp(asset_id, asset_type_id, asset_slug, error_if_any, created_date)
		select v_asset_id, v_asset_type_id, v_asset_slug, v_error_on_save, v_current_timestamp;
		
	end if;
	
	p_result := 1;
	
exception
	when others then
		p_result := -1;
	
end;
$$;


--
