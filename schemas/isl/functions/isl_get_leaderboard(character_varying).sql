-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_get_leaderboard(character varying)
-- Type: FUNCTION

-- Name: isl_get_leaderboard(character varying); Type: FUNCTION; Schema: isl; Owner: -
--

CREATE FUNCTION isl.isl_get_leaderboard(p_match_source_object_id character varying, OUT p_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
    v_teamsarray text[];
    v_team text;
    v_ht_gp numeric := 0;
    v_ht_htt numeric := 0;
    v_ht_att numeric := 0;
    v_at_gp numeric := 0;
    v_at_htt numeric := 0;
    v_at_att numeric := 0;
    v_t_gp numeric := 0;
    v_t_tf numeric := 0;
    v_t_ta numeric := 0;
    v_t_td numeric := 0;
    v_points numeric := 0;
    v_win_points numeric := 0;
    v_draw_points numeric := 0;
    v_leaderboardrowjson json;
    v_leaderboardjson text := '{"leader_board":{"data":[';
    v_leaderboard jsonb;
    v_last_character char(1);
    
begin
	
    if p_match_source_object_id is not null then
    	
        select leader_board
        into strict v_leaderboard
        from isl.isl_match_centre
        where match_source_object_id = p_match_source_object_id;
        
	else
    	
        select array(select erm.source_object_id
                     from isl.isl_entity_role_map erm
                     join isl.isl_entity_master em
                     on em.entity_master_id = erm.entity_master_id
                     where erm.entity_role_id = 5)
		into v_teamsarray;
        
        foreach v_team in array(v_teamsarray)
        loop
        	
            select count(1) gp, sum((match_day_battle->>'home_team_tweets')::numeric) tf, sum((match_day_battle->>'away_team_tweets')::numeric) ta
            into v_ht_gp, v_ht_htt, v_ht_att
            from isl.isl_match_centre
            where match_day_battle->>'home_team_id' = v_team
            and match_source_object_id = coalesce(p_match_source_object_id, match_source_object_id)
            and (match_centre_json->'data'->>'match_status')::text in ('L','R');
            -- and ((match_day_battle->>'is_draw')::text = 'true' or match_day_battle->>'winning_team_id' is  not null);
            
            -- select * from isl.isl_match_centre limit 1
            
            select count(1) gp, sum((match_day_battle->>'home_team_tweets')::numeric) tf, sum((match_day_battle->>'away_team_tweets')::numeric) ta
            into v_at_gp, v_at_htt, v_at_att
            from isl.isl_match_centre
            where match_day_battle->>'away_team_id' = v_team
            and match_source_object_id = coalesce(p_match_source_object_id, match_source_object_id)
            and (match_centre_json->'data'->>'match_status')::text in ('L','R');
            -- and ((match_day_battle->>'is_draw')::text = 'true' or match_day_battle->>'winning_team_id' is  not null);
            
            select count(1) points
            into v_win_points
            from isl.isl_match_centre
            where match_day_battle->>'winning_team_id' = v_team
            and match_source_object_id = coalesce(p_match_source_object_id, match_source_object_id);
            
            select count(1) points
            into v_draw_points
            from isl.isl_match_centre
            where (match_day_battle->>'is_draw')::text = 'true'
            and (match_day_battle->>'home_team_id' = v_team or match_day_battle->>'away_team_id' = v_team)
            and match_source_object_id = coalesce(p_match_source_object_id, match_source_object_id);
            
            v_points := (v_win_points * 3) + v_draw_points;
            
            v_t_gp := v_ht_gp + v_at_gp;
            v_t_tf := coalesce(v_ht_htt,0) + coalesce(v_at_att,0);
            v_t_ta := coalesce(v_ht_att,0) + coalesce(v_at_htt,0);
            v_t_td := v_t_tf - v_t_ta;
            
            select row_to_json(row)
            from(select erm.entity_role_map_id, em.entity_name, v_team source_object_id, v_t_gp gp, v_t_tf tf, v_t_ta ta, v_t_td td, v_points points
                 from isl.isl_entity_role_map erm
                 join isl.isl_entity_master em
                 on em.entity_master_id = erm.entity_master_id
                 where erm.source_object_id = v_team
                 and erm.entity_role_id = 5)row
			into v_leaderboardrowjson;
            
            v_leaderboardjson := v_leaderboardjson||v_leaderboardrowjson||',';
            
		end loop;
        
        select substring(reverse(v_leaderboardjson),1,1) into v_last_character;
        
        if v_last_character = ',' then
        	v_leaderboardjson := substring(v_leaderboardjson,1,(length(v_leaderboardjson)-1))||']}}';
		else
        	v_leaderboardjson := v_leaderboardjson||']}}';
		end if;
        
        v_leaderboard := v_leaderboardjson::jsonb;
        v_leaderboard := jsonb_set(v_leaderboard,'{leader_board,match_source_object_id}',
                                   ('"'||coalesce(p_match_source_object_id,'')||'"')::text::jsonb,true);
		v_leaderboard := jsonb_set(v_leaderboard,'{leader_board,series_source_object_id}',('"'||''||'"')::text::jsonb,true);
        v_leaderboard := jsonb_set(v_leaderboard,'{leader_board,sports_source_object_id}',('"'||''||'"')::text::jsonb,true);
        
	end if;
	
    p_result := 1;
    p_json := v_leaderboard;
	    
exception
	when no_data_found then
    	p_result := 0;
        p_json := (v_leaderboardjson||']}}')::jsonb;
	
end;

$$;


--
