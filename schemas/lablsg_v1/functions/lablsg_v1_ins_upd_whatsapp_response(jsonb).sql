-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg_v1
-- Object: lablsg_v1_ins_upd_whatsapp_response(jsonb)
-- Type: FUNCTION

-- Name: lablsg_v1_ins_upd_whatsapp_response(jsonb); Type: FUNCTION; Schema: lablsg_v1; Owner: -
--

CREATE FUNCTION lablsg_v1.lablsg_v1_ins_upd_whatsapp_response(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	
    v_currenttimestamp timestamp;
    v_json jsonb := p_json;
    v_poll_id numeric;
	v_polldatajson json;
    v_mobile_no character varying(256);
    v_userid numeric;
    v_uservotecount numeric;
    v_polldata json;
    v_option_id numeric;
    v_rows numeric;
    v_poll_response_id numeric;
    v_total_responses numeric;
	v_player_rating numeric;
    v_poll_option_id numeric;
	v_no_of_ans_allowed numeric;
    v_score numeric;
	v_player_id numeric;
	v_wickets numeric;
	v_image_path character varying(1000);
	v_video_path character varying(1000);
	v_extra character varying(1000); 
	v_poll_desc varchar(1000);
	v_ans numeric;
	
	v_ad_info jsonb;
	v_total_wrong_ans numeric;
	v_total_correct_ans numeric;
    v_total_poll numeric;
    v_total_poll_ans boolean;
	v_entityrole_mapid numeric;
begin
	
    select current_timestamp at time zone 'utc' into v_currenttimestamp;
    
    select v_json->'data'->>'poll_id', v_json->'data'->>'polloption', v_json->'data'->'user_info'->>'mobile_no'
    into v_poll_id, v_polldatajson, v_mobile_no;
    
	select v_polldatajson->>'poll_option_id'
	into v_poll_option_id;
    
  --raise notice 'v_mobile_no %',v_mobile_no;

	
 --   select user_id
  --  into v_userid
   -- from lablsg_v1.lablsg_v1_web_user
    --where mobile_no = v_mobile_no;
	
	select entity_role_map_id into v_entityrole_mapid from lablsg_v1.lablsg_v1_asset_entity_map where asset_id=v_poll_id and asset_type_id=6;
	
		CREATE TEMP TABLE poll_data AS 
	(select aem.asset_id as poll_id from lablsg_v1.lablsg_v1_asset_entity_map aem join
		lablsg_v1.lablsg_v1_poll p on p.poll_id=aem.asset_id and p.poll_desc::jsonb->>'is_active'='1' 
	 and p.is_quiz=1 where aem.entity_role_map_id=v_entityrole_mapid and aem.asset_type_id=6
	);	
    
    raise notice 'v_userid:%',v_userid;
	
	select no_of_ans_allowed,poll_desc into v_no_of_ans_allowed,v_poll_desc
	from lablsg_v1.lablsg_v1_poll
	where poll_id=v_poll_id;
  --  raise notice 'v_userid %',v_userid;
    raise notice 'v_no_of_ans_allowed %',v_no_of_ans_allowed;
    raise notice 'v_poll_desc %',v_poll_desc;  
    
    select count(1)
    into v_uservotecount
    from lablsg_v1.lablsg_v1_whatsapp_poll_response
    where poll_id = v_poll_id
	--and response_option_id =v_poll_option_id
    and mobile_no = v_mobile_no;
    
    
    if v_mobile_no is not null then 
    --if v_uservotecount < 1 then
      --if (v_poll_desc::json->>'is_active')::int=1 then
        if v_polldatajson is not null then
    	
        	for v_polldata in select * from json_array_elements(v_polldatajson)
        	loop
            
            	select v_polldata->>'option_id',v_polldata->>'rating',v_polldata->>'score'
				,v_polldata->>'player_id',v_polldata->>'wickets',v_polldata->>'image_path'
				,v_polldata->>'video_path',v_polldata->>'extra',v_polldata->>'answer_id'
            	into v_option_id,v_player_rating,v_score,v_player_id,v_wickets,v_image_path,
				v_video_path,v_extra,v_ans;
            	
            	if not exists(select 1 from lablsg_v1.lablsg_v1_whatsapp_poll_response
				where mobile_no=v_mobile_no and poll_id=v_poll_id and response_option_id=v_option_id)
				or (v_poll_desc::json->>'is_update')::int !=1
                then
				    if (v_no_of_ans_allowed>v_uservotecount)
					then
                    
                    if exists (select 1 from lablsg_v1.lablsg_v1_poll_option where poll_id=v_poll_id and poll_option_id=v_option_id and is_ans=1) then
                        v_ans:=1;
                    else
                        v_ans:=0;
                    end if;
									
					 insert into lablsg_v1.lablsg_v1_whatsapp_poll_response(whatsapp_poll_response_id,poll_id,response_option_id,mobile_no,response_date,player_rating,
																score,player_id,wickets,image_path,video_path,extra,ans,response_count)
					values(nextval('lablsg_v1.seq_lablsg_v1_whatsapp_poll_response_id'),v_poll_id,v_option_id,v_mobile_no,v_currenttimestamp,v_player_rating,
														 v_score,v_player_id,v_wickets,v_image_path,v_video_path,v_extra,v_ans,1);
				   
			        end if;
			   else 
			    raise notice 'poll update v_no_of_ans_allowed: % ',  v_no_of_ans_allowed ;
				  raise notice 'poll update v_uservotecount: % ',  v_uservotecount ;
			           if (v_poll_desc::json->>'is_update')::int=1
			           then 
					   update lablsg_v1.lablsg_v1_whatsapp_poll_response
					   set 
						 image_path=v_image_path,extra=v_extra
					   where mobile_no=v_mobile_no and poll_id=v_poll_id and response_option_id=v_option_id;
				       end if;
			   end if;
			   
			end loop;
            
		end if;
    	
    	p_result := 1;
		
--    else
    	
  --      p_result := 0;
        
   -- end if;
    
    select sum(response_count)
    into v_total_responses
    from lablsg_v1.lablsg_v1_whatsapp_poll_response
    where poll_id = v_poll_id;
    
    else
        p_result = 0;
    
    end if;
	
		select sum(case when coalesce(ans,0)=0 then 1 end) as total_wrong_ans, 
    sum(case when ans=1 then 1 end) as total_correct_ans
    from lablsg_v1.lablsg_v1_whatsapp_poll_response 
    where mobile_no = v_mobile_no  and poll_id in 
    (select poll_id from poll_data) into v_total_wrong_ans,v_total_correct_ans; 

    select count(poll_id) into v_total_poll from poll_data;

    select case when count(1)=v_total_poll then 'True' else 'False' end into v_total_poll_ans 
    from lablsg_v1.lablsg_v1_whatsapp_poll_response 
    where mobile_no=v_mobile_no and poll_id in 
        (select poll_id from poll_data);
		
			  v_ad_info = '{
					"total_poll_correct_ans": "'||coalesce(v_total_correct_ans::text,'0')||'",
                     "total_poll_wrong_ans": "'||coalesce(v_total_wrong_ans::text,'0')||'",
					"total_poll": "'||coalesce(v_total_poll::text,'0')||'",
                    "all_poll_answered": "'||coalesce(v_total_poll_ans,'False')||'"
				}' ;
    
    if p_result = 1 then
    	
		select ('{"data":'||string_agg((row_to_json(row))::text,',')||'}')::jsonb
		from(select v_poll_id poll_id, v_total_responses as total_responses,
             (select array_to_json(array_agg(poll_option)) as poll_option
              from(select po.poll_option_id, coalesce(sum(response_count),0) as response_count
                   from lablsg_v1.lablsg_v1_poll_option po 
				   left join lablsg_v1.lablsg_v1_whatsapp_poll_response wpr
				   on po.poll_option_id = wpr.response_option_id
                   where po.poll_id = v_poll_id
                   group by po.poll_option_id)poll_option))row
		into p_data;
        
	else
    	
        p_data := '{"data":{"total_responses":null,"poll_option":null,"poll_id":null}}'::jsonb;
     
    end if;
    
	p_data := jsonb_set(p_data,'{data,additional_info}',(v_ad_info::jsonb),true);
/*  
exception
     when others then
    		 p_result := -1;
			 p_data:='{"data":null}';
			 insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
					log_error_message,log_guid,error_json,created_date,client_name,log_type)
				values ((select nextval('siwaf.seq_siwaf_api_error_log_id')),'ins_upd_whatsapp_response',
				'{"exception":""}',uuid_generate_v4(),p_json,v_currenttimestamp,'lablsg_v1','db-error');
*/
end;
$$;


--
