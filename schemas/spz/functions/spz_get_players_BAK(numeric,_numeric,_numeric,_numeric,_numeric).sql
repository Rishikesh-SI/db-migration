-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: spz_get_players_BAK(numeric, numeric, numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: spz_get_players_BAK(numeric, numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: spz; Owner: -
--

CREATE FUNCTION spz."spz_get_players_BAK"(p_institute_id numeric, p_sport_id numeric, p_category_id numeric, p_page_number numeric, p_item_number numeric, OUT p_players_count numeric, OUT p_players_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
    v_fromrownumber numeric;
    v_torownumber numeric;
    
begin
	
    v_fromrownumber := (p_page_number * p_item_number - (p_item_number - 1));
    v_torownumber   := (p_page_number * p_item_number);
    
	select count(pm.player_id) into p_players_count
    from spz.spz_player_master pm
    join spz.spz_player_sport_map psm
    on psm.player_id = pm.player_id
    join spz.spz_player_institute_map pim
    on pim.player_id = pm.player_id
    join spz.spz_position_master pm1
    on pm1.position_id = psm.position_id
    where pm.category_id = (case when coalesce(p_category_id,0) = 0 then pm.category_id else p_category_id end)
    -- coalesce(p_category_id,pm.category_id)
    and psm.sport_id = p_sport_id
    and pim.institute_id = p_institute_id;
    
    select ('{"players":['||string_agg((row_to_json(row))::text,',')||']}')::jsonb
    from (select player_name ,jersey_no,position_name,slno, player_id, institute_id, 
          institute_name, city_id , city_name,  profile_image
          from (select pm.first_name || ' '|| coalesce(pm.middle_name,'') || ' '||coalesce(pm.last_name,'') player_name,
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
                where pm.category_id = (case when coalesce(p_category_id,0) = 0 then pm.category_id else p_category_id end)
                and psm.sport_id = p_sport_id
                and pim.institute_id = p_institute_id
               )tab
          where slno between v_fromrownumber and v_torownumber
         )row
	into p_players_json;
    
    if p_players_count = 0 then
    	p_players_json := ('{"players":[]}')::jsonb;
    end if;
    
end;

$$;


--
