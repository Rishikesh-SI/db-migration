-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: labstlz_get_user_data(jsonb, refcursor)
-- Type: FUNCTION

-- Name: labstlz_get_user_data(jsonb, refcursor); Type: FUNCTION; Schema: labstlz; Owner: -
--

CREATE FUNCTION labstlz.labstlz_get_user_data(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
declare
	
    v_start_date_time timestamp;
    v_end_date_time timestamp;
    v_opt_type numeric;
	
begin
	
	select p_input_json->>'start_date_time', p_input_json->>'end_date_time', p_input_json->>'opt_type'
    into v_start_date_time, v_end_date_time, v_opt_type;
    
    v_start_date_time := v_start_date_time::date;
    v_end_date_time := v_end_date_time::date;
    
 	if v_opt_type = 1 then
		
		open p_user_cursor for
		select client_id, social_user_name, user_full_name, email_id, created_date
		from labstlz.labstlz_web_user
		order by created_date desc;
		
	end if;
 	
end;

$$;


--
