-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_get_user_team(text, numeric, numeric)
-- Type: FUNCTION

-- Name: isl_get_user_team(text, numeric, numeric); Type: FUNCTION; Schema: isl; Owner: -
--

CREATE FUNCTION isl.isl_get_user_team(p_user_id text, p_season_id numeric, p_week_id numeric, OUT p_user_team_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
    v_week_id numeric := p_week_id;
	v_user_id numeric;
    v_last_week_id numeric;
    v_active_week_id numeric;
    v_active_week_name text;
    v_current_timestamp timestamp := current_timestamp at time zone 'utc';
    v_week_list jsonb := '[]'::jsonb;
    v_week_start_date timestamp;
    v_week_end_date timestamp;
    v_entity_role_map_id numeric;
	
	v_season_id varchar(20);
	
begin
	
	v_season_id := p_season_id::varchar ;
	
	select user_id into strict v_user_id from isl.isl_web_user where user_guid = p_user_id;
    
    select entity_role_map_id into v_entity_role_map_id
    from isl.isl_entity_role_map r  where r.source_object_id = v_season_id ; 
	
    if v_week_id is null then
    	if exists(select 1 from isl.isl_user_team where user_id = v_user_id and season_id = v_season_id) then
        	/*select week_id into v_last_week_id
            from isl.isl_season_weeks
            where week_id in(select max(week_id) from isl.isl_user_team
                             where user_id = v_user_id and season_id = v_season_id)
			and season_id = v_season_id;*/
            v_week_id := 15;
        end if;
    end if;
    
   
    if exists(select 1 from isl.isl_user_team where user_id = v_user_id and season_id = v_season_id) then
    
    	select ('['||string_agg(row_to_json(row)::text,',')||']')::jsonb
        from (select distinct sw.week_id, week_name, week_start_date, week_end_date, is_active
              from isl.isl_user_team ut
              join isl.isl_season_weeks sw
              on sw.season_id = ut.season_id
              and sw.week_id = ut.week_id
              where ut.season_id = v_season_id
             -- added by purushottam
              and ut.user_id = v_user_id
             )row
		into v_week_list;
        
        if v_week_list is null then
        	v_week_list := '[]'::jsonb;
        end if;
    end if;  
    
    select week_id, week_name, week_start_date, week_end_date
    into v_active_week_id,v_active_week_name, v_week_start_date, v_week_end_date
    from isl.isl_season_weeks
    where v_current_timestamp between week_start_date and week_end_date
    and week_id= coalesce(v_week_id,15);
    
    select team_json into p_user_team_json 
    from isl.isl_user_team
    where user_id = v_user_id and season_id = v_season_id and week_id = coalesce(v_week_id,15);
    
    if p_user_team_json is null then
    	-- p_user_team_json := '{}'::jsonb;
        p_user_team_json := '{
                              "total_players": 0,
                              "latest_week": null, '
                              -- "active_week": null,
                             -- "week_start_date" : null, 
                             --  "week_end_date" : null,
                             || ' "season_source_id":  '||v_season_id ||',
                              "season_role_id": '||v_entity_role_map_id::varchar ||',
                              "newly_added_players": [],
                              "userid": "'|| p_user_id ||'",
                              "weekid": "'|| coalesce(v_week_id::varchar,'15') ||'",
                              "teams": {},
                              "week_list": []
                            }';
    end if;
    
    p_user_team_json := jsonb_set(p_user_team_json,'{latest_week}',coalesce(v_last_week_id,0)::text::jsonb,true);
    p_user_team_json := jsonb_set(p_user_team_json,'{active_week}',coalesce(v_active_week_id,0)::text::jsonb,true);
    p_user_team_json := jsonb_set(p_user_team_json,'{active_week_name}',('"'||coalesce(v_active_week_name,'')||'"')::jsonb,true);
    p_user_team_json := jsonb_set(p_user_team_json,'{week_start_date}',('"'||coalesce(v_week_start_date::varchar,'')||'"')::jsonb,true);
    p_user_team_json := jsonb_set(p_user_team_json,'{week_end_date}',('"'||coalesce(v_week_end_date::varchar,'')||'"')::jsonb,true);
    p_user_team_json := jsonb_set(p_user_team_json,'{season_role_id}',p_season_id::text::jsonb,true);
    p_user_team_json := jsonb_set(p_user_team_json,'{week_list}',v_week_list,true);
	
    p_result := 1;
    
/*exception
	when others then
		p_result := -1;
        p_user_team_json := null;
*/	
end;

$$;


--
