-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: labstmp_calculate_poll_points(jsonb)
-- Type: FUNCTION

-- Name: labstmp_calculate_poll_points(jsonb); Type: FUNCTION; Schema: labstmp; Owner: -
--

CREATE FUNCTION labstmp.labstmp_calculate_poll_points(p_json jsonb, OUT p_result numeric) RETURNS numeric
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
   select p_json->'data'->>'poll_id' into v_poll_id;
   
   if v_poll_id is not null then 
   
	select is_ans ,poll_option_id   into strict v_is_ans,v_poll_option_id
    from labstmp.labstmp_poll_option
    where poll_id=v_poll_id
    and is_ans=1 order by 1 desc;

      if v_is_ans=1 then 
	     select poll_desc::jsonb->>'coins_multiple_of' , is_cal_proceed,correct_ans_id
		 
		 into v_coins_multiple_of , v_is_cal_proceed,v_correct_ans_id
		 from labstmp.labstmp_poll
		 where poll_id=v_poll_id;
		
		  
		 if v_is_cal_proceed=1 then 
		-- raise notice '% % % %',v_is_ans,v_poll_option_id,v_coins_multiple_of,v_correct_ans_id; 
		  if v_poll_option_id!=v_correct_ans_id then 
		    
			 update labstmp.labstmp_user_poll_response
	         set total_coins= 0
		     where poll_id=v_poll_id
		     and response_option_id=v_correct_ans_id;
			--set new ans id  logic--
			update labstmp.labstmp_user_poll_response
	        set total_coins= (coins * v_coins_multiple_of)
		    where poll_id=v_poll_id
		    and response_option_id=v_poll_option_id;
	  
           	update labstmp.labstmp_poll
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
	        update labstmp.labstmp_user_poll_response
	        set total_coins= (coins * v_coins_multiple_of)
		    where poll_id=v_poll_id
		    and response_option_id=v_poll_option_id;
	  
           update labstmp.labstmp_poll
	       set is_cal_proceed=1,
	       correct_ans_id=v_poll_option_id
	       where  poll_id=v_poll_id;
		   p_result :=1;
		 end ;
		 
		end if ;
		 
		 
	    /*begin
	        update labstmp.labstmp_user_poll_response
	        set total_coins= (coins * v_coins_multiple_of)
		    where poll_id=541
		    and response_option_id=v_poll_option_id;
	  
           update labstmp.labstmp_poll
	       set is_cal_proceed=1,
	       correct_ans_id=v_poll_option_id
	       where  poll_id=541;
	   */
	   
	  end if;
  
end if;

exception when others then 
p_result :=-1;
end ;
$$;


--
