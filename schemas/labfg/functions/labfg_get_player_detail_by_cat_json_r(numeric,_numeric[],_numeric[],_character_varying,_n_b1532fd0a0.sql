-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfg
-- Object: labfg_get_player_detail_by_cat_json_r(numeric, numeric[], numeric[], character varying, numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: labfg_get_player_detail_by_cat_json_r(numeric, numeric[], numeric[], character varying, numeric, numeric, numeric); Type: FUNCTION; Schema: labfg; Owner: -
--

CREATE FUNCTION labfg.labfg_get_player_detail_by_cat_json_r(p_player_role_map_id numeric, p_entity_role_map_id numeric[], p_asset_type_id numeric[], p_search_keyword character varying, p_page_number numeric, p_item_number numeric, p_page_size numeric, OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$ 

declare
	
	v_asset_count jsonb;
    v_category_cur jsonb;
	v_ermid numeric;
    v_entity_role_map_id numeric[];
    v_sportid numeric;
    v_sportname varchar(100);
    v_playername varchar(500);
    v_json text; 
    v_listing_asset_count numeric;
    v_listing_asset_json jsonb;
    v_asset_count_str text;
    v_entity_master_id numeric;
    v_is_image_available char(1) := 'n';
    v_entity_role_map_id1  numeric[];
    v_entity_count numeric;
    v_entity_role_map_id11 numeric;
    
begin
	
    v_entity_role_map_id := p_entity_role_map_id;
    
    select array_append(v_entity_role_map_id, p_player_role_map_id)
    into   v_entity_role_map_id;
    
	
	-- v_entity_role_map_id1:=v_entity_role_map_id
	
  select array(select b.entity_role_map_id  
  from labfg.labfg_entity_category a
  join labfg.labfg_entity_role_map b on a.entity_role_id=b.entity_role_id
  where category_name ='language'  
  and b.entity_role_map_id in (select entity_id from unnest(v_entity_role_map_id) as entity_id ))
  into  v_entity_role_map_id1;
  
  
  select b.entity_role_map_id  into  v_entity_role_map_id11
  from labfg.labfg_entity_category a
  join labfg.labfg_entity_role_map b on a.entity_role_id=b.entity_role_id
  where category_name ='language'  
  and b.entity_role_map_id in (select entity_id from unnest(v_entity_role_map_id) as entity_id )
  ;
 --  raise notice ' %',v_entity_role_map_id1;
 --  select 1/0;
  
  -- v_entity_role_map_id11:=replace(v_entity_role_map_id1::text,'{');
 raise notice ' %',v_entity_role_map_id11;
--  select 1/0;
  
  select array_append(v_entity_role_map_id1, p_player_role_map_id)
    into   v_entity_role_map_id1;
	
    select * from labfg.labfg_get_asset_count_by_cat_json_r(v_entity_role_map_id1, null, null)
    into v_asset_count, v_category_cur;
    
    if v_asset_count::text is null then
    	-- v_asset_count_str := '"'||''||'"';
        v_asset_count_str := '[]';
    else
    	v_asset_count_str := trim(trailing '}' from trim(leading '{' from v_asset_count::text));
    end if;
    
    select (json_array_elements(v_asset_count::json)->>'sentid')::numeric
    into v_ermid
    limit 1;
    
    select count(1) from unnest(v_entity_role_map_id) u(entity_role_map_id) into v_entity_count;
    
    if v_entity_count = 2 then
    
    select array_append(v_entity_role_map_id, v_ermid)
    into   v_entity_role_map_id;
    
    end if;
    
   	select * from 
     labfg.labfg_get_asset_listing_r(p_page_number, p_item_number, p_page_size, 
                                 v_entity_role_map_id, null, null, null) s1
    into v_listing_asset_count, v_listing_asset_json;
    
    select entity_master_id
    into   v_entity_master_id
    from   labfg.labfg_entity_role_map
    where  entity_role_map_id = p_player_role_map_id;
    
    /*if exists(select 1
              from   labfg.labfg_entity_image_map
              where  entity_master_id = v_entity_master_id) then
		
        v_is_image_available = 'y';
        
    end if;*/
    
    select  
    -- case when v_entity_role_map_id11=7926 then em.entity_name 
      -- else elm.entity_name end as player_name,
    -- em.entity_name as player_name ,
    
   /* ( case when (case when v_entity_role_map_id11=7926 then em.entity_name 
       else elm.entity_name end ) is null then  
       em.entity_name
       else 
       (case when v_entity_role_map_id11=7926 then em.entity_name 
       else elm.entity_name end )
       end )
       as player_name, */
      ( case when (case when v_entity_role_map_id11=7926 then em.wafc_entity_name
       else elm.entity_name end ) is null then  
       em.wafc_entity_name
       else 
       (case when v_entity_role_map_id11=7926 then em.wafc_entity_name
       else elm.entity_name end )
       end )
       as player_name,
       
    eg.entity_group_id sport_id,
    eg.group_name sport_name, 
    em.image_available::varchar
    into v_playername, v_sportid, v_sportname, v_is_image_available
	from   labfg.labfg_entity_role_map erm
	join   labfg.labfg_entity_role er
	on     er.entity_role_id = erm.entity_role_id
	join   labfg.labfg_entity_group eg
	on     eg.entity_group_id = er.entity_group_id
    join   labfg.labfg_entity_master em
    on     em.entity_master_id = erm.entity_master_id
    left join labfg.labfg_entity_language_map  elm 
     on elm.entity_master_id = erm.entity_master_id
	where  entity_role_map_id = p_player_role_map_id;
    
    if v_is_image_available = 1::varchar then
    	v_is_image_available = 'y';
	else
    	v_is_image_available = 'n';
    end if;
	
    v_json := '{"content" : {
                			"data" :{"player_id" : null,
                            	   "player_name" : "'||coalesce(v_playername, '')||'",
                                   "player_bio" : null,
                                   "sport_name" : "'||coalesce(v_sportname, '')||'",
                                   "image_available" : "'||coalesce(v_is_image_available, '')||'",'
                                   ||trim(trailing '}' from trim(leading '{' from v_listing_asset_json::text))||',
                                   "category_data" : '||trim(trailing '}' from trim(leading '{' from v_category_cur::text))||',
                                   "asset_data" : '||v_asset_count_str||'}},
				"imagesdata" : null,
                "authordata" : null,
                "nextprev" : null,
                "entitydata" : null,
                "meta" : null}';
    
    p_json := v_json::jsonb;
    
end;

 $$;


--
