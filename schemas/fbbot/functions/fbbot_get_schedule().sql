-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fbbot
-- Object: fbbot_get_schedule()
-- Type: FUNCTION

-- Name: fbbot_get_schedule(); Type: FUNCTION; Schema: fbbot; Owner: -
--

CREATE FUNCTION fbbot.fbbot_get_schedule(OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

begin
	
	select ('[{"date":"'||(current_timestamp at time zone 'utc' + '5.5 hours'::interval)::date||'","sports":['||string_agg((row_to_json(row))::text,',')||']}]')::jsonb
	from(select tv_s_s.sport_id,s.sport_name,s.payload_text,
		(select array_to_json(array_agg(a))
		from(select tv_s_l.league_id,l.league_name,l.payload_text,
			(select array_to_json(array_agg(b))
			from(select tv_s_m.match_id,m.match_name,to_char((m.match_start_date + '5.5 hours'::interval),'DD Mon YYYY, HH12:MI AM') match_time,
				(select array_to_json(array_agg(d))
				from(select tv_s_c.channel_id,tv_s_c.channel_name channel
					from fbbot.fbbot_tv_schedule tv_s_c
					where tv_s_c.match_id = tv_s_m.match_id
					group by tv_s_c.channel_id,tv_s_c.channel_name)d
				)channels,
				(select array_to_json(array_agg(c))
				from(select t.team_id,t.team_name,t.payload_text,1 rownum
                     from fbbot.fbbot_tv_schedule tv_s_t
                     join fbbot.fbbot_teams t
                     on t.team_id = tv_s_t.team_a_id
                     where tv_s_t.match_id = tv_s_m.match_id
                     group by t.team_id,t.team_name,t.payload_text
                     union
                     select t.team_id,t.team_name,t.payload_text,2 rownum
                     from fbbot.fbbot_tv_schedule tv_s_t
                     join fbbot.fbbot_teams t
                     on t.team_id = tv_s_t.team_b_id
                     where tv_s_t.match_id = tv_s_m.match_id
                     group by t.team_id,t.team_name,t.payload_text)c
				)teams
				from fbbot.fbbot_tv_schedule tv_s_m
				join fbbot.fbbot_matches m
				on m.match_id = tv_s_m.match_id
				where tv_s_m.league_id = tv_s_l.league_id
                and tv_s_m.schedule_date = (current_timestamp at time zone 'utc' + '5.5 hours'::interval)::date
				group by tv_s_m.match_id,m.match_name,m.match_start_date)b
			)matches
			from fbbot.fbbot_tv_schedule tv_s_l
			join fbbot.fbbot_leagues l
			on l.league_id = tv_s_l.league_id
			where tv_s_l.sport_id = tv_s_s.sport_id
            and tv_s_l.schedule_date = (current_timestamp at time zone 'utc' + '5.5 hours'::interval)::date
			group by tv_s_l.league_id,l.league_name,l.payload_text)a
	  )leagues
	  from fbbot.fbbot_tv_schedule tv_s_s
	  join fbbot.fbbot_sports s
	  on s.sport_id = tv_s_s.sport_id
	  where tv_s_s.schedule_date = (current_timestamp at time zone 'utc' + '5.5 hours'::interval)::date
	  group by tv_s_s.sport_id,s.sport_name,s.payload_text)row
	  into p_json;
	  
end;

$$;


--
