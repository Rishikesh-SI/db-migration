-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: labstmp_ins_upd_poll_response17092020(jsonb)
-- Type: FUNCTION

-- Name: labstmp_ins_upd_poll_response17092020(jsonb); Type: FUNCTION; Schema: labstmp; Owner: -
--

CREATE FUNCTION labstmp.labstmp_ins_upd_poll_response17092020(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
    v_currenttimestamp timestamp;
    v_json jsonb := p_json;
    v_poll_id numeric;
	v_polldatajson json;
    v_userguid character varying(1000);
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
	v_poll_option_count numeric;
begin
	
    select current_timestamp at time zone 'utc' into v_currenttimestamp;
    
    select v_json->'data'->>'poll_id', v_json->'data'->>'polloption', v_json->'data'->>'user_guid'
    into v_poll_id, v_polldatajson, v_userguid;
    
	select v_polldatajson->>'poll_option_id'
	into v_poll_option_id;
	--RAISE NOTICE 'user_guid: %',v_userguid;
	--RAISE NOTICE 'v_json: %',v_json;
	---RAISE NOTICE 'v_polldatajson: %',v_polldatajson;
	---v_userguid:='3844e4d0-e244-45bc-b17a-0debc3a7f932';
	--if v_userguid is not null then
	begin
    select user_id
    into strict v_userid
    from labstmp.labstmp_web_user
    where user_guid = v_userguid;
	
	select no_of_ans_allowed
	from labstmp.labstmp_poll
	where poll_id=v_poll_id
	into v_no_of_ans_allowed;
	v_uservotecount:=0;
	
	exception when no_data_found then
	v_userid:=null;
	v_no_of_ans_allowed:=null;
	
	   select count(1)
    into v_uservotecount
    from labstmp.labstmp_user_poll_response
    where poll_id = v_poll_id
    and user_id = v_userid;
	end;
   
   
 
	
    if v_uservotecount < 1 then
    	
        if v_polldatajson is not null then
    	
        	for v_polldata in select * from json_array_elements(v_polldatajson)
        	loop
			
            
            		select v_polldata->>'option_id',v_polldata->>'rating',v_polldata->>'score'
				,v_polldata->>'player_id',v_polldata->>'wickets',v_polldata->>'image_path'
				,v_polldata->>'video_path',v_polldata->>'extra'
            	into v_option_id,v_player_rating,v_score,v_player_id,v_wickets,v_image_path,
				v_video_path,v_extra;
				
				select count(1)
    into v_poll_option_count
    from labstmp.labstmp_user_poll_response
    where poll_id = v_poll_id
    and user_id = v_userid
	and response_option_id=v_option_id;
            	
			if v_poll_option_count>0
			then
			delete from labstmp.labstmp_user_poll_response
			where poll_id = v_poll_id
    and user_id = v_userid
	and response_option_id=v_option_id;
	
	delete from labstmp.labstmp_poll_response
	where poll_response_id in (select poll_response_id from labstmp.labstmp_poll_response
							   where poll_id = v_poll_id
     and response_option_id=v_option_id
							  limit 1
							  );
			end if;
            	
          		insert into labstmp.labstmp_poll_response(poll_response_id,poll_id,response_option_id,created_date,updated_date,created_by,updated_by,
                                                  is_active,is_deleted,is_published,poll_response_guid,response_count)
         		values(nextval('labstmp.seq_labstmp_poll_response_id'),v_poll_id,v_option_id,v_currenttimestamp,v_currenttimestamp,1,1,1,0,1,
                       uuid_generate_v4(),1);
				if v_userid is not null then
                 insert into labstmp.labstmp_user_poll_response(user_poll_response_id,poll_id,response_option_id,user_id,response_date,player_rating,
															score,player_id,wickets,image_path,video_path,extra)
            	values(nextval('labstmp.seq_labstmp_user_poll_response_id'),v_poll_id,v_option_id,v_userid,v_currenttimestamp,v_player_rating,
					                                 v_score,v_player_id,v_wickets,v_image_path,v_video_path,v_extra);
                end if;
			end loop;
            
			
				p_result := 1;	
		end if;
		
		
    
    
		
    else
    	
        p_result := 0;
        
    end if;
	
    
    select sum(response_count)
    into v_total_responses
    from labstmp.labstmp_poll_response
    where poll_id = v_poll_id;
    
    if p_result = 1 then
    	
		select ('{"data":'||string_agg((row_to_json(row))::text,',')||'}')::jsonb
		from(select v_poll_id poll_id, v_total_responses as total_responses,
             (select array_to_json(array_agg(poll_option)) as poll_option
              from(select pd.response_option_id as option_id,sum(pd.response_count)  as response_count,
				 (select  max(player_rating) 
                 from labstmp.labstmp_user_poll_response
                  where poll_id=v_poll_id
                  and   response_option_id= pd.response_option_id
				  and user_id = v_userid
					and coalesce(player_rating,0)>0)   as player_rating,
				    (select  max(score) 
                 from labstmp.labstmp_user_poll_response
                  where poll_id=v_poll_id
                  and   response_option_id= pd.response_option_id
					  and user_id = v_userid
					and coalesce(score,0)>0)  as score
				     from labstmp.labstmp_poll_response pd
				   join labstmp.labstmp_poll_option p
				   on p.poll_id=pd.poll_id
				   
                   where pd.poll_id = v_poll_id
                   group by  pd.response_option_id)poll_option))row
		into p_data;
        
	else
    	
        p_data := '{"data":{"total_responses":null,"poll_option":null,"poll_id":null,"player_rating":null,"score":null}}'::jsonb;
     
    end if;
 /*
exception
	when others then
    	p_result := -1;
		p_data := '{"data":{"total_responses":null,"poll_option":null,"poll_id":null,"user_guid": '''||v_userguid||'''}}'::jsonb;
	*/
end;

$$;


--
