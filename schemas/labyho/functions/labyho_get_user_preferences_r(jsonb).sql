-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_get_user_preferences_r(jsonb)
-- Type: FUNCTION

-- Name: labyho_get_user_preferences_r(jsonb); Type: FUNCTION; Schema: labyho; Owner: -
--

CREATE FUNCTION labyho.labyho_get_user_preferences_r(p_input_json jsonb, OUT p_result numeric, OUT p_user_preferences jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
	v_user_guid character varying(500);
	v_guest_guid character varying(500);
	v_type numeric;
	v_user_preferences jsonb;
	v_preferences_count jsonb;
	
begin
	
	p_result := 0;
	
	select p_input_json->>'user_guid', p_input_json->>'guest_guid', p_input_json->>'type'
	into v_user_guid, v_guest_guid, v_type;
	
	v_user_guid := case v_user_guid when '' then 'na' else v_user_guid end;
	v_guest_guid := case v_guest_guid when '' then 'na' else v_guest_guid end;
	
	select json_agg(row_to_json(row))
	from (select up.type_id, up.value as id, em.entity_name as name
		  from labyho.labyho_user_preferences up
		  join labyho.labyho_asset_type at
		  on at.asset_type_id = up.type_id
		  join labyho.labyho_entity_role_map erm
		  on erm.entity_role_id = at.entity_role_id
		  and erm.source_object_id = up.value::text
		  join labyho.labyho_entity_master em
		  on em.entity_master_id = erm.entity_master_id
		  where (user_guid = v_user_guid
				 or guest_guid = v_guest_guid)
		  and type_id = v_type
		  group by up.type_id, up.value, em.entity_name
		 ) row
	into v_user_preferences;
	
	select json_agg(row_to_json(row))
	from (select up.type_id, up.value as id, em.entity_name as name, count(1) count
		  from labyho.labyho_user_preferences up
		  join labyho.labyho_asset_type at
		  on at.asset_type_id = up.type_id
		  join labyho.labyho_entity_role_map erm
		  on erm.entity_role_id = at.entity_role_id
		  and erm.source_object_id = up.value::text
		  join labyho.labyho_entity_master em
		  on em.entity_master_id = erm.entity_master_id
		  where up.type_id = v_type
		  group by up.type_id, up.value, em.entity_name
		  order by em.entity_name
		 ) row
	into v_preferences_count;
	
	select row_to_json(row)::jsonb
	from (select v_user_preferences as user_preferences, v_preferences_count as preference_count
		 ) row
	into p_user_preferences;
	
	if p_user_preferences is not null then
		p_result := 1;
	end if;
	
exception
	when others then
		p_result := -1;
end;
$$;


--
