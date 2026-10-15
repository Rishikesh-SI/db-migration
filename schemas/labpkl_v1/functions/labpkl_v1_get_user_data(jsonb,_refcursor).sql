-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: labpkl_v1_get_user_data(jsonb, refcursor)
-- Type: FUNCTION

-- Name: labpkl_v1_get_user_data(jsonb, refcursor); Type: FUNCTION; Schema: labpkl_v1; Owner: -
--

CREATE FUNCTION labpkl_v1.labpkl_v1_get_user_data(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
/*
select * from labpkl_v1.labpkl_v1_get_user_data
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
	v_poll_id numeric;
	i record;
	v_options json;
	v_question text;
	v_json json;
	v_opt_type_1 numeric;
    v_map_id numeric;
begin
	
    select p_input_json->>'start_date_time', 
	p_input_json->>'end_date_time',
	p_input_json->>'opt_type'
    into v_start_date_time, v_end_date_time,v_opt_type;
    
    v_start_date_time := v_start_date_time - '5.5 hours'::interval;
    v_end_date_time := v_end_date_time - '5.5 hours'::interval;
	
	
    select opt_type,map_id into v_opt_type_1,v_map_id from labpkl_v1.labpkl_v1_user_data_filter
    where id = v_opt_type;

	if v_opt_type_1 = 2 then

	open p_user_cursor for
	
	select case platform_id when 1 then 'Android' when 2 then 'IOS' end as source,full_name,
    			 email_id, created_date as claim_date
    from (select b.platform_id, b.full_name, 
		  b.email_id,a.created_date
          from labpkl_v1.labpkl_v1_panga_hunt_contest a
		  join labpkl_v1.labpkl_v1_panga_hunt_user b
		  on a.panga_hunt_user_id = b.panga_hunt_user_id 
          where (a.created_date between v_start_date_time and v_end_date_time))as tab;
		  
    end if;         

end;
$$;


--
