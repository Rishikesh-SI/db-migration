-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_get_user_analytics(numeric)
-- Type: FUNCTION

-- Name: sibot_get_user_analytics(numeric); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_get_user_analytics(p_application_id numeric, OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
	v_user_count numeric;
	v_subscribed_user_count numeric;
	v_team_user_count_json jsonb;
    v_team_count_user_count_json jsonb;
	v_league_id numeric;
	v_bat_ball_count_json jsonb;
	
	
	
begin

	
	
	select count(1) into v_user_count from sibot.sibot_user 
	where application_id = p_application_id;
	select count(1) into v_subscribed_user_count
	from sibot.sibot_user u
	where application_id = p_application_id
	and exists(select 1
			   from sibot.sibot_user_league_team_map ultm
			   where ultm.user_id = u.user_id);
   /*select count(1) into v_subscribed_user_count
                   from sibot.sibot_user_league_team_map ultm
				   join sibot.sibot_league l
				   on ultm.league_id=l.league_id
				   join sibot.sibot_user u
				   on u.user_id= ultm.user_id
				   where application_id=p_application_id
				   and l.is_active=1;*/
	select ('['||string_agg(row_to_json(row)::text,',')||']')::jsonb
	from (select t.team_name,count(1) user_count
		  from sibot.sibot_user_league_team_map ultm
		  join sibot.sibot_team t
		  on t.team_id = ultm.team_id
		  join sibot.sibot_user u
		  on u.user_id = ultm.user_id
		  join  sibot.sibot_league alm
		  on ultm.league_id = alm.league_id
		  where u.application_id = p_application_id
		  and alm.is_active=1
		  group by t.team_name
		  order by row_number() over(order by t.team_name)
		 )row
	into v_team_user_count_json;
    select ('['||string_agg(row_to_json(row)::text,',')||']')::jsonb
	from (select team_count,count(user_id) user_count
          from (select ultm.user_id,count(distinct team_id) team_count
                from sibot.sibot_application_league_map alm
                join sibot.sibot_league l
                on l.league_id = alm.league_id
                join sibot.sibot_user_league_team_map ultm
				on ultm.league_id = l.league_id
                where alm.application_id = p_application_id
				and l.is_active=1
                group by ultm.user_id
               )a
          group by team_count
          order by row_number() over(order by team_count)
         )row
	into v_team_count_user_count_json;
	
	

	select ('['||string_agg(row_to_json(row)::text,',')||']')::jsonb
	from (select league_name,count(1) as ball_count ,(select count(1)  from sibot.sibot_league l 
													  join sibot.sibot_user_league_bat_bowl_mode ulbbm
	                                                  on l.league_id=ulbbm.league_id 
													  where opt_type='Bat' 
													  and application_id=p_application_id
													  group by league_name
													 ) as bat_count,
		                                            (select count(1) from sibot.sibot_league l 
			                                         join sibot.sibot_user_league_bat_bowl_mode ulbbm
			                                         on l.league_id=ulbbm.league_id 
													 where application_id=p_application_id
													 group by league_name
													) as overall_bat_ball_count
    from sibot.sibot_league l 
	join sibot.sibot_user_league_bat_bowl_mode ulbbm
	on l.league_id=ulbbm.league_id where opt_type='Ball'
	and application_id=p_application_id
	group by league_name
		  ) row
		 
    into v_bat_ball_count_json;
	
	


    
	select row_to_json(row)::jsonb
	from (select v_user_count user_count,v_subscribed_user_count subscribed_user_count,v_team_user_count_json team_user_count,v_team_count_user_count_json team_count_user_count_json,		 
		  v_bat_ball_count_json
		 )row
	into p_json;
end;

$$;


--
