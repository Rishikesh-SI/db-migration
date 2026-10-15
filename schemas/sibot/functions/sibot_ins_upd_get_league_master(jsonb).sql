-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_ins_upd_get_league_master(jsonb)
-- Type: FUNCTION

-- Name: sibot_ins_upd_get_league_master(jsonb); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_ins_upd_get_league_master(p_input_json jsonb, OUT p_league_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$

/*--opt_type = "S"-updating active and deactivate status,"U"- upadate sports,"I"-insert sports,"G"- get sports
select * from sibot.sibot_ins_upd_get_league_master(
'{
  "opt_type": "G",
  "name": null,
  "meta_data": null,
  "start_date": null,
  "end_date": null,
  "short_name": null,
  "sport_id":null,
  "has_team": null,
  "schedule_image_id": null,
  "application_ids": null,
  "team_a_id": null,
  "team_b_id": null,
  "channel_id": null,
  "league_id": null,
  "attachment_id": null,
  "status": "0",
  "show_in_buddy": null,
  "image_url": null
}' -- > p_input_json jsonb
    
    );
*/
declare
	v_opt_type character(2);
    v_sport_id numeric;
	v_league_id numeric;
    v_league_name character varying(50);
    v_short_name character varying(50);
    v_start_date date;
    v_end_date date;
    v_keywords text;
    v_has_teams numeric;
    v_status numeric;
    v_application_id numeric;
    v_schedule_image_id numeric;
    /*v_league_id2 numeric;*/
begin
	select p_input_json->>'opt_type', p_input_json->>'sport_id',p_input_json->>'league_id', 
           p_input_json->>'name', p_input_json->>'start_date',p_input_json->>'end_date', 
           p_input_json->>'short_name',p_input_json->>'meta_data',p_input_json->>'has_team',
           p_input_json->>'status',p_input_json->>'application_id',
           p_input_json->>'schedule_image_id'
     into  v_opt_type, v_sport_id,v_league_id, v_league_name,v_start_date,v_end_date,
           v_short_name,v_keywords,v_has_teams,v_status,v_application_id,
           v_schedule_image_id;
     if v_opt_type = 'G' then
    	p_result = 1;
	elsif v_opt_type = 'I' or v_opt_type = 'U' then
    	  if v_league_id is null then
          if not exists (select 1 from sibot.sibot_league where league_name=v_league_name)
          then
    		 insert into sibot.sibot_league(league_id,league_name,league_short_name,league_start_date,
                         league_end_date,league_payload_text,sport_id,meta_data, has_teams,is_active,created_date)
        	             select nextval('sibot.seq_sibot_league_id'),v_league_name,v_short_name,
                         v_start_date, v_end_date ,replace(v_league_name,' ',''),v_sport_id,
                         v_keywords,v_has_teams,1,now()::date;
           /* SELECT currval('sibot.seq_sibot_league_id')
             into  v_league_id2; */
             insert into sibot.sibot_application_league_map(application_league_map_id,application_id,
                        league_id,show_in_buddy,league_schedule_image_attachment_id)
                        select nextval('sibot.seq_sibot_application_league_map_id'),v_application_id,
                        currval('sibot.seq_sibot_league_id'),0,v_schedule_image_id;
           end if;
        	            p_result := 1;
    	 elsif v_league_id is not null 
      then
    		 update sibot.sibot_league
        	 set meta_data = v_keywords,league_short_name = v_short_name,
               league_start_date = v_start_date, league_end_date =  v_end_date,
               updated_date = (select now()::date)
           where league_id = v_league_id;
             
           if v_schedule_image_id is not null 
           then  
               update sibot.sibot_application_league_map
               set league_schedule_image_attachment_id = v_schedule_image_id
               where league_id = v_league_id;
           end if;
        	 p_result := 1;
    	else
    		 p_result := -1;
   end if;
         elsif v_opt_type = 'S' and v_league_id is not null 
         then
             update sibot.sibot_league
        	   set is_active = coalesce(v_status,is_active),
                 updated_date = (select now()::date)
        	   where league_id = v_league_id;
        	   p_result := 1;
	 else
    	p_result := -1;
  end if;
       if p_result = 1 then
    	   select ('{"leagues":['||string_agg(row_to_json(row)::text,',')||']}')::jsonb
		   from (select league.league_id,league.league_name,league.league_short_name,
                 league.league_start_date,league.league_end_date,league.meta_data,
                 league.has_teams,league.is_active,league.meta_data,league.has_teams,
                 league.is_active,l_map.league_schedule_image_attachment_id as
                 attachment_id,sport.sport_id,sport.sport_name, case when l_map.league_schedule_image_attachment_id is null
                 then 'Incomplete' else 'Complete' end as save_status
           from sibot.sibot_league league inner join sibot.sibot_sport sport
             on league.sport_id = sport.sport_id inner join 
                 sibot.sibot_application_league_map l_map on league.league_id = 
                 l_map.league_id
				 where l_map.application_id=1
				 order by league.created_date 
                )row
		  into p_league_json;
    else
    	p_league_json := '{}'::jsonb;
    end if;
exception
	when others then
    	p_result := -1;
       p_league_json := '{}'::jsonb;
end;

$$;


--
