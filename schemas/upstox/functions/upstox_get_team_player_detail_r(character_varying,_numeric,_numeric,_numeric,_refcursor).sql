-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_get_team_player_detail_r(character varying, numeric, numeric, numeric, refcursor)
-- Type: FUNCTION

-- Name: upstox_get_team_player_detail_r(character varying, numeric, numeric, numeric, refcursor); Type: FUNCTION; Schema: upstox; Owner: -
--

CREATE FUNCTION upstox.upstox_get_team_player_detail_r(p_id character varying, p_entity_type numeric, p_id_source numeric, p_sport_id numeric, p_data refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
 

declare
	
    v_query text;
    
begin
	
    if p_id_source = 1 then
    	
        v_query := 'select em.entity_master_id, em.entity_name, em.entity_display_name, em.country, em.canonical_url, erm.entity_role_map_id,
        					erm.source_object_id, image_available
					from upstox.upstox_entity_role_map erm
                    join upstox.upstox_entity_role er
                    on er.entity_role_id = erm.entity_role_id
                    join upstox.upstox_entity_type et
                    on et.entity_type_id = er.entity_type_id
                    join upstox.upstox_entity_group eg
                    on eg.entity_group_id = er.entity_group_id
                    and eg.entity_group_id = '||p_sport_id||'
                     join upstox.upstox_entity_master em
                    on em.entity_master_id = erm.entity_master_id
                    where et.entity_type_id = case '||p_entity_type||' when 1 then 1 when 2 then 2 else et.entity_type_id end
                    and erm.entity_role_map_id =any((''{'||p_id||'}'')::numeric[])';
        
    elsif p_id_source = 2 then
    	
        v_query := 'select em.entity_master_id, em.entity_name, 
		em.entity_display_name, em.country, em.canonical_url, 
		erm.entity_role_map_id,erm.source_object_id, image_available,
		et.entity_type_name,et.entity_type_id,em.show_content,em.show_data
					from upstox.upstox_entity_role_map erm
                    join upstox.upstox_entity_role er
                    on er.entity_role_id = erm.entity_role_id
                    join upstox.upstox_entity_type et
                    on et.entity_type_id = er.entity_type_id
                    join upstox.upstox_entity_group eg
                    on eg.entity_group_id = er.entity_group_id
                    and eg.entity_group_id = '||p_sport_id||'
                     join upstox.upstox_entity_master em
                    on em.entity_master_id = erm.entity_master_id
                    where et.entity_type_id =  '||p_entity_type||'
                    and erm.source_object_id::text =any((''{'||p_id||'}'')::text[])';
        
    end if;
    
    open p_data for execute v_query;
    
end;

 
$$;


--
