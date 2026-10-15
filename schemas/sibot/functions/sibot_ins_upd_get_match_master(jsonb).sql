-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_ins_upd_get_match_master(jsonb)
-- Type: FUNCTION

-- Name: sibot_ins_upd_get_match_master(jsonb); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_ins_upd_get_match_master(p_input_json jsonb, OUT p_match_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$

/*--opt_type = "S"-updating active and deactivate status,"U"- upadate sports,
                "I"-insert sports,"G"- get sports, "F" - auto-searching functionality.
select * from sibot.sibot_ins_upd_get_match_master(
'{
  "team_id": null,
  "opt_type": "I",
  "name": "Sport-Club Freiburg",
  "meta_data": null,
  "start_date": "2018,
  "end_date": null,
  "short_name": null,
  "sport_id": "1",
  "has_team": null,
  "schedule_image_id": null,
  "application_ids": null,
  "team_a_id": null,
  "team_b_id": null,
  "channel_id": "1,2,3",
  "match_id":"4",
  "league_id": "4",
  "status": "0",
  "show_in_buddy": null,
  "image_url": null
}' -- > p_input_json jsonb
);
*/
declare
	v_opt_type character(2);
    v_team_a_id numeric;
    v_team_b_id numeric;
	v_league_id numeric;
    v_match_name character varying(50);
    v_short_name character varying(50);
    v_start_date timestamp ;
    v_end_date timestamp;
    v_keywords text;
    v_status numeric;
    v_application_id numeric;
    v_schedule_image_id numeric;
    v_image_url text;
    v_channel_id text;
    v_match_id numeric;
    p_channel_id numeric;
    v_item text;
    v_alert_image_url text;
    tmp_match_json jsonb;
	v_category_id numeric;
    /*v_league_id2 numeric;*/
begin
	select p_input_json->>'opt_type', p_input_json->>'match_id',p_input_json->>'league_id', 
           p_input_json->>'start_date',p_input_json->>'end_date',p_input_json->>'name',
           p_input_json->>'application_id',p_input_json->>'image_url',p_input_json->>'status',
           p_input_json->>'team_a_id',p_input_json->>'team_b_id', p_input_json->>'channel_id',
           p_input_json->>'status',p_input_json->>'match_alert_image_url',p_input_json->>'category_id'                                        
     into  v_opt_type, v_match_id, v_league_id, v_start_date, v_end_date,
           v_match_name,v_application_id,v_image_url,v_status, v_team_a_id,
            v_team_b_id,v_channel_id,v_status,v_alert_image_url,v_category_id;
            
            v_start_date:=v_start_date - '5.5 hours'::interval;
            v_end_date := v_end_date - '5.5 hours'::interval;
     if v_opt_type = 'G' 
     then
         p_result = 1;
   
	 elsif v_opt_type = 'I' or v_opt_type = 'U' 
     then
    	 if v_match_id is null and v_league_id is not null 
         then
        -- if not exists(select 1 from sibot.sibot_match where match_name=v_match_name)
         -- then
    		 insert into sibot.sibot_match(match_id,match_name,match_start_date,
                         match_end_date,team_a_id,team_b_id,league_id,status,created_date,match_type_id)
        	 select nextval('sibot.seq_sibot_match_id'),v_match_name,v_start_date,
                             v_end_date,v_team_a_id,v_team_b_id,v_league_id,1,now()+'5:30',v_category_id;
          /*select * from sibot.sibot_application_match_map*/
             insert into sibot.sibot_application_match_map(application_match_map_id,
                         application_id,match_id,match_alert_image_url,match_alert_status,
                                                           match_schedule_image_url)
             select nextval('sibot.seq_sibot_application_match_map_id'),v_application_id,
                    currval('sibot.seq_sibot_match_id'),v_alert_image_url,0,v_image_url;
                    
                    
                
            FOR v_item IN (select channel_id from unnest( string_to_array(v_channel_id,',' )::numeric[]) U(channel_id))
            loop
              
             insert into sibot.sibot_match_channel_map(match_channel_map_id,match_id,channel_id)
             select nextval('sibot.seq_sibot_match_channel_map_id'),currval('sibot.seq_sibot_match_id'),
                    v_item::numeric; 
                   
            end loop;
            --end if;
        	 p_result := 1;
            
         elsif v_match_id is not null and v_league_id is not null 
         then
    		 update sibot.sibot_match
        	 set match_start_date = v_start_date,match_end_date = v_end_date, 
                 team_a_id = v_team_a_id,team_b_id = v_team_b_id,match_name = v_match_name,
                 updated_date = (select now()+'5:30')
        	 where match_id = v_match_id;
             
             update sibot.sibot_application_match_map
        	 set match_schedule_image_url = v_image_url,
               match_alert_image_url = v_alert_image_url
             where match_id = v_match_id;
             
            
             
             delete from sibot.sibot_match_channel_map where match_id = v_match_id;
             FOR v_item IN (select channel_id from unnest( string_to_array(v_channel_id,',' )::numeric[]) U(channel_id))
             loop
              
             insert into sibot.sibot_match_channel_map(match_channel_map_id,match_id,channel_id)
             select nextval('sibot.seq_sibot_match_channel_map_id'),v_match_id,
                    v_item::numeric; 
                   
             end loop;
             p_result := 1;
         else
    		 p_result := -1;
    	end if;
	 elsif v_opt_type = 'S' and v_match_id is not null 
     then
         update sibot.sibot_match
         set status = coalesce(v_status,status),
             updated_date = (select now()+'5:30')
         where match_id = v_match_id;
         
         p_result := 1;
	 else
    	p_result := -1;
     end if;
           if p_result = 1 
           then
    	       select ('{"matches":['||string_agg(row_to_json(row)::text,',')||']}')::jsonb
		       from   ( select  tmp.match_id,tmp.match_name,tmp.status,tmp.team_a_id,tmp.team_b_id,
                               tmp.match_start_date + '5.5 hours'::interval as start_date,
                         tmp.match_end_date + '5.5 hours'::interval as end_date,tmp.match_type_id as category_id,tmp.sport_id as sport_id,tmp.league_id as league_id,
                               -- (select array_to_json(array_agg(a)) from
                                (select distinct team.team_name from sibot.sibot_match mat 
                                                               inner join sibot.sibot_team team 
                                                               on mat.team_a_id= team.team_id 
                                                               where mat.league_id = v_league_id and team.team_id=tmp.team_a_id) -- a)
                                                               team_a_name,
                               -- (select array_to_json(array_agg(b)) from
                               (select distinct team.team_name from sibot.sibot_match mat 
                                                               inner join sibot.sibot_team team 
                                                               on mat.team_b_id= team.team_id 
                                                               where mat.league_id = v_league_id and team.team_id=tmp.team_b_id) -- b)
                                                               team_b_name,
                                -- (select array_to_json(array_agg(c)) from
                               (select string_agg(cmap.channel_id::text, ',')  from sibot.sibot_match_channel_map cmap
                                                               inner join sibot.sibot_channel channel 
                                                               on cmap.channel_id= channel.channel_id 
                                                               where cmap.match_id = tmp.match_id) -- c) 
                                                               channel_id
                            
                      from   (select  t.match_id,t.match_name,t.status,t.team_a_id,t.team_b_id,t.match_start_date ,
                                      t.match_end_date,t.match_type_id,t.sport_id,t.league_id
                               from   ( select mat.match_id,mat.match_name,mat.status,mat.team_a_id,mat.team_b_id,
                                               mat.match_start_date,mat.match_end_date,mat.match_type_id,league.sport_id,league.league_id 
                                        from sibot.sibot_league league inner join sibot.sibot_match mat
                                        on league.league_id = mat.league_id order by mat.created_date ) t 
                              where t.league_id = v_league_id) as tmp
               )row
		       into p_match_json;
               
               /*select replace(tmp_match_json::text,'T',' ')
               into p_match_json;*/
           else
    	       p_match_json := '{}'::jsonb;
           end if;
/*exception
	when others then
    	p_result := -1;
       p_match_json := '{}'::jsonb;*/
end;

$$;


--
