-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkr_beta
-- Object: labtkr_get_player_detail_by_cat_r(numeric, numeric[], numeric[], character varying, numeric, numeric, numeric, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: labtkr_get_player_detail_by_cat_r(numeric, numeric[], numeric[], character varying, numeric, numeric, numeric, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: labtkr_beta; Owner: -
--

CREATE FUNCTION labtkr_beta.labtkr_get_player_detail_by_cat_r(p_player_role_map_id numeric, p_entity_role_map_id numeric[], p_asset_type_id numeric[], p_search_keyword character varying, p_page_number numeric, p_item_number numeric, p_page_size numeric, p_asset_count refcursor, p_category_cur refcursor, p_ermidarr refcursor, p_listing_asset_count refcursor, p_listing_asset_json refcursor, p_sport_detail refcursor, p_asset_count_all refcursor, p_category_cur_all refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

declare
	
	v_asset_count refcursor;
    my_data record;
    v_arr_count numeric[];
    v_arr_sentid numeric[];
    i numeric := 1;
	v_ermid numeric;
    v_entity_role_map_id numeric[];
    v_listing_asset_count numeric;
    v_listing_asset_json jsonb;
    v_sportid numeric;
    v_sportname varchar(100);
    v_playername varchar(500);
    v_language_erm_id numeric[];
    
begin
	
    v_entity_role_map_id := p_entity_role_map_id;
    
    select array(select erm.entity_role_map_id
                 from   labtkr.labtkr_entity_category ec
                 join   labtkr.labtkr_entity_role_map erm
                 on     erm.entity_role_id = ec.entity_role_id
                 where  category_name = 'language'
                 and    erm.entity_role_map_id in(select entity_role_map_id
                                                  from   unnest(v_entity_role_map_id) u(entity_role_map_id)
                                                 )
                 )
	into   v_language_erm_id;
    
    select array_append(v_language_erm_id, p_player_role_map_id)
    into   v_language_erm_id;
    
    perform labtkr.labtkr_get_asset_count_by_cat_r(v_language_erm_id, null, null, p_asset_count_all, p_category_cur_all);
    
    select array_append(v_entity_role_map_id, p_player_role_map_id)
    into   v_entity_role_map_id;
    
	perform labtkr.labtkr_get_asset_count_by_cat_r(v_entity_role_map_id, null, null, p_asset_count, p_category_cur);
    
    v_asset_count :=  p_asset_count;
    
    loop
    	fetch v_asset_count into my_data;
       	exit when not found;
        v_arr_count[i] := my_data.cnt;
       	v_arr_sentid[i] := my_data.sentid;
       	i := i + 1;
	end loop;
    close v_asset_count;
    
	select v_sentid into v_ermid from unnest(v_arr_sentid) u(v_sentid) limit 1;
    
    open p_ermidarr for select v_ermid;
    
    select array_append(v_entity_role_map_id, v_ermid)
    into   v_entity_role_map_id;
    
   	select * from labtkr.labtkr_get_asset_listing_r(p_page_number, p_item_number, p_page_size, v_entity_role_map_id, null, null, null) s1
    into v_listing_asset_count, v_listing_asset_json;
    
    select em.entity_name player_name, eg.entity_group_id sport_id, eg.group_name sport_name
    into   v_playername, v_sportid, v_sportname
	from   labtkr.labtkr_entity_role_map erm
	join   labtkr.labtkr_entity_role er
	on     er.entity_role_id = erm.entity_role_id
	join   labtkr.labtkr_entity_group eg
	on     eg.entity_group_id = er.entity_group_id
    join   labtkr.labtkr_entity_master em
    on     em.entity_master_id = erm.entity_master_id
	where  entity_role_map_id = p_player_role_map_id;
    
    open p_listing_asset_count for select v_listing_asset_count;
    
    open p_listing_asset_json for select v_listing_asset_json;
    
    open p_asset_count for select * from unnest(v_arr_count, v_arr_sentid) u(cnt, sentid);
    
    open p_sport_detail for select v_playername player_name, v_sportname sport_name;
 	
end;

 $$;


--
