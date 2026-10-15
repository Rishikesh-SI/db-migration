-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: u17wc_ins_upd_player_fan_poll(jsonb)
-- Type: FUNCTION

-- Name: u17wc_ins_upd_player_fan_poll(jsonb); Type: FUNCTION; Schema: u17wc; Owner: -
--

CREATE FUNCTION u17wc.u17wc_ins_upd_player_fan_poll(p_playerfan_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
	
    v_currenttimestamp timestamp := current_timestamp at time zone 'utc';
    
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
    v_userguid character varying(256);
    v_userid numeric;
   	v_uservotecount numeric;
    
begin
	
    select  v_json->'data'->>'player_fan_poll_id',
			v_json->'data'->>'match_id',
			v_json->'data'->>'player_id',
			v_json->'data'->>'team_id',
			v_json->'data'->>'vote',
			v_json->'data'->>'season_id',
			v_json->'data'->>'sport_id',
            v_json->'data'->>'user_guid'
	into 	v_player_fan_poll_id,
			v_match_id,
			v_player_id,
			v_team_id,
			v_vote,
			v_season_id,
			v_sport_id,
            v_userguid;
	
    select user_id
    into strict v_userid
    from u17wc.u17wc_web_user
    where user_guid = v_userguid;
    
    select count(1)
    into v_uservotecount
    from u17wc.u17wc_user_poll_response
    where poll_id = v_match_id::numeric
    and user_id = v_userid;
    
    if v_uservotecount < 3 then
    	
    	if v_player_fan_poll_id is null then
        	
			v_poll_guid = uuid_generate_v4();
			v_player_fan_poll_id = nextval('u17wc.seq_u17wc_player_fan_poll_id');
			
            insert into  u17wc.u17wc_player_fan_poll(player_fan_poll_id,match_id,player_id,team_id,votes,season_id,sport_id,created_date,updated_date,
                                                 created_by,updated_by,is_active,is_deleted,poll_guid)
			select v_player_fan_poll_id,v_match_id,v_player_id,v_team_id,v_vote,v_season_id,v_sport_id,v_currenttimestamp,v_currenttimestamp,1,1,1,0,
            		v_poll_guid;
			
            insert into u17wc.u17wc_user_poll_response(user_poll_response_id,poll_id,response_option_id,user_id,response_date)
            values(nextval('u17wc.seq_u17wc_user_poll_response_id'),v_match_id::numeric,v_player_id::numeric,v_userid,v_currenttimestamp);
			
            p_result := 1;
			
		else
        	
            p_result := 0;
            
		end if;
	
    else
        
        p_result := 0;
        
	end if;
    
	/*else 
		
		update u17wc.u17wc_player_fan_poll 
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
	
	end if ;*/
    
exception
	when others then
    	p_result := -1;
end;

$$;


--
