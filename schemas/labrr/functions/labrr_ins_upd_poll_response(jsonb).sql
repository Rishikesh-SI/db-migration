-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_ins_upd_poll_response(jsonb)
-- Type: FUNCTION

-- Name: labrr_ins_upd_poll_response(jsonb); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_ins_upd_poll_response(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
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
    v_contact_id numeric;
	v_ans_array jsonb;
	i numeric;
	v_ans_array1 numeric[];
	v_poll_desc jsonb;
	v_answer_id numeric;
	v_ans numeric;
	--v_answer_array n
	v_status numeric;
begin
	
    select current_timestamp at time zone 'utc' into v_currenttimestamp;
  
  	insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
	log_error_message,log_guid,error_json,created_date,client_name,log_type)
	values (nextval('siwaf.seq_siwaf_api_error_log_id'),'input-ins_upd_poll_response','logs',uuid_generate_v4(),p_json,current_timestamp,'labrr','logs');
  
  
    select v_json->'data'->>'poll_id', v_json->'data'->>'polloption', v_json->'data'->>'user_guid',v_json->'data'->>'contact_id'
    into v_poll_id, v_polldatajson, v_userguid,v_contact_id;
    
	select v_polldatajson->>'poll_option_id'
	into v_poll_option_id;
	
	raise notice 'v_poll_option_id %',v_poll_option_id;

	
    select user_id
    into  v_userid
   from labrr.labrr_web_user
    where user_guid = v_userguid;

	select poll_desc into v_poll_desc
	from labrr.labrr_poll
	where poll_id=v_poll_id;
	
	select no_of_ans_allowed
	from labrr.labrr_poll
	where poll_id=v_poll_id
	into v_no_of_ans_allowed;
    
  select count(1)
  into v_uservotecount
  from labrr.labrr_user_poll_response
   where poll_id = v_poll_id
	--and response_option_id =v_poll_option_id
   and user_id = v_userid;
    
   -- if v_uservotecount < 1 then
   	raise notice 'v_poll_desc %',v_poll_desc;
	
	raise notice 'v_userid %',v_userid;
    
if v_contact_id is not null then
    
	if not exists(select 1 from labrr.labrr_poll_response where contact_id=v_contact_id and poll_id=v_poll_id) then 
		if (v_poll_desc::json->>'is_active')::int=1 then
		raise notice 'v_ans_array1 %',v_ans_array1;
			if v_polldatajson is not null then

				for v_polldata in select * from json_array_elements(v_polldatajson)
				loop

					v_ans_array1:= null;

					select v_polldata->>'option_id',v_polldata->>'rating',v_polldata->>'score'
					,v_polldata->>'player_id',v_polldata->>'wickets',v_polldata->>'image_path'
					,v_polldata->>'video_path',v_polldata->>'extra'--,v_polldata->>'answer_id'
					into v_option_id,v_player_rating,v_score,v_player_id,v_wickets,v_image_path,
					v_video_path,v_extra; --v_answer_id

					if v_poll_desc::json->>'type'='2' or v_poll_desc::json->>'type'='1' then

						select v_polldata->>'answer_id' into v_answer_id;

						--v_ans_array1:= array_append(v_ans_array1,v_answer_id);

					elsif v_poll_desc::json->>'type'='3' then	
					raise notice 'abc';
						select v_polldata->>'answer_id' into v_ans_array;

						for i in select * from jsonb_array_elements(v_ans_array)
						loop
							v_ans_array1 := array_append(v_ans_array1,i);
						end loop;

					end if;

			if /*v_contact_id is null THEN

					insert into labrr.labrr_poll_response(poll_response_id,poll_id,response_option_id,created_date,updated_date,created_by,updated_by,
													  is_active,is_deleted,is_published,poll_response_guid,response_count)
					values(nextval('labrr.seq_labrr_poll_response_id'),v_poll_id,v_option_id,v_currenttimestamp,v_currenttimestamp,1,1,1,0,1,
						   uuid_generate_v4(),1);

					 insert into labrr.labrr_user_poll_response(user_poll_response_id,poll_id,response_option_id,user_id,response_date,player_rating,
																score,player_id,wickets,image_path,video_path,extra,poll_ans)
					values(nextval('labrr.seq_labrr_user_poll_response_id'),v_poll_id,v_option_id,v_userid,v_currenttimestamp,v_player_rating,
														 v_score,v_player_id,v_wickets,v_image_path,v_video_path,v_extra,v_ans_array1);

		elsif*/ v_contact_id is not null then

						insert into labrr.labrr_poll_response(poll_response_id,poll_id,response_option_id,created_date,updated_date,created_by,updated_by,
													  is_active,is_deleted,is_published,poll_response_guid,response_count,contact_id,answer_id,poll_ans)
					values(nextval('labrr.seq_labrr_poll_response_id'),v_poll_id,v_option_id,v_currenttimestamp,v_currenttimestamp,1,1,1,0,1,
						   uuid_generate_v4(),1,v_contact_id,v_answer_id,v_ans_array1);

					 insert into labrr.labrr_user_poll_response(user_poll_response_id,poll_id,response_option_id,user_id,response_date,player_rating,
																score,player_id,wickets,image_path,video_path,extra)
					values(nextval('labrr.seq_labrr_user_poll_response_id'),v_poll_id,v_option_id,v_userid,v_currenttimestamp,v_player_rating,
														 v_score,v_player_id,v_wickets,v_image_path,v_video_path,v_extra);

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
	 
else 

if v_userid is not null then
      if (v_poll_desc::json->>'is_active')::int=1 and current_timestamp between to_timestamp(v_poll_desc::json->>'start_date'::text, 'DD-MM-YYYY hh24:mi GMT+00:00')::timestamp
  					and to_timestamp(v_poll_desc::json->>'end_date'::text, 'DD-MM-YYYY hh24:mi GMT+00:00')::timestamp then
raise notice '1';

		if v_polldatajson is not null then

				for v_polldata in select * from json_array_elements(v_polldatajson)
				loop

					select v_polldata->>'option_id',v_polldata->>'rating',v_polldata->>'score'
					,v_polldata->>'player_id',v_polldata->>'wickets',v_polldata->>'image_path'
					,v_polldata->>'video_path',v_polldata->>'extra',v_polldata->>'answer_id'
					into v_option_id,v_player_rating,v_score,v_player_id,v_wickets,v_image_path,
					v_video_path,v_extra,v_ans;

					if not exists(select 1 from labrr.labrr_user_poll_response
					where user_id=v_userid and poll_id=v_poll_id and response_option_id=v_option_id)
					or (v_poll_desc::json->>'is_update')::int !=1
					then
						  
						if (v_no_of_ans_allowed>v_uservotecount)
						then
						raise notice '4';
							--raise notice 'country:%',v_country;
							insert into labrr.labrr_poll_response(poll_response_id,poll_id,response_option_id,created_date,updated_date,created_by,updated_by,
															  is_active,is_deleted,is_published,poll_response_guid,response_count,ans)
							values(nextval('labrr.seq_labrr_poll_response_id'),v_poll_id,v_option_id,v_currenttimestamp,v_currenttimestamp,1,1,1,0,1,
								   uuid_generate_v4(),1,v_ans);

							 insert into labrr.labrr_user_poll_response(user_poll_response_id,poll_id,response_option_id,user_id,response_date,player_rating,
																		score,player_id,wickets,image_path,video_path,extra,ans)
							values(nextval('labrr.seq_labrr_user_poll_response_id'),v_poll_id,v_option_id,v_userid,v_currenttimestamp,v_player_rating,
																 v_score,v_player_id,v_wickets,v_image_path,v_video_path,v_extra,v_ans);
							  p_result:=1;
							  v_status := 1;
						else 
							p_result:=1;	
							v_status := 0;
						end if;

					else 
					raise notice '2';
					v_status := 0;
						p_result:=0;
					
					end if;

					end loop;

		   end if;	

	

		end IF;
end if;

end if;
    
    select sum(response_count)
    into v_total_responses
    from labrr.labrr_poll_response
    where poll_id = v_poll_id;
    
    if p_result = 1 then
	
	if v_userid is not null THEN
		select ('{"data":'||string_agg((row_to_json(row))::text,',')||'}')::jsonb
		from(select v_poll_id poll_id, v_total_responses as total_responses,v_status as status,
             (select array_to_json(array_agg(poll_option)) as poll_option
              from(select p1.poll_option_id as option_id,coalesce ((select  sum(response_count)
					from labrr.labrr_poll_response where poll_id=	p1.poll_id
					and   response_option_id= p1.poll_option_id),0) as response_count,
				   case when up.response_option_id = p1.poll_option_id then 1 else 0 end as user_voted
               	   from labrr.labrr_poll_option p1 
				   left join labrr.labrr_user_poll_response up on  p1.poll_option_id= up.response_option_id
				   and up.user_id = v_userid
                   where p1.poll_id = v_poll_id
                   group by p1.poll_option_id,up.response_option_id)poll_option))row
	
		into p_data;
	
		
	ELSE
    	
		select ('{"data":'||string_agg((row_to_json(row))::text,',')||'}')::jsonb
		from(select v_poll_id poll_id, v_total_responses as total_responses,v_status as status,
             (select array_to_json(array_agg(poll_option)) as poll_option
              from(select p1.poll_option_id as option_id,coalesce ((select  sum(response_count)
					from labrr.labrr_poll_response where poll_id=	p1.poll_id
					and   response_option_id= p1.poll_option_id),0) as response_count,
				   case when up.response_option_id = p1.poll_option_id then 1 else 0 end as user_voted
               	   from labrr.labrr_poll_option p1 
				   left join labrr.labrr_user_poll_response up on  p1.poll_option_id= up.response_option_id
				   and up.user_id = v_userid
                   where p1.poll_id = v_poll_id
                   group by p1.poll_option_id,up.response_option_id)poll_option))row
	
		into p_data;
     end if;   
	else
    	
--         p_data := '{"data":{"total_responses":null,"poll_option":null,"poll_id":null}}'::jsonb;

		select ('{"data":'||string_agg((row_to_json(row))::text,',')||'}')::jsonb
		from(select v_poll_id poll_id, v_total_responses as total_responses,v_status as status,
             (select array_to_json(array_agg(poll_option)) as poll_option
              from(select p1.poll_option_id as option_id,coalesce ((select  sum(response_count)
					from labrr.labrr_poll_response where poll_id=	p1.poll_id
					and   response_option_id= p1.poll_option_id),0) as response_count,
				   case when up.response_option_id = p1.poll_option_id then 1 else 0 end as user_voted
               	   from labrr.labrr_poll_option p1 
				   left join labrr.labrr_user_poll_response up on  p1.poll_option_id= up.response_option_id
				   and up.user_id = v_userid
                   where p1.poll_id = v_poll_id
                   group by p1.poll_option_id,up.response_option_id)poll_option))row
	
		into p_data;

     
    end if;
/*  
exception
	when others then
    	p_result := -1;
		p_data := '{"data":{"total_responses":null,"poll_option":null,"poll_id":null}}'::jsonb;
*/	
end;

$$;


--
