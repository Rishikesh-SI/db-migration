-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_ins_upd_get_team_master(jsonb)
-- Type: FUNCTION

-- Name: sibot_ins_upd_get_team_master(jsonb); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_ins_upd_get_team_master(p_input_json jsonb, OUT p_team_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$

/*--opt_type = "S"-updating active and deactivate status,"U"- update sports,
                "I"-insert sports,"G"- get sports, F- auto-searching functionality.
select * from sibot.sibot_ins_upd_get_team_master(
'{"opt_type":",
  "name":null,
  "meta_data":null,
  "start_date":null,
  "end_date":null,
  "short_name":null,
  "sport_id":null,
  "has_team":null,
  "schedule_image_id":null,
  "application_id":null,
  "team_id":"112",
  "team_a_id":null,
  "team_b_id":null,
  "channel_id":null,
  "league_id":"4",
  "attachment_id":null,
  "status":"0
  "show_in_buddy":null,
   "image_url":null
}' -- > p_input_json jsonb
    
    );
*/
declare
	v_opt_type character(2);
    v_team_id numeric;
	v_league_id numeric;
    v_team_name character varying(50);
    v_short_name character varying(50);
    v_start_date date;
    v_end_date date;
    v_keywords text;
    v_has_teams numeric;
    v_status numeric;
    v_application_id numeric;
    v_schedule_image_id numeric;
    v_image_url character varying(2000);
    /*v_league_id2 numeric;*/
begin
	select p_input_json->>'opt_type', p_input_json->>'team_id',
    p_input_json->>'league_id', 
           p_input_json->>'name', p_input_json->>'meta_data',
           p_input_json->>'application_id',
           p_input_json->>'image_url',p_input_json->>'status'
     into  v_opt_type, v_team_id,v_league_id, v_team_name, v_keywords,v_application_id,
     v_image_url,v_status;
     if v_opt_type = 'G' then
      p_result = 1;
	 elsif v_opt_type = 'I' or v_opt_type = 'U' then
    	  if v_team_id is null and v_league_id is not null 
          then
          if not exists (select 1 from sibot.sibot_team where team_name = v_team_name)
          then
                insert into sibot.sibot_team(team_id,team_name,
                             team_payload_text,meta_data,status,created_date)
                             select nextval('sibot.seq_sibot_team_id'),v_team_name,
                             replace(v_team_name,' ',''),v_keywords,1,now()::date;

                insert into sibot.sibot_application_league_team_map(application_league_team_map_id,application_id,
                            league_id,team_id,team_image_url)
                            select nextval('sibot.seq_sibot_application_league_team_map_id'),
                            v_application_id,v_league_id,
                            currval('sibot.seq_sibot_team_id'),v_image_url;
          end if;
        	p_result := 1;
            
            elsif v_team_id is not null and v_league_id is not null then
                    update sibot.sibot_team 
                    set meta_data = v_keywords,
                        updated_date = (select now()::date)
                    where team_id = v_team_id;
                   
                   update sibot.sibot_application_league_team_map 
                    set team_image_url = v_image_url
                    where team_id = v_team_id;
          
                    if exists (select 1 from sibot.sibot_application_league_team_map 
                               where league_id = v_league_id and team_id = v_team_id )
                               /*based on league we can map with team. if team doesn't map with 
                                 any league then inserting */
                     then
                     p_result := 1;/*team already mapped with league*/
    	             else
                          insert into  sibot.sibot_application_league_team_map (application_league_team_map_id,application_id,
                                                                               league_id,team_id,team_image_url)
                          select nextval('sibot.seq_sibot_application_league_team_map_id'),v_application_id,v_league_id,
                                                                               v_team_id,v_image_url;  
                          p_result := 1;
                      end if;
        	
            else
                p_result := -1;
            end if;
     elsif v_opt_type = 'S' and v_team_id is not null 
     then
         update sibot.sibot_team
         set status = coalesce(v_status,status),
             updated_date = (select now()::date)
         where team_id = v_team_id;
         p_result := 1;
    end if;
          if p_result = 1 
          then
    	      select ('{"teams":['||string_agg(row_to_json(row)::text,',')||']}')::jsonb
		      from (select league.sport_id,league.league_id,team.team_id,team.team_name,team.meta_data,team.status,
                    case when lmap.team_image_url is null
                 then 'Incomplete' else 'Complete' end as save_status
              from sibot.sibot_team team 
              inner join sibot.sibot_application_league_team_map lmap
              on team.team_id = lmap.team_id 
              inner join sibot.sibot_league league 
              on lmap.league_id = league.league_id order by team.created_date 
              )row
		      into p_team_json;      
         else
    	     p_team_json := '{}'::jsonb;
         end if;
exception
	when others then
    	p_result := -1;
        p_team_json := '{}'::jsonb;
end;

$$;


--
