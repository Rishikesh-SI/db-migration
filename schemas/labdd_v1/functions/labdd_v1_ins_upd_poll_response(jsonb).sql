-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1
-- Object: labdd_v1_ins_upd_poll_response(jsonb)
-- Type: FUNCTION

-- Name: labdd_v1_ins_upd_poll_response(jsonb); Type: FUNCTION; Schema: labdd_v1; Owner: -
--

CREATE FUNCTION labdd_v1.labdd_v1_ins_upd_poll_response(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
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
    v_answer_id numeric;
begin

		insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
	   log_error_message,log_guid,error_json,created_date,client_name,log_type)
	   values (nextval('siwaf.seq_siwaf_api_error_log_id'),'ins_upd_poll','logs',uuid_generate_v4(),p_json,current_timestamp,'labdd_v1','logs');

	
    select current_timestamp at time zone 'utc' into v_currenttimestamp;
	
	raise notice 'innnn';
    
    select v_json->'data'->>'poll_id', v_json->'data'->>'polloption', v_json->'data'->>'user_guid'
    into v_poll_id, v_polldatajson, v_userguid;
	
	raise notice '1.poll_id%',v_poll_id;
	raise notice 'v_polldatajson%',v_polldatajson;
	 raise notice 'v_userguid%',v_userguid;
	
    
	select v_polldatajson->>'poll_option_id'
	into v_poll_option_id;
	
	raise notice ' 1.innnn';
    raise notice 'option id%',v_poll_option_id;
	
    select user_id
    into  v_userid
    from labdd_v1.labdd_v1_web_user
    where user_guid = v_userguid;
	
	raise notice 'v_userid%',v_userid;
	
		raise notice '2.innnn';

	
	/*select no_of_ans_allowed
	from labdd_v1.labdd_v1_poll
	where poll_id=v_poll_id
	into v_no_of_ans_allowed;*/
	
    
    select count(1)
    into v_uservotecount
    from labdd_v1.labdd_v1_user_poll_response
    where poll_id = v_poll_id
	and response_option_id =v_poll_option_id
    and user_id = v_userid;
	
	raise notice '3.v_userid%',v_poll_option_id;
    
    if v_uservotecount < 1 then
    	raise notice '3. innnn';
		
        if v_polldatajson is not null then
		
		    raise notice 'for polldata';
    	
        	for v_polldata in select * from json_array_elements(v_polldatajson)
        	loop
			
			
			raise notice 'polldata%',v_polldata;
            	
				raise notice '4. innnn';

            		select v_polldata->>'option_id',v_polldata->>'rating',v_polldata->>'score'
				,v_polldata->>'player_id',v_polldata->>'wickets',v_polldata->>'image_path'
				,v_polldata->>'video_path',v_polldata->>'extra',v_polldata->>'answer_id'
            	into v_option_id,v_player_rating,v_score,v_player_id,v_wickets,v_image_path,
				v_video_path,v_extra,v_answer_id;
            	
            	
          		insert into labdd_v1.labdd_v1_poll_response(poll_response_id,poll_id,response_option_id,created_date,updated_date,created_by,updated_by,
                                                  is_active,is_deleted,is_published,poll_response_guid,response_count)
         		values(nextval('labdd_v1.seq_labdd_v1_poll_response_id'),v_poll_id,v_option_id,v_currenttimestamp,v_currenttimestamp,1,1,1,0,1,
                       uuid_generate_v4(),1);
				
                 insert into labdd_v1.labdd_v1_user_poll_response(user_poll_response_id,poll_id,response_option_id,user_id,response_date,player_rating,
															score,player_id,wickets,image_path,video_path,extra,ans)
            	values(nextval('labdd_v1.seq_labdd_v1_user_poll_response_id'),v_poll_id,v_option_id,v_userid,v_currenttimestamp,v_player_rating,
					                                 v_score,v_player_id,v_wickets,v_image_path,v_video_path,v_extra,v_answer_id);
                
			end loop;
            
		end if;
    	
    	p_result := 1;
		
    else
    	
        p_result := 0;
        
    end if;
    
    select sum(response_count)
    into v_total_responses
    from labdd_v1.labdd_v1_poll_response
    where poll_id = v_poll_id;
    
    if p_result = 1 then
    	
		select ('{"data":'||string_agg((row_to_json(row))::text,',')||'}')::jsonb
		from(select v_poll_id poll_id, v_total_responses as total_responses,
             (select array_to_json(array_agg(poll_option)) as poll_option
              from(select response_option_id as option_id, sum(response_count) as response_count
                   from labdd_v1.labdd_v1_poll_response
                   where poll_id = v_poll_id
                   group by response_option_id)poll_option))row
		into p_data;
        
	else
    	
        p_data := '{"data":{"total_responses":null,"poll_option":null,"poll_id":null}}'::jsonb;
     
    end if;
  
-- exception
-- 	when others then
--     	p_result := -1;
-- 		p_data := '{"data":{"total_responses":null,"poll_option":null,"poll_id":null}}'::jsonb;
	
end;

$$;


--
