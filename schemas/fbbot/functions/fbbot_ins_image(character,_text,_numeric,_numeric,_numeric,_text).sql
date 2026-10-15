-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fbbot
-- Object: fbbot_ins_image(character, text, numeric, numeric, numeric, text)
-- Type: FUNCTION

-- Name: fbbot_ins_image(character, text, numeric, numeric, numeric, text); Type: FUNCTION; Schema: fbbot; Owner: -
--

CREATE FUNCTION fbbot.fbbot_ins_image(p_opt_type character, p_date text, p_sport_id numeric, p_league_id numeric, p_match_id numeric, p_image_url text, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

begin
	
	if p_opt_type = 'T' then
		
		if not exists(select 1 from fbbot.fbbot_league_schedule
                      where schedule_date = p_date::date
                      and sport_id = p_sport_id
                      and league_id = p_league_id
                      and match_id = p_match_id) then
			
			insert into fbbot.fbbot_league_schedule
			select p_date::date,p_sport_id,p_league_id,p_match_id,p_image_url,current_timestamp at time zone 'utc';
			
			p_result := 1;
			
		else
			
            update fbbot.fbbot_league_schedule
            set schedule_image_url = p_image_url
            where schedule_date = p_date::date
            and sport_id = p_sport_id
            and league_id = p_league_id
            and match_id = p_match_id;
            
			p_result := 1;
			
		end if;
		
	elsif p_opt_type = 'N' then
    	
        if exists(select 1 from fbbot.fbbot_matches
					where match_start_date::date = p_date::date
					and league_id = p_league_id
					and match_id = p_match_id) then
			
			update fbbot.fbbot_matches
            set alert_image_url = p_image_url
            where match_id = p_match_id;
			
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
