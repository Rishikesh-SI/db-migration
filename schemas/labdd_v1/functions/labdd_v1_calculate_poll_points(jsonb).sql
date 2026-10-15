-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1
-- Object: labdd_v1_calculate_poll_points(jsonb)
-- Type: FUNCTION

-- Name: labdd_v1_calculate_poll_points(jsonb); Type: FUNCTION; Schema: labdd_v1; Owner: -
--

CREATE FUNCTION labdd_v1.labdd_v1_calculate_poll_points(p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
v_is_ans numeric;
v_poll_option_id numeric;
v_coins_multiple_of numeric;
v_is_cal_proceed numeric;
v_correct_ans_id numeric;
v_poll_id numeric;
begin
/*
p_json :={ "data":
			{
			"poll_id":null
			
			}

        }

*/
	
-- 	insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
-- log_error_message,log_guid,error_json,created_date,client_name,log_type)
-- values (nextval('siwaf.seq_siwaf_api_error_log_id'),'output-update_membership_details','logs',uuid_generate_v4(),p_tran_json,current_timestamp,'labrr','logs');
	
   select p_json->'data'->>'poll_id' into v_poll_id;

   if v_poll_id is not null then 
	select is_ans ,poll_option_id   into strict v_is_ans,v_poll_option_id
    from labdd_v1.labdd_v1_poll_option
    where poll_id=v_poll_id
    and is_ans=1 order by 1 desc;
    raise notice 'dfde'; 
      if v_is_ans=1 then 
	     select poll_desc::jsonb->>'coins_multiple_of' , is_cal_proceed,correct_ans_id
		 
		 into v_coins_multiple_of , v_is_cal_proceed,v_correct_ans_id
		 from labdd_v1.labdd_v1_poll
		 where poll_id=v_poll_id;
		
		  
		 if v_is_cal_proceed=1 then 
		-- raise notice '% % % %',v_is_ans,v_poll_option_id,v_coins_multiple_of,v_correct_ans_id; 
		  if v_poll_option_id!=v_correct_ans_id then 
		    
			 update labdd_v1.labdd_v1_user_poll_response
	         set total_coins= 0
		     where poll_id=v_poll_id
		     and response_option_id=v_correct_ans_id;
			--set new ans id  logic--
			update labdd_v1.labdd_v1_user_poll_response
	        set total_coins= (coins * v_coins_multiple_of)
		    where poll_id=v_poll_id
		    and response_option_id=v_poll_option_id;
	  
           	update labdd_v1.labdd_v1_poll
	       	set is_cal_proceed=1,
	       	correct_ans_id=v_poll_option_id
	       	where  poll_id=v_poll_id;
			p_result :=1;
			-- revert logic for existing ans 
		  
		   --raise notice '% % % %',v_is_ans,v_poll_option_id,v_coins_multiple_of,v_correct_ans_id; 
		 else
		 p_result:=1;
		  end if ;
		 else 
		 begin
	        update labdd_v1.labdd_v1_user_poll_response
	        set total_coins= (coins * v_coins_multiple_of)
		    where poll_id=v_poll_id
		    and response_option_id=v_poll_option_id;
	  
           update labdd_v1.labdd_v1_poll
	       set is_cal_proceed=1,
	       correct_ans_id=v_poll_option_id
	       where  poll_id=v_poll_id;
		   p_result :=1;
		 end ;
		 
		end if ;
		 
		 
	    /*begin
	        update labdd_v1.labdd_v1_user_poll_response
	        set total_coins= (coins * v_coins_multiple_of)
		    where poll_id=541
		    and response_option_id=v_poll_option_id;
	  
           update labdd_v1.labdd_v1_poll
	       set is_cal_proceed=1,
	       correct_ans_id=v_poll_option_id
	       where  poll_id=541;
	   */
	   
	  end if;
  
end if;

--  exception when others then 
--  p_result :=-1;
end ;
$$;


--
