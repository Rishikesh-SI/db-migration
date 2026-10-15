-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: labgsoc_ins_upd_contest_response(jsonb)
-- Type: FUNCTION

-- Name: labgsoc_ins_upd_contest_response(jsonb); Type: FUNCTION; Schema: labgsoc; Owner: -
--

CREATE FUNCTION labgsoc.labgsoc_ins_upd_contest_response(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
    v_currenttimestamp timestamp;
    v_json jsonb := p_json;
    v_contest_id numeric;
	v_contestdatajson json;
    v_userguid character varying(256);
    v_userid numeric;
    v_uservotecount numeric;
    v_contestdata json;
    v_option_id numeric;
    v_rows numeric;
    v_contest_response_id numeric;
    v_total_responses numeric;
	v_player_rating numeric;
    v_contest_questions_id numeric;
	v_no_of_ans_allowed numeric;
    v_score numeric;
	v_player_id numeric;
	v_wickets numeric;
	v_image_path character varying(1000);
	v_video_path character varying(1000);
	v_extra character varying(1000); 
    v_answer_id numeric;
	v_answerid numeric;
	v_contest_option_id numeric;
	v_answers jsonb;
	v_contest_answers jsonb;
	v_answer_type text;
begin


select current_timestamp at time zone 'utc' into v_currenttimestamp;

	
-- insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
-- log_error_message,log_guid,error_json,created_date,client_name,log_type)
-- values (nextval('siwaf.seq_siwaf_api_error_log_id'),'ins_upd_contest_response','logs',uuid_generate_v4(),p_json,current_timestamp,'labgsoc','logs');
	
    
    select v_json->'data'->>'contest_id', v_json->'data'->'contest_questions'->>'answer_id' ,  v_json->'data'->'contest_questions'->>'question_id' ,v_json->'data'->>'contest_questions', v_json->'data'->>'user_guid'
    into v_contest_id,v_answer_id, v_contest_option_id , v_contestdatajson, v_userguid;

	raise notice 'v_contestdatajson%' , v_contestdatajson;
    
	select v_contestdatajson->>'contest_questions_id'
	into v_contest_questions_id;
	
    select user_id
    into  v_userid
    from labgsoc.labgsoc_web_user
    where user_guid = v_userguid;
	
	/*select no_of_ans_allowed
	from labgsoc.labgsoc_contest
	where contest_id=v_contest_id
	into v_no_of_ans_allowed;*/
    
    select count(1)
    into v_uservotecount
    from labgsoc.labgsoc_user_contest_response
    where contest_id = v_contest_id
	and response_option_id =v_contest_questions_id
    and user_id = v_userid;
    
    if v_uservotecount < 1 then
    	
        if v_contestdatajson is not null then
    	
        	for v_contestdata in select * from json_array_elements(v_contestdatajson)
        	loop

			raise notice 'sachin';
            
            	select v_contestdata->>'question_id',v_contestdata->>'rating',v_contestdata->>'score'
				,v_contestdata->>'player_id',v_contestdata->>'wickets',v_contestdata->>'image_path'
				,v_contestdata->>'video_path',v_contestdata->>'extra',v_contestdata->>'answer_id'
            	into v_option_id,v_player_rating,v_score,v_player_id,v_wickets,v_image_path,
				v_video_path,v_extra,v_answer_id;

				select v_contestdata ->> 'answer_type' into v_answer_type;

			
				select v_contestdata ->> 'contest_answers' into v_contest_answers;

				if v_answer_type = 'Input' then 

				raise notice 'v_answer_type121233 %' , v_answer_type;
							select json_agg(answer_id) into v_answers from
							(SELECT obj.value->>'correct_answer_id' as answer_id  
							from jsonb_array_elements(v_contest_answers::jsonb) obj(value))a ;
							
	         else    	
					raise notice 'v_answer_type%' , v_answer_type;
					
							select json_agg(answer_id::int) into v_answers from
							(SELECT obj.value->>'correct_answer_id' as answer_id  
							from jsonb_array_elements(v_contest_answers::jsonb) obj(value))a ;

				-- 		else

				-- 		select v_contestdata -> 'contest_answers' into v_contest_answers;
                  
             end if;

				raise notice 'v_option_id %' , v_option_id ;

				if not exists (select 1 from labgsoc.labgsoc_user_contest_response where contest_id = v_contest_id and response_option_id = v_option_id and user_id = v_userid )
				then 
				

			
				raise notice 'v_answers1%', v_answers;
                

				
            	
          		insert into labgsoc.labgsoc_contest_response(contest_response_id,contest_id,response_option_id,created_date,updated_date,created_by,updated_by,
                                                  is_active,is_deleted,is_published,contest_response_guid,response_count)
         		values(nextval('labgsoc.seq_labgsoc_contest_response_id'),v_contest_id,v_contest_option_id,v_currenttimestamp,v_currenttimestamp,1,1,1,0,1,
                       uuid_generate_v4(),1);
					   
				
                 insert into labgsoc.labgsoc_user_contest_response(user_contest_response_id,contest_id,response_option_id,user_id,response_date,player_rating,
															score,player_id,wickets,image_path,video_path,extra,ans)
            	values(nextval('labgsoc.seq_labgsoc_user_contest_response_id'),v_contest_id,v_option_id,v_userid,v_currenttimestamp,v_player_rating,
					                                 v_score,v_player_id,v_wickets,v_image_path,v_video_path,v_extra,v_answers);

          
			else 

			

			   -- select v_contestdata -> 'contest_answers' ->>'correct_answer_id' into v_answers;

			   raise notice 'v_answers%' , v_answers;

		   		update labgsoc.labgsoc_user_contest_response
				  set ans = v_answers
				 where contest_id = v_contest_id and response_option_id = v_option_id;
			end if ;

			end loop;

			 
            
		end if;
    	
    	p_result := 1;
		
    else
    	
        p_result := 0;
        
    end if;
    
    select sum(response_count)
    into v_total_responses
    from labgsoc.labgsoc_contest_response
    where contest_id = v_contest_id;
    
    if p_result = 1 then
    	
		select ('{"data":'||string_agg((row_to_json(row))::text,',')||'}')::jsonb
		from(select v_contest_id contest_id, v_total_responses as total_responses,
             (select array_to_json(array_agg(contest_option)) as contest_option
              from(select response_option_id as option_id, sum(response_count) as response_count
                   from labgsoc.labgsoc_contest_response
                   where contest_id = v_contest_id
                   group by response_option_id)contest_option))row
		into p_data;
        
	else
    	
        p_data := '{"data":{"total_responses":null,"contest_option":null,"contest_id":null}}'::jsonb;
     
    end if;
  
-- exception
-- 	when others then
--     	p_result := -1;
-- 		p_data := '{"data":{"total_responses":null,"contest_option":null,"contest_id":null}}'::jsonb;
	
end;

$$;


--
