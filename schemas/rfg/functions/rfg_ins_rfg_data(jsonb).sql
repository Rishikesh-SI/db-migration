-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: rfg_ins_rfg_data(jsonb)
-- Type: FUNCTION

-- Name: rfg_ins_rfg_data(jsonb); Type: FUNCTION; Schema: rfg; Owner: -
--

CREATE FUNCTION rfg.rfg_ins_rfg_data(p_json jsonb, OUT p_result numeric, OUT p_count numeric, OUT p_out_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
    v_data_json jsonb;
    v_is_validcapcha numeric;
	v_data_count numeric;
	v_json json;
	v_current_timestamp timestamp := current_timestamp at time zone 'utc';
    v_skip_count numeric := 0;
	v_inserted_count numeric;
    
begin
	
    select p_json->'data', p_json->>'is_validcapcha' into v_data_json, v_is_validcapcha;
	
	select count(1) into v_data_count from json_array_elements(v_data_json::json);
	
    if v_is_validcapcha = 1 then
    	
        select v_data_json->0 into v_json;
        
        /*if not exists(select 1 from rfg.rfg_raid_for_gold
                      where trim(lower(first_name)) = trim(lower(v_json->>'first_name'))
                      and trim(lower(last_name)) = trim(lower(v_json->>'last_name'))
                      and age = (v_json->>'age')::numeric
                      -- and date_of_birth = (v_json->>'date_of_birth')::date
                      and trim(lower(email_id)) = trim(lower(v_json->>'email_id'))
                      and trim(lower(mobile_number)) = trim(lower(v_json->>'mobile_number'))
                      and trim(lower(gender)) = trim(lower(v_json->>'gender'))
                      and trim(lower(city)) = trim(lower(v_json->>'city'))
                      and trim(lower(institute_code)) = trim(lower(v_json->>'institute_code'))
                      and trim(lower(standard)) = trim(lower(v_json->>'standard'))
                      and trim(lower(refernce_id)) = trim(lower(v_json->>'refernce_id'))) then*/
			
            insert into rfg.rfg_raid_for_gold(rfg_id,first_name,last_name,age,date_of_birth,email_id,mobile_number,gender,city,institute_code,standard,
                                              created_date,guid,refernce_id,is_email_sent,utm_source,utm_medium)
			select nextval('rfg.seq_rfg_id'), v_json->>'first_name', v_json->>'last_name', v_json->>'age', (v_json->>'date_of_birth')::date,
            		v_json->>'email_id', v_json->>'mobile_number', v_json->>'gender', v_json->>'city', v_json->>'institute_code', v_json->>'standard',
                	v_current_timestamp, uuid_generate_v4(), v_json->>'refernce_id', 4, v_json->>'utm_source', v_json->>'utm_medium';
            
            select ('{"data":['||row_to_json(row)::text||']}')::jsonb into p_out_json
            from(select * from rfg.rfg_raid_for_gold where rfg_id = currval('rfg.seq_rfg_id'))row;
            
		/*else
        	
            v_skip_count := v_skip_count + 1;
            
        end if;*/
        
    else
    	
        for v_json in select * from json_array_elements(v_data_json::json)
        loop
        	
            /*if not exists(select 1 from rfg.rfg_raid_for_gold
                          where trim(lower(first_name)) = trim(lower(v_json->>'first_name'))
                          and trim(lower(last_name)) = trim(lower(v_json->>'last_name'))
                          and age = (v_json->>'age')::numeric
                          and date_of_birth = (v_json->>'date_of_birth')::date
                          and trim(lower(email_id)) = trim(lower(v_json->>'email_id'))
                          and trim(lower(mobile_number)) = trim(lower(v_json->>'mobile_number'))
                          and trim(lower(gender)) = trim(lower(v_json->>'gender'))
                          and trim(lower(city)) = trim(lower(v_json->>'city'))
                          and trim(lower(institute_code)) = trim(lower(v_json->>'institute_code'))
                          and trim(lower(standard)) = trim(lower(v_json->>'standard'))
                          and trim(lower(refernce_id)) = trim(lower(v_json->>'refernce_id'))) then*/
            	
            	insert into rfg.rfg_raid_for_gold(rfg_id,first_name,last_name,age,date_of_birth,email_id,mobile_number,gender,city,institute_code,
                                                  standard,created_date,guid,refernce_id)
				select nextval('rfg.seq_rfg_id'),v_json->>'first_name',v_json->>'last_name',v_json->>'age',(v_json->>'date_of_birth')::date,
                		v_json->>'email_id',v_json->>'mobile_number',v_json->>'gender',v_json->>'city',v_json->>'institute_code',v_json->>'standard',
                        v_current_timestamp,uuid_generate_v4(),v_json->>'refernce_id';
				
                p_out_json := ('{"data":[]}')::jsonb;
                
			/*else
            	
                v_skip_count := v_skip_count + 1;
                
			end if;*/
            
        end loop;
        
    end if;
    
    select count(1) into v_inserted_count from rfg.rfg_raid_for_gold where created_date = v_current_timestamp;
    
    if v_data_count = (v_inserted_count + v_skip_count) then
    	
        p_result := 1;
        select count(1) into p_count from rfg.rfg_raid_for_gold;
        
    else
    	
        p_result := -1;
        p_count := 0;
        
    end if;
    
    
    
end;

$$;


--
