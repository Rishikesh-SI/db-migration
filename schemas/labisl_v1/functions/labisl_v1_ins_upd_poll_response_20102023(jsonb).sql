-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: labisl_v1_ins_upd_poll_response_20102023(jsonb)
-- Type: FUNCTION

-- Name: labisl_v1_ins_upd_poll_response_20102023(jsonb); Type: FUNCTION; Schema: labisl_v1; Owner: -
--

CREATE FUNCTION labisl_v1.labisl_v1_ins_upd_poll_response_20102023(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
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
	v_status numeric;
	v_poll_array numeric;
    --v_country character varying;
begin
	
    select current_timestamp at time zone 'utc' into v_currenttimestamp;
    v_status:=1;
    select v_json->'data'->>'poll_id', v_json->'data'->>'polloption', v_json->'data'->>'user_guid'--,v_json->'data'->>'country'
    into v_poll_id,v_polldatajson,v_userguid;--,v_country
    
	select v_polldatajson->>'poll_option_id'
	into v_poll_option_id;
    
if 	v_userguid is not null and v_userguid <>'' then
    select user_id
    into  v_userid
    from labisl_v1.labisl_v1_web_user
    where user_guid = v_userguid;
end if;	

	select no_of_ans_allowed,poll_desc into v_no_of_ans_allowed,v_poll_desc
	from labisl_v1.labisl_v1_poll
	where poll_id=v_poll_id;
    
    select count(1)
    into v_uservotecount
    from labisl_v1.labisl_v1_user_poll_response
    where poll_id = v_poll_id
    and user_id = v_userid;
    
    --if v_uservotecount < 1 then
	--raise notice 'user_id:%',v_userid;
    --raise notice 'v_poll_desc:%',v_poll_desc;
	if v_userid is not null then
      if (v_poll_desc::json->>'is_active')::int=1 then

        if v_polldatajson is not null then
    	
        	for v_polldata in select * from json_array_elements(v_polldatajson)
        	loop
            
            	select v_polldata->>'option_id',v_polldata->>'rating',v_polldata->>'score'
				,v_polldata->>'player_id',v_polldata->>'wickets',v_polldata->>'image_path'
				,v_polldata->>'video_path',v_polldata->>'extra',v_polldata->>'answer_id'
            	into v_option_id,v_player_rating,v_score,v_player_id,v_wickets,v_image_path,
				v_video_path,v_extra,v_ans;
            	
            	if not exists(select 1 from labisl_v1.labisl_v1_user_poll_response
				where user_id=v_userid and poll_id=v_poll_id and response_option_id=v_option_id)
				or (v_poll_desc::json->>'is_update')::int !=1
                then
                      --raise notice '3';
				    if (v_no_of_ans_allowed>v_uservotecount)
					then
					--raise notice '4';
                    --raise notice 'country:%',v_country;
					insert into labisl_v1.labisl_v1_poll_response(poll_response_id,poll_id,response_option_id,created_date,updated_date,created_by,updated_by,
													  is_active,is_deleted,is_published,poll_response_guid,response_count,ans)
					values(nextval('labisl_v1.seq_labisl_v1_poll_response_id'),v_poll_id,v_option_id,v_currenttimestamp,v_currenttimestamp,1,1,1,0,1,
						   uuid_generate_v4(),1,v_ans);
					
					 insert into labisl_v1.labisl_v1_user_poll_response(user_poll_response_id,poll_id,response_option_id,user_id,response_date,player_rating,
																score,player_id,wickets,image_path,video_path,extra,ans)
					values(nextval('labisl_v1.seq_labisl_v1_user_poll_response_id'),v_poll_id,v_option_id,v_userid,v_currenttimestamp,v_player_rating,
														 v_score,v_player_id,v_wickets,v_image_path,v_video_path,v_extra,v_ans);
				      v_status:=1;
					  
			        end if;
			   else 
			        --raise notice '5';
			           if (v_poll_desc::json->>'is_update')::int=1
			           then 
					   update labisl_v1.labisl_v1_user_poll_response
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
	
	v_status:=0;
    p_result:=0;
	
	end if ;
	
	
    select sum(response_count)
    into v_total_responses
    from labisl_v1.labisl_v1_poll_response
    where poll_id = v_poll_id;
    
    if p_result = 1 then
	
	if v_userid is not null THEN
		select ('{"data":'||string_agg((row_to_json(row))::text,',')||'}')::jsonb
		from(select v_poll_id poll_id, v_total_responses as total_responses,
             (select array_to_json(array_agg(poll_option)) as poll_option
              from(select p1.poll_option_id as option_id,coalesce ((select  sum(response_count)
					from labisl_v1.labisl_v1_poll_response where poll_id=	p1.poll_id
					and   response_option_id= p1.poll_option_id),0) as response_count,
				   case when up.response_option_id = p1.poll_option_id then 1 else 0 end as user_voted
               	   from labisl_v1.labisl_v1_poll_option p1 
				   left join labisl_v1.labisl_v1_user_poll_response up on  p1.poll_option_id= up.response_option_id
				   and up.user_id = v_userid
                   where p1.poll_id = v_poll_id
                   group by p1.poll_option_id,up.response_option_id)poll_option))row
	
		into p_data;
	
		
	ELSE
    	
		select ('{"data":'||string_agg((row_to_json(row))::text,',')||'}')::jsonb
		from(select v_poll_id poll_id, v_total_responses as total_responses,
             (select array_to_json(array_agg(poll_option)) as poll_option
              from(select response_option_id as option_id, sum(response_count) as response_count
                   from labisl_v1.labisl_v1_poll_response
                   where poll_id = v_poll_id
                   group by response_option_id)poll_option))row
		into p_data;
     end if;   
	else
    	
        p_data := '{"data":{"total_responses":null,"poll_option":null,"poll_id":null}}'::jsonb;
     
    end if;
  
		p_data	:= 	jsonb_set(p_data, '{data,status}', ('"'||coalesce(v_status,'0')||'"')::jsonb, true); 
        --p_data	:= 	jsonb_set(p_data, '{data,country}', ('"'||coalesce(v_country,'')||'"')::jsonb, true); 
end;
$$;


--
