-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_ins_upd_poll_response_211122(jsonb)
-- Type: FUNCTION

-- Name: isl_ins_upd_poll_response_211122(jsonb); Type: FUNCTION; Schema: isl; Owner: -
--

CREATE FUNCTION isl.isl_ins_upd_poll_response_211122(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
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
    v_remaining_vote_cnt  numeric := 1;
    v_cnt  numeric := 0;
    
begin
	
    select current_timestamp at time zone 'utc' into v_currenttimestamp;
    
    select v_json->'data'->>'poll_id', v_json->'data'->>'polloption', v_json->'data'->>'user_guid'
    into v_poll_id, v_polldatajson, v_userguid;
    
    select user_id
    into strict v_userid
    from isl.isl_web_user
    where user_guid = v_userguid;
    
    select count(1)
    into v_uservotecount
    from isl.isl_user_poll_response
    where poll_id = v_poll_id
    and user_id = v_userid;
    
    if v_uservotecount < 1 then
    	
        if v_polldatajson is not null then
    	
        	for v_polldata in select * from json_array_elements(v_polldatajson)
        	loop
            
            	select v_polldata->>'option_id'
            	into v_option_id;
            	
          		insert into isl.isl_poll_response(poll_response_id,poll_id,response_option_id,created_date,updated_date,created_by,updated_by,
                                                  is_active,is_deleted,is_published,poll_response_guid,response_count)
         		values(nextval('isl.seq_isl_poll_response_id'),v_poll_id,v_option_id,v_currenttimestamp,v_currenttimestamp,1,1,1,0,1,
                       uuid_generate_v4(),1);
				
                insert into isl.isl_user_poll_response(user_poll_response_id,poll_id,response_option_id,user_id,response_date)
            	values(nextval('isl.seq_isl_user_poll_response_id'),v_poll_id,v_option_id,v_userid,v_currenttimestamp);
                
                v_cnt := v_cnt +1 ; 
                
			end loop;
            
		end if; 
        
    	p_result := 1;
		
    else
    	
        p_result := 0;
     
        
    end if;
    
    v_remaining_vote_cnt := v_remaining_vote_cnt - (v_uservotecount + v_cnt) ; 
       
    select sum(response_count)
    into v_total_responses
    from isl.isl_poll_response
    where poll_id = v_poll_id;
    
    if p_result = 1 then
    	
		select ('{"data":'||string_agg((row_to_json(row))::text,',')||'}')::jsonb
		from(select v_poll_id poll_id, v_total_responses as total_responses , coalesce(v_remaining_vote_cnt,0) remaining_vote_cnt, 
             (select array_to_json(array_agg(poll_option)) as poll_option
              from(select response_option_id as option_id, sum(response_count) as response_count
                  
                   from isl.isl_poll_response
                   where poll_id = v_poll_id
                   group by response_option_id)poll_option))row
		into p_data;
        
	else
    	
        p_data := '{"data":{"total_responses":null,"poll_option":null,"poll_id":null, "remaining_vote_cnt" :"'|| coalesce(v_remaining_vote_cnt,0)::varchar ||'"}}'::jsonb;
        
    end if;
    
exception
	when others then
    	p_result := -1;
		p_data := '{"data":{"total_responses":null,"poll_option":null,"poll_id":null}}'::jsonb;
	
end;

$$;


--
