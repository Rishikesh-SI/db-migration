-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_upd_gallery_status(json)
-- Type: FUNCTION

-- Name: labrstg_upd_gallery_status(json); Type: FUNCTION; Schema: labrstg; Owner: -
--

CREATE FUNCTION labrstg.labrstg_upd_gallery_status(p_gallery_json json, OUT p_result numeric, OUT p_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare

   v_gallery_json json := p_gallery_json;
    v_gallery_data_json json;
    v_data_json json;
    v_user_name character varying;
    v_user_guid character varying;
	v_status numeric;
	v_process_id numeric;
begin

    select v_gallery_json->>'data'
    into   v_gallery_data_json;
    
	 if v_gallery_data_json is not null then
		
    	
      for v_data_json in select * from json_array_elements(v_gallery_data_json)
      loop
        	
            select  v_data_json->>'user_guid',
            		v_data_json->>'user_name',
					v_data_json->>'status',
					v_data_json->>'process_id'
				into v_user_guid,
    				 v_user_name,
					 v_status,
					 v_process_id;
					
										
					update labrstg.labrstg_gallery a
					set process_id=v_process_id
					from labrstg.labrstg_web_user b
					where a.user_guid=v_user_guid
					and b.social_user_name=v_user_name
					and a.status=v_status;
					
	   end loop;
      p_result:=1;  
	else if  v_data_json is null then
	p_result:=0;
	end if;
	 end if;
  -- select '{ "data" :' || jsonb_agg(row_alias) || '}' from (select (v_data_json)::jsonb)row_alias into p_json;

	--select ('{"data":'||(row_to_json(row))::text||'}')::jsonb
	--		from (select p_gallery_json )
	--			  row
	--		into p_json;
	p_json:=p_gallery_json;
			--how will be input json/json array
			--how will be output json/json_array or normal_numeric
end;
$$;


--
