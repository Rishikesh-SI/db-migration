-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: labmao_get_user_data(jsonb, refcursor)
-- Type: FUNCTION

-- Name: labmao_get_user_data(jsonb, refcursor); Type: FUNCTION; Schema: labmao; Owner: -
--

CREATE FUNCTION labmao.labmao_get_user_data(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
/*
select * from labmao.labmao_get_user_data
(
    '{
    "opt_type": 1,
  "start_date_time": "2019-03-23 00:00:00",
  "end_date_time": "2019-03-23 23:20:02"
}',
    'a'
);
fetch all in "a";
*/

declare
	
    v_start_date_time timestamp;
    v_end_date_time timestamp;
    v_opt_type numeric;
begin
	
    select p_input_json->>'start_date_time', p_input_json->>'end_date_time',p_input_json->>'opt_type'
    into v_start_date_time, v_end_date_time,v_opt_type;
    
   -- v_start_date_time := v_start_date_time - '5.5 hours'::interval;
   -- v_end_date_time := v_end_date_time - '5.5 hours'::interval;
    
	 if v_opt_type = 1 then

			open p_user_cursor for
			select group_name,no_of_runners,total_fees,invoice_address,group_contact_name,
					group_contact_email,group_contact_number,corporate_type,group_pancard_number,pancard as pan_name,
					(created_date + '5.5 hours'::interval)::date created_date
			from labmao.labmao_group
			where (created_date + '5.5 hours'::interval)::date between 	v_start_date_time::date and v_end_date_time::date ;

	 elsif  v_opt_type = 2 then

			 open p_user_cursor for
			 select first_name,last_name,email_address,mobile_number,
			 dob,gender,codeno as employee_code ,(created_date + '5.5 hours'::interval)::date created_date
			 from labmao.labmao_itc_contact;

	 end if;
 
	
 
 
 
end;
$$;


--
