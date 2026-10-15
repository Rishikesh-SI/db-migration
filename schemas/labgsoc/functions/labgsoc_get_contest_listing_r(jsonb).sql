-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: labgsoc_get_contest_listing_r(jsonb)
-- Type: FUNCTION

-- Name: labgsoc_get_contest_listing_r(jsonb); Type: FUNCTION; Schema: labgsoc; Owner: -
--

CREATE FUNCTION labgsoc.labgsoc_get_contest_listing_r(p_json jsonb, OUT p_contestjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
	/* input json
	{"pagenumber":"1","itemnumber":"10","entityrole_mapid":"2373","user_guid":"585982be-8b0d-4ea3-baa6-e7742b3e3750"}
	*/
	v_contestidarr numeric[];
	v_asset_type_id numeric :=39;
	v_fromrownumber numeric;
   v_torownumber numeric;
    v_sysdate timestamp;
    v_ent_count numeric;
    v_userid numeric;
    v_contestid numeric;
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
	v_foractiveusers numeric;
	v_boolean boolean;
	
    
begin
     
	 select p_json->>'pagenumber',
			p_json->>'itemnumber',
			p_json->>'entityrole_mapid',
			p_json->>'user_guid',
			p_json->>'asset_type_id',
			--p_json->>'foractiveusers',
		 	p_json->>'asset_id'
	into 	v_pagenumber,
			v_itemnumber,
			v_entityrole_mapid,
			v_user_guid,
			v_ent_asset_type_id,
			--v_foractiveusers,
		 	v_asset_id;

--select 1/0;
	
		if v_ent_asset_type_id>0 then
		
			 select entity_role_map_id
			 into v_entityrole_mapid
			 from labgsoc.labgsoc_entity_role_map
			 where entity_role_id = (select entity_role_id
			 from labgsoc.labgsoc_asset_type
			 where asset_type_id=v_ent_asset_type_id)
			 and source_object_id=v_asset_id;

			 
		end if;

		raise notice '1';

		
		--select Case when v_foractiveusers=1 then true else false end into v_boolean;

			
			
		v_entity_array := string_to_array(v_entityrole_mapid,',')::numeric[];	
			
	
     v_sysdate:= current_timestamp at time zone 'utc';
     
     select count(1)
     into   v_ent_count
     from   unnest(v_entity_array)entity_id;
     
   	v_fromrownumber := (v_pagenumber * v_itemnumber - (v_itemnumber - 1));
  	v_torownumber   := (v_pagenumber * v_itemnumber);
   -- raise notice 'v_entity_array=%',v_entity_array;
     select array(select contest_id
                  from   (select p.contest_id, rank() over (order by p.updated_date desc) as rno
                          from   labgsoc.labgsoc_contest p
                          where  p.is_active = 1
                          and    p.is_deleted = 0
                          and    p.is_published = 1
                         -- and    p.end_date >= v_sysdate
                          and    exists(select 1
                                        from   labgsoc.labgsoc_asset_entity_map aem
                                        where  aem.asset_id = p.contest_id
                                        and    aem.asset_type_id = v_asset_type_id
                                        and    aem.entity_role_map_id in (select entity_role_mapid
                                                                          from unnest(v_entity_array) U(entity_role_mapid))
                                        group by aem.asset_id, aem.asset_type_id
                                        having count(1) = v_ent_count)
                         ) a
                  where  a.rno between v_fromrownumber and v_torownumber
                 )
                  into   v_contestidarr;
				  
	raise notice 'v_contestidarr=%',v_contestidarr;
	--raise notice '2';
     
   if v_user_guid = '' or v_user_guid is null then 

   raise notice 'sachin';
	 
	 select '{ "data" :'||json_agg(tab)||'}' into p_contestjson from 
	(select p.*,
      coalesce( (select sum(response_count) 
       from labgsoc.labgsoc_contest_response
       where contest_id=p.contest_id),0) as total_response , to_jsonb((al.web_detail_jsn ->'data'->>'cover_image')::jsonb) as cover_image ,
	   (select json_agg(row) from(select p1.contest_option_id,p1.contest_id,p1.option,p1.created_date,p1.updated_date,
		p1.created_by,p1.updated_by,p1.is_active,p1.is_deleted,p1.contest_option_guid,
		p1.option_order,coalesce(p1.is_ans,null) as is_ans,coalesce((select  sum(response_count) 
                 from labgsoc.labgsoc_contest_response
                  where contest_id = p1.contest_id
                  and   response_option_id= p1.contest_option_id),0) as response_count ,
					0 as user_voted			  
     from   labgsoc.labgsoc_contest_option p1
     where    p1.contest_id = p.contest_id)row ) as contest_option
          from   labgsoc.labgsoc_contest p 
         inner join labgsoc.labgsoc_asset_list  al on al.asset_id=p.contest_id and al.asset_type_id=39
          where  p.contest_id in(select contest_id
                            from   unnest(v_contestidarr) U(contest_id))
							
							--and p.for_loggedin_user = v_boolean
                            order by created_date desc)tab;
							
	raise notice 'p_contestjson1234 %',p_contestjson;

	
    
  else
  --raise notice '3';
  
   select user_id into v_userid
    from labgsoc.labgsoc_web_user 
    where user_guid = v_user_guid ; 
	
	
  
    select '{ "data" :'||json_agg(tab)||'}' into p_contestjson from 
	(select p.*,al.image_file_name,
      coalesce( (select sum(response_count) 
       from labgsoc.labgsoc_contest_response
       where contest_id=p.contest_id),0) as total_response ,to_jsonb((al.web_detail_jsn ->'data'->>'cover_image')::jsonb) as cover_image ,
	   (select json_agg(row) from(select distinct p1.contest_option_id,p1.contest_id,p1.option,p1.created_date,p1.updated_date,
		p1.created_by,p1.updated_by,p1.is_active,p1.is_deleted,p1.contest_option_guid,
		p1.option_order,coalesce(p1.is_ans,null) as is_ans,coalesce((select  sum(response_count) 
                 from labgsoc.labgsoc_contest_response
                  where contest_id = p1.contest_id
                  and   response_option_id= p1.contest_option_id),0) as response_count ,
				  case when up.response_option_id = p1.contest_option_id  then 1 else 0 end as user_voted,
				  up.ans as user_answer_id				  
     from   labgsoc.labgsoc_contest_option p1
	 left join labgsoc.labgsoc_user_contest_response up on p.contest_id = up.contest_id and up.response_option_id= p1.contest_option_id
								  and up.user_id = v_userid							  
     where  p1.contest_id = p.contest_id)row ) as contest_option
          from   labgsoc.labgsoc_contest p
		 

		  
         inner join labgsoc.labgsoc_asset_list  al on al.asset_id=p.contest_id and al.asset_type_id=39
          where  p.contest_id in(select contest_id
                            from   unnest(v_contestidarr) U(contest_id))
							--and p.for_loggedin_user = v_boolean

                            order by created_date desc)tab;

  raise notice '5';
   
   
   
  select contest_id  into v_contestid 
  from labgsoc.labgsoc_contest p 
  where  p.is_active = 1 and    p.is_deleted = 0
  
  and current_timestamp  between p.start_date and p.end_date
  
   
  and  exists(select 1 from   labgsoc.labgsoc_asset_entity_map aem
                                        where  aem.asset_id = p.contest_id
                                        and    aem.asset_type_id = v_asset_type_id
                                        and    aem.entity_role_map_id in (select entity_role_mapid
                                                                          from unnest(v_entity_array) U(entity_role_mapid))
                                        group by aem.asset_id, aem.asset_type_id
                                        having count(1) = v_ent_count) and is_published = 1 and is_active = 1;
	
   --raise notice '%',v_contestid;

  -- select v_no_of_ans_allowed - coalesce((select count(1) 
  --  from labgsoc.labgsoc_user_contest_response
  --  where contest_id = v_contestid -- in(select contest_id from unnest(v_contestidarr) U(contest_id))
  --  and user_id = v_userid),0) into v_user_vote_remain;

 
   v_ad_info = '{
					"remaining_vote_cnt": "'||coalesce(v_user_vote_remain::text,'0')||'"
						
				}' ;
   
   p_contestjson := jsonb_set(p_contestjson,'{additional_info}',v_ad_info::jsonb,true);
   
	end if;					
   
end;
$$;


--
