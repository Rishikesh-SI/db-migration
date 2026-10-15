-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: _get_web_list_json(text, numeric, numeric)
-- Type: FUNCTION

-- Name: _get_web_list_json(text, numeric, numeric); Type: FUNCTION; Schema: labyho; Owner: -
--

CREATE FUNCTION labyho._get_web_list_json(p_schema_prefix text, p_asset_type_id numeric, p_asset_id numeric, OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$

begin 
	
	
	
	p_schema_prefix := 'labyho';
	
	execute 'select row_to_json(row) as web_list
				from (select al.asset_list_id, al.asset_id, al.asset_type_id, al.asset_title, al.title_alias, al.author_id, al.short_desc,
								al.tags, al.primary_entity_role_map_id, al.secondary_entity_role_map_id, al.total_assets, al.image_file_name,
								al.image_path, al.duration, al.published_version_number, al.created_date, al.updated_date, al.created_by,
								al.updated_by, al.published_date, u.display_name display_name, u.user_name user_name, u.full_name full_name,
								(select p_entity_name from labyho.labyho_get_entity_name_by_lang(language_id, al.primary_entity_role_map_id)) as primary_entity_name,
								(select p_entity_display_name from labyho.labyho_get_entity_name_by_lang(language_id, al.primary_entity_role_map_id)) as pri_ent_disp_name,
								(select p_entity_name from labyho.labyho_get_entity_name_by_lang(language_id, al.secondary_entity_role_map_id)) as secondary_entity_name,
								(select p_entity_display_name from labyho.labyho_get_entity_name_by_lang(language_id, al.secondary_entity_role_map_id)) as sec_ent_disp_name,
								cp.content_provider_id content_source_id, cp.content_provider_name, al.show_in_web, al.show_in_mobile,
								al.show_in_app, al.is_trashed, al.is_active, al.is_deleted, al.is_published, al.asset_guid, al.show_copyright,
								al.order_number, al.short_title, al.language_url as lang_curl
						from labyho.labyho_asset_list al
						left join labyho.labyho_user u
						on u.user_id = al.author_id
						left join labyho.labyho_provider_author_map pam
						on pam.author_id = al.author_id
						left join labyho.labyho_content_provider cp
						on cp.content_provider_id = pam.content_provider_id
						where al.asset_id = $1
						and al.asset_type_id = $2
						and al.is_published = 1
						and al.is_trashed = 0
						and al.is_active = 1
						and al.is_deleted = 0
					)row'
	into p_json
	using p_asset_id, p_asset_type_id;
	
end;

$_$;


--
