-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg_v1
-- Object: lablsg_v1_get_whatsapp_pole_listing_r(jsonb)
-- Type: FUNCTION

-- Name: lablsg_v1_get_whatsapp_pole_listing_r(jsonb); Type: FUNCTION; Schema: lablsg_v1; Owner: -
--

CREATE FUNCTION lablsg_v1.lablsg_v1_get_whatsapp_pole_listing_r(p_poll jsonb, OUT p_poll_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
	/* input json
	{
  "pagenumber": "1",
  "itemnumber": "10",
  "entityrole_mapid": "1301",
  "mobile_no": "K0npSmC4YCvJkTMzj+cyUCsaIf2y2haMb25BXv55gI8="
}
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
    v_mobile_no CHARACTER VARYING;
    v_message CHARACTER VARYING;
    v_max_version numeric;
	v_is_quiz numeric;
	
    v_total_wrong_ans numeric;
	v_total_correct_ans numeric;
    v_total_poll numeric;
    v_total_poll_ans boolean;
	v_poll_data numeric[];
begin
     
	 select p_poll->>'pagenumber',
			p_poll->>'itemnumber',
			p_poll->>'entityrole_mapid',
			--p_poll->>'user_guid',
            p_poll->>'mobile_no',
			p_poll->>'asset_type_id',
		 	p_poll->>'asset_id',
			p_poll->>'is_quiz'
	into 	v_pagenumber,
			v_itemnumber,
			v_entityrole_mapid,
			--v_user_guid,
            v_mobile_no,
			v_ent_asset_type_id,
		 	v_asset_id,
			v_is_quiz;
            
         
	--	select user_guid from lablsg_v1.lablsg_v1_web_user where mobile_no=v_mobile_no into v_user_guid;
        
        
        raise notice 'user_guid:%',v_user_guid;   
		if v_ent_asset_type_id>0 then
		
			 select entity_role_map_id
			 into v_entityrole_mapid
			 from lablsg_v1.lablsg_v1_entity_role_map
			 where entity_role_id = (select entity_role_id
			 from lablsg_v1.lablsg_v1_asset_type
			 where asset_type_id=v_ent_asset_type_id)
			 and source_object_id=v_asset_id;

			 
		end if;
			
			
		v_entity_array := string_to_array(v_entityrole_mapid,',')::numeric[];

-- CREATE TEMP TABLE poll_data AS 
-- (select aem.asset_id as poll_id from lablsg_v1.lablsg_v1_asset_entity_map aem join
--     lablsg_v1.lablsg_v1_poll p on p.poll_id=aem.asset_id and p.poll_desc::jsonb->>'is_active'='1' 
--  and p.is_quiz=1 where aem.entity_role_map_id=v_entityrole_mapid::numeric and aem.asset_type_id=6
-- );	

select array_agg(aem.asset_id) from lablsg_v1.lablsg_v1_asset_entity_map aem join
lablsg_v1.lablsg_v1_poll p on p.poll_id=aem.asset_id and p.poll_desc::jsonb->>'is_active'='1' 
and p.is_quiz=1 where aem.entity_role_map_id=v_entityrole_mapid::numeric and aem.asset_type_id=6
into v_poll_data;
	--raise notice 'v_poll_data %',v_poll_data;
     v_sysdate:= current_timestamp at time zone 'utc';

  	select sum(case when coalesce(ans,0)=0 then 1 end) as total_wrong_ans, 
    sum(case when ans=1 then 1 end) as total_correct_ans
    from lablsg_v1.lablsg_v1_whatsapp_poll_response 
    where mobile_no = v_mobile_no  and poll_id in 
    (select poll_id from unnest(v_poll_data)poll_id) into v_total_wrong_ans,v_total_correct_ans; 

    select array_length((v_poll_data),1) into v_total_poll;
	
	--raise notice 'v_total_poll %',v_total_poll;

    select case when count(1)=v_total_poll then 'True' else 'False' end into v_total_poll_ans 
    from lablsg_v1.lablsg_v1_whatsapp_poll_response 
    where mobile_no=v_mobile_no and poll_id in 
        (select poll_id from unnest(v_poll_data)poll_id);

-- 	select count(*)  from lablsg_v1.lablsg_v1_whatsapp_poll_response 
--     where mobile_no = v_mobile_no and poll_id in 
--     (select asset_id from lablsg_v1.lablsg_v1_asset_entity_map where entity_role_map_id=v_entityrole_mapid::numeric
--      and asset_type_id=6);
     
     select count(1)
     into   v_ent_count
     from   unnest(v_entity_array)entity_id;
     
   	v_fromrownumber := (v_pagenumber * v_itemnumber - (v_itemnumber - 1));
  	v_torownumber   := (v_pagenumber * v_itemnumber);

   
   if (v_is_quiz is null or v_is_quiz = 0  ) then
   
  --if not EXISTS (select 1 from lablsg_v1.lablsg_v1_whatsapp_poll_response where mobile_no=v_mobile_no) and v_is_quiz = 1 then --or v_is_quiz = '' or v_mobile_no is null
   
   raise notice 'mobile_no not exists';
   
     select array(select poll_id
                  from   (select p.poll_id, rank() over (order by p.updated_date desc) as rno
                          from   lablsg_v1.lablsg_v1_poll p
                          where  p.is_active = 1
						  and (p.poll_desc::jsonb->>'is_active')::int=1
                          and    p.is_deleted = 0
                          and    p.is_published = 1
                          and    p.end_date >= v_sysdate
                          and    exists(select 1
                                        from   lablsg_v1.lablsg_v1_asset_entity_map aem
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
				  
	raise notice 'v_pollidarr=%',v_pollidarr;
	
   select poll_id , no_of_ans_allowed into v_pollid , v_no_of_ans_allowed
  from lablsg_v1.lablsg_v1_poll p 
  where  p.is_active = 1 and    p.is_deleted = 0
  
  and current_timestamp  between to_timestamp(poll_desc::json->>'start_date'::text, 'DD-MM-YYYY hh24:mi GMT+00:00')::timestamp
  					and to_timestamp(poll_desc::json->>'end_date'::text, 'DD-MM-YYYY hh24:mi GMT+00:00')::timestamp
  

   
  and  exists(select 1 from   lablsg_v1.lablsg_v1_asset_entity_map aem
                                        where  aem.asset_id = p.poll_id
                                        and    aem.asset_type_id = v_asset_type_id
                                        and    aem.entity_role_map_id in (select entity_role_mapid
                                                                          from unnest(v_entity_array) U(entity_role_mapid))
                                        group by aem.asset_id, aem.asset_type_id
                                        having count(1) = v_ent_count) and is_published = 1 and (poll_desc::json->>'is_active')::numeric = 1;
	
   --raise notice '%',v_pollid;

  select v_no_of_ans_allowed - coalesce((select count(1) 
   from lablsg_v1.lablsg_v1_whatsapp_poll_response
   where poll_id = v_pollid -- in(select poll_id from unnest(v_pollidarr) U(poll_id))
   and mobile_no = v_mobile_no),0) into v_user_vote_remain;
   

 
   v_ad_info = '{
					"remaining_vote_cnt": "'||coalesce(v_user_vote_remain::text,'0')||'"		
				}' ;

	
	--end if;
	elsif v_is_quiz = 1 then
	
	raise notice 'hi';
	     select array(select poll_id
                  from   (select p.poll_id, rank() 
				  over (order by p.poll_id asc) as rno
				  --over (order by p.updated_date desc) as rno
                          from   lablsg_v1.lablsg_v1_poll p
						  left join lablsg_v1.lablsg_v1_whatsapp_poll_response wpr
						  on p.poll_id=wpr.poll_id
                          where  p.is_active = 1
						  and (p.poll_desc::jsonb->>'is_active')::int=1
                          and    p.is_deleted = 0
                          and    p.is_published = 1
                          and    p.end_date >= v_sysdate
                          and    exists(select 1
                                        from   lablsg_v1.lablsg_v1_asset_entity_map aem
                                        where  aem.asset_id = p.poll_id
                                        and    aem.asset_type_id = v_asset_type_id
                                        and    aem.entity_role_map_id in (select entity_role_mapid
                                                                          from unnest(v_entity_array) U(entity_role_mapid))
                                        group by aem.asset_id, aem.asset_type_id
                                        having count(1) = v_ent_count)
						  and not EXISTS(select 1 from lablsg_v1.lablsg_v1_whatsapp_poll_response where mobile_no = v_mobile_no and poll_id=p.poll_id)
		  				  and current_timestamp  between to_timestamp(p.poll_desc::json->>'start_date'::text, 'DD-MM-YYYY hh24:mi GMT+00:00')::timestamp
     						and to_timestamp(p.poll_desc::json->>'end_date'::text, 'DD-MM-YYYY hh24:mi GMT+00:00')::timestamp
							
                         ) a
                  where  a.rno between v_fromrownumber and v_torownumber
     			  order by poll_id asc limit 1

                 )
                  into   v_pollidarr;

	raise notice 'v_pollidarr 2 =%',v_pollidarr;
	v_user_vote_remain:=1;
	

	
	
	  v_ad_info = '{
					"remaining_vote_cnt": "'||coalesce(v_user_vote_remain::text,'0')||'",
					"total_poll_correct_ans": "'||coalesce(v_total_correct_ans::text,'0')||'",
                     "total_poll_wrong_ans": "'||coalesce(v_total_wrong_ans::text,'0')||'",
					"total_poll": "'||coalesce(v_total_poll::text,'0')||'",
                    "all_poll_answered": "'||coalesce(v_total_poll_ans,'False')||'"
				}' ;

	
	
	end if;
--	end if;
	
 
					select '{ "data" :'||json_agg(tab)||'}' into p_poll_data from 
					(select p.*,al.image_file_name,
					  coalesce( (select sum(response_count) 
					   from lablsg_v1.lablsg_v1_whatsapp_poll_response
					   where poll_id=p.poll_id),0) as total_response ,
					   (select json_agg(row) from(select distinct p1.poll_option_id,p1.poll_id,p1.option,p1.created_date,p1.updated_date,
						p1.created_by,p1.updated_by,p1.is_active,p1.is_deleted,p1.poll_option_guid,
						p1.option_order,coalesce(p1.is_ans,0) as is_ans,coalesce((select  sum(response_count) 
								 from lablsg_v1.lablsg_v1_whatsapp_poll_response
								  where poll_id = p1.poll_id
								  and   response_option_id= p1.poll_option_id),0) as response_count ,
								  case when up.response_option_id = p1.poll_option_id  then 1 else 0 end as user_voted,
								  up.ans as user_answer_id				  
					 from   lablsg_v1.lablsg_v1_poll_option p1
					 left join lablsg_v1.lablsg_v1_whatsapp_poll_response up on p.poll_id = up.poll_id and up.response_option_id= p1.poll_option_id
												  and up.mobile_no = v_mobile_no							  
					 where  p1.poll_id = p.poll_id
					)row ) as poll_option
						  from   lablsg_v1.lablsg_v1_poll p
						 inner join lablsg_v1.lablsg_v1_asset_list  al on al.asset_id=p.poll_id and al.asset_type_id=6
						  where  p.poll_id in(select poll_id
											from   unnest(v_pollidarr) U(poll_id))
											order by created_date desc)tab;
raise notice 'v_pollidarr %',v_pollidarr;
raise notice 'v_mobile_no %',v_mobile_no;

		p_poll_data := jsonb_set(p_poll_data,'{additional_info}',(v_ad_info::jsonb),true);
	
	
	if p_poll_data is null THEN
    

	
	p_poll_data:='{"data":null,
  "additional_info": {"total_poll_correct_ans": "'||coalesce(v_total_correct_ans::text,'0')||'",
                      "total_poll_wrong_ans": "'||coalesce(v_total_wrong_ans::text,'0')||'",
					"total_poll": "'||coalesce(v_total_poll::text,'0')||'",
                    "all_poll_answered": "'||coalesce(v_total_poll_ans,'False')||'"                        
}}';	
	end if;
end;
$$;


--
