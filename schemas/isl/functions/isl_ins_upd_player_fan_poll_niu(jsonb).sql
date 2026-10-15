-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_ins_upd_player_fan_poll_niu(jsonb)
-- Type: FUNCTION

-- Name: isl_ins_upd_player_fan_poll_niu(jsonb); Type: FUNCTION; Schema: isl; Owner: -
--

CREATE FUNCTION isl.isl_ins_upd_player_fan_poll_niu(p_playerfan_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
	
    v_curren_timestamp timestamp := current_timestamp at time zone 'utc';
	
    v_json jsonb := p_playerfan_json;
    v_playerfan_data_json 		json;
    v_data_json 				json;
	v_player_fan_poll_id  		numeric;
    v_match_id 					character varying(100);
	v_player_id 				character varying(100);
	v_team_id 					character varying(100);
	v_vote 						numeric;
	v_season_id 				character varying(100);
	v_sport_id					character varying(100);  
    v_poll_guid varchar(256);
   
    
begin
	
   
    select  v_json->'data'->>'player_fan_poll_id',
			v_json->'data'->>'match_id',
			v_json->'data'->>'player_id',
			v_json->'data'->>'team_id',
			v_json->'data'->>'vote',
			v_json->'data'->>'season_id',
			v_json->'data'->>'sport_id'
	into 	v_player_fan_poll_id,
			v_match_id,
			v_player_id,
			v_team_id,
			v_vote,
			v_season_id,
			v_sport_id;
	
	if v_player_fan_poll_id is null
	then 
		v_poll_guid = uuid_generate_v4();
		v_player_fan_poll_id = nextval('isl.seq_isl_player_fan_poll_id');
		
	insert into  isl.isl_player_fan_poll
	(player_fan_poll_id, match_id, player_id, team_id, votes, season_id, sport_id, created_date,updated_date,
     created_by, updated_by, is_active, is_deleted, poll_guid)	
	select v_player_fan_poll_id, v_match_id,  v_player_id, v_team_id, v_vote, v_season_id, v_sport_id, v_curren_timestamp, v_curren_timestamp, 1 , 1,
		1 , 0 , v_poll_guid ;
		
	else 
		
		update isl.isl_player_fan_poll 
		set match_id = v_match_id, 
			player_id = v_player_id, 
			team_id = v_team_id, 
			votes = v_vote, 
			season_id = v_season_id, 
			sport_id = v_sport_id, 
			created_date = v_curren_timestamp,
			updated_date = v_curren_timestamp ,
			created_by = 1, 
			updated_by = 1
		where player_fan_poll_id = v_player_fan_poll_id
		and 	is_active = 1 
		and is_deleted = 0; 
	
	end if ;
	
	p_result := 1 ;
	
end;

$$;


--
