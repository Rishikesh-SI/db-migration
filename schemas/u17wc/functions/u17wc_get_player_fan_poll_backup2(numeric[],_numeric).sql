-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: u17wc_get_player_fan_poll_backup2(numeric[], numeric)
-- Type: FUNCTION

-- Name: u17wc_get_player_fan_poll_backup2(numeric[], numeric); Type: FUNCTION; Schema: u17wc; Owner: -
--

CREATE FUNCTION u17wc.u17wc_get_player_fan_poll_backup2(p_completedmatchid numeric[], p_matchid numeric, OUT p_playerjson jsonb, OUT p_top3json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

     

declare
	 v_total_vote  numeric ;   
     v_json jsonb[];
   --   v_json text;
      v_winnerjson  text := '{"winner":[';
    -- v_winnerjson  json[] ;
     v_top3json  text := '{"top3":[';
     -- v_top3json json;
     v_asset_type_id numeric := 4 ; 
     v_playerjson text  ;
     v_json2 jsonb[];
     
     
begin
	
	select  array(
    select row_to_json(row) as jsonrow  
    from (              
            select m.source_object_id match_source_objectid,
                   m.entity_role_map_id match_entity_role_mapid, 
                   emm.entity_name match_title,
                   s.source_object_id season_source_objectid,
                   s.entity_role_map_id season_entity_role_mapid,
                   ems.entity_name sport_name,
                   p.source_object_id player_source_objectid,
                   p.entity_role_map_id player_entity_role_mapid,
                   emp.entity_name player_name,
                   t.source_object_id team_source_objectid,
                   t.entity_role_map_id team_entity_role_mapid,
                   sp.source_object_id sport_source_objectid,
                   sp.entity_role_map_id sport_entity_role_mapid,
                   player_total_vote, 
                   a.vote_percentage,
        		a.srno
        			,
        		  -- row_number() over(partition by m.source_object_id order by vote_percentage desc) srno 
                   (select asset_data from u17wc.u17wc_asset_draft d 
                    where exists (
                                    select asset_id, asset_type_id, count(1) 
                                    from   u17wc.u17wc_asset_entity_map eam
                                    where  eam.asset_id= d.asset_id
                                    and    eam.asset_type_id = d.asset_type_id 
                                    and    eam.entity_role_map_id in (m.entity_role_map_id, p.entity_role_map_id)
                                    group by asset_id, asset_type_id 
                                    having count(1) >= 2
                                    )
                    and d.asset_type_id  = v_asset_type_id
                   )video_json
        		
            from 
            (
                select p.match_id, p.season_id, p.player_id, p.team_id, p.sport_id, sum(p.votes) player_total_vote, 
                       v.total_vote , ((sum(p.votes) / v.total_vote) * 100) vote_percentage,
                	    row_number() over(partition by p.match_id order by  ((sum(p.votes) / v.total_vote) * 100) desc) srno 	
                from u17wc.u17wc_player_fan_poll p
                inner join (select p1.match_id, p1.season_id, sum(votes) total_vote 
                            from u17wc.u17wc_player_fan_poll p1 
    						where p1.match_id in (SELECT matchid FROM UNNEST(p_completedmatchid) U(matchid))
    						and  p1.is_active = 1 
    						and p1.is_deleted = 0
    						group by p1.match_id, p1.season_id
                           )v
                on (p.match_id = v.match_id and p.season_id = v.season_id)
                where p.match_id in (SELECT matchid FROM UNNEST(p_completedmatchid) U(matchid))
                and  is_active = 1 
                and is_deleted = 0
                group by p.match_id, p.season_id, p.player_id, p.team_id, p.sport_id, v.total_vote
                order by vote_percentage desc 
               
             )a 
             inner join u17wc.u17wc_entity_role_map m on (a.match_id::varchar = m.source_object_id and m.entity_role_id =6)
             inner join u17wc.u17wc_entity_master emm on (m.entity_master_id = emm.entity_master_id)
             inner join u17wc.u17wc_entity_role_map s on (a.season_id::varchar = s.source_object_id and s.entity_role_id = 7)
             inner join u17wc.u17wc_entity_master ems on (s.entity_master_id = ems.entity_master_id)
             inner join u17wc.u17wc_entity_role_map p on (a.player_id::varchar = p.source_object_id and p.entity_role_id = 4)
             inner join u17wc.u17wc_entity_master emp on (p.entity_master_id = emp.entity_master_id)
             left join u17wc.u17wc_entity_role_map t on (a.team_id::varchar = t.source_object_id and t.entity_role_id = 5)
             left join u17wc.u17wc_entity_master emt on (t.entity_master_id = emt.entity_master_id)
             left join u17wc.u17wc_entity_role_map sp on (a.sport_id::varchar = sp.source_object_id and sp.entity_role_id = 3)
             left join u17wc.u17wc_entity_master emsp on (t.entity_master_id = emsp.entity_master_id)
        	where a.srno = 1
          )row 
        )
          into v_json ; 
           

           
       /*  
           v_winnerjson = v_winnerjson ||v_json::text ||']} ' ;
          
        --  raise notice 'json : %' , v_json ; 
          
         -- v_winnerjson = '[' || v_json::text || ']' ;
         -- v_winnerjson =  v_json::text ;   
          
          select  array(select row_to_json(row) as jsonrow  
    	  from (              
            select m.source_object_id match_source_objectid,
                   m.entity_role_map_id match_entity_role_mapid, 
                   emm.entity_name match_title,
                   s.source_object_id season_source_objectid,
                   s.entity_role_map_id season_entity_role_mapid,
                   ems.entity_name sport_name,
                   p.source_object_id player_source_objectid,
                   p.entity_role_map_id player_entity_role_mapid,
                   emp.entity_name player_name,
                   t.source_object_id team_source_objectid,
                   t.entity_role_map_id team_entity_role_mapid,
                   sp.source_object_id sport_source_objectid,
                   sp.entity_role_map_id sport_entity_role_mapid,
                   player_total_vote, 
                   vote_percentage                  
            from 
            (
                select p.match_id, p.season_id, p.player_id, p.team_id, p.sport_id, sum(p.votes) player_total_vote, 
                       v.total_vote , ((sum(p.votes) / v.total_vote) * 100) vote_percentage 
                from u17wc.u17wc_player_fan_poll p
                inner join (select p1.match_id, p1.season_id, sum(votes) total_vote 
                            from u17wc.u17wc_player_fan_poll p1 
    						where p1.match_id in (SELECT matchid FROM UNNEST(p_completedmatchid) U(matchid))
    						and  p1.is_active = 1 
    						and p1.is_deleted = 0
    						group by p1.match_id, p1.season_id
                           )v
                on (p.match_id = v.match_id and p.season_id = v.season_id)
                where p.match_id in (SELECT matchid FROM UNNEST(p_completedmatchid) U(matchid))
                and  is_active = 1 
                and is_deleted = 0
                group by p.match_id, p.season_id, p.player_id, p.team_id, p.sport_id, v.total_vote
                order by vote_percentage desc 
                limit 3
             )a 
              inner join u17wc.u17wc_entity_role_map m on (a.match_id::varchar = m.source_object_id and m.entity_role_id =6)
             inner join u17wc.u17wc_entity_master emm on (m.entity_master_id = emm.entity_master_id)
             inner join u17wc.u17wc_entity_role_map s on (a.season_id::varchar = s.source_object_id and s.entity_role_id = 7)
             inner join u17wc.u17wc_entity_master ems on (s.entity_master_id = ems.entity_master_id)
             inner join u17wc.u17wc_entity_role_map p on (a.player_id::varchar = p.source_object_id and p.entity_role_id = 4)
             inner join u17wc.u17wc_entity_master emp on (p.entity_master_id = emp.entity_master_id)
             left join u17wc.u17wc_entity_role_map t on (a.team_id::varchar = t.source_object_id and t.entity_role_id = 5)
             left join u17wc.u17wc_entity_master emt on (t.entity_master_id = emt.entity_master_id)
             left join u17wc.u17wc_entity_role_map sp on (a.sport_id::varchar = sp.source_object_id and sp.entity_role_id = 3)
             left join u17wc.u17wc_entity_master emsp on (t.entity_master_id = emsp.entity_master_id)
          )row
        )
          into v_json ; 
          
       
       
          raise notice 'v_json : %', v_json ;
          
         --  v_top3json =  v_json2::text ; 
          
           v_top3json :=  v_top3json || v_json::text || ']}' ; 
        
        --  v_top3json := v_json;
        
         raise notice 'v_json : %', v_winnerjson ;
         raise notice 'v_json 2 : %', v_top3json ;
         select 1 /0 ;
        -- raise notice '1  : %' , (v_playerjson || v_winnerjson::json ||','|| v_top3json::json  ||'}') ;
         
        v_playerjson := '{"data": {
    						"winner": "'||coalesce(v_winnerjson::text, '')||'",
    						"top3": "'||coalesce(v_top3json::text, '')||'"
                            
                        }
				}';
	
         
        -- v_playerjson :=  v_playerjson || v_winnerjson::json ||','|| v_top3json::json  ||'}' ;   
         
         p_playerjson := v_json;
         p_top3json := v_top3json;
      */
      p_playerjson := v_json;
       --  p_top3json := v_top3json;
end;

     

$$;


--
