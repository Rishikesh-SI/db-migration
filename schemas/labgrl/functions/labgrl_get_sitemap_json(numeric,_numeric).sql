-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgrl
-- Object: labgrl_get_sitemap_json(numeric, numeric)
-- Type: FUNCTION

-- Name: labgrl_get_sitemap_json(numeric, numeric); Type: FUNCTION; Schema: labgrl; Owner: -
--

CREATE FUNCTION labgrl.labgrl_get_sitemap_json(p_asset_type_id numeric, p_asset_id numeric, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
	declare
	v_current_timestamp timestamp := current_timestamp;
    p_sitemap_category_data_json jsonb;
	begin
	
	
	execute 'select row_to_json(row) from (select al.asset_title as title, al.title_alias, al.updated_date,
								lower(replace(pem.entity_name,'' '',''-'')) primary_entity_name,
								lower(replace(sem.entity_name,'' '',''-'')) secondary_entity_name,
								al.image_path||al.image_file_name as thumbnail_image, i.image_caption,
								CP.content_provider_name as publisher,
								(select string_agg(em2.entity_name,'','') from labgrl.labgrl_asset_entity_map aem1
								left join labgrl.labgrl_entity_role_map erm2 on aem1.entity_role_map_id = erm2.entity_role_map_id
								left join labgrl.labgrl_entity_master em2 on erm2.entity_master_id = em2.entity_master_id 
								where asset_id = al.asset_id and asset_type_id = al.asset_type_id) entities
							from labgrl.labgrl_asset_list al
							join labgrl.labgrl_asset_entity_map aem
							on aem.asset_id = al.asset_id
							and aem.asset_type_id = al.asset_type_id
							join labgrl.labgrl_entity_role_map perm
							on perm.entity_role_map_id = al.primary_entity_role_map_id
							join labgrl.labgrl_entity_master pem
							on pem.entity_master_id = perm.entity_master_id
							join labgrl.labgrl_entity_role_map serm
							on serm.entity_role_map_id = al.secondary_entity_role_map_id
							join labgrl.labgrl_entity_master sem
							on sem.entity_master_id = serm.entity_master_id
							left join labgrl.labgrl_album_asset_map aam
							on aam.album_id = al.asset_id
							and al.asset_type_id = 2
							and aam.is_cover = 1
							left join labgrl.labgrl_image i
							on i.image_id = aam.asset_id
							and aam.asset_type_id = 3
							left join labgrl.labgrl_provider_author_map PAM
							on al.author_id = PAM.author_id
							left join labgrl.labgrl_content_provider CP
							on PAM.content_provider_id = CP.content_provider_id
							where al.asset_type_id in('''||p_asset_type_id||''')
							and aem.entity_role_map_id = 4
                              and al.asset_id='''||p_asset_id||'''
          					and al.is_published = 1 order by al.published_date desc)row'
			into p_sitemap_category_data_json;
			
			p_data:=p_sitemap_category_data_json;
	end;
	
$$;


--
