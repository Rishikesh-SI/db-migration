-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_ins_upd_poll_response_29032019(jsonb)
-- Type: FUNCTION

-- Name: labmi_ins_upd_poll_response_29032019(jsonb); Type: FUNCTION; Schema: labmi_beta_22042024; Owner: -
--

CREATE FUNCTION labmi_beta_22042024.labmi_ins_upd_poll_response_29032019(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
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
    
begin
	
    select current_timestamp at time zone 'utc' into v_currenttimestamp;
    
    select v_json->'data'->>'poll_id', v_json->'data'->>'polloption', v_json->'data'->>'user_guid'
    into v_poll_id, v_polldatajson, v_userguid;
    
    select user_id
    into strict v_userid
    from labmi.labmi_web_user
    where user_guid = v_userguid;
    
    select count(1)
    into v_uservotecount
    from labmi.labmi_user_poll_response
    where poll_id = v_poll_id
    and user_id = v_userid;
    
    if v_uservotecount < 1 then
    	
        if v_polldatajson is not null then
    	
        	for v_polldata in select * from json_array_elements(v_polldatajson)
        	loop
            
            	select v_polldata->>'option_id'
            	into v_option_id;
            	
          		insert into labmi.labmi_poll_response(poll_response_id,poll_id,response_option_id,created_date,updated_date,created_by,updated_by,
                                                  is_active,is_deleted,is_published,poll_response_guid,response_count)
         		values(nextval('labmi.seq_labmi_poll_response_id'),v_poll_id,v_option_id,v_currenttimestamp,v_currenttimestamp,1,1,1,0,1,
                       uuid_generate_v4(),1);
				
                insert into labmi.labmi_user_poll_response(user_poll_response_id,poll_id,response_option_id,user_id,response_date)
            	values(nextval('labmi.seq_labmi_user_poll_response_id'),v_poll_id,v_option_id,v_userid,v_currenttimestamp);
                
			end loop;
            
		end if;
    	
    	p_result := 1;
		
    else
    	
        p_result := 0;
        
    end if;
    
    select sum(response_count)
    into v_total_responses
    from labmi.labmi_poll_response
    where poll_id = v_poll_id;
    
    if p_result = 1 then
    	
		select ('{"data":'||string_agg((row_to_json(row))::text,',')||'}')::jsonb
		from(select v_poll_id poll_id, v_total_responses as total_responses,
             (select array_to_json(array_agg(poll_option)) as poll_option
              from(select response_option_id as option_id, sum(response_count) as response_count
                   from labmi.labmi_poll_response
                   where poll_id = v_poll_id
                   group by response_option_id)poll_option))row
		into p_data;
        
	/*else
    	
        p_data := '{"data":{"total_responses":null,"poll_option":null,"poll_id":null}}'::jsonb;*/
        
    end if;
 /*   
exception
	when others then
    	p_result := -1;
		p_data := '{"data":{"total_responses":null,"poll_option":null,"poll_id":null}}'::jsonb;*/
	
end;

$$;


--
