-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_get_user_info_r(jsonb)
-- Type: FUNCTION

-- Name: labrr_get_user_info_r(jsonb); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_get_user_info_r(p_input_json jsonb, OUT p_user_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
/*
select * from labrr.labrr_get_user_info_r(
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
	
	 select p_input_json->'data'->'user_id',
	 		p_input_json->'data'->'user_guid'
	into 	v_user_id,
	        v_user_guid;
			
			
	
	
	  if  v_user_id is not null  then
	  	    
		select ('{"data":'||(json_agg(row_to_json(row)))::text||'}')::jsonb
	    from(select first_name,last_name,profile_picture_url,user_id,user_guid
			 from labrr.labrr_web_user a,
			 jsonb_array_elements_text(v_user_id) as b
			 where  a.user_id = b.value::numeric)row
		into p_user_json ;	 
		
     elseif v_user_guid is not null then
	
	 
	    select ('{"data":'||(json_agg(row_to_json(row)))::text||'}')::jsonb
		from(select first_name,last_name,profile_picture_url,user_id,user_guid
			from labrr.labrr_web_user a,
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
