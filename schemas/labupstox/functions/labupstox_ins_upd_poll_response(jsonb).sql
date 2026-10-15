-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: labupstox_ins_upd_poll_response(jsonb)
-- Type: FUNCTION

-- Name: labupstox_ins_upd_poll_response(jsonb); Type: FUNCTION; Schema: labupstox; Owner: -
--

CREATE FUNCTION labupstox.labupstox_ins_upd_poll_response(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
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
	
	v_email_id character varying(1000);
	v_person_name character varying(1000);
	v_mobile_no character varying(1000);
	v_country_code numeric;
	v_type numeric;
	v_response_count numeric;
	v_vote_count numeric;
	v_poll numeric[];
begin
	
    select current_timestamp at time zone 'utc' into v_currenttimestamp;
    
    select v_json->'data'->>'poll_id', v_json->'data'->>'polloption', v_json->'data'->>'user_guid'
    into v_poll_id, v_polldatajson, v_userguid;
    
	select v_polldatajson->>'poll_option_id'
	into v_poll_option_id;
	
	-- raise notice '%',v_polldatajson;
	
   -- select user_id
    --into strict v_userid
   -- from labupstox.labupstox_web_user
   -- where user_guid = v_userguid;
	
	/*select no_of_ans_allowed
	from labupstox.labupstox_poll
	where poll_id=v_poll_id
	into v_no_of_ans_allowed;*/
    
  --  select count(1)
  --  into v_uservotecount
  --  from labupstox.labupstox_user_poll_response
 --   where poll_id = v_poll_id
--	and response_option_id =v_poll_option_id
  --  and user_id = v_userid;
    
   -- if v_uservotecount < 1 then
    	
        if v_polldatajson is not null then
    	
        	for v_polldata in select * from json_array_elements(v_polldatajson)
        	loop
            
            		select v_polldata->>'option_id',v_polldata->>'rating',v_polldata->>'score'
				,v_polldata->>'player_id',v_polldata->>'wickets',v_polldata->>'image_path'
				,v_polldata->>'video_path',v_polldata->>'extra',v_polldata->>'email_id',
				v_polldata->>'person_name',v_polldata->>'mobile_no',v_polldata->>'country_code',
				v_polldata->>'type',v_polldata->>'vote_count'
            	into v_option_id,v_player_rating,v_score,v_player_id,v_wickets,v_image_path,
				v_video_path,v_extra,v_email_id,v_person_name,v_mobile_no,v_country_code,v_type,
				v_vote_count ;
				
				
				
				if not exists(select 1 from labupstox.labupstox_user_poll_response
							  where mobile_no = v_mobile_no and response_option_id = v_option_id ) or v_mobile_no = '' then
				
            	v_response_count := case when v_type = 1 then 1 
				                   when v_type = 2 then v_vote_count end;
				if v_response_count>9999 then
				    v_response_count:=9999;
				end if;
			
				
          		insert into labupstox.labupstox_poll_response(poll_response_id,poll_id,response_option_id,created_date,updated_date,created_by,updated_by,
                                                  is_active,is_deleted,is_published,poll_response_guid,response_count,type)
         		values(nextval('labupstox.seq_labupstox_poll_response_id'),v_poll_id,v_option_id,v_currenttimestamp,v_currenttimestamp,1,1,1,0,1,
                       uuid_generate_v4(),v_response_count,v_type);
				
                 insert into labupstox.labupstox_user_poll_response(user_poll_response_id,poll_id,response_option_id,user_id,response_date,player_rating,
															score,player_id,wickets,image_path,video_path,extra,email_id,person_name,mobile_no,country_code)
            	values(nextval('labupstox.seq_labupstox_user_poll_response_id'),v_poll_id,v_option_id,v_userid,v_currenttimestamp,v_player_rating,
					                                 v_response_count,v_player_id,v_wickets,v_image_path,v_video_path,v_extra,
					   									v_email_id,v_person_name,v_mobile_no,v_country_code);
				p_result := 1;										
														
				else
				
					p_result := 0;
				
				end if;
                
			end loop;
            
		end if;
    	
    
		
  --  else
    	
     --   p_result := 0;
        
   -- end if;
   
   
   select array_agg (distinct asset_id) into v_poll  from labupstox.labupstox_asset_entity_map
	where entity_role_map_id in 
	(select distinct entity_role_map_id from labupstox.labupstox_asset_entity_map
	where asset_id = v_poll_id and asset_type_id = 6 and entity_role_map_id not in (1,4) )
	and asset_type_id = 6  
	order by 1 desc;
	
	select sum(response_count) into v_total_responses from labupstox.labupstox_poll_response
	where poll_id in (select poll_id
                      from unnest(v_poll) U(poll_id)) ;
   
    
   /* select sum(response_count)
    into v_total_responses
    from labupstox.labupstox_poll_response
    where poll_id = v_poll_id;*/
	
	
	
    
    if p_result = 1 then
    	
		select ('{"data":'||string_agg((row_to_json(row))::text,',')||',"status":1}')::jsonb
		from(select v_poll_id poll_id, v_total_responses as total_responses,
             (select array_to_json(array_agg(poll_option)) as poll_option
              from(select response_option_id as option_id, sum(response_count) as response_count,
				   ROUND((sum(response_count)*100)/v_total_responses,2) as avg_rating
                   from labupstox.labupstox_poll_response
                   where poll_id = v_poll_id
                   group by response_option_id)poll_option))row
		into p_data;
        
	else
    	
        p_data := '{"data":{"total_responses":null,"poll_option":null,"poll_id":null},"status":0}'::jsonb;
     
    end if;
  
exception
	when others then
    	p_result := -1;
		p_data := '{"data":{"total_responses":null,"poll_option":null,"poll_id":null},"status":-1}'::jsonb;
	
end;
$$;


--
