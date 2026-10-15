-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: _get_web_list_json(text, numeric, numeric)
-- Type: FUNCTION

-- Name: _get_web_list_json(text, numeric, numeric); Type: FUNCTION; Schema: labmi; Owner: -
--

CREATE FUNCTION labmi._get_web_list_json(p_schema_prefix text, p_asset_type_id numeric, p_asset_id numeric, OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$

begin
	
	p_schema_prefix := 'labmi';
	
	execute 'select row_to_json(row) as web_list
				from (select sl.asset_list_id, sl.asset_id, sl.asset_type_id, sl.asset_title, sl.title_alias, sl.author_id, sl.short_desc,
								sl.tags, sl.primary_entity_role_map_id, sl.secondary_entity_role_map_id, sl.total_assets, sl.image_file_name,
								sl.image_path, sl.duration, sl.published_version_number, sl.created_date, sl.updated_date, sl.created_by,
								sl.updated_by, sl.published_date, u.display_name, u.user_name, u.full_name, v.hls_url,
								(SELECT p_entity_name from labmi.labmi_get_entity_name_by_lang(sl.language_id, sl.primary_entity_role_map_id)) as primary_entity_name,
								(SELECT p_entity_display_name from labmi.labmi_get_entity_name_by_lang(sl.language_id, sl.primary_entity_role_map_id)) as pri_ent_disp_name,
								(SELECT p_entity_name from labmi.labmi_get_entity_name_by_lang(sl.language_id, sl.secondary_entity_role_map_id)) as secondary_entity_name,
								(SELECT p_entity_display_name from labmi.labmi_get_entity_name_by_lang(sl.language_id, sl.secondary_entity_role_map_id)) as sec_ent_disp_name,
								''/''||lower((SELECT p_entity_display_name from labmi.labmi_get_entity_name_by_lang(sl.language_id, sl.secondary_entity_role_map_id)))||''/''||sl.title_alias as asset_url
						from labmi.labmi_asset_list sl
						left join labmi.labmi_user u
						on u.user_id = author_id
						left join labmi.labmi_video v
						on v.video_id = sl.asset_id
						and sl.asset_type_id = 4
						where sl.asset_id = $2
						and sl.asset_type_id = $1
						
					)row'
	into p_json
	using p_asset_type_id, p_asset_id;
	
-- 	and sl.is_published = 1
-- 						and sl.is_trashed = 0
-- 						and sl.is_active = 1
-- 						and sl.is_deleted = 0
	
end;

$_$;


--
