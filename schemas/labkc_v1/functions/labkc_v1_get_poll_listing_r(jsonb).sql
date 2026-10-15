-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_get_poll_listing_r(jsonb)
-- Type: FUNCTION

-- Name: labkc_v1_get_poll_listing_r(jsonb); Type: FUNCTION; Schema: labkc_v1; Owner: -
--

CREATE FUNCTION labkc_v1.labkc_v1_get_poll_listing_r(p_poll jsonb, OUT p_poll_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
	/* input json
	{"pagenumber":"1","itemnumber":"10","entityrole_mapid":"2373","user_guid":"585982be-8b0d-4ea3-baa6-e7742b3e3750"}
	*/
	v_pollidarr numeric[];
	v_asset_type_id numeric :=6;
	v_fromrownumber numeric;
   v_torownumber numeric;
    v_sysdate timestamp;
    v_ent_count numeric;
    v_userid numeric;
    v_pollid numeric;
	v_pagenumber numeric;
	v_itemnumber numeric;
	v_entityrole_mapid CHARACTER VARYING;
	v_user_guid CHARACTER VARYING;
	v_entity_array numeric[];
	v_user_vote_remain numeric;
	v_ad_info jsonb;
	v_ent_asset_type_id numeric;
	v_asset_id character varying;
	v_no_of_ans_allowed numeric;
	v_vote_user numeric;
   v_count numeric; 
   v_pid numeric[];
begin
     
	 select p_poll->>'pagenumber',
			p_poll->>'itemnumber',
			p_poll->>'entityrole_mapid',
			p_poll->>'user_guid',
			p_poll->>'asset_type_id',
		 	p_poll->>'asset_id'
	into 	v_pagenumber,
			v_itemnumber,
			v_entityrole_mapid,
			v_user_guid,
			v_ent_asset_type_id,
		 	v_asset_id;
		
		if v_ent_asset_type_id>0 then
		
			 select entity_role_map_id
			 into v_entityrole_mapid
			 from labkc_v1.labkc_v1_entity_role_map
			 where entity_role_id = (select entity_role_id
			 from labkc_v1.labkc_v1_asset_type
			 where asset_type_id=v_ent_asset_type_id)
			 and source_object_id=v_asset_id;

			 
		end if;
			
			
		v_entity_array := string_to_array(v_entityrole_mapid,',')::numeric[];	

     v_sysdate:= current_timestamp at time zone 'utc';
     
     select count(1)
     into   v_ent_count
     from   unnest(v_entity_array)entity_id;
    
	
	
	
   	v_fromrownumber := (v_pagenumber * v_itemnumber - (v_itemnumber - 1));
  	v_torownumber   := (v_pagenumber * v_itemnumber);
   -- raise notice 'v_entity_array=%',v_entity_array;
     select array(select poll_id
                  from   (select p.poll_id, rank() over (order by p.updated_date desc) as rno
                          from   labkc_v1.labkc_v1_poll p
                          where  p.is_active = 1
                          and    p.is_deleted = 0
                          and    p.is_published = 1
                          and    p.end_date >= v_sysdate
                          and    exists(select 1
                                        from   labkc_v1.labkc_v1_asset_entity_map aem
                                        where  aem.asset_id = p.poll_id
                                        and    aem.asset_type_id = v_asset_type_id
                                        and    aem.entity_role_map_id in (select entity_role_mapid
                                                                          from unnest(v_entity_array) U(entity_role_mapid))
                                        group by aem.asset_id, aem.asset_type_id
                                        having count(1) = v_ent_count)
                         ) a
                  where  a.rno between v_fromrownumber and v_torownumber
                 )
                  into   v_pollidarr;
				  
	--raise notice 'v_pollidarr=%',v_pollidarr;
     
     if v_user_guid is null then 
	 
	 select '{ "data" :'||json_agg(tab)||'}' into p_poll_data from 
	(select p.*,al.image_file_name,
      coalesce( (select sum(response_count) 
       from labkc_v1.labkc_v1_poll_response
       where poll_id=p.poll_id),0) as total_response ,
	   (select json_agg(row) from(select p1.poll_option_id,p1.poll_id,p1.option,p1.created_date,p1.updated_date,
		p1.created_by,p1.updated_by,p1.is_active,p1.is_deleted,p1.poll_option_guid,
		p1.option_order,coalesce(p1.is_ans,0) as is_ans,coalesce((select  sum(response_count) 
                 from labkc_v1.labkc_v1_poll_response
                  where poll_id = p1.poll_id
                  and   response_option_id= p1.poll_option_id),0) as response_count ,
					0 as user_voted			  
     from   labkc_v1.labkc_v1_poll_option p1
     where  p1.poll_id = p.poll_id)row ) as poll_option
          from   labkc_v1.labkc_v1_poll p
         inner join labkc_v1.labkc_v1_asset_list  al on al.asset_id=p.poll_id and al.asset_type_id=6
          where  p.poll_id in(select poll_id
                            from   unnest(v_pollidarr) U(poll_id))
                            order by created_date desc)tab;
							
	
    
  else
  
   select user_id into v_userid
    from labkc_v1.labkc_v1_web_user 
    where user_guid = v_user_guid ; 
	
	
	select array_agg(poll_id) from labkc_v1.labkc_v1_user_poll_response 
	where user_id=v_userid
	into v_pid;

    select '{ "data" :'||json_agg(tab)||'}' into p_poll_data from 
	(select p.*,al.image_file_name,case when p.poll_id in (select poll_id
												from unnest(v_pid) U(poll_id)) then 1 else 0 end as user_voted,
      coalesce( (select sum(response_count) 
       from labkc_v1.labkc_v1_poll_response
       where poll_id=p.poll_id),0) as total_response ,
	   (select json_agg(row) from(select distinct p1.poll_option_id,p1.poll_id,p1.option,p1.created_date,p1.updated_date,
		p1.created_by,p1.updated_by,p1.is_active,p1.is_deleted,p1.poll_option_guid,
		p1.option_order,coalesce(p1.is_ans,0) as is_ans,coalesce((select  sum(response_count) 
                 from labkc_v1.labkc_v1_poll_response
                  where poll_id = p1.poll_id
                  and   response_option_id= p1.poll_option_id),0) as response_count ,
				  case when up.response_option_id = p1.poll_option_id  then 1 else 0 end as user_voted,
				  up.ans as user_answer_id				  
     from   labkc_v1.labkc_v1_poll_option p1
	 left join labkc_v1.labkc_v1_user_poll_response up on p.poll_id = up.poll_id and up.response_option_id= p1.poll_option_id
								  and up.user_id = v_userid							  
     where  p1.poll_id = p.poll_id)row ) as poll_option
          from   labkc_v1.labkc_v1_poll p
         inner join labkc_v1.labkc_v1_asset_list  al on al.asset_id=p.poll_id and al.asset_type_id=6
          where  p.poll_id in(select poll_id
                            from   unnest(v_pollidarr) U(poll_id))
                            order by created_date desc)tab;
   
   
   
  select poll_id , no_of_ans_allowed into v_pollid , v_no_of_ans_allowed
  from labkc_v1.labkc_v1_poll p 
  where  p.is_active = 1 and    p.is_deleted = 0
  
  and current_timestamp  between to_timestamp(poll_desc::json->>'start_date'::text, 'DD-MM-YYYY hh24:mi GMT+00:00')::timestamp
  					and to_timestamp(poll_desc::json->>'end_date'::text, 'DD-MM-YYYY hh24:mi GMT+00:00')::timestamp
  
   
  and  exists(select 1 from   labkc_v1.labkc_v1_asset_entity_map aem
                                        where  aem.asset_id = p.poll_id
                                        and    aem.asset_type_id = v_asset_type_id
                                        and    aem.entity_role_map_id in (select entity_role_mapid
                                                                          from unnest(v_entity_array) U(entity_role_mapid))
                                        group by aem.asset_id, aem.asset_type_id
                                        having count(1) = v_ent_count) and is_published = 1 and (poll_desc::json->>'is_active')::numeric = 1;
	
   raise notice '%',v_pollid;

  select v_no_of_ans_allowed - coalesce((select count(1) 
   from labkc_v1.labkc_v1_user_poll_response
   where poll_id = v_pollid -- in(select poll_id from unnest(v_pollidarr) U(poll_id))
   and user_id = v_userid),0) into v_user_vote_remain;

 
   v_ad_info = '{
					"remaining_vote_cnt": "'||coalesce(v_user_vote_remain::text,'0')||'"
						
				}' ;
   
   p_poll_data := jsonb_set(p_poll_data,'{additional_info}',v_ad_info::jsonb,true);
   
	end if;									
   
end;
$$;


--
