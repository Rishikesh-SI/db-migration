-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: rfg_ins_rfg_data_niu(jsonb)
-- Type: FUNCTION

-- Name: rfg_ins_rfg_data_niu(jsonb); Type: FUNCTION; Schema: rfg; Owner: -
--

CREATE FUNCTION rfg.rfg_ins_rfg_data_niu(p_json jsonb, OUT p_result numeric, OUT p_count numeric, OUT p_out_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

/*
{
  "data": [
    {
	  "name": "",
      "date_of_birth": "",
      "email_id": "",
      "mobile_number": "",
      "gender": "",
      "city": ""
    },
    {
	  "name": "",
      "date_of_birth": "",
      "email_id": "",
      "mobile_number": "",
      "gender": "",
      "city": ""
    }
  ]
}
*/
declare
	v_data_json jsonb;
	v_data_count numeric;
	v_json json;
	v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	v_inserted_count numeric;
    v_is_validcapcha numeric;
begin
	select p_json->'data' ,
    	   p_json->>'is_validcapcha'
    into v_data_json,
    	v_is_validcapcha;
	
	select count(1) into v_data_count from json_array_elements(v_data_json::json);
	
	for v_json in select * from json_array_elements(v_data_json::json)
	loop
    
    	if v_is_validcapcha = 1 
        then
        	
        	if not exists (select 1 from rfg.rfg_raid_for_gold 
                           where trim(lower(email_id)) = trim(lower(v_json->>'email_id')))
            then             
                insert into rfg.rfg_raid_for_gold
                (rfg_id, first_name, last_name, age, date_of_birth,email_id,mobile_number,gender, city, institute_code, standard,
                 created_date, guid, refernce_id)
                select nextval('rfg.seq_rfg_id'), v_json->>'first_name',  v_json->>'last_name',  (v_json->>'age')::numeric, (v_json->>'date_of_birth')::date,
                       v_json->>'email_id', v_json->>'mobile_number', v_json->>'gender', v_json->>'city', v_json->>'institute_code', v_json->>'standard',
                       v_current_timestamp,uuid_generate_v4(), (v_json->>'refernce_id')::numeric;
                       
                p_result := 1;
            else 
            		
                    p_result := 2;    
            end if;
   	    else 
              insert into rfg.rfg_raid_for_gold
                (rfg_id, first_name, last_name, age, date_of_birth,email_id,mobile_number,gender, city, institute_code, standard,
                 created_date, guid, refernce_id)
                select nextval('rfg.seq_rfg_id'), v_json->>'first_name',  v_json->>'last_name',  (v_json->>'age')::numeric, 
                		(v_json->>'date_of_birth')::date,
                       v_json->>'email_id', v_json->>'mobile_number', v_json->>'gender', v_json->>'city', v_json->>'institute_code', v_json->>'standard',
                       v_current_timestamp,uuid_generate_v4(), (v_json->>'refernce_id')::numeric; 
                       
               p_result := 1;        
        end if;                    
	end loop;
    
	select count(1) into v_inserted_count from rfg.rfg_raid_for_gold where created_date = v_current_timestamp;   
  
  
    if p_result != 2
    then 
        
        if v_inserted_count = v_data_count then
		p_result := 1;     
		select count(1) into p_count from rfg.rfg_raid_for_gold;
        
		select ('{"data":['||string_agg((row_to_json(row))::text,',')||']}')::json into p_out_json
		from (select rfg_id, first_name, last_name, age, date_of_birth,email_id,mobile_number,gender, city, institute_code,
              standard, created_date,guid, refernce_id
			  from rfg.rfg_raid_for_gold
			  where created_date = v_current_timestamp)row;
        else
            p_result := -1;
            p_count := 0;
            p_out_json := ('{"data":[]}')::jsonb;
        end if;
    else 
    	p_count := 0;
        p_out_json := ('{"data":[]}')::jsonb;
    end if;
    	
end;

$$;


--
