-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg_v1
-- Object: lablsg_v1_ins_upd_poll_response(jsonb)
-- Type: FUNCTION

-- Name: lablsg_v1_ins_upd_poll_response(jsonb); Type: FUNCTION; Schema: lablsg_v1; Owner: -
--

CREATE FUNCTION lablsg_v1.lablsg_v1_ins_upd_poll_response(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
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
	v_status numeric:=1;
	v_ans_submitted numeric;
	v_user_info jsonb;
	v_is_quiz numeric;
begin

    select current_timestamp at time zone 'utc' into v_currenttimestamp;
    
    select v_json->'data'->>'poll_id', v_json->'data'->>'polloption', v_json->'data'->>'user_guid',v_json->'data'->>'user_info'
    into v_poll_id, v_polldatajson, v_userguid,v_user_info;
    
	select v_polldatajson->>'poll_option_id'
	into v_poll_option_id;
	
    select user_id
    into v_userid
    from lablsg_v1.lablsg_v1_web_user
    where user_guid = v_userguid;
	
    
	select no_of_ans_allowed,is_quiz
	from lablsg_v1.lablsg_v1_poll
	where poll_id=v_poll_id
	into v_no_of_ans_allowed,v_is_quiz;
    
    select count(1)
    into v_uservotecount
    from lablsg_v1.lablsg_v1_user_poll_response
    where poll_id = v_poll_id
	--and response_option_id =v_poll_option_id
    and user_id = v_userid;
	if v_userid is not null then
	
    if v_uservotecount < v_no_of_ans_allowed then
    
    if exists(select 1 from lablsg_v1.lablsg_v1_poll where poll_id=v_poll_id and poll_desc::jsonb->>'is_active'='1') then
        if v_polldatajson is not null then
    	
        	for v_polldata in select * from json_array_elements(v_polldatajson)
        	loop
            
            		select v_polldata->>'option_id',v_polldata->>'rating',v_polldata->>'score'
				,v_polldata->>'player_id',v_polldata->>'wickets',v_polldata->>'image_path'
				,v_polldata->>'video_path',v_polldata->>'extra',v_polldata->>'answer_id'
            	into v_option_id,v_player_rating,v_score,v_player_id,v_wickets,v_image_path,
				v_video_path,v_extra,v_answer_id;
            	
            	v_ans_submitted:= 1;
				
          		insert into lablsg_v1.lablsg_v1_poll_response(poll_response_id,poll_id,response_option_id,created_date,updated_date,created_by,updated_by,
                                                  is_active,is_deleted,is_published,poll_response_guid,response_count)
         		values(nextval('lablsg_v1.seq_lablsg_v1_poll_response_id'),v_poll_id,v_option_id,v_currenttimestamp,v_currenttimestamp,1,1,1,0,1,
                       uuid_generate_v4(),1);
				
                 insert into lablsg_v1.lablsg_v1_user_poll_response(user_poll_response_id,poll_id,response_option_id,user_id,response_date,player_rating,
															score,player_id,wickets,image_path,video_path,extra,ans,user_info)
            	values(nextval('lablsg_v1.seq_lablsg_v1_user_poll_response_id'),v_poll_id,v_option_id,v_userid,v_currenttimestamp,v_player_rating,
					                                 v_score,v_player_id,v_wickets,v_image_path,v_video_path,v_extra,v_answer_id,v_user_info);
													 
				v_status:=1;
                
			end loop;
            
		end if;
     else
    	
        p_result := 0;
        
    end if;   	
    
    	p_result := 1;
		
    else
    	
        p_result := 0;
        
    end if;
    
	else
    	v_status:=0;
        p_result := 0;
        
    end if;
	
    select sum(response_count)
    into v_total_responses
    from lablsg_v1.lablsg_v1_poll_response
    where poll_id = v_poll_id;
    
    if p_result = 1 then
    	
	if v_userid is not null THEN
		select ('{"data":'||string_agg((row_to_json(row))::text,',')||'}')::jsonb
		from(select v_poll_id poll_id, v_total_responses as total_responses,
		coalesce(v_ans_submitted,0) as ans_submitted,v_userguid as user_guid,
		coalesce(v_is_quiz,0) as is_quiz,
             (select array_to_json(array_agg(poll_option)) as poll_option
              from(select p1.poll_option_id as option_id,coalesce ((select  sum(response_count)
					from lablsg_v1.lablsg_v1_poll_response where poll_id=	p1.poll_id
					and   response_option_id= p1.poll_option_id),0) as response_count,
				   case when up.response_option_id = p1.poll_option_id then 1 else 0 end as user_voted
               	   from lablsg_v1.lablsg_v1_poll_option p1 
				   left join lablsg_v1.lablsg_v1_user_poll_response up on  p1.poll_option_id= up.response_option_id
				   and up.user_id = v_userid
                   where p1.poll_id = v_poll_id
                   group by p1.poll_option_id,up.response_option_id)poll_option))row
	
		into p_data;
	
		
	ELSE
    	
		select ('{"data":'||string_agg((row_to_json(row))::text,',')||'}')::jsonb
		from(select v_poll_id poll_id, v_total_responses as total_responses,
		coalesce(v_ans_submitted,0) as ans_submitted,v_userguid as user_guid,
		coalesce(v_is_quiz,0) as is_quiz,
             (select array_to_json(array_agg(poll_option)) as poll_option
              from(select response_option_id as option_id, sum(response_count) as response_count
                   from lablsg_v1.lablsg_v1_poll_response
                   where poll_id = v_poll_id
                   group by response_option_id)poll_option))row
		into p_data;
     end if;   
        
	else
    	
        p_data := '{"data":{"total_responses":null,"poll_option":null,"poll_id":null}}'::jsonb;
     
    end if;
	
	p_data	:= 	jsonb_set(p_data, '{data,status}', ('"'||coalesce(v_status,'0')||'"')::jsonb, true);
  
exception
	when others then
    	p_result := -1;
		p_data := '{"data":{"total_responses":null,"poll_option":null,"poll_id":null}}'::jsonb;
	
end;

$$;


--
