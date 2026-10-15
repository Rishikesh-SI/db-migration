-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_get_broadcast_targets(text, numeric, numeric, text, numeric)
-- Type: FUNCTION

-- Name: sibot_get_broadcast_targets(text, numeric, numeric, text, numeric); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_get_broadcast_targets(p_opt_type text, p_application_id numeric, p_league_id numeric, p_team_id text, p_match_id numeric, OUT p_count numeric, OUT p_data text[]) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
    v_current_timestamp timestamp := current_timestamp at time zone 'utc';
    v_team_arr numeric[];
    v_team_count numeric;
    v_target character(1);
    v_match_id numeric;
    
begin
	
    if p_opt_type = 'MA' then
    	
        select array(select list_key
                     from sibot.sibot_list
                     where application_id =1
                     and list_type = 'M'
                     and match_id = p_match_id)
        into p_data;
        
	elsif p_opt_type = 'MU' then
    	
        select string_to_array(p_team_id,',')::numeric[] into v_team_arr;
        select array_length(v_team_arr,1) into v_team_count;
        if v_team_count = 1 then
        	select array(select list_key
                             from sibot.sibot_list
                             where application_id = p_application_id
                             and league_id = p_league_id
                             and list_type = 'T' and status=1
                             and team_id = p_team_id::numeric)
                               
            into p_data;
            
        elsif v_team_count = 2 then
                select array(select list_key
                             from sibot.sibot_list
                             where application_id = p_application_id
                             and league_id = p_league_id
                             and list_type = 'M' and status=1
                             and (team_a_id in(select unnest(v_team_arr))
                               or team_b_id in(select unnest(v_team_arr))))
                 into p_data;
                             
          else
               select array(select distinct u.receiver_id
                         from sibot.sibot_list l
                         join sibot.sibot_list_user_map lum
                         on lum.list_id = l.list_id
                         join sibot.sibot_user u
                         on u.user_id = lum.user_id
                         where l.application_id = p_application_id
                         and l.league_id = p_league_id
                         and (l.team_a_id in(select unnest(v_team_arr))
                               or l.team_b_id in(select unnest(v_team_arr))))
            into p_data;
        end if;
        
    end if;
    
    select coalesce(array_length(p_data,1),0) into p_count;
    
end;

$$;


--
