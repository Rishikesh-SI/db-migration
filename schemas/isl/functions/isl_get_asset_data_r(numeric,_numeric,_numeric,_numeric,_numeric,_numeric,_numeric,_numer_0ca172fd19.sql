-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_get_asset_data_r(numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: isl_get_asset_data_r(numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: isl; Owner: -
--

CREATE FUNCTION isl.isl_get_asset_data_r(p_team_role_id numeric, p_season_role_id numeric, p_match_role_id numeric, p_compilation_role_id numeric, p_entity_role_map_id numeric, p_asset_type_id numeric, p_language_entity_role_map_id numeric, p_page_number numeric, p_item_number numeric, p_page_size numeric, OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
	
    v_fromrownumber numeric;
    v_torownumber numeric;
    v_entityroledataarray json[];
    v_seasondataarray json[];
    v_assetdataarray json[];
    v_entityroledata json;
    v_entityroledatajson text := '[';
    v_seasondata json;
    v_seasondatajson text := '[';
    v_asset_count numeric;
    v_assetdata json;
    v_assetdatajson text := '[';
    v_json text;
    v_season_role_id numeric := 7;
    
begin
	
    v_fromrownumber := (p_page_number * p_item_number - (p_item_number - 1));
    v_torownumber := (p_page_number * p_item_number);
    
    if p_team_role_id is not null then
    	
        select array(select row_to_json(row)
                     from
                     (
                         select erm.entity_role_map_id, em.entity_name
                         from isl.isl_entity_role_map erm
                         join isl.isl_entity_master em
                         on em.entity_master_id = erm.entity_master_id
                         where erm.entity_role_id = p_team_role_id
                     )row
                    )
		into v_entityroledataarray;
        
    elsif p_season_role_id is not null then
    	
        select array(select row_to_json(row)
                     from
                     (
                         select erm.entity_role_map_id, em.entity_name
                         from isl.isl_entity_role_map erm
                         join isl.isl_entity_master em
                         on em.entity_master_id = erm.entity_master_id
                         where erm.entity_role_id = p_season_role_id
                     )row
                    )
		into v_entityroledataarray;
        
    elsif p_match_role_id is not null then
    	
        select array(select row_to_json(row)
                     from
                     (
                         select erm.entity_role_map_id, em.entity_name
                         from isl.isl_entity_role_map erm
                         join isl.isl_entity_master em
                         on em.entity_master_id = erm.entity_master_id
                         where erm.entity_role_id = v_season_role_id
                     )row
                    )
		into v_seasondataarray;
        
        select array(select row_to_json(row)
                     from
                     (
                         select erm.entity_role_map_id, em.entity_name
                         from isl.isl_entity_role_map erm
                         join isl.isl_entity_master em
                         on em.entity_master_id = erm.entity_master_id
                         where exists(select 1
                                      from isl.isl_entity_role_map erm1
                                      where erm1.entity_master_id = em.entity_master_id
                                      and erm1.entity_role_id in(v_season_role_id, p_match_role_id)
                                      group by erm1.entity_role_id
                                      having count(1) = 2
                                     )
                     )row
                    )
		into v_entityroledataarray;
		
    elsif p_compilation_role_id is not null then
    	
        select array(select row_to_json(row)
                     from
                     (
                         select erm.entity_role_map_id, em.entity_name
                         from isl.isl_entity_role_map erm
                         join isl.isl_entity_master em
                         on em.entity_master_id = erm.entity_master_id
                         where erm.entity_role_id = p_compilation_role_id
                     )row
                    )
		into v_entityroledataarray;
        
    end if;
    
    select count(1)
    into v_asset_count
    from isl.isl_asset_list al
    where al.asset_type_id = p_asset_type_id
    and exists(select 1
               from isl.isl_asset_entity_map aem
               where aem.asset_id = al.asset_id
               and aem.asset_type_id = al.asset_type_id
               and aem.entity_role_map_id in(p_language_entity_role_map_id, coalesce(p_entity_role_map_id, 0))
               group by aem.asset_id, aem.asset_type_id
               having count(1) = case coalesce(p_entity_role_map_id, 0) when 0 then 1 else 2 end);
    
    select array(select row_to_json(row)
                 from
                 (
                     select asset_id, asset_type_id, asset_title, title_alias, image_file_name, image_path, published_date
                     from
                     (
                         select row_number() over(order by al.published_date desc) slno, al.asset_id, al.asset_type_id, al.asset_title, al.title_alias, 
                         		al.image_file_name, al.image_path, al.published_date
                         from isl.isl_asset_list al
                         where al.asset_type_id = p_asset_type_id
                         and exists(select 1
                                    from isl.isl_asset_entity_map aem
                                    where aem.asset_id = al.asset_id
                                    and aem.asset_type_id = al.asset_type_id
                                    and aem.entity_role_map_id in(p_language_entity_role_map_id, coalesce(p_entity_role_map_id, 0))
                                    group by aem.asset_id, aem.asset_type_id
                                    having count(1) = case coalesce(p_entity_role_map_id, 0) when 0 then 1 else 2 end)
                     )tab
                     where slno between v_fromrownumber and v_torownumber
                 )row
                )
	into v_assetdataarray;
    
    if array_length(v_entityroledataarray, 1) > 0 then
    foreach v_entityroledata in array v_entityroledataarray
    loop
    	v_entityroledatajson := v_entityroledatajson||v_entityroledata||',';  
  	end loop;
	
    if (select count(1) from unnest(v_entityroledataarray)) > 0 then
    	v_entityroledatajson := substring(v_entityroledatajson,1,(length(v_entityroledatajson)-1));
	else
     	v_entityroledatajson := substring(v_entityroledatajson,1,(length(v_entityroledatajson)));
    end if;
    end if;
    
    v_entityroledatajson := v_entityroledatajson||']';
    
    if array_length(v_seasondataarray, 1) > 0 then
    foreach v_seasondata in array v_seasondataarray
    loop
    	v_seasondatajson := v_seasondatajson||v_seasondata||',';  
  	end loop;
	
    if (select count(1) from unnest(v_seasondataarray)) > 0 then
    	v_seasondatajson := substring(v_seasondatajson,1,(length(v_seasondatajson)-1));
	else
     	v_seasondatajson := substring(v_seasondatajson,1,(length(v_seasondatajson)));
    end if;
    end if;
    
    v_seasondatajson := v_seasondatajson||']';
    
    if array_length(v_assetdataarray, 1) > 0 then
    foreach v_assetdata in array v_assetdataarray
    loop
    	v_assetdatajson := v_assetdatajson||v_assetdata||',';  
  	end loop;
	
    if (select count(1) from unnest(v_assetdataarray)) > 0 then
    	v_assetdatajson := substring(v_assetdatajson,1,(length(v_assetdatajson)-1));
	else
     	v_assetdatajson := substring(v_assetdatajson,1,(length(v_assetdatajson)));
    end if;
    
    v_assetdatajson := v_assetdatajson||']';
    
    end if;
    
    raise notice '1-%',v_assetdatajson;
    
    v_json := '{"data": {
    						"team_role_id": "'||coalesce(p_team_role_id::text, '')||'",
    						"season_role_id": "'||coalesce(p_season_role_id::text, '')||'",
                            "match_role_id": "'||coalesce(p_match_role_id::text, '')||'",
                            "seasons": '||coalesce(v_seasondatajson, '[]')||',
                            "entity_role_data": '||coalesce(v_entityroledatajson, '[]')||',
                            "asset_count": "'||coalesce(v_asset_count::text, '')||'",
                            "asset_data": '||coalesce(v_assetdatajson, '[]')||'
                        }
				}';
	
    p_json := v_json::jsonb;
	
end;

$$;


--
