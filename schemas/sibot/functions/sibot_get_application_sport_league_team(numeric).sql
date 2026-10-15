-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_get_application_sport_league_team(numeric)
-- Type: FUNCTION

-- Name: sibot_get_application_sport_league_team(numeric); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_get_application_sport_league_team(p_application_id numeric, OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

begin
	
    select ('{"sports":['||string_agg((row_to_json(row))::text,',')||']}')::jsonb
	from (select s.sport_id,s.sport_name,
          			(select array_to_json(array_agg(a))
                     from (select l1.league_id,l1.league_name,l1.sport_id,
                           			(select array_to_json(array_agg(b))
                                     from (select t.team_id,t.team_name,l1.league_id
                                           from sibot.sibot_application_league_team_map altm
                                           join sibot.sibot_team t
                                           on t.team_id = altm.team_id
                                           where altm.application_id = p_application_id
                                           and altm.league_id = l1.league_id)b
                                    )teams
                           from sibot.sibot_league l1
                           where l1.sport_id = s.sport_id
						  and is_active=1)a
                    )leagues
          from sibot.sibot_application_league_map alm
          join sibot.sibot_league l
          on l.league_id = alm.league_id
          join sibot.sibot_sport s
          on s.sport_id = l.sport_id
          where alm.application_id = p_application_id
          group by s.sport_id,s.sport_name
          order by s.sport_id
         )row
	into p_json;
    
end;

$$;


--
