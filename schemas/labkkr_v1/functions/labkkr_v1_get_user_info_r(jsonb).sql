-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_v1
-- Object: labkkr_v1_get_user_info_r(jsonb)
-- Type: FUNCTION

-- Name: labkkr_v1_get_user_info_r(jsonb); Type: FUNCTION; Schema: labkkr_v1; Owner: -
--

CREATE FUNCTION labkkr_v1.labkkr_v1_get_user_info_r(p_input_json jsonb, OUT p_user_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
/*
select * from labkkr_v1.labkkr_v1_get_user_info_r(
'{
  "data": {
    "user_guid": [
      "b06087f9-b5a5-4031-9251-51578b41e055",
      "1e952ee5-5d3f-4f0f-b2c8-cd4c60482ebd"
    ],
    "user_id": null
  }
}'
);
*/

	declare
	
	v_user_id jsonb;
	v_user_guid jsonb;

	begin
	
	 select p_input_json->'data'->>'user_id',
	 		p_input_json->'data'->>'user_guid'
	into 	v_user_id,
	        v_user_guid;
			
			raise notice 'here in %',v_user_guid;
	
	
	  if  v_user_id is not null  then
	  raise notice '2. here in %',v_user_guid;
	  	    
		select ('{"data":'||(json_agg(row_to_json(row)))::text||'}')::jsonb
	    from(select first_name,last_name,profile_picture_url,user_id,user_guid
			 from labkc_v1.labkc_v1_web_user a,
			 jsonb_array_elements_text(v_user_id) as b
			 where  a.user_id = b.value::numeric)row
		into p_user_json ;	 
		
     elseif v_user_guid is not null then
	
	 
	    select ('{"data":'||(json_agg(row_to_json(row)))::text||'}')::jsonb
		from(select first_name,last_name,profile_picture_url,user_id,user_guid
			from labkc_v1.labkc_v1_web_user a,
			jsonb_array_elements_text(v_user_guid) as b
			where  a.user_guid = b.value)row
		into p_user_json ;
	 
	 end if;
	 
	 if p_user_json is null then
	 
	 p_user_json := '{}';
	 
	 end if;

	end;
$$;


--
