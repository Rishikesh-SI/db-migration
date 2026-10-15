-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _ins_upd_custom_web_model(text, jsonb)
-- Type: FUNCTION

-- Name: _ins_upd_custom_web_model(text, jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._ins_upd_custom_web_model(p_schema_prefix text, p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$

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
	
     select p_json->'data'->>'module_name' into v_module_name;
	
     
	 
     if v_module_name = 'asset_view' then
   		for i in (select b from jsonb_array_elements(p_json->'data'->'userdata') b) 
		 loop
          select  	i.b->>'user_id',
                    i.b->>'url',
                    i.b->>'asset_id',
                    i.b->>'asset_type_id',
                    i.b->>'extra',
                    i.b->>'action',
					i.b->>'data_guid'
		into v_user_guid, v_url, v_asset_id, v_asset_type_id, v_extra, v_action,v_data_guid;
          
           if v_user_guid is not null or v_user_guid != '' then
          	execute'select user_id from '||p_schema_prefix||'.'||p_schema_prefix||'_web_user
          	   		where user_guid = $1'
               into  v_user_id
               using v_user_guid;
		else
          	v_user_id = 0;
          end if;
          
          execute 'select nextval('''||p_schema_prefix||'.seq_'||p_schema_prefix||'_asset_view_id'')' 
          into v_custom_module_id;
		  
		  execute 'select count(1) from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_view_trac
		           where data_guid = '''||v_data_guid||''''
				   into v_count;
		
		if v_count<1 or v_count is null then
  		execute ' insert into '||p_schema_prefix||'.'||p_schema_prefix||'_asset_view_trac(asset_view_id, asset_id, asset_type_id,
          																	user_id, url,share, viewed_date,is_action,data_guid)
				select $1, $2, $3, $4, $5, $6, $7, $8, $9;'
  		using v_custom_module_id, v_asset_id, v_asset_type_id, coalesce(v_user_id,0), v_url, v_extra, v_sysdate, v_action,v_data_guid;
		
		end if;
		
      end loop; 
	  v_result := 1;
	  p_data := '{"result":"'||coalesce(v_result, 0)||'"}';
	  
	elsif  lower(v_module_name) in ('53093','53094','53095','53096','53097','53098','53099') then
	
	   select p_json->'data'->'user_info'->>'email' into v_email_id;
		
  	if not exists(select 1 from isl.isl_client_web_cust_model 
				  where lower(module_name) = lower(v_module_name) and  lower(client_mod_json->'data'->'user_info'->>'email') = lower(v_email_id)
	             ) then
				 
		execute 'select nextval('''||p_schema_prefix||'.seq_'||p_schema_prefix||'_custom_module_id'')'
        into v_custom_module_id;
		
		execute 'insert into '||p_schema_prefix||'.'||p_schema_prefix||'_client_web_cust_model(custom_module_id, module_name,
          																		client_mod_json, created_date,
                                                                                                    updated_date)
				select $1, $2, $3, $4, $5'
  		using v_custom_module_id, v_module_name, p_json, v_sysdate, v_sysdate;
		
          p_data := p_json;
		  p_data := jsonb_set(p_data::jsonb,'{success_flag}','1',true); 
		  
		else
		 
		  p_data := p_json;
		  p_data := jsonb_set(p_data::jsonb,'{success_flag}','-1',true); 
		
		end if;
	
	  
	else
     	
  		execute 'select nextval('''||p_schema_prefix||'.seq_'||p_schema_prefix||'_custom_module_id'')'
          into v_custom_module_id;
          
  		execute 'insert into '||p_schema_prefix||'.'||p_schema_prefix||'_client_web_cust_model(custom_module_id, module_name,
          																		client_mod_json, created_date,
                                                                                                    updated_date)
				select $1, $2, $3, $4, $5'
  		using v_custom_module_id, v_module_name, p_json, v_sysdate, v_sysdate;
          p_data := p_json;
		  p_data := jsonb_set(p_data::jsonb,'{success_flag}','1',true); 
		  
		  raise notice '%',v_custom_module_id;
		  
  	end if;
  	
     
     
end;

$_$;


--
