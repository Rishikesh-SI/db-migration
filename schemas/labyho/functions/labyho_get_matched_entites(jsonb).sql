-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_get_matched_entites(jsonb)
-- Type: FUNCTION

-- Name: labyho_get_matched_entites(jsonb); Type: FUNCTION; Schema: labyho; Owner: -
--

CREATE FUNCTION labyho.labyho_get_matched_entites(p_input_json jsonb, OUT p_result numeric, OUT p_entities_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
begin
	
	if p_input_json is not null then
		
		with tab as
		(select e->>'priority' priority, e->>'is_visible' is_visible, e->>'name' as name, e->>'ent_disp_name' ent_disp_name,
		 		e->>'is_linkable' is_linkable, e->>'source_object_id' source_object_id, e->>'is_lang' is_lang, e->>'entity_type_name' entity_type_name
		 from (select jsonb_array_elements(p_input_json->'data') e
			  ) t1
		)
		select ('{"data":'||jsonb_agg(row_to_json(row))::text||'}')::jsonb
		from (select t.priority, t.is_visible, t.name, t.ent_disp_name, t.is_linkable, erm.entity_role_map_id::text entity_role_map_id,
			  			t.source_object_id, t.is_lang, t.entity_type_name
			  from tab t
			  join labyho.labyho_entity_type et
			  on case et.entity_type_name when 'BilateralSeries' then 'Series' else et.entity_type_name end = t.entity_type_name
			  join labyho.labyho_entity_role er
			  on er.entity_type_id = et.entity_type_id
			  join labyho.labyho_entity_role_map erm
			  on erm.entity_role_id = er.entity_role_id
			  and erm.source_object_id = t.source_object_id
			 ) row
		into p_entities_json;
		
	else
		p_result := -2;
	end if;
	
	if p_entities_json is not null then
		p_result := 1;
	else
		p_result := 0;
	end if;
	
exception
	when others then
		p_result := -1;
	
end;
$$;


--
