-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: labupstox_get_poll_vote_listing_r(jsonb)
-- Type: FUNCTION

-- Name: labupstox_get_poll_vote_listing_r(jsonb); Type: FUNCTION; Schema: labupstox; Owner: -
--

CREATE FUNCTION labupstox.labupstox_get_poll_vote_listing_r(p_input_json jsonb, OUT p_vote_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare

v_count numeric;
v_json jsonb;
v_pollidarr numeric[]; 
v_sysdate timestamp := current_timestamp at time zone 'utc';
v_entityrole_mapid_1 text;
v_entityrole_mapid numeric[]; 

begin

    select p_input_json->>'entityrole_mapid' 
	into v_entityrole_mapid_1 ;
	
	v_entityrole_mapid := string_to_array(v_entityrole_mapid_1,',')::numeric[];
	
	--raise notice '%',v_entityrole_mapid;

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

	select '{ "player_voting_list" :'|| json_agg(row)||'}'  into p_vote_json
	from(select option_id,player_id,v_count as fan_vote_count,
		 	round((total*100)/v_count,2) as fan_vote_percent 
		 from(select poll_option_id as option_id,option::json->>'player_id' as player_id,sum(response_count) as total
			  from labupstox.labupstox_poll_response pr
			  left join labupstox.labupstox_poll_option po 
			  on pr.response_option_id = po.poll_option_id and pr.poll_id = po.poll_id
			  where pr.poll_id in (select entity_role_mapid
                      from unnest(v_pollidarr) U(entity_role_mapid)) 
			  group by 1,2
			  order by total desc )
		 tab)row ;
		 
	--	p_vote_json :=  v_json;
		 
	-- raise notice '%'	,p_vote_json	;  	 

end;
$$;


--
