-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: labupstox_get_leaderboard_listing_r(jsonb)
-- Type: FUNCTION

-- Name: labupstox_get_leaderboard_listing_r(jsonb); Type: FUNCTION; Schema: labupstox; Owner: -
--

CREATE FUNCTION labupstox.labupstox_get_leaderboard_listing_r(p_input_json jsonb, OUT leaderboardjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare

v_count numeric;
v_json jsonb;
v_pollidarr numeric[]; 
v_sysdate timestamp := current_timestamp at time zone 'utc';
v_entityrole_mapid_1 text;
v_entityrole_mapid numeric[]; 
p_pagenumber numeric;
v_pagination jsonb;
v_count1 numeric;
v_inum numeric;
v_fromrownumber numeric;
v_torownumber numeric;
begin

    select p_input_json->>'entities',
		   p_input_json->>'pgnum',
		   p_input_json->>'inum'
    	into v_entityrole_mapid_1,
			 p_pagenumber,
			 v_inum;
	
	v_entityrole_mapid := string_to_array(v_entityrole_mapid_1,',')::numeric[];
	
	
	
	v_fromrownumber := (p_pagenumber * v_inum - (v_inum - 1));
    v_torownumber   := (p_pagenumber * v_inum);

    select count(1) into v_count from labupstox.labupstox_poll_response;
		
	select array(select poll_id
                  from   (select p.poll_id
                          from   labupstox.labupstox_poll p
                          where  p.is_active = 1
                          and    p.is_deleted = 0
                          and    p.is_published = 1
                          and    p.end_date >= v_sysdate
                          and    exists(select 1
                                        from   labupstox.labupstox_asset_entity_map aem
                                        where  aem.asset_id = p.poll_id
                                        and    aem.asset_type_id = 6
                                        and    aem.entity_role_map_id in (select entity_role_mapid
                                                                          from unnest(v_entityrole_mapid) U(entity_role_mapid))
                                        group by aem.asset_id, aem.asset_type_id
                                        )
                         ) a
                 )
                  into   v_pollidarr;
				  
		
	
	select sum(response_count) into v_count from labupstox.labupstox_poll_response
	where poll_id in (select entity_role_mapid
                      from unnest(v_pollidarr) U(entity_role_mapid)) ;

	select '{ "leader_board" :'|| json_agg(row)||'}'  into leaderboardjson
	from(select option_id,player_id,v_count as fan_vote_count,player_name,team_id,skill_id,
		 	round((total*100)/v_count,2) as fan_vote_percent,rno
		 from(select poll_option_id as option_id,option::json->>'player_id' as player_id,option::json->>'team_id' as team_id,
			  option::json->>'skill_id' as skill_id,
			  option::json->>'player_name' as player_name,
			  round((sum(pr.response_count)*100)/v_count,2) as fan_vote_percent1,
			 
			  sum(response_count) as total,
			  row_number()over (order by round((sum(pr.response_count)*100)/v_count,2) desc) as rno
			  from labupstox.labupstox_poll_response pr
			  left join labupstox.labupstox_poll_option po 
			  on pr.response_option_id = po.poll_option_id and pr.poll_id = po.poll_id
			  where  pr.poll_id in (select entity_role_mapid
                      from unnest(v_pollidarr) U(entity_role_mapid)) 
					 
			  group by 1,2
			  order by fan_vote_percent1 desc,
			  player_name asc
			  ) 
		 tab 
		 where rno between v_fromrownumber and v_torownumber order by rno
		 )row ;
		 
	raise notice 'v_fromrownumber=%',v_fromrownumber; 
raise notice 'v_torownumber=%',v_torownumber; 	
	
	select count(distinct(option::json->>'player_id')) into v_count1
			  from labupstox.labupstox_poll_response pr
			  left join labupstox.labupstox_poll_option po 
			  on pr.response_option_id = po.poll_option_id and pr.poll_id = po.poll_id
			  where pr.poll_id in (select entity_role_mapid
                      from unnest(v_pollidarr) U(entity_role_mapid));

	
 v_pagination:='{"total":'||v_count1||',
 				 "current_page":'||coalesce(p_pagenumber,0)||'	
				 }';

leaderboardjson:=jsonb_set(leaderboardjson,'{pagination}',v_pagination,true);
 

end;
$$;


--
