-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: labhkind_get_user_data(jsonb, refcursor)
-- Type: FUNCTION

-- Name: labhkind_get_user_data(jsonb, refcursor); Type: FUNCTION; Schema: labhkind; Owner: -
--

CREATE FUNCTION labhkind.labhkind_get_user_data(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

/*
select * from labhkind.labhkind_get_user_data
(
    '{
    "opt_type": 3,
  "start_date_time": "2019-04-08 20:00:00",
  "end_date_time": "2019-04-08 23:59:59"
}',
    'a'
);
fetch all in "a";
*/

declare
	
    v_start_date_time timestamp;
    v_end_date_time timestamp;
    v_opt_type numeric;
    v_opt_type_1 numeric;
    v_map_id numeric;
begin
	
    select p_input_json->>'start_date_time', p_input_json->>'end_date_time',p_input_json->>'opt_type'
    into v_start_date_time, v_end_date_time,v_opt_type;
  
    
    v_start_date_time := v_start_date_time::date;
    v_end_date_time := v_end_date_time::date;
    
    select opt_type,map_id into v_opt_type_1,v_map_id from labhkind.labhkind_user_data_filter
    where id=v_opt_type;
    

    
    
 if v_opt_type_1 = 1 then
 
    	open p_user_cursor for
		select name,email_address,mobile_number from labhkind.labhkind_contact
		where page_flag = v_map_id and (created_date + '5.5 hours'::interval)::date between v_start_date_time and v_end_date_time ;
 
   end if; 
 
end;

$$;


--
