-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_02042024
-- Object: labkc_v1_ins_asset_view_track(jsonb)
-- Type: FUNCTION

-- Name: labkc_v1_ins_asset_view_track(jsonb); Type: FUNCTION; Schema: labkc_v1_02042024; Owner: -
--

CREATE FUNCTION labkc_v1_02042024.labkc_v1_ins_asset_view_track(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

/*
p_json := '{
"data": {
"module_name": "Sadd Avtar",
"user_data":
{ 
"custom_module_id":null,
"UserId":"",
"name": "",
"message": "", 
"imag_path": "" 
}
}
}';
*/
declare
	
     v_module_name text;
     v_user_id numeric;
     v_user_guid character varying;
     v_url text;
	v_asset_id numeric;
	v_asset_type_id numeric;
	v_extra text;
     v_action text;
     v_custom_module_id numeric;
	v_sysdate timestamp := current_timestamp  at time zone 'utc';
	i record;
	v_data_guid character varying(500);
	v_result numeric;
	v_count numeric;
	v_email_id text;
begin
		 
   		for i in (select b from jsonb_array_elements(p_json->'data') b) 
		 loop
          select  	i.b->>'user_guid',
                    i.b->>'url',
                    i.b->>'asset_id',
                    i.b->>'asset_type_id',
                    i.b->>'extra',
                    i.b->>'action',
					i.b->>'data_guid'
		into v_user_guid, v_url, v_asset_id, v_asset_type_id, v_extra, v_action,v_data_guid;
          
          
         select nextval('labkc_v1.seq_labkc_v1_asset_view_id')
          into v_custom_module_id;
		  
		  select count(1) from labkc_v1.labkc_v1_asset_view_trac
		  where data_guid = v_data_guid
		  into v_count;
		
		if v_count<1 or v_count is null then
		
  		insert into labkc_v1.labkc_v1_asset_view_trac(asset_view_id, asset_id, asset_type_id,
         user_guid, url,share, viewed_date,is_action,data_guid)
  		values (v_custom_module_id, v_asset_id, v_asset_type_id, coalesce(v_user_guid,'none'), v_url, v_extra, v_sysdate, v_action,v_data_guid);
		
		end if;
		
      end loop; 
	  v_result := 1;
	  p_data := '{"result":"'||coalesce(v_result, 0)||'"}';
	  
  
     
end;

$$;


--
