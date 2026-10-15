-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp
-- Object: labkxp_get_user_data(jsonb, refcursor)
-- Type: FUNCTION

-- Name: labkxp_get_user_data(jsonb, refcursor); Type: FUNCTION; Schema: labkxp; Owner: -
--

CREATE FUNCTION labkxp.labkxp_get_user_data(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
declare
	
    v_start_date_time timestamp;
    v_end_date_time timestamp;
    v_opt_type numeric;
	v_json_data jsonb;
	
begin
	
	select p_input_json->>'start_date_time', p_input_json->>'end_date_time', p_input_json->>'opt_type'
    into v_start_date_time, v_end_date_time, v_opt_type;
    
    v_start_date_time := v_start_date_time::date;
    v_end_date_time := v_end_date_time::date;
    
 	if v_opt_type = 1 then
		
		open p_user_cursor for
		select 
		 case client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' end as source,client_id, social_user_name, user_full_name, email_id, created_date,dob,gender,mobile_no,user_guid
		from labkxp.labkxp_web_user
		where created_date between v_start_date_time and v_end_date_time
		order by created_date desc;
		
	elseif 	v_opt_type = 2 then
	
			open p_user_cursor for
			select title,poll_desc::jsonb->>'optionName' as match_name ,c.user_full_name,
			c.user_guid,c.email_id,c.mobile_no,c.dob,c.gender,
			d.option::jsonb->>'player' as player_name,
			b.response_date + interval '5:30 hour' as response_date

			from labkxp.labkxp_poll a
			join labkxp.labkxp_user_poll_response b on a.poll_id=b.poll_id
			join labkxp.labkxp_poll_option d on d.poll_option_id=b.response_option_id
			join labkxp.labkxp_web_user c on c.user_id=b.user_id

			where  exists (select 1 from labkxp.labkxp_asset_entity_map
					   where asset_type_id=6 and asset_id=a.poll_id
					   and entity_role_map_id=8161)
			order by a.created_date desc;
		elseif 	v_opt_type = 5 then	
		--select 1/0;
		
		select p_input_json->'jsondata'->'guids' into v_json_data;

		--raise notice '%',v_json_data;
		--select 1/0;
        open p_user_cursor for
		select client_id, social_user_name, user_full_name, email_id, created_date,dob,gender,mobile_no,user_guid

		
		from labkxp.labkxp_web_user a,
		jsonb_array_elements_text(v_json_data) as b
		where  a.user_guid=b.value
		order by created_date desc
		;

		
	end if;
 	
end;

$$;


--
