-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_get_poll_listing_r(jsonb, refcursor, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: labrstg_get_poll_listing_r(jsonb, refcursor, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: labrstg; Owner: -
--

CREATE FUNCTION labrstg.labrstg_get_poll_listing_r(p_json jsonb, p_poll_cur refcursor, p_poll_option refcursor, p_poll_response refcursor, p_user_remcount refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
declare
	
	v_pollidarr numeric[];
	v_asset_type_id1 numeric :=6;
	v_fromrownumber numeric;
    v_torownumber numeric;
    v_sysdate timestamp;
    v_ent_count numeric;
    v_userid numeric;
	v_pollid  numeric;
	v_no_of_ans_allowed numeric:=0;
   
	v_entity_role_map_id numeric;
	v_entity_role_mapid1 numeric;
	p_pagenumber numeric;
	p_itemnumber numeric;
	v_entity_id text;
	p_user_guid character varying;
	v_asset_type_id numeric;
	v_asset_id character varying;
	i character varying;
	p_entityrole_mapid1 numeric[];
	p_entityrole_mapid numeric[] ;
	p_erm numeric:=8081;
	p_asset_id character varying[] ;
begin

/*
{
  "entityid": "8703,8704",
  "spgnnum": "1",
  "sitem": "1",
  "user_guid": "",
  "asset_id": "sawpkw01202021199377",
  "asset_type_id": "41"
}
*/

		 select p_json->>'asset_type_id',
		 		p_json->>'asset_id',
				p_json->>'user_guid',
				p_json->>'entityid',
				p_json->>'spgnnum',
				p_json->>'sitem'
			--	p_json->>'asset_id'
		 into v_asset_type_id,
		 	  v_asset_id,
			  p_user_guid,
			  v_entity_id,
			  p_pagenumber,
			  p_itemnumber;

	
	--p_entityrole_mapid1:=(SELECT string_to_array(v_entity_id,','))::int[];
	
	--raise notice 'p_entityrole_mapid1 % ',p_entityrole_mapid1;
	 
	 --p_entityrole_mapid1:=array_append(p_entityrole_mapid1,p_entityrole_mapid);
	 
	 p_asset_id:=(SELECT string_to_array(v_asset_id,','))::character varying[];
	 
	 if v_entity_id!='' then
	 end if;
	 if v_asset_type_id>0 then
	 select entity_role_map_id
	 into v_entity_role_map_id
     from labrstg.labrstg_entity_role_map
	 where entity_role_id = (select entity_role_id
	 from labrstg.labrstg_asset_type
	 where asset_type_id=v_asset_type_id)
	 and source_object_id in(select asset_id
                            from   unnest(p_asset_id) U(asset_id));--=v_asset_id;
	 
	 p_entityrole_mapid:=array_append(p_entityrole_mapid,v_entity_role_map_id);
	 end if;
	 raise notice 'v_entity_role_map_id % ',v_entity_role_map_id;
	 
	  raise notice 'p_entityrole_mapid % ',p_entityrole_mapid;
	 
	 
     v_sysdate:= current_timestamp at time zone 'utc';
     
     select count(1)
     into   v_ent_count
     from   unnest(p_entityrole_mapid)entity_id;
     
	 raise notice 'v_ent_count % ',v_ent_count;
	 
   	v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
  	v_torownumber   := (p_pagenumber * p_itemnumber);
	
	raise notice 'v_fromrownumber % ',v_fromrownumber;
	raise notice 'v_torownumber % ',v_torownumber;

	
	
	select user_id into v_userid
    from labrstg.labrstg_web_user 
    where user_guid = p_user_guid ;   
    	
     select array(select poll_id
                  from   (select p.poll_id, rank() over (order by p.updated_date desc) as rno
                          from   labrstg.labrstg_poll p
                          where  p.is_active = 1
                          and    p.is_deleted = 0
                          and    p.is_published = 1
                          /*and    p.start_date <= v_sysdate
                          and    p.end_date >= v_sysdate*/
                          and    exists(select 1
                                        from   labrstg.labrstg_asset_entity_map aem
                                        where  aem.asset_id = p.poll_id
                                        and    aem.asset_type_id = v_asset_type_id1
                                        and    aem.entity_role_map_id in (select entity_role_mapid
                                                                          from unnest(p_entityrole_mapid) U(entity_role_mapid))
                                        group by aem.asset_id, aem.asset_type_id)
                                        --having count(1) = v_ent_count)
                          -- limit  2
                         ) a
                  where  a.rno between v_fromrownumber and v_torownumber
                 )
                  into   v_pollidarr;
				  
				  raise notice '% poll cursor % % %',v_pollidarr,v_userid,v_asset_type_id1,p_entityrole_mapid;
			--select 1/0;
     
     open p_poll_cur for     	
     select p.*,al.image_file_name,
       (select sum(response_count) 
       from labrstg.labrstg_poll_response
       where poll_id=p.poll_id) as total_response,
		case when p_user_guid is not null then
		 p.no_of_ans_allowed - (select count(1) 
       from labrstg.labrstg_user_poll_response
       where poll_id=p.poll_id
		and user_id =v_userid ) else p.no_of_ans_allowed end as user_response,	
		coalesce((select total_coins  from labrstg.labrstg_user_poll_response 
        where poll_id=p.poll_id
        and user_id=v_userid
		and total_coins is not null
		limit 1	),0) as tot_earned_pt_by_user,
		coalesce((select 1  from labrstg.labrstg_user_poll_response 
        where poll_id=p.poll_id
        and user_id=v_userid limit 1),0) as is_poll_submitted
		
        from   labrstg.labrstg_poll p
        inner join labrstg.labrstg_asset_list  al on al.asset_id=p.poll_id and al.asset_type_id=v_asset_type_id1
        where  p.poll_id in(select poll_id
                            from   unnest(v_pollidarr) U(poll_id))
                            order by created_date desc;
       
		if p_erm=any(p_entityrole_mapid) then				 
														 
		if p_user_guid is null  then	
		  open p_poll_option for     
				 select p.*,(select  sum(response_count) 
                 from labrstg.labrstg_poll_response
                  where poll_id=p.poll_id
                  and   response_option_id= p.poll_option_id) as response_count,
					(select  avg(player_rating) 
                 from labrstg.labrstg_user_poll_response
                  where poll_id=p.poll_id
                  and   response_option_id= p.poll_option_id) avg_rating,
				0 as is_flag,
		0 as score,0 as player_id,0 as wickets,
		null as image_path,null as video_path,null as extra	,
		0 is_ans , 0 coins
     from   labrstg.labrstg_poll_option p
     where  p.poll_id in(select poll_id
                         from   unnest(v_pollidarr) U(poll_id))
                         order by created_date desc;	
	else  
     open p_poll_option for     	
     select p.*,(select  sum(response_count) 
                 from labrstg.labrstg_poll_response
                  where poll_id=p.poll_id
                  and   response_option_id= p.poll_option_id) as response_count,
				case when up.response_option_id=p.poll_option_id  then 1 else 0 end as is_flag,										  
					(select  avg(player_rating) 
                 from labrstg.labrstg_user_poll_response
                  where poll_id=p.poll_id
                  and   response_option_id= p.poll_option_id
					and coalesce(player_rating,0)>0) avg_rating,								  
		 coalesce(up.score,0) as score,
				coalesce(up.player_id,0) as player_id,
				coalesce(up.wickets,0) as wickets,
				 up.image_path,up.video_path,up.extra	,
				 coalesce(p.is_ans,0) as is_ans,coalesce(up.coins,0) as coins
     from   labrstg.labrstg_poll_option p
	left join labrstg.labrstg_user_poll_response up
	  on up.poll_id= p.poll_id
	   and up.user_id= v_userid	
	 and up.response_option_id =p.poll_option_id												  
     where  p.poll_id in(select poll_id
                         from   unnest(v_pollidarr) U(poll_id))
                         order by created_date desc;
	 end if;
		 else
		if p_user_guid is null  then	
		  open p_poll_option for     
				select kp.* from ( select p.*,(select  sum(response_count) 
                 from labrstg.labrstg_poll_response
                  where poll_id=p.poll_id
                  and   response_option_id= p.poll_option_id) as response_count,
					(select  avg(player_rating) 
                 from labrstg.labrstg_user_poll_response
                  where poll_id=p.poll_id
                  and   response_option_id= p.poll_option_id) avg_rating,
				0 as is_flag,
        	0 as score,0 as player_id,
								  0 as wickets,null as image_path,
								  null as video_path,
								  null as extra ,
								  coalesce(p.is_ans,0) as is_ans,0 coins
     from   labrstg.labrstg_poll_option p
     where  p.poll_id = any(v_pollidarr) /* in(select poll_id
                         from   unnest(v_pollidarr) U(poll_id))
								  */
                         ) kp
						 order by coalesce(kp.avg_rating,0)	desc;
	else  
     open p_poll_option for     	
  select kp.* from (  select p.*,(select  sum(response_count) 
                 from labrstg.labrstg_poll_response
                  where poll_id=p.poll_id
                  and   response_option_id= p.poll_option_id) as response_count,
				case when up.response_option_id=p.poll_option_id  then up.player_rating else 0 end as is_flag,										  
					(select  avg(player_rating) 
                 from labrstg.labrstg_user_poll_response
                  where poll_id=p.poll_id
                  and   response_option_id= p.poll_option_id
					and coalesce(player_rating,0)>0) avg_rating,								  
			 coalesce(up.score,0) as score,
				coalesce(up.player_id,0) as player_id,
				coalesce(up.wickets,0) as wickets,
				 up.image_path,up.video_path,up.extra,
					coalesce(p.is_ans,0) as is_ans ,coalesce(up.coins,0) as coins
     from   labrstg.labrstg_poll_option p
	left join labrstg.labrstg_user_poll_response up
	  on up.poll_id= p.poll_id
	   and up.user_id= v_userid	
	 and up.response_option_id =p.poll_option_id												  
     where  p.poll_id = any(v_pollidarr)
					/*in(select poll_id
                         from   unnest(v_pollidarr) U(poll_id))
					
					*/
                         ) as kp
						 order by coalesce(kp.avg_rating,0) desc;
	 end if;
	 end if;
	
     open p_poll_response for
     select *
     from   labrstg.labrstg_poll_response 
     where  poll_id in(select poll_id
                       from   unnest(v_pollidarr) U(poll_id))
                       limit 1;
	
    
	
	select poll_id,no_of_ans_allowed into v_pollid,
	v_no_of_ans_allowed												
	from labrstg.labrstg_poll p 
	where current_timestamp between start_date and end_date;
     -- poll_desc::json->>'start_date')::timestamp and (poll_desc::json->>'end_date')::timestamp ;
	raise notice 'v_no_of_ans_allowed % ',v_no_of_ans_allowed; 
	 
	 select array(select poll_id
                  from   (select p.poll_id, rank() over (order by p.updated_date desc) as rno
                          from   labrstg.labrstg_poll p
                          where  p.is_active = 1
                          and    p.is_deleted = 0
                          and    p.is_published = 1
                          /*and    p.start_date <= v_sysdate
                          and    p.end_date >= v_sysdate*/
                          and    exists(select 1
                                        from   labrstg.labrstg_asset_entity_map aem
                                        where  aem.asset_id = p.poll_id
                                        and    aem.asset_type_id = v_asset_type_id1
                                        and    aem.entity_role_map_id in (select entity_role_mapid
                                                                          from unnest(p_entityrole_mapid) U(entity_role_mapid))
                                        group by aem.asset_id, aem.asset_type_id)
                                        --having count(1) = v_ent_count)
                          -- limit  2
                         ) a
                  where  a.rno between 1 and 100
                 )
                  into   v_pollidarr;
				  
	raise notice 'v_pollidarr % ',v_pollidarr;
    
    open p_user_remcount for
    select (v_no_of_ans_allowed - (coalesce((select count(1) 
    from labrstg.labrstg_user_poll_response												
    where poll_id = v_pollid -- in(select poll_id from unnest(v_pollidarr) U(poll_id))
    ),0))) user_vote_remain ,
	coalesce((select sum(total_coins)  from labrstg.labrstg_user_poll_response 
        where  user_id=v_userid and poll_id in(select poll_id
                            from   unnest(v_pollidarr) U(poll_id))),0) as total_points,
		coalesce((
			select rank from (select  user_id,		 
             (case when tot_points !=0
               then RANK() over ( order by tot_points desc) 
               else 0
           end)	as rank	 
       from (
          select  user_id,coalesce(sum(total_coins),0) as tot_points
           from labrstg.labrstg_user_poll_response  where poll_id in(select poll_id
                            from   unnest(v_pollidarr) U(poll_id))
           group by user_id
          )tab
			)tab2
          where user_id=v_userid),0) as  user_rank;
		  
		  raise notice 'v_no_of_ans_allowed % ',v_no_of_ans_allowed;
        
end;
$$;


--
