-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_get_schedule(jsonb)
-- Type: FUNCTION

-- Name: sibot_get_schedule(jsonb); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_get_schedule(p_input_json jsonb, OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
	
    v_current_date date;
    v_application_id numeric;
    v_sports_arr numeric[];
    v_leagues_arr numeric[];
    v_matches_arr numeric[];
    
begin
	
    select (p_input_json->>'date')::date, p_input_json->>'application_id' into v_current_date, v_application_id;
    
    if v_current_date is null then
    	v_current_date := (current_timestamp at time zone 'utc')::date;
    end if;
    
    select array(select distinct s.sport_id
    				from sibot.sibot_match m
    			 	join sibot.sibot_league l
    			 	on l.league_id = m.league_id
    			 	join sibot.sibot_sport s
    			 	on s.sport_id = l.sport_id
                 	join sibot.sibot_application_league_map alm
                 	on alm.league_id = l.league_id
    			 	where alm.application_id = v_application_id
                 	and v_current_date between m.match_start_date::date and m.match_end_date::date)
    into v_sports_arr;
    
    select array(select distinct l.league_id
    				from sibot.sibot_match m
    			 	join sibot.sibot_league l
    			 	on l.league_id = m.league_id
                 	join sibot.sibot_application_league_map alm
                 	on alm.league_id = l.league_id
    			 	where alm.application_id = v_application_id
    			 	and v_current_date between m.match_start_date::date and m.match_start_date::date)
    into v_leagues_arr;
    
    select array(select m.match_id
                 from sibot.sibot_match m
                 join sibot.sibot_application_match_map amm
                 on amm.match_id = m.match_id
                 where amm.application_id = v_application_id
                 and v_current_date between match_start_date::date and match_start_date::date)
    into v_matches_arr;
    
	select ('[{"date":"'||v_current_date||'","sports":['||string_agg((row_to_json(row))::text,',')||']}]')::jsonb
	from(select s.sport_id,s.sport_name,s.sport_payload_text as payload_text,
         		(select array_to_json(array_agg(a))
                 from(select l.league_id,l.league_name,l.league_payload_text payload_text,
                      			(select array_to_json(array_agg(b))
                                 from(select amm.application_id,m.match_id,m.match_name,to_char((m.match_start_date + '5.5 hours'::interval)::timestamp,'DD Mon YYYY, HH12:MI AM') match_time,
                                      			(select array_to_json(array_agg(c))
                                                 from(select c.channel_id,c.channel_name channel
                                                      from sibot.sibot_match_channel_map mcm
                                                      join sibot.sibot_channel c
                                                      on c.channel_id = mcm.channel_id
                                                      where mcm.match_id = m.match_id)c
                                                )channels,
                                      (select array_to_json(array_agg(d))
                                       from(select t.team_id,t.team_name,t.team_payload_text payload_text,1 rownum
                                            from sibot.sibot_team t
                                            where t.team_id = m.team_a_id
                                            union
                                            select t.team_id,t.team_name,t.team_payload_text payload_text,2 rownum
                                            from sibot.sibot_team t
                                            where t.team_id = m.team_b_id)d
                                      )teams
                                      from sibot.sibot_match m
                                      join sibot.sibot_application_match_map amm
                                      on amm.match_id = m.match_id
                                      where m.league_id = l.league_id
                                      and m.match_id in(select match_id from unnest(v_matches_arr) u(match_id)))b
                                )matches
                      from sibot.sibot_league l
                      where l.sport_id = s.sport_id
                      and l.league_id in(select league_id from unnest(v_leagues_arr) u(league_id)))a
                )leagues
         from sibot.sibot_sport s
         where s.sport_id in(select sport_id from unnest(v_sports_arr) u(sport_id))
        )row
	into p_json;
    
end;

$$;


--
