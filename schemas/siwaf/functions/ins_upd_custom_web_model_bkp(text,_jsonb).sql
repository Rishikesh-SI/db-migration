-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _ins_upd_custom_web_model_bkp(text, jsonb)
-- Type: FUNCTION

-- Name: _ins_upd_custom_web_model_bkp(text, jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._ins_upd_custom_web_model_bkp(p_schema_prefix text, p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$
declare
	
    v_module_name text;
    v_user_id numeric;
    v_user_guid character varying(500);
    v_url text;
	v_asset_id numeric;
	v_asset_type_id numeric;
	v_extra text;
    v_action text;
    v_custom_module_id numeric;
	v_sysdate timestamp := current_timestamp  at time zone 'utc';
	v_i record;
	v_data_guid character varying(500);
	v_result numeric;
	v_count numeric;
	v_email character varying;
	v_poll_id numeric;
	v_referral_url text;
	v_user_agent text;
	v_guest_guid character varying(500);
	---------------------------
	       v_user_data_for_array jsonb;
           v_url_ar text[];
	       v_module_name_ar text[];
		   v_action_ar text[];
		   v_asset_id_ar numeric[];
		   v_asset_type_id_ar numeric[];
		   v_extra_ar text[];
		    v_utm_param_ar text[];
		   v_guest_guid_ar text[];
		   v_referer_ar text[];
		  -- v_custom_module_id numeric;
		   v_user_agent_ar text[];
		   v_data_guid_ar text[]; 
		   v_user_guid_ar text[];
		   v_exists numeric;
		   v_check numeric;
		   
		   v_aboutMe_count numeric;
		   v_aboutMe_total numeric;
		   v_world_of_sport_count numeric;
		   v_world_of_sport_total numeric;
		   v_change_in_sports_count numeric;
		   v_change_in_sports_total numeric;
		   v_me_and_my_sports_count numeric;
		   v_me_and_my_sports_total numeric;
		   v_me_and_working_in_sports_count numeric;
		   v_me_and_working_in_sports_total numeric;
		   v_profile_com numeric;
		   v_total numeric;
		   v_count_1 numeric;
		   v_trans_guid character varying;
	---------------------
	
	v_group_name character varying(1000);
	v_no_of_runners numeric;
	v_total_distance character varying(1000) ;
	v_no_of_runners_tier1 numeric;
	v_no_of_runners_tier2 numeric;
    v_no_of_runners_tier3 numeric;
	v_total_fees numeric;
	v_company_name character varying(1000); 			   
	v_address character varying(1000);
	v_contact_person character varying(1000);
	v_email_id character varying(1000);
	v_contact_number character varying(1000);
	v_pan_no character varying(1000);
	v_gst_no character varying(1000);
	v_state_code numeric;
	v_city_code numeric ;
	v_group_json jsonb;
	v_runner_group_id numeric;
	
begin
	
	select p_json->'data'->>'module_name' into v_module_name;
	select p_json->'data'->>'userdata',p_json->'data'->>'user_guid' into v_user_data_for_array,v_user_guid;
	
	if v_module_name='job_application' then 
	
	select p_json->'data' into v_user_data_for_array;
	end if;
	
	
	if v_module_name='Digital Survey' then 
	
	 v_user_data_for_array := p_json;
	
	end if;
    
	if v_module_name = 'asset_view' and p_schema_prefix = 'labyho' then
		
		
		SELECT 
	 			array_agg(obj.value->>'url'::text)  ,
	 			array_agg (obj.value->>'module_name'),
	
	 			array_agg (obj.value->>'action'),
	 			array_agg(obj.value->>'asset_id'),
	 			array_agg (obj.value->>'asset_type_id'),
	 			array_agg((obj.value->'extra')),
	 			array_agg(obj.value->>'utm_param'),
	 			array_agg(obj.value->>'guest_guid'),
	 			array_agg(obj.value->>'referer'),
				array_agg(obj.value->>'user_agent'),
	 			array_agg(obj.value->>'data_guid'),
	  			array_agg(obj.value->>'user_id')	
	 		into v_url_ar,
	      v_module_name_ar,
		  v_action_ar,
		  v_asset_id_ar,
		  v_asset_type_id_ar,
		  v_extra_ar,
		  v_utm_param_ar,
		  v_guest_guid_ar,
		  v_referer_ar,
		  v_user_agent_ar,
		  v_data_guid_ar,
		  v_user_guid_ar
	 from jsonb_array_elements(v_user_data_for_array::jsonb) obj(value);
	 
	-- select * from labyho.labyho_asset_view_trac limit 10;
	
	insert into labyho.labyho_asset_view_trac(
	     asset_view_id, asset_id, asset_type_id,user_id, url,share, 
		viewed_date,is_action, data_guid,referral_url,user_agent,user_guid,guest_guid)
	    select nextval('labyho.seq_labyho_asset_view_id'),
	         unnest(v_asset_id_ar) ,unnest(v_asset_type_id_ar), 0, unnest(v_url_ar::text[]), unnest(v_extra_ar),current_timestamp
	     , unnest(v_action_ar), unnest(v_data_guid_ar),unnest(v_referer_ar),unnest(v_user_agent_ar),unnest(v_user_guid_ar),unnest(v_guest_guid_ar) ;
	
	
		
		
		
		/*
		for v_i in (select b from jsonb_array_elements(p_json->'data'->'userdata') b)
		loop
			
			v_user_id := null;
			v_user_guid := null;
			
			select  v_i.b->>'user_id', v_i.b->>'url', v_i.b->>'asset_id', v_i.b->>'asset_type_id', v_i.b->>'extra', v_i.b->>'action',
					v_i.b->>'data_guid'
			into v_user_guid, v_url, v_asset_id, v_asset_type_id, v_extra, v_action, v_data_guid;
          	
          	execute 'select nextval('''||p_schema_prefix||'.seq_'||p_schema_prefix||'_asset_view_id'')'
          	into v_custom_module_id;
		  	
		  	execute 'select count(1)
						from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_view_trac
						where data_guid = '''||v_data_guid||''''
			into v_count;
			
			if v_count < 1 or v_count is null then
				
				if p_schema_prefix != 'labyho' then
					
					if v_user_guid is not null or v_user_guid != '' then
						
						execute 'select user_id
									from '||p_schema_prefix||'.'||p_schema_prefix||'_web_user
									where user_guid = $1'
               			into  v_user_id
               			using v_user_guid;
						
          			end if;
					
					execute 'insert into '||p_schema_prefix||'.'||p_schema_prefix||'_asset_view_trac(asset_view_id, asset_id, asset_type_id,
																										user_id, url,share, viewed_date,
																										is_action, data_guid)
								select $1, $2, $3, $4, $5, $6, $7, $8, $9'
  					using v_custom_module_id, v_asset_id, v_asset_type_id, coalesce(v_user_id,0), v_url, v_extra, v_sysdate, v_action,
							v_data_guid;
					
				else
					
					select v_i.b->>'referer', v_i.b->>'user_agent', v_i.b->>'guest_guid'
					into v_referral_url, v_user_agent, v_guest_guid;
					
					if v_user_guid is not null or v_user_guid != '' then
						
						execute 'select user_id
									from '||p_schema_prefix||'.'||p_schema_prefix||'_web_user
									where user_guid = $1'
               			into  v_user_id
               			using v_user_guid;
						
          			end if;
					
					if v_user_id is null and v_guest_guid is not null or v_guest_guid != '' then
						
						select user_id, user_guid
						into v_user_id, v_user_guid
						from labyho.labyho_guest_login_user_map
						where guest_guid = v_guest_guid;
						
					end if;
					
					execute 'insert into '||p_schema_prefix||'.'||p_schema_prefix||'_asset_view_trac(asset_view_id, asset_id, asset_type_id,
																										user_id, url, share, viewed_date,
																										is_action, data_guid, referral_url,
																										user_agent, user_guid, guest_guid)
								select $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13'
  					using v_custom_module_id, v_asset_id, v_asset_type_id, v_user_id, v_url, v_extra, v_sysdate, v_action, v_data_guid,
							v_referral_url, v_user_agent, v_user_guid,v_guest_guid;
					
				end if;
				
			end if;
			
		end loop; 
		
	     */	
   		v_result := 1;
		p_data := '{"result":"'||coalesce(v_result, 0)||'"}';
		
	elsif v_module_name != 'asset_view' and p_schema_prefix = 'isl' then
		
		select p_json->'data'->'user'->>'email', p_json->>'poll_id'
		into v_email, v_poll_id;
		
		execute 'select count(1)
					from '||p_schema_prefix||'.'||p_schema_prefix||'_client_web_cust_model
					where upper(client_mod_json->''data''->''user''->>''email'') = upper('''||v_email||''')
					and (client_mod_json->>''poll_id'')::numeric = '||v_poll_id
		into v_count;
		
		if v_count = 0 or v_count is null then
			
			execute 'select nextval('''||p_schema_prefix||'.seq_'||p_schema_prefix||'_custom_module_id'')'
			into v_custom_module_id;
			
			execute 'insert into '||p_schema_prefix||'.'||p_schema_prefix||'_client_web_cust_model(custom_module_id, module_name,
																									client_mod_json, created_date,
																									updated_date)
						select $1, $2, $3, $4, $5'
			using v_custom_module_id, v_module_name, p_json, v_sysdate, v_sysdate;
			
			p_data := p_json;
			p_data := jsonb_set(p_data::jsonb,'{result}','1',true);
			
			--if v_module_name = 'asset_view' and p_schema_prefix = 'labyho' then
			
		else
			
			p_data := p_json;
			p_data := jsonb_set(p_data::jsonb,'{result}','0',true);
			
		end if;
	--coalesce
	
	elsif upper(v_module_name) = upper('user_profile')  then
	
	EXECUTE ' (SELECT count(1) FROM '||p_schema_prefix||'.'||p_schema_prefix||'_client_web_cust_model where user_guid='''||v_user_guid||''')' 
	into v_check;
	raise notice 'v_check : %',v_check;
	IF v_check = 0  THEN 
	
	    execute 'select nextval('''||p_schema_prefix||'.seq_'||p_schema_prefix||'_custom_module_id'')'
		         into v_custom_module_id;
		
  		execute 'insert into '||p_schema_prefix||'.'||p_schema_prefix||'_client_web_cust_model
		(custom_module_id, module_name, client_mod_json,
          created_date, updated_date,user_guid,profile_completion)
					select $1, $2, $3, $4, $5,$6,$7'
  		using v_custom_module_id, v_module_name, p_json, v_sysdate, v_sysdate,v_user_guid,v_profile_com;				   
		   	
	else 

-- 	   execute ' update '||p_schema_prefix||'.'||p_schema_prefix||'_client_web_cust_model
-- 		set client_mod_json='''||p_json||''',updated_date='''||v_sysdate||''',profile_completion = '||v_profile_com||'
-- 		where user_guid='''||v_user_guid||'''';

		execute ' update '||p_schema_prefix||'.'||p_schema_prefix||'_client_web_cust_model
 		set client_mod_json='''||p_json||''',updated_date='''||v_sysdate||'''
 		where user_guid='''||v_user_guid||'''';
		
	end if;
	
	
	raise notice 'v_check : %',v_check;
	
		EXECUTE 'select count(1)  from (
		select * from json_each_text(
		(select client_mod_json->''data''->''aboutMe''  from '||p_schema_prefix||'.'||p_schema_prefix||'_client_web_cust_model
		 where user_guid='''||v_user_guid||''')::json  )) a
		where key != ''work_exp'' and (value is not null and value != '''')'
		into v_aboutMe_count;
		
		raise notice 'v_aboutMe_count : %',v_aboutMe_count;
		EXECUTE 'select count(1)  from (
		select * from json_each_text(
		(select client_mod_json->''data''->''aboutMe''  from '||p_schema_prefix||'.'||p_schema_prefix||'_client_web_cust_model
		 where user_guid='''||v_user_guid||''')::json  )) a'
		into v_aboutMe_total;
		
		raise notice 'v_aboutMe_total : %',v_aboutMe_total;
		
		EXECUTE 'select count(1) from (
		select * from json_each_text(
		(select client_mod_json->''data''->''world_of_sport'' from '||p_schema_prefix||'.'||p_schema_prefix||'_client_web_cust_model
		 where user_guid='''||v_user_guid||''')::json  )) a
		 where value != 0::text and (value is not null and value != '''')'
		 into v_world_of_sport_count ;
		 raise notice 'v_world_of_sport_count : %',v_world_of_sport_count;
		EXECUTE 'select count(1) from (
		select * from json_each_text(
		(select client_mod_json->''data''->''world_of_sport'' from '||p_schema_prefix||'.'||p_schema_prefix||'_client_web_cust_model
		 where user_guid='''||v_user_guid||''')::json  )) a '
		 into v_world_of_sport_total ;
		raise notice 'v_world_of_sport_total : %',v_world_of_sport_total;
		EXECUTE 'select count(1) from (
		select * from json_each_text(
		(select client_mod_json->''data''->''change_in_sports'' from '||p_schema_prefix||'.'||p_schema_prefix||'_client_web_cust_model
		 where user_guid='''||v_user_guid||''')::json  )) a
		 where value != 0::text and (value is not null and value != '''' )'
		 into v_change_in_sports_count ;
		 raise notice 'v_change_in_sports_count : %',v_change_in_sports_count;
		EXECUTE 'select count(1) from (
		select * from json_each_text(
		(select client_mod_json->''data''->''change_in_sports'' from '||p_schema_prefix||'.'||p_schema_prefix||'_client_web_cust_model
		 where user_guid='''||v_user_guid||''')::json  )) a '
		 into v_change_in_sports_total ;	
	raise notice 'v_change_in_sports_total : %',v_change_in_sports_total;
		EXECUTE 'select count(1) from (
		select * from json_each_text(
		(select client_mod_json->''data''->''me_and_my_sports'' from '||p_schema_prefix||'.'||p_schema_prefix||'_client_web_cust_model
		 where user_guid='''||v_user_guid||''')::json  )) a
		 where value != 0::text and (value is not null and value != '''' ) '
		 into v_me_and_my_sports_count ;
		 raise notice 'v_me_and_my_sports_count : %',v_me_and_my_sports_count;
		EXECUTE 'select count(1) from (
		select * from json_each_text(
		(select client_mod_json->''data''->''me_and_my_sports'' from '||p_schema_prefix||'.'||p_schema_prefix||'_client_web_cust_model
		 where user_guid='''||v_user_guid||''')::json  )) a '
		 into v_me_and_my_sports_total ;
		raise notice 'v_me_and_my_sports_total : %',v_me_and_my_sports_total;
		EXECUTE 'select count(1) from (
		select * from json_each_text(
		(select client_mod_json->''data''->''me_and_working_in_sports'' from '||p_schema_prefix||'.'||p_schema_prefix||'_client_web_cust_model
		 where user_guid='''||v_user_guid||''')::json  )) a
		 where value != 0::text and (value is not null and value != '''' ) '
		 into v_me_and_working_in_sports_count ;
		 raise notice 'v_me_and_working_in_sports_count : %',v_me_and_working_in_sports_count;
		EXECUTE 'select count(1) from (
		select * from json_each_text(
		(select client_mod_json->''data''->''me_and_working_in_sports'' from '||p_schema_prefix||'.'||p_schema_prefix||'_client_web_cust_model
		 where user_guid='''||v_user_guid||''')::json  )) a '
		 into v_me_and_working_in_sports_total ;
		raise notice 'v_me_and_working_in_sports_total : %',v_me_and_working_in_sports_total;
		v_total := v_aboutMe_total+v_world_of_sport_total+v_change_in_sports_total+v_me_and_my_sports_total+v_me_and_working_in_sports_total;
		
		raise notice 'v_total : %',v_total;
		
		v_count_1	:= v_aboutMe_count+v_world_of_sport_count+v_change_in_sports_count+v_me_and_my_sports_count+v_me_and_working_in_sports_count;
		
		raise notice 'v_count_1 : %',v_count_1;
		
		if v_count_1 <> 0 and v_total <> 0 then
		v_profile_com := (v_count_1 * 100)/v_total;
		execute ' update '||p_schema_prefix||'.'||p_schema_prefix||'_client_web_cust_model
 		set profile_completion = $1
 		where user_guid= $2'
		using v_profile_com, v_user_guid; 
		end if;
		
		p_data := p_json;
		p_data := jsonb_set(p_data::jsonb,'{success_flag}','1',true);
		
	elsif upper(v_module_name) = upper('unsubscribe')  then
	
		select p_json->'data'->'user_data'->>'trans_guid'
		into v_trans_guid;
		raise notice '%',v_trans_guid;
		
		execute 'update '||p_schema_prefix||'.'||p_schema_prefix||'_web_user
				set unsubscribe=1
				where trans_guid = $1 '
		using v_trans_guid;	
		
		p_data := p_json;
		p_data := jsonb_set(p_data::jsonb,'{success_flag}','1',true);
		
	elsif upper(v_module_name) = upper('Runner Data')  then	
		
		select p_json->'data'->'user_data'->>'group_name',
			   p_json->'data'->'user_data'->>'no_of_runners',
			   p_json->'data'->'user_data'->>'total_distance',
			   p_json->'data'->'user_data'->>'no_of_runners_tier1',
			   p_json->'data'->'user_data'->>'no_of_runners_tier2',
			   p_json->'data'->'user_data'->>'no_of_runners_tier3',
			   p_json->'data'->'user_data'->>'company_name',
			   p_json->'data'->'user_data'->>'address',
			   p_json->'data'->'user_data'->>'contact_person',
			   p_json->'data'->'user_data'->>'email_id',
			   p_json->'data'->'user_data'->>'contact_number',
			   p_json->'data'->'user_data'->>'pan_no',
			   p_json->'data'->'user_data'->>'gst_no',
			   p_json->'data'->'user_data'->>'state_code',
			   p_json->'data'->'user_data'->>'city_code',
			   p_json->'data'->'user_data'->>'total_fees',
			   p_json->'data'->'user_data'
		into   v_group_name,
			   v_no_of_runners,
			   v_total_distance,
			   v_no_of_runners_tier1,
			   v_no_of_runners_tier2,
			   v_no_of_runners_tier3,
			   v_company_name,			   
			   v_address,
			   v_contact_person,
			   v_email_id,
			   v_contact_number,
			   v_pan_no,
			   v_gst_no,
			   v_state_code,
			   v_city_code,
			   v_total_fees,
			   v_group_json ;
		
		execute 'select nextval('''||p_schema_prefix||'.seq_'||p_schema_prefix||'_runner_group_id'')'
		into v_runner_group_id;
		
		 execute 'insert into '||p_schema_prefix||'.'||p_schema_prefix||'_runner_group_data(runner_group_id, group_name, no_of_runners,
																		total_distance, no_of_runners_tier1,no_of_runners_tier2,no_of_runners_tier3,
																		total_fees,company_name,address,contact_person,email_id,
																		contact_number,pan_no,gst_no,state_code,city_code,group_json)
					select $1, $2, $3, $4, $5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18'
  		using v_runner_group_id,v_group_name,v_no_of_runners,v_total_distance,v_no_of_runners_tier1,v_no_of_runners_tier2,
			  v_no_of_runners_tier3,v_total_fees,v_company_name,v_address,v_contact_person,v_email_id,
			  v_contact_number,v_pan_no,v_gst_no,v_state_code,v_city_code,v_group_json;
			  
		p_data := p_json;
		p_data := jsonb_set(p_data::jsonb,'{data,user_data,runner_group_id}',v_runner_group_id::text::jsonb,true);
		p_data := jsonb_set(p_data::jsonb,'{success_flag}','1',true);		  
				
	else
     	
		execute 'select nextval('''||p_schema_prefix||'.seq_'||p_schema_prefix||'_custom_module_id'')'
		into v_custom_module_id;
		
		execute 'insert into '||p_schema_prefix||'.'||p_schema_prefix||'_client_web_cust_model(custom_module_id, module_name, client_mod_json,
																								created_date, updated_date)
					select $1, $2, $3, $4, $5'
  		using v_custom_module_id, v_module_name, v_user_data_for_array, v_sysdate, v_sysdate;

		
		p_data := p_json;
		p_data := jsonb_set(p_data::jsonb,'{success_flag}','1',true);
		
	end if;
  	
/*exception
	when others then
		p_data := '{"success_flag": "-1","data": null}';*/
		
end;
$_$;


--
