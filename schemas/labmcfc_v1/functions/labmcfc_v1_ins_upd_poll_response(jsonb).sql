-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc_v1
-- Object: labmcfc_v1_ins_upd_poll_response(jsonb)
-- Type: FUNCTION

-- Name: labmcfc_v1_ins_upd_poll_response(jsonb); Type: FUNCTION; Schema: labmcfc_v1; Owner: -
--

CREATE FUNCTION labmcfc_v1.labmcfc_v1_ins_upd_poll_response(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
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
begin
	
    select current_timestamp at time zone 'utc' into v_currenttimestamp;
    
    select v_json->'data'->>'poll_id', v_json->'data'->>'polloption', v_json->'data'->>'user_guid'
    into v_poll_id, v_polldatajson, v_userguid;
    
	select v_polldatajson->>'poll_option_id'
	into v_poll_option_id;
	
    select user_id
    into strict v_userid
    from labmcfc_v1.labmcfc_v1_web_user
    where user_guid = v_userguid;
	
	select no_of_ans_allowed,poll_desc into v_no_of_ans_allowed,v_poll_desc
	from labmcfc_v1.labmcfc_v1_poll
	where poll_id=v_poll_id;
    
    select count(1)
    into v_uservotecount
    from labmcfc_v1.labmcfc_v1_user_poll_response
    where poll_id = v_poll_id
	--and response_option_id =v_poll_option_id
    and user_id = v_userid;
    
    --if v_uservotecount < 1 then
      if (v_poll_desc::json->>'is_active')::int=1 then
        if v_polldatajson is not null then
    	
        	for v_polldata in select * from json_array_elements(v_polldatajson)
        	loop
            
            	select v_polldata->>'option_id',v_polldata->>'rating',v_polldata->>'score'
				,v_polldata->>'player_id',v_polldata->>'wickets',v_polldata->>'image_path'
				,v_polldata->>'video_path',v_polldata->>'extra',v_polldata->>'answer_id'
            	into v_option_id,v_player_rating,v_score,v_player_id,v_wickets,v_image_path,
				v_video_path,v_extra,v_ans;
            	
            	if not exists(select 1 from labmcfc_v1.labmcfc_v1_user_poll_response
				where user_id=v_userid and poll_id=v_poll_id and response_option_id=v_option_id)
				or (v_poll_desc::json->>'is_update')::int !=1
                then
				  raise notice 'poll insert v_no_of_ans_allowed: % ',  v_no_of_ans_allowed ;
				  raise notice 'poll insert v_uservotecount: % ',  v_uservotecount ;
				    if (v_no_of_ans_allowed>v_uservotecount)
					then
				
					insert into labmcfc_v1.labmcfc_v1_poll_response(poll_response_id,poll_id,response_option_id,created_date,updated_date,created_by,updated_by,
													  is_active,is_deleted,is_published,poll_response_guid,response_count,ans)
					values(nextval('labmcfc_v1.seq_labmcfc_v1_poll_response_id'),v_poll_id,v_option_id,v_currenttimestamp,v_currenttimestamp,1,1,1,0,1,
						   uuid_generate_v4(),1,v_ans);
					
					 insert into labmcfc_v1.labmcfc_v1_user_poll_response(user_poll_response_id,poll_id,response_option_id,user_id,response_date,player_rating,
																score,player_id,wickets,image_path,video_path,extra,ans)
					values(nextval('labmcfc_v1.seq_labmcfc_v1_user_poll_response_id'),v_poll_id,v_option_id,v_userid,v_currenttimestamp,v_player_rating,
														 v_score,v_player_id,v_wickets,v_image_path,v_video_path,v_extra,v_ans);
				   
			        end if;
			   else 
			    raise notice 'poll update v_no_of_ans_allowed: % ',  v_no_of_ans_allowed ;
				  raise notice 'poll update v_uservotecount: % ',  v_uservotecount ;
			           if (v_poll_desc::json->>'is_update')::int=1
			           then 
					   update labmcfc_v1.labmcfc_v1_user_poll_response
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
    
    select sum(response_count)
    into v_total_responses
    from labmcfc_v1.labmcfc_v1_poll_response
    where poll_id = v_poll_id;
    
    if p_result = 1 then
    	
		select ('{"data":'||string_agg((row_to_json(row))::text,',')||'}')::jsonb
		from(select v_poll_id poll_id, v_total_responses as total_responses,
             (select array_to_json(array_agg(poll_option)) as poll_option
              from(select response_option_id as option_id, sum(response_count) as response_count
                   from labmcfc_v1.labmcfc_v1_poll_response
                   where poll_id = v_poll_id
                   group by response_option_id)poll_option))row
		into p_data;
        
	else
    	
        p_data := '{"data":{"total_responses":null,"poll_option":null,"poll_id":null}}'::jsonb;
     
    end if;
  
/*exception
	when others then
    	p_result := -1;
		p_data := '{"data":{"total_responses":null,"poll_option":null,"poll_id":null}}'::jsonb;
	*/
end;

$$;


--
