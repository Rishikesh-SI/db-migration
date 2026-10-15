-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_ins_team(numeric, text)
-- Type: FUNCTION

-- Name: stn_ins_team(numeric, text); Type: FUNCTION; Schema: stn; Owner: -
--

CREATE FUNCTION stn.stn_ins_team(p_user_id numeric, p_team_name text, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
	
    v_current_timestamp timestamp without time zone := current_timestamp at time zone 'utc';
    v_team_name text := upper(trim(p_team_name));
	v_team_id numeric;
	v_team_user_map_id numeric;
    
begin
	
    if exists(select 1 from stn.stn_user_info where user_id = p_user_id) then
    	
        if not exists(select 1 from stn.stn_team_info where upper(trim(team_name)) = v_team_name) then
        	
			v_team_id := nextval('stn.seq_stn_team_id');
			v_team_user_map_id := nextval('stn.seq_stn_team_user_map_id');
			
            insert into stn.stn_team_info(team_id,team_name,user_id,created_date,updated_date,is_active,is_deleted,team_guid)
            select v_team_id,p_team_name,p_user_id,v_current_timestamp,v_current_timestamp,1,0,uuid_generate_v4();
            
			insert into stn.stn_team_user_map(team_user_map_id,team_id,user_id,player_no,created_date,updated_date,is_active,is_deleted,
														tum_guid)
			select v_team_user_map_id,v_team_id,p_user_id,0,v_current_timestamp,v_current_timestamp,1,0,uuid_generate_v4();
			
            p_result := 1;
            
        else
        	
            p_result := 0;
            
        end if;
        
    else
    	
        p_result := -1;
        
    end if;
    
end;

$$;


--
