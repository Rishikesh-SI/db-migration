-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs_2602
-- Object: labrs_ins_upd_poll_response(jsonb)
-- Type: FUNCTION

-- Name: labrs_ins_upd_poll_response(jsonb); Type: FUNCTION; Schema: labrs_2602; Owner: -
--

CREATE FUNCTION labrs_2602.labrs_ins_upd_poll_response(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
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
      v_gift_id numeric:=0;
   v_gift_name varchar(500):='NO GIFT';
   v_available_quantity numeric;
   v_gratification_value numeric;
   v_reg_cnt numeric;
   v_better_luck_value numeric;
begin
	
    select current_timestamp at time zone 'utc' into v_currenttimestamp;
    
    select v_json->'data'->>'poll_id', v_json->'data'->>'polloption', v_json->'data'->>'user_guid'
    into v_poll_id, v_polldatajson, v_userguid;
    
    select user_id
    into strict v_userid
    from labrs.labrs_web_user
    where user_guid = v_userguid;
    
    select count(1)
    into v_uservotecount
    from labrs.labrs_user_poll_response
    where poll_id = v_poll_id
    and user_id = v_userid;
	
	select gratification_value,better_luck_value
     from labrs.labrs_gratification_event 
     where event_id=2
     into v_gratification_value,v_better_luck_value;
    
    if v_uservotecount < 1 then
    	
        if v_polldatajson is not null then
    	
        	for v_polldata in select * from json_array_elements(v_polldatajson)
        	loop
            
            	select v_polldata->>'option_id'
            	into v_option_id;
            	
          		insert into labrs.labrs_poll_response(poll_response_id,poll_id,response_option_id,created_date,updated_date,created_by,updated_by,
                                                  is_active,is_deleted,is_published,poll_response_guid,response_count)
         		values(nextval('labrs.seq_labrs_poll_response_id'),v_poll_id,v_option_id,v_currenttimestamp,v_currenttimestamp,1,1,1,0,1,
                       uuid_generate_v4(),1);
				
                insert into labrs.labrs_user_poll_response(user_poll_response_id,poll_id,response_option_id,user_id,response_date)
            	values(nextval('labrs.seq_labrs_user_poll_response_id'),v_poll_id,v_option_id,v_userid,v_currenttimestamp);
              
			     v_reg_cnt:= nextval('labrs.labrs_poll_gratify_seq'); 
	
				update labrs.labrs_user_poll_response
				set gratification_seq = v_reg_cnt
				where user_id =v_userid
				and poll_id =v_poll_id
				and response_option_id=v_option_id
				and gratification_seq is null;
			
 if mod(v_reg_cnt,v_gratification_value) = 0 then
     
     with tab as( select gift_id,gift_url,available_quantity,gift_name
     from labrs.labrs_gratification_gift
		where 	available_quantity>0	 
    order by RANDOM() 
    LIMIT 1) 
    select gift_id,available_quantity,gift_name
    from tab 
      into v_gift_id,v_available_quantity,v_gift_name;
												   
     update labrs.labrs_gratification_gift
     set available_quantity = available_quantity-1
     where gift_id =v_gift_id;
         
     insert into labrs.labrs_gratification_details
    values (nextval('labrs.labrs_gratification_detail_seq'),v_userid,2,v_reg_cnt,v_gift_id,1,0,0,current_timestamp,null);
     
     
                            
     end if;
			  
		if (mod(v_reg_cnt,v_better_luck_value) = 0 and v_gift_id =0) then
     
      select gift_id,available_quantity,gift_name
     from labrs.labrs_gratification_gift
		where is_flag=1	 
      into v_gift_id,v_available_quantity,v_gift_name;
		
         
     insert into labrs.labrs_gratification_details
    values (nextval('labrs.labrs_gratification_detail_seq'),v_userid,2,v_reg_cnt,v_gift_id,1,0,0,current_timestamp,null);
     
     
                            
     end if;	  
			  
			  
			end loop;
            
		end if;
    	
    	p_result := 1;
		
    else
    	
        p_result := 0;
        
    end if;
    
    select sum(response_count)
    into v_total_responses
    from labrs.labrs_poll_response
    where poll_id = v_poll_id;
    
    if p_result = 1 then
    	
		select ('{"data":'||string_agg((row_to_json(row))::text,',')||'}')::jsonb
		from(select v_poll_id poll_id, v_total_responses as total_responses,
			  v_gift_id gift_id, v_gift_name gift_name,
             (select array_to_json(array_agg(poll_option)) as poll_option
              from(select response_option_id as option_id, sum(response_count) as response_count
                   from labrs.labrs_poll_response
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
