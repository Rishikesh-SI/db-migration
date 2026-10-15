-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_ins_upd_poll_response_whatsapp(jsonb)
-- Type: FUNCTION

-- Name: labmi_v1_ins_upd_poll_response_whatsapp(jsonb); Type: FUNCTION; Schema: labmi_v1; Owner: -
--

CREATE FUNCTION labmi_v1.labmi_v1_ins_upd_poll_response_whatsapp(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
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
   v_poll_id_1 numeric[];
   v_poll_option_id_1 numeric;
   v_mobile_no character varying;
   v_poll_id_2 numeric;
   v_title character varying;
begin
	
    select current_timestamp at time zone 'utc' into v_currenttimestamp;
    
    select v_json->'data'->>'poll_id', v_json->'data'->>'polloption', v_json->'data'->'user_info'->>'mobile_no'
    into v_poll_id, v_polldatajson, v_mobile_no ;
    
	 --select gratification_value,better_luck_value
     --from labmi_v1.labmi_v1_gratification_event 
  --  where event_id=2
     -- into v_gratification_value,v_better_luck_value;
	 
   -- select user_id
   -- into strict v_userid
   -- from labmi_v1.labmi_v1_web_user
   -- where user_guid = v_userguid;
	select array
	(select asset_id from labmi_v1.labmi_v1_asset_entity_map
	where entity_role_map_id in 
	(select entity_role_map_id from labmi_v1.labmi_v1_asset_entity_map
	where asset_id = v_poll_id and asset_type_id = 6 and entity_role_map_id not in (4262,5,2,2882,3622))
	and asset_type_id = 6 and asset_id <> v_poll_id) into v_poll_id_1 ;
	
	--- raise notice '%' ,v_poll_id_1;
	
	
    
    select count(1)
    into v_uservotecount
    from labmi_v1.labmi_v1_user_poll_response
    where poll_id = v_poll_id
    and mobile_no = v_mobile_no;
	
	-- raise notice '%' ,v_uservotecount;
    
    if v_uservotecount < 1 then
    	
        if v_polldatajson is not null then
    	
        	for v_polldata in select * from json_array_elements(v_polldatajson)
        	loop
            
            	select v_polldata->>'option_id'
            	into v_option_id;
							
            	
          		insert into labmi_v1.labmi_v1_poll_response(poll_response_id,poll_id,response_option_id,created_date,updated_date,created_by,updated_by,
                                                  is_active,is_deleted,is_published,poll_response_guid,response_count)
         		values(nextval('labmi_v1.seq_labmi_v1_poll_response_id'),v_poll_id,v_option_id,v_currenttimestamp,v_currenttimestamp,1,1,1,0,1,
                       uuid_generate_v4(),1);
				
                insert into labmi_v1.labmi_v1_user_poll_response(user_poll_response_id,poll_id,response_option_id,user_id,response_date,mobile_no)
            	values(nextval('labmi_v1.seq_labmi_v1_user_poll_response_id'),v_poll_id,v_option_id,v_userid,v_currenttimestamp,v_mobile_no);
                
				if v_poll_id_1 is not null then
				
				
				for v_poll_id_2 in select unnest(v_poll_id_1)
				loop 
				
				--raise notice '%',v_poll_id_2;
				--raise notice '%',v_option_id;
				
				select poll_option_id into v_poll_option_id_1 from labmi_v1.labmi_v1_poll_option
				where option::json->>'pid' = (select option::json->>'pid' from labmi_v1.labmi_v1_poll_option
											  where poll_option_id = v_option_id)
				and poll_id = v_poll_id_2;
				
				
					insert into labmi_v1.labmi_v1_poll_response(poll_response_id,poll_id,response_option_id,created_date,updated_date,created_by,updated_by,
													  is_active,is_deleted,is_published,poll_response_guid,response_count)
					values(nextval('labmi_v1.seq_labmi_v1_poll_response_id'),v_poll_id_2,v_poll_option_id_1,v_currenttimestamp,v_currenttimestamp,1,1,1,0,1,
						   uuid_generate_v4(),1);

					insert into labmi_v1.labmi_v1_user_poll_response(user_poll_response_id,poll_id,response_option_id,user_id,response_date,mobile_no)
					values(nextval('labmi_v1.seq_labmi_v1_user_poll_response_id'),v_poll_id_2,v_poll_option_id_1,v_userid,v_currenttimestamp,v_mobile_no);

				
				
				end loop;	
				
				end if;
				
			end loop;
            
		end if;
    	
    	p_result := 1;
		
    else
    	
        p_result := 0;
		
		p_data := '{"Msg" : "Already submitted"}';
        
    end if;
    
    select sum(response_count)
    into v_total_responses
    from labmi_v1.labmi_v1_poll_response
    where poll_id = v_poll_id;
	
	  select title into v_title
	  from labmi_v1.labmi_v1_poll 
	  where poll_id = v_poll_id;
 
   -- raise notice '%' ,v_total_responses;
    
    if p_result = 1 then
    	
		/*select ('{"data":'||string_agg((row_to_json(row))::text,',')||'}')::jsonb
		from(select v_poll_id poll_id, v_total_responses as total_responses,
			  v_gift_id gift_id, v_gift_name gift_name,v_title as title,
             (select array_to_json(array_agg(poll_option)) as poll_option
              from(select response_option_id as option_id, sum(response_count) as response_count
                   from labmi_v1.labmi_v1_poll_response
                   where poll_id = v_poll_id
                   group by response_option_id)poll_option))row
		into p_data;*/
        
		select ('{"data":'||string_agg((row_to_json(row))::text,',')||'}')::jsonb
		from(select v_poll_id poll_id, v_total_responses as total_responses,
			  v_gift_id gift_id, v_gift_name gift_name,v_title as title,
             (select array_to_json(array_agg(poll_option)) as poll_option
              from(select p.poll_option_id as option_id,p.option, sum(response_count) as response_count
                   from labmi_v1.labmi_v1_poll_option p
				   left join labmi_v1.labmi_v1_poll_response pr on  p.poll_option_id = pr.response_option_id
                   where p.poll_id = v_poll_id
                   group by 1,2)poll_option))row
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
