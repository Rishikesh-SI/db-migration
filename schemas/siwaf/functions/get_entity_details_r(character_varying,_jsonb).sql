-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_entity_details_r(character varying, jsonb)
-- Type: FUNCTION

-- Name: _get_entity_details_r(character varying, jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_entity_details_r(p_schema_prefix character varying, p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
	 v_entity_master_id numeric;
begin

     
	
	
	 select  p_json->'id'
	 into    v_entity_master_id;
	 raise notice '1.innn';
	 if (lower(p_schema_prefix) not in ('labwis','labecn_v1','labgrl','labgsoc','labgt','labrr',
									   'labeisl', 'labkxip', 'labukk', 'labrstg', 'labpvl', 'labsaw', 
					   'labbr', 'labgmr', 'labmcfc_v1', 'labrg', 'labdv', 'labgg', 'labgfg',
					   'lablsg', 'labpc', 'labpr', 'labfih', 'labdsg', 'labkc_v1', 'labkkr', 'labwpl', 
					   'labupw', 'lablakr', 'labisl_v1', 'labspz_v1', 'labkkr_v1', 'labdd_v1', 'labwf', 
					   'labecn_v1', 'labilt', 'labsm', 'labetpl', 'labwskl')) then
     
	execute  'select row_to_json(row) from 
         (select  a.entity_master_id,a.entity_name,a.entity_display_name,
          a.canonical_url,a.player_image_path ,a.updated_date,(d.entity_type_name) as entity_type_name,
          d.entity_type_id,c.entity_role_id,b.source_object_id,c.entity_group_id,c.entity_type_id,
          a.is_active,a.is_deleted,a.entity_url,b.entity_role_map_id,coalesce(a.show_data,0) as show_data,
          coalesce(a.show_content,0) as show_content,  a.is_add_info as is_add_info
          from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master a
          join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map b on a.entity_master_id = b.entity_master_id
          join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role c on b.entity_role_id = c.entity_role_id
          join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_type d on c.entity_type_id = d.entity_type_id
          where a.entity_master_id='||v_entity_master_id||' ) as row'    
          into p_data;
			  
			  -- and  a.is_deleted=0 and a.is_active=1
	 else
     
     execute  'select row_to_json(row) from 
         (select  a.entity_master_id,a.entity_name,a.entity_display_name,
          a.canonical_url,a.player_image_path ,a.updated_date,(d.entity_type_name) as entity_type_name,
          d.entity_type_id,c.entity_role_id,b.source_object_id,c.entity_group_id,c.entity_type_id,
          a.is_active,a.is_deleted,a.entity_url,b.entity_role_map_id,coalesce(a.show_data,0) as show_data,
          coalesce(a.show_content,0) as show_content,coalesce(a.show_standings,0) as show_standings,
          ref_source_object_id,ref_tag_id,ref_url,a.add_info,coalesce(a.is_add_info, false) as is_add_info
          from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master a
          join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map b on a.entity_master_id = b.entity_master_id
          join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role c on b.entity_role_id = c.entity_role_id
          join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_type d on c.entity_type_id = d.entity_type_id
          where a.entity_master_id='||v_entity_master_id||' ) as row'    
          into p_data;
     
     end if;
	
	 
end;
$$;


--
