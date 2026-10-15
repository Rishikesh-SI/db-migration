-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_get_team_player_detail_r(character varying, numeric, numeric, numeric, refcursor)
-- Type: FUNCTION

-- Name: abp_get_team_player_detail_r(character varying, numeric, numeric, numeric, refcursor); Type: FUNCTION; Schema: abpp; Owner: -
--

CREATE FUNCTION abpp.abp_get_team_player_detail_r(p_id character varying, p_entity_type numeric, p_id_source numeric, p_sport_id numeric, p_data refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare
	
    v_query text;
    
begin
	
    if p_id_source = 1 then
    	
        v_query := 'select em.entity_master_id, em.entity_name, em.entity_display_name, em.known_as, em.canonical_url, null as big_image,
					null as small_image, null as profile_text, null as fb_url, null as twtr_url, null as gp_url, null as linkdin_url,
					null as instagram_url, null as flicker_url, null as vimeo, null as youtube, em.is_active, em.is_deleted is_delete, 0 as position,
					null as position_short, erm.hyperlink, erm.entity_role_map_id, erm.source_object_id, '||p_entity_type||' as entity_type_id,
					et.entity_type_name, em.country, image_available
					from abp.abp_entity_role_map erm
                    join abp.abp_entity_role er
                    on er.entity_role_id = erm.entity_role_id
                    join abp.abp_entity_type et
                    on et.entity_type_id = er.entity_type_id
                    join abp.abp_entity_group eg
                    on eg.entity_group_id = er.entity_group_id
                    and eg.waf_entity_group_id = '||p_sport_id||'
                    join abp.abp_entity_master em
                    on em.entity_master_id = erm.entity_master_id
                    where et.entity_type_id = case '||p_entity_type||' when 1 then 1 when 2 then 2 else et.entity_type_id end
                    and erm.entity_role_map_id =any((''{'||p_id||'}'')::numeric[])';
        
    elsif p_id_source = 2 then
    	
        v_query := 'select em.entity_master_id, em.entity_name, em.entity_display_name, em.known_as, em.canonical_url, null as big_image,
					null as small_image, null as profile_text, null as fb_url, null as twtr_url, null as gp_url, null as linkdin_url,
					null as instagram_url, null as flicker_url, null as vimeo, null as youtube, em.is_active, em.is_deleted is_delete, 0 as position,
					null as position_short, erm.hyperlink, erm.entity_role_map_id, erm.source_object_id, '||p_entity_type||' as entity_type_id,
					et.entity_type_name, em.country, image_available
					from abp.abp_entity_role_map erm
                    join abp.abp_entity_role er
                    on er.entity_role_id = erm.entity_role_id
                    join abp.abp_entity_type et
                    on et.entity_type_id = er.entity_type_id
                    join abp.abp_entity_group eg
                    on eg.entity_group_id = er.entity_group_id
                    and eg.waf_entity_group_id = '||p_sport_id||'
                    join abp.abp_entity_master em
                    on em.entity_master_id = erm.entity_master_id
                    where et.entity_type_id = case '||p_entity_type||' when 1 then 1 when 2 then 2 else et.entity_type_id end
                    and erm.source_object_id::numeric =any((''{'||p_id||'}'')::numeric[])';
        
    end if;
    
    open p_data for execute v_query;
    
end;

$$;


--
