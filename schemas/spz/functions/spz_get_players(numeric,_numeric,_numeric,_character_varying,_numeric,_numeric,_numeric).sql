-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: spz_get_players(numeric, numeric, numeric, character varying, numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: spz_get_players(numeric, numeric, numeric, character varying, numeric, numeric, numeric); Type: FUNCTION; Schema: spz; Owner: -
--

CREATE FUNCTION spz.spz_get_players(p_institute_id numeric, p_sport_id numeric, p_category_id numeric, p_player_name character varying, p_city_id numeric, p_page_number numeric, p_item_number numeric, OUT p_players_count numeric, OUT p_players_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

declare
	
    v_fromrownumber numeric;
    v_torownumber numeric;
    v_institute_qry text := '';
    v_sport_qry text := '';
    v_category_qry text := '';
    v_city_qry text := '';
    v_playersearch_qry text := '';
    v_count_query text := '';
    v_player_query text := '';
    
begin
	
    v_fromrownumber := (p_page_number * p_item_number - (p_item_number - 1));
    v_torownumber   := (p_page_number * p_item_number);
    
    p_player_name := upper(p_player_name) ;
    if coalesce(p_institute_id,0) != 0
    then 
    	v_institute_qry := ' and pim.institute_id = $1 ' ;
    end if ;    
    
    if coalesce(p_sport_id,0) != 0 
    then 
    	v_sport_qry := ' and psm.sport_id = $2 ' ;
    end if ;
    
    if coalesce(p_category_id,0) != 0
    then 
    	v_category_qry := ' and pm.category_id = $3 '  ;
    end if ;
    
    if coalesce(p_city_id,0) != 0
    then 
    	v_city_qry := ' and i.city_id = $4 '  ;
    end if ;
    
    if p_player_name is not null
    then 
    	v_playersearch_qry := ' and upper(pm.first_name || '' ''|| coalesce(pm.middle_name,'''') || '' ''||coalesce(pm.last_name,''''))
        						like ''%''||'||'$5'||'||''%'' ';
    end if ;
    
      
	execute  'select count(pm.player_id) 
    ---  into p_players_count
    from spz.spz_player_master pm
    join spz.spz_player_sport_map psm
    on psm.player_id = pm.player_id
    join spz.spz_player_institute_map pim
    on pim.player_id = pm.player_id
    join spz.spz_position_master pm1
    on pm1.position_id = psm.position_id
    join spz.spz_institute_master i 
    on (i.institute_id = pim.institute_id)
    where 1 = 1 ' 
    || v_institute_qry
    || v_sport_qry
    || v_category_qry
    || v_city_qry
    || v_playersearch_qry 
   into p_players_count
   using p_institute_id, p_sport_id, p_category_id, p_city_id, p_player_name ;
   
  --  pm.category_id = (case when coalesce(p_category_id,0) = 0 then pm.category_id else p_category_id end)
    -- coalesce(p_category_id,pm.category_id)
  --  and psm.sport_id = p_sport_id
  --  and pim.institute_id = p_institute_id;
    
   execute ' select (''{"players":[''||string_agg((row_to_json(row))::text,'','')||'']}'')::jsonb
    		 from (select player_name ,jersey_no,position_name,slno, player_id, institute_id, 
             		institute_name, city_id , city_name,  profile_image
          	 		from (select pm.first_name || '' ''|| coalesce(pm.middle_name,'''') || '' ''||coalesce(pm.last_name,'''') player_name,
                           psm.jersey_no,pm1.position_name,
                           row_number() over(order by jersey_no) slno,
                           pm.player_id,  pim.institute_id , i.institute_name, i.city_id , c.city_name,
                           pm.category_id, null profile_image
                    from spz.spz_player_master pm
                    join spz.spz_player_sport_map psm
                    on psm.player_id = pm.player_id
                    join spz.spz_player_institute_map pim
                    on pim.player_id = pm.player_id
                    join spz.spz_position_master pm1
                    on pm1.position_id = psm.position_id
                    join spz.spz_institute_master i 
                    on (i.institute_id = pim.institute_id)
                    left join spz.spz_city_master c 
                    on (c.city_id = i.city_id)
                    where 1 = 1 '
                    || v_institute_qry
                    || v_sport_qry
                    || v_category_qry
                    || v_city_qry
                    || v_playersearch_qry 
                    ||' )tab
              where slno between $6 and $7
             )row '
             into p_players_json
             using p_institute_id, p_sport_id, p_category_id, p_city_id, p_player_name, v_fromrownumber, v_torownumber ;
    
    if p_players_count = 0 then
    	p_players_json := ('{"players":[]}')::jsonb;
    end if;
    
end;

$_$;


--
