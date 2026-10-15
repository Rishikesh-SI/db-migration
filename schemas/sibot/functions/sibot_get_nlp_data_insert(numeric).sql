-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_get_nlp_data_insert(numeric)
-- Type: FUNCTION

-- Name: sibot_get_nlp_data_insert(numeric); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_get_nlp_data_insert(p_application_id numeric, OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
	
	v_json jsonb := '{"data":[]}'::jsonb;
    v_leagues_json jsonb;
    v_teams_json jsonb;
    v_sports_json jsonb;
    v_venues_json jsonb;
    v_players_json jsonb;
    v_repeated_players_json jsonb;
    
begin
	
	select ('{"leagues":['||string_agg((row_to_json(row))::text,',')||']}')::jsonb
    from (select l.league_id as id,league_name as name,meta_data||','||league_name||','||league_short_name meta_data
          from sibot.sibot_league l
          join sibot.sibot_application_league_map alm
          on alm.league_id = l.league_id
          where alm.application_id = p_application_id
          union
          select 0 as id,'leagues' as name,null as meta_data)row
    into v_leagues_json;
    
    select ('{"teams":['||string_agg((row_to_json(row))::text,',')||']}')::jsonb
    from (select t.team_id as id,team_name as name,meta_data||','||team_name meta_data
          from sibot.sibot_team t
          join sibot.sibot_application_league_team_map altm
          on altm.team_id = t.team_id
          where altm.application_id = p_application_id
          union
          select 0 as id,'teams' as name,null as meta_data)row
    into v_teams_json;
    
    select ('{"sports":['||string_agg((row_to_json(row))::text,',')||']}')::jsonb
    from (select s.sport_id as id,sport_name as name,s.meta_data||','||sport_name meta_data
          from sibot.sibot_sport s
          join sibot.sibot_league l
          on l.sport_id = s.sport_id
          join sibot.sibot_application_league_map alm
          on alm.league_id = l.league_id
          where alm.application_id = p_application_id
          union
          select 0 as id,'sports' as name,null as meta_data)row
    into v_sports_json;
    
    select ('{"venues":['||string_agg((row_to_json(row))::text,',')||']}')::jsonb
    from (select v.venue_id as id,venue_name as name,meta_data||','||venue_name meta_data
          from sibot.sibot_venue v
          join sibot.sibot_application_venue_map avm
          on avm.venue_id = v.venue_id
          where avm.application_id = p_application_id
          union
          select 0 as id,'venues' as name,null as meta_data)row
    into v_venues_json;
    
    /*select ('{"players":['||string_agg((row_to_json(row))::text,',')||']}')::jsonb
    from (select p.player_id as id,player_name as name,meta_data||','||player_name meta_data
          from sibot.sibot_player p
          join sibot.sibot_application_league_team_player_map altpm
          on altpm.player_id = p.player_id
          where altpm.application_id = p_application_id
          union
          select 0 as id,'players' as name,null as meta_data)row
    into v_players_json;*/
    
    select ('{"players":['||string_agg((row_to_json(row))::text,',')||']}')::jsonb
    from (select p.player_id as id,synonyms as name,synonyms meta_data
          from sibot.sibot_nlp_assets nlpa
          join sibot.sibot_player p
          on ids::numeric = p.player_id
          join sibot.sibot_application_league_team_player_map altpm
          on altpm.player_id = p.player_id
          where altpm.application_id = p_application_id
          and category_name = 'players'
          and array_length(string_to_array(ids,','),1) = 1
          union
          select 0 as id,'players' as name,null as meta_data)row
    into v_players_json;
    
    select ('{"repeated_players":['||string_agg((row_to_json(row))::text,',')||']}')::jsonb
    from (select p.player_id as id,synonyms as name,synonyms meta_data
          from sibot.sibot_nlp_assets nlpa
          join sibot.sibot_player p
          on p.player_id in(select unnest(string_to_array(ids,',')))
          join sibot.sibot_application_league_team_player_map altpm
          on altpm.player_id = p.player_id
          where altpm.application_id = p_application_id
          and category_name = 'players'
          and array_length(string_to_array(ids,','),1) > 1
          union
          select 0 as id,'players' as name,null as meta_data)row
    into v_repeated_players_json;
    
    v_json := jsonb_set(v_json,'{data,1}',v_leagues_json,true);
    v_json := jsonb_set(v_json,'{data,2}',v_teams_json,true);
    v_json := jsonb_set(v_json,'{data,3}',v_sports_json,true);
    v_json := jsonb_set(v_json,'{data,4}',v_venues_json,true);
    v_json := jsonb_set(v_json,'{data,5}',v_players_json,true);
    v_json := jsonb_set(v_json,'{data,6}',v_repeated_players_json,true);
    
    p_json := v_json;
    
end;

$$;


--
