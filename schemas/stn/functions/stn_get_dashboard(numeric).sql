-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_get_dashboard(numeric)
-- Type: FUNCTION

-- Name: stn_get_dashboard(numeric); Type: FUNCTION; Schema: stn; Owner: -
--

CREATE FUNCTION stn.stn_get_dashboard(p_kid_id numeric, OUT p_dashboard_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
	v_game_day_number numeric := 0;
	v_kid_full_name text;
	v_team_id numeric;
	v_team_name text;
	v_region text;
	v_age_category text;
	v_team_previous_rank numeric;
	v_team_current_rank numeric;
	v_team_rank_change_indicator numeric;
	v_dimension_detail_id numeric;
	v_dimension_id numeric;
	v_dimension_name text;
	v_day_number numeric;
	v_dimension_points numeric;
	v_kid_points numeric;
	v_kid_previous_zone_rank numeric;
	v_kid_previous_age_rank numeric;
	v_next_dimension_points numeric;
	v_next_dimension_name text;
	v_kid_current_zone_rank numeric;
	v_kid_current_age_rank numeric;
	v_kid_zone_rank_change_indicator numeric;
	v_kid_age_rank_change_indicator numeric;
	v_points_needed_for_next_dimension numeric;
	v_partner_kid_id numeric;
	v_partner_name text;
	v_partner_kid_dimension_detail_id numeric;
	v_partner_kid_points numeric;
	v_partner_kid_dimension_name text;
	v_partner_kid_day_number numeric;
	v_team_points numeric;
	v_kid_badges text;
	v_json text;
	v_error_json text;
	
begin
	
	v_error_json := '{
						"data": {
									"game_day_number": null,
									"kid_name": null,
									"team_name": null,
									"day_number": null,
									"dimension_name": null,
									"partner_name": null,
									"partner_day_number": null,
									"partner_dimension_name": null,
									"kid_points": null,
									"team_points": null,
									"next_dimension": null,
									"points_needed_for_next_dimension": null,
									"badges": null,
									"leader_board": {
														"team": {
																	"rank": null,
																	"name": null,
																	"points": null,
																	"change_indicator": null
																},
														"individual": {
																			"name": null,
																			"points": null,
																			"dimension": null,
																			"zone": {
																						"rank": null,
																						"category": null,
																						"change_indicator": null
																					},
																			"age": {
																						"rank": null,
																						"category": null,
																						"change_indicator": null
																					}
																		}
													}
								}
					}';
	
	select day_number
	into v_game_day_number
	from stn.stn_dimension_detail dd
	where dd.dimension_detail_id = (select max(dimension_detail_id) from stn.stn_dimension_detail where is_day_locked = 0);
	
	select ui.first_name||' '||ui.last_name kid_full_name, tum.team_id, ti.team_name, ui.region, ui.age_category
	into strict v_kid_full_name, v_team_id, v_team_name, v_region, v_age_category
	from stn.stn_user_info ui
	join stn.stn_team_user_map tum
	on tum.user_id = ui.user_id
	join stn.stn_team_info ti
	on ti.team_id = tum.team_id
	where ui.user_id = p_kid_id
	and ui.is_kid = 1;
	
	if exists(select 1 from stn.stn_team_leaderboard where team_id = v_team_id) then
		
		select leaderboard_json->'data'->'team'->>'rank'
		into v_team_previous_rank
		from stn.stn_team_leaderboard
		where team_id = v_team_id;
		
	else
		
		v_team_previous_rank := 0;
		
	end if;
	
	select team_rank
	into v_team_current_rank
	from (select team_id, team_points, rank() over(order by team_points desc) team_rank
			from (select tum.team_id, sum(kj.points) team_points
					from stn.stn_kid_journey kj
					join stn.stn_team_user_map tum
					on tum.user_id = kj.kid_id
					group by tum.team_id
				)a
		)b
	where team_id = v_team_id;
	
	v_team_current_rank := coalesce(v_team_current_rank, 0);
	
	if v_team_current_rank > v_team_previous_rank then
		v_team_rank_change_indicator := 1;
	elsif v_team_current_rank < v_team_previous_rank then
		v_team_rank_change_indicator := -1;
	else
		v_team_rank_change_indicator := 0;
	end if;
	
	if exists(select 1 from stn.stn_kid_journey where kid_id = p_kid_id) then
		
		select kj.dimension_detail_id, dd.dimension_id, d.dimension_name, dd.day_number, d.points, sum(kj.points)
		into v_dimension_detail_id, v_dimension_id, v_dimension_name, v_day_number, v_dimension_points, v_kid_points
		from stn.stn_kid_journey kj
		join stn.stn_dimension_detail dd
		on dd.dimension_detail_id = kj.dimension_detail_id
		join stn.stn_dimension d
		on d.dimension_id = dd.dimension_id
		where kj.kid_id = p_kid_id
		and kj.dimension_detail_id = (select max(kj1.v_dimension_detail_id) from stn.stn_kid_journey kj1 where kj1.kid_id = kj.kid_id)
		group by kj.dimension_detail_id, dd.dimension_id, d.dimension_name, dd.day_number, d.points;
		
		if exists(select 1 from stn.stn_kid_leaderboard where kid_id = p_kid_id) then
			
			select leaderboard_json->'data'->'individual'->'zone'->>'rank', leaderboard_json->'data'->'individual'->'age'->>'rank'
			into v_kid_previous_zone_rank, v_kid_previous_age_rank
			from stn.stn_kid_leaderboard
			where kid_id = p_kid_id;
			
		else
			
			v_kid_previous_zone_rank := 0;
			v_kid_previous_age_rank := 0;
			
		end if;
		
		select kid_rank
		into v_kid_current_zone_rank
		from (select kid_id, kid_points, rank() over(order by kid_points desc) kid_rank
				from (select ui.user_id kid_id, sum(kj.points) kid_points
						from stn.stn_kid_journey kj
						join stn.stn_user_info ui
						on ui.user_id = kj.kid_id
						and ui.region = v_region
						group by ui.user_id
					)a
			)b
		where kid_id = p_kid_id;
		
		v_kid_current_zone_rank := coalesce(v_kid_current_zone_rank, 0);
		
		if v_kid_current_zone_rank > v_kid_previous_zone_rank then
			v_kid_zone_rank_change_indicator := 1;
		elsif v_kid_current_zone_rank < v_kid_previous_zone_rank then
			v_kid_zone_rank_change_indicator := -1;
		else
			v_kid_zone_rank_change_indicator := 0;
		end if;
		
		select kid_rank
		into v_kid_current_age_rank
		from (select kid_id, kid_points, rank() over(order by kid_points desc) kid_rank
				from (select ui.user_id kid_id, sum(kj.points) kid_points
						from stn.stn_kid_journey kj
						join stn.stn_user_info ui
						on ui.user_id = kj.kid_id
						and ui.age_category = v_age_category
						group by ui.user_id
					)a
			)b
		where kid_id = p_kid_id;
		
		v_kid_current_age_rank := coalesce(v_kid_current_age_rank, 0);
		
		if v_kid_current_age_rank > v_kid_previous_age_rank then
			v_kid_age_rank_change_indicator := 1;
		elsif v_kid_current_age_rank < v_kid_previous_age_rank then
			v_kid_age_rank_change_indicator := -1;
		else
			v_kid_age_rank_change_indicator := 0;
		end if;
		
	else
		
		select dd.dimension_detail_id, dd.dimension_id, d.dimension_name, dd.day_number, d.points, 0
		into v_dimension_detail_id, v_dimension_id, v_dimension_name, v_day_number, v_dimension_points, v_kid_points
		from stn.stn_dimension d
		join stn.stn_dimension_detail dd
		on dd.dimension_id = d.dimension_id
		where dd.dimension_detail_id = 1;
		
		v_kid_previous_zone_rank := 0;
		v_kid_previous_age_rank := 0;
		
	end if;
	
	if exists(select 1 from stn.stn_dimension where dimension_id = (v_dimension_id + 1)) then
		
		select points, dimension_name
		into v_next_dimension_points, v_next_dimension_name
		from stn.stn_dimension
		where dimension_id = (v_dimension_id + 1);
		
		v_points_needed_for_next_dimension := greatest((v_next_dimension_points - v_kid_points),0);
	
	else
		
		v_points_needed_for_next_dimension := 0;
		v_next_dimension_name := null;
		
	end if;
	
	select tum.user_id, ui.first_name||' '||ui.last_name partner_full_name
	into strict v_partner_kid_id, v_partner_name
	from stn.stn_team_user_map tum
	join stn.stn_user_info ui
	on ui.user_id = tum.user_id
	where tum.team_id = v_team_id
	and tum.user_id <> p_kid_id
	and ui.is_kid = 1;
	
	if exists(select 1 from stn.stn_kid_journey where kid_id = v_partner_kid_id) then
		
		select kj.dimension_detail_id, d.dimension_name, dd.day_number, d.points, sum(kj.points)
		into v_partner_kid_dimension_detail_id, v_partner_kid_dimension_name, v_partner_kid_day_number, v_dimension_points, v_partner_kid_points
		from stn.stn_kid_journey kj
		join stn.stn_dimension_detail dd
		on dd.dimension_detail_id = kj.dimension_detail_id
		join stn.stn_dimension d
		on d.dimension_id = dd.dimension_id
		where kj.kid_id = v_partner_kid_id
		and kj.dimension_detail_id = (select max(kj1.v_dimension_detail_id) from stn.stn_kid_journey kj1 where kj1.kid_id = kj.kid_id)
		group by kj.dimension_detail_id, d.dimension_name, dd.day_number, d.points;
		
	else
		
		select dd.dimension_detail_id, d.dimension_name, dd.day_number, d.points, 0
		into v_partner_kid_dimension_detail_id, v_partner_kid_dimension_name, v_partner_kid_day_number, v_dimension_points, v_partner_kid_points
		from stn.stn_dimension d
		join stn.stn_dimension_detail dd
		on dd.dimension_id = d.dimension_id
		where dd.dimension_detail_id = 1;
		
	end if;
	
	v_team_points := v_kid_points + v_partner_kid_points;
	
	select string_agg(bt.badge_name,',')
	into v_kid_badges
	from stn.stn_kid_badges kb
	join stn.stn_badge_type bt
	on bt.badge_type_id = kb.badge_id
	where bt.badge_level = 'I'
	and kb.kid_id = p_kid_id;
	
	v_json := '{
				"data": {
						"game_day_number": '||coalesce(v_game_day_number,0)||',
						"kid_name": "'||coalesce(v_kid_full_name,'')||'",
    					"team_name": "'||coalesce(v_team_name,'')||'",
    					"day_number": '||coalesce(v_day_number,0)||',
    					"dimension_name": "'||coalesce(v_dimension_name,'')||'",
						"partner_name": "'||coalesce(v_partner_name,'')||'",
						"partner_day_number": '||coalesce(v_partner_kid_day_number,0)||',
    					"partner_dimension_name": "'||coalesce(v_partner_kid_dimension_name,'')||'",
    					"kid_points": '||coalesce(v_kid_points,0)||',
    					"team_points": '||coalesce(v_team_points,0)||',
						"next_dimension": "'||coalesce(v_next_dimension_name,'')||'",
    					"points_needed_for_next_dimension": '||coalesce(v_points_needed_for_next_dimension,0)||',
						"badges": "'||coalesce(v_kid_badges,'')||'",
						"leader_board": {
										"team": {
												"rank": '||coalesce(v_team_current_rank,0)||',
												"name": "'||coalesce(v_team_name,'')||'",
												"points": '||coalesce(v_team_points,0)||',
												"change_indicator": '||coalesce(v_team_rank_change_indicator,0)||'
												},
										"individual": {
														"name": "'||coalesce(v_kid_full_name,'')||'",
														"points": '||coalesce(v_kid_points,0)||',
														"dimension": "'||coalesce(v_dimension_name,'')||'",
														"zone": {
																"rank": '||coalesce(v_kid_current_zone_rank,0)||',
																"category": "'||coalesce(v_region,'')||'",
																"change_indicator": '||coalesce(v_kid_zone_rank_change_indicator,0)||'
																},
														"age": {
																"rank": '||coalesce(v_kid_current_age_rank,0)||',
																"category": "'||coalesce(v_age_category,'')||'",
																"change_indicator": '||coalesce(v_kid_age_rank_change_indicator,0)||'
																}
														}
										}
  						}
				}';
	
	p_dashboard_json := v_json::jsonb;
	
	p_result := 1;
	
exception
	when no_data_found then
		
		p_result := 0;
		p_dashboard_json := v_error_json::jsonb;
		
	when others then
		
		p_result := -1;
		p_dashboard_json := v_error_json::jsonb;
		
end;

$$;


--
