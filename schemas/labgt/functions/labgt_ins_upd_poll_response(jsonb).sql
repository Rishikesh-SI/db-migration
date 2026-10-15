-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_ins_upd_poll_response(jsonb)
-- Type: FUNCTION

-- Name: labgt_ins_upd_poll_response(jsonb); Type: FUNCTION; Schema: labgt; Owner: -
--

CREATE FUNCTION labgt.labgt_ins_upd_poll_response(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	
    v_currenttimestamp timestamp;
    v_json jsonb := p_json;
    v_poll_id numeric;
	v_polldatajson json;
    v_userguid character varying(256);
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
	v_is_quiz numeric;
	v_ans_submitted numeric;
	v_correct_ans numeric;
	v_option_json jsonb;
	v_options jsonb;
	v_ans_id numeric;
	v_incr numeric;
	v_gaming_minutes numeric;
	v_user_info jsonb;
	v_message varchar;
begin
	
    select current_timestamp at time zone 'utc' into v_currenttimestamp;
    
	insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
log_error_message,log_guid,error_json,created_date,client_name,log_type)
values (nextval('siwaf.seq_siwaf_api_error_log_id'),'input-poll_repsonse','logs',uuid_generate_v4(),p_json,current_timestamp,'labgt','logs');
	
    select v_json->'data'->>'poll_id', v_json->'data'->>'polloption', v_json->'data'->>'user_guid',v_json->'data'->'user_info'
    into v_poll_id, v_polldatajson, v_userguid,v_user_info;
    
	select option::json->>'questions' into v_option_json from labgt.labgt_poll_option where poll_id = v_poll_id limit 1;
	
	select v_polldatajson->>'poll_option_id'
	into v_poll_option_id;
	
    select user_id
    into v_userid
    from labgt.labgt_web_user
    where user_guid = v_userguid;
	
	raise notice 'v_userid %',v_userid;
	
	select no_of_ans_allowed,poll_desc,is_quiz into v_no_of_ans_allowed,v_poll_desc,v_is_quiz
	from labgt.labgt_poll
	where poll_id=v_poll_id;
    
    select count(1)
    into v_uservotecount
    from labgt.labgt_user_poll_response
    where poll_id = v_poll_id
	--and response_option_id =v_poll_option_id
    and user_id = v_userid;
    
    --if v_uservotecount < 1 then
	if v_userguid = '' then 
	v_userguid = null ;
	end if;
	
	if v_poll_desc::jsonb->>'is_contact' is null then
	
		if v_userguid is not null then
	
	if v_option_json is null then
	
		if v_userid is not null then
	    		raise notice 'v_option_json %',v_option_json;

		if (v_poll_desc::json->>'is_active')::int=1 then
        if v_polldatajson is not null then

        	for v_polldata in select * from json_array_elements(v_polldatajson)
        	loop
            
            	select v_polldata->>'option_id',v_polldata->>'rating',v_polldata->>'score'
				,v_polldata->>'player_id',v_polldata->>'wickets',v_polldata->>'image_path'
				,v_polldata->>'video_path',v_polldata->>'extra',v_polldata->>'answer_id',v_polldata->>'gaming_minutes'
            	into v_option_id,v_player_rating,v_score,v_player_id,v_wickets,v_image_path,
				v_video_path,v_extra,v_ans,v_gaming_minutes;
				
				
            	if not exists(select 1 from labgt.labgt_user_poll_response
				where user_id=v_userid and poll_id=v_poll_id and response_option_id=v_option_id)
				or (v_poll_desc::json->>'is_update')::int !=1
                then
				  
				    if (v_no_of_ans_allowed>v_uservotecount)
					then
						v_ans_submitted:= 1;
						
						if exists(select 1 from labgt.labgt_poll_option a
									join labgt.labgt_poll b
									on a.poll_id=b.poll_id
									where a.poll_id = v_poll_id and b.is_quiz = 1						
									and a.poll_option_id = v_option_id and is_ans=1)then
            	
					      v_correct_ans:=1;
					
				        end if;

						
					insert into labgt.labgt_poll_response(poll_response_id,poll_id,response_option_id,created_date,updated_date,created_by,updated_by,
													  is_active,is_deleted,is_published,poll_response_guid,response_count,ans)
					values(nextval('labgt.seq_labgt_poll_response_id'),v_poll_id,v_option_id,v_currenttimestamp,v_currenttimestamp,1,1,1,0,1,
						   uuid_generate_v4(),1,v_ans);
					
					 insert into labgt.labgt_user_poll_response(user_poll_response_id,poll_id,response_option_id,user_id,response_date,player_rating,
																score,player_id,wickets,image_path,video_path,extra,ans,gaming_minutes)
					values(nextval('labgt.seq_labgt_user_poll_response_id'),v_poll_id,v_option_id,v_userid,v_currenttimestamp,v_player_rating,
														 v_score,v_player_id,v_wickets,v_image_path,v_video_path,v_extra,v_ans,v_gaming_minutes);
				   
			        end if;
			   else 
			    
			           if (v_poll_desc::json->>'is_update')::int=1
			           then 
					   update labgt.labgt_user_poll_response
					   set 
						 image_path=v_image_path,extra=v_extra
					   where user_id=v_userid and poll_id=v_poll_id and response_option_id=v_option_id;
				       end if;
			   end if;
			   
			end loop;
            
		end if;
    	
    	p_result := 1;
		
    else
    	
        p_result := 0;
        
    end if;
	else
    	
        p_result := 0;
        
    end if;

	elsif v_option_json is not null then
	
	if v_userid is not null then
	raise notice 'v_uservotecount %',v_uservotecount;
	if (v_poll_desc::json->>'is_active')::int=1 then
	
		if v_polldatajson is not null then
				
	       	for v_polldata in select * from json_array_elements(v_polldatajson)
					
				loop
					
				select v_polldata->>'option_id',v_polldata->>'answer_id',v_polldata->>'gaming_minutes'
				into v_option_id,v_ans,v_gaming_minutes;
						
				select option::json->>'correct_ans_id' into v_ans_id
				from labgt.labgt_poll_option
				where poll_option_id=v_option_id;
					
				if not exists(select 1 from labgt.labgt_user_poll_response
				where user_id=v_userid and poll_id=v_poll_id and response_option_id=v_option_id)
				or (v_poll_desc::json->>'is_update')::int !=1
				then
						  
					if (v_no_of_ans_allowed>v_uservotecount)
					then
					
					if v_ans_id != v_ans then
						raise notice 'wrong';
						v_incr:= 1;
					else 
						v_incr:= 0;
					end if;
					
					v_ans_submitted:=1;
					
					insert into labgt.labgt_poll_response(poll_response_id,poll_id,response_option_id,created_date,updated_date,created_by,updated_by,is_active,is_deleted,is_published,poll_response_guid,response_count,ans)
					values(nextval('labgt.seq_labgt_poll_response_id'),v_poll_id,v_option_id,v_currenttimestamp,v_currenttimestamp,1,1,1,0,1,uuid_generate_v4(),1,v_ans);
							
					insert into labgt.labgt_user_poll_response(user_poll_response_id,poll_id,response_option_id,user_id,response_date,player_rating,score,player_id,wickets,image_path,video_path,extra,ans,gaming_minutes,user_info)
					values(nextval('labgt.seq_labgt_user_poll_response_id'),v_poll_id,v_option_id,v_userid,v_currenttimestamp,v_player_rating,v_score,v_player_id,v_wickets,v_image_path,v_video_path,v_extra,v_ans,v_gaming_minutes,v_user_info);
					
				    end if;	
						
				else 
						
					if (v_poll_desc::json->>'is_update')::int=1 Then 
							
					   update labgt.labgt_user_poll_response
					   set image_path=v_image_path,extra=v_extra
					   where user_id=v_userid and poll_id=v_poll_id 
					   and response_option_id=v_option_id;
							   
					end if;
							
				end if;
				
				end loop;
				raise notice 'v_incr %',v_incr;
				if v_incr = 1 then
				raise notice 'wrong';
					v_correct_ans:=0;
				elsif v_incr != 1 then
				raise notice 'right';
					v_correct_ans:=1;
				end if;
			 	p_result:=1;				
		end if;
	    else
    	
        p_result := 0;
        
    end if;
	
	else
	
		p_result:=0;
	
	end if;
		
	end if;
	
    else
    	
        p_result := 0;
        
    end if;
	
	elsif v_poll_desc::jsonb->>'is_contact' = '1' then
		raise notice '1';
		
	if not exists(select 1 from labgt.labgt_user_poll_response where v_user_info->>'mobile_no' = user_info->>'mobile_no') then
	
		for v_polldata in select * from json_array_elements(v_polldatajson)
        	loop
            
            	select v_polldata->>'option_id',v_polldata->>'answer_id' /*,v_polldata->>'rating',v_polldata->>'score'
				,v_polldata->>'player_id',v_polldata->>'wickets',v_polldata->>'image_path'
				,v_polldata->>'video_path',v_polldata->>'extra',v_polldata->>'answer_id',v_polldata->>'gaming_minutes'*/
            	into v_option_id,v_ans;
				--v_player_rating,v_score,v_player_id,v_wickets,v_image_path,
-- 				v_video_path,v_extra,v_ans,v_gaming_minutes;
				
				insert into labgt.labgt_poll_response(poll_response_id,poll_id,response_option_id,created_date,updated_date,created_by,updated_by,
													  is_active,is_deleted,is_published,poll_response_guid,response_count,ans)
					values(nextval('labgt.seq_labgt_poll_response_id'),v_poll_id,v_option_id,v_currenttimestamp,v_currenttimestamp,1,1,1,0,1,
						   uuid_generate_v4(),1,v_ans);
					
					 insert into labgt.labgt_user_poll_response(user_poll_response_id,poll_id,response_option_id,response_date,user_info,ans)
					values(nextval('labgt.seq_labgt_user_poll_response_id'),v_poll_id,v_option_id,v_currenttimestamp,v_user_info,v_ans);
			end loop;	   
			p_result := 1;
			
	else
			v_message := 'Poll Already Submitted';
			p_result := 0;
	end if;

	end if;

    select sum(response_count)
    into v_total_responses
    from labgt.labgt_poll_response
    where poll_id = v_poll_id;
    
   if p_result = 1 then
    	
		select ('{"data":'||string_agg((row_to_json(row))::text,',')||'}')::jsonb
		from(select v_poll_id poll_id, v_total_responses as total_responses, coalesce(v_is_quiz,0) as is_quiz,p_result as status,
			 coalesce(v_correct_ans,0) as is_correct_ans,coalesce(v_ans_submitted,0) as ans_submitted,v_userguid as user_guid,
             (select array_to_json(array_agg(poll_option)) as poll_option
              from(select response_option_id as option_id, sum(response_count) as response_count
                   from labgt.labgt_poll_response
                   where poll_id = v_poll_id
                   group by response_option_id)poll_option))row
		into p_data;
		
	elseif p_result = 0 then
		
		select ('{"data":'||string_agg((row_to_json(row))::text,',')||'}')::jsonb
		from(select v_poll_id poll_id, v_total_responses as total_responses,
			coalesce(v_correct_ans,0) as is_correct_ans,coalesce(v_ans_submitted,0) as ans_submitted,v_userguid as user_guid,
			 v_message as message,p_result as status,
             (select array_to_json(array_agg(poll_option)) as poll_option
              from(select response_option_id as option_id, sum(response_count) as response_count
                   from labgt.labgt_poll_response
                   where poll_id = v_poll_id
                   group by response_option_id)poll_option))row
		into p_data;
		
		else
	
        p_data := '{
					"data":
					{
					"total_responses":null,
					"poll_option":null,
					"poll_id":null
					}
					}';	
    end if;
/*
 exception
     when others then
    		 p_result := -1;
			 p_data:='{"data":{"total_responses":null,"poll_option":null,"poll_id":null}}'::jsonb;
			 insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
					log_error_message,log_guid,error_json,created_date,client_name,log_type)
				values ((select nextval('siwaf.seq_siwaf_api_error_log_id')),'ins_upd_poll_response',
				'{"exception":""}',uuid_generate_v4(),p_json,v_currenttimestamp,'labgt','poll-db-error');
*/
end;
$$;


--
