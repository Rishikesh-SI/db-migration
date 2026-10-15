-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_ins_upd_user_profile(text, jsonb)
-- Type: FUNCTION

-- Name: labbsc_dev_ins_upd_user_profile(text, jsonb); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_ins_upd_user_profile(p_schema_prefix text, p_json jsonb, OUT p_result numeric, OUT p_user_profile jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	
	v_module_name text;
	v_user_guid text;
	v_user_id numeric;
	v_profile_completion_percentage numeric;
	v_email_id text;
	v_image_url text;
	v_user_email_id text;
	v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	is_custom_image numeric;
	v_first_name text;
	v_last_name text;
	v_status numeric;
	v_code text;
 
-- 	v_about_me_total numeric;
-- 	v_world_of_sport_count numeric;
-- 	v_world_of_sport_total numeric;
-- 	v_change_in_sports_count numeric;
-- 	v_change_in_sports_total numeric;
-- 	v_me_and_my_sports_count numeric;
-- 	v_me_and_my_sports_total numeric;
-- 	v_me_and_working_in_sports_count numeric;
-- 	v_me_and_working_in_sports_total numeric;
-- 	v_total numeric;
-- 	v_count numeric;
	
begin
	
	select p_json->'data'->>'module_name', p_json->'data'->>'user_guid', p_json->'data'->>'profile_percentage',
			p_json->'data'->'aboutMe'->>'email', p_json->'data'->'aboutMe'->>'imageUpload',p_json->'data'->'aboutMe'->>'is_custom_image',
			p_json->'data'->'aboutMe'->>'f_name',
			p_json->'data'->'aboutMe'->>'l_name',
			p_json->'data'->>'status'
	into v_module_name, v_user_guid, v_profile_completion_percentage, v_email_id, v_image_url,is_custom_image,
	v_first_name,v_last_name,v_status;
	
	select email_id, user_id,university_code 
	into strict v_user_email_id, v_user_id ,v_code
	from labbsc_dev.labbsc_dev_web_user
	where user_guid = v_user_guid;

	
	if v_email_id is not null and v_email_id <> '' then
		
		if v_user_email_id is null and v_user_email_id = '' then
			
			update labbsc_dev.labbsc_dev_web_user
			set email_id = v_email_id,
				updated_date = v_current_timestamp
			where user_guid = v_user_guid;
			
		else
			
			if v_user_email_id <> v_email_id then
				
				p_result := 0;
				
			end if;
			
		end if;
		
	end if;
	
	if (v_first_name is not null and   v_first_name <> '' )
	then
	update labbsc_dev.labbsc_dev_web_user
			set first_name = v_first_name,
				updated_date = v_current_timestamp
			where user_guid = v_user_guid;
	
	end if;
	if (v_last_name is not null and   v_last_name <> '' )
	then
	update labbsc_dev.labbsc_dev_web_user
			set last_name = v_last_name,
				updated_date = v_current_timestamp
			where user_guid = v_user_guid;
	
	end if;
	
	if p_result is null then
		
		if exists(select 1
				  from labbsc_dev.labbsc_dev_user_tests
				  where user_id  = v_user_id
				  and is_attempted = 1
				  and attempted_on + (test_duration::text||' hours')::interval >= v_current_timestamp) then
			
			p_result := -3;
			
		end if;
		
	end if;
	
	if p_result is null then
		
		if v_image_url is not null and v_image_url <> '' and is_custom_image=1 then

			update labbsc_dev.labbsc_dev_web_user
			set profile_picture_url = v_image_url,
				is_custom_image = 1,
				updated_date = v_current_timestamp
			where user_id = v_user_id;

		end if;
		
-- 		select count(1)
-- 		into v_about_me_total
-- 		from (select * from json_each_text((p_json->'data'->'aboutMe')::json))tab;
		
-- 		select count(1)
-- 		into v_about_me_count
-- 		from (select * from json_each_text((p_json->'data'->'aboutMe')::json))tab
-- 		where value <> '0' and value is not null and value <> '';
		
-- 		select count(1)
-- 		into v_world_of_sport_total
-- 		from (select * from json_each_text((p_json->'data'->'world_of_sport')::json))tab;
		
-- 		select count(1)
-- 		into v_world_of_sport_count
-- 		from (select * from json_each_text((p_json->'data'->'world_of_sport')::json))tab
-- 		where value <> '0' and value is not null and value <> '';
		
-- 		select count(1)
-- 		into v_change_in_sports_total
-- 		from (select * from json_each_text((p_json->'data'->'change_in_sports')::json))tab;
		
-- 		select count(1)
-- 		into v_change_in_sports_count
-- 		from (select * from json_each_text((p_json->'data'->'change_in_sports')::json))tab
-- 		where value <> '0' and value is not null and value <> '';
		
-- 		select count(1)
-- 		into v_me_and_my_sports_total
-- 		from (select * from json_each_text((p_json->'data'->'me_and_my_sports')::json))tab;
		
-- 		select count(1)
-- 		into v_me_and_my_sports_count
-- 		from (select * from json_each_text((p_json->'data'->'me_and_my_sports')::json))tab
-- 		where value <> '0' and value is not null and value <> '';
		
-- 		select count(1)
-- 		into v_me_and_working_in_sports_total
-- 		from (select * from json_each_text((p_json->'data'->'me_and_working_in_sports')::json))tab;
		
-- 		select count(1)
-- 		into v_me_and_working_in_sports_count
-- 		from (select * from json_each_text((p_json->'data'->'me_and_working_in_sports')::json))tab
-- 		where value <> '0' and value is not null and value <> '';
		
-- 		v_total := v_about_me_total + v_world_of_sport_total + v_change_in_sports_total + v_me_and_my_sports_total + v_me_and_working_in_sports_total;
-- 		v_count	:= v_about_me_count + v_world_of_sport_count + v_change_in_sports_count + v_me_and_my_sports_count + v_me_and_working_in_sports_count;
-- 		v_profile_completion_percentage := (v_count * 100) / v_total;
		
-- 		p_json := jsonb_set(p_json, '{data,profile_completion}', ('"'||v_profile_completion_percentage||'"')::jsonb, true);
		
		if exists(select 1 from labbsc_dev.labbsc_dev_client_web_cust_model where user_guid = v_user_guid and module_name in ('user_profile','sporjo_coach_user_profile')) then
			
			update labbsc_dev.labbsc_dev_client_web_cust_model
			set client_mod_json = p_json,
				profile_completion = v_profile_completion_percentage,
				status=v_status,
				updated_date = v_current_timestamp
			where user_guid = v_user_guid
			and module_name in ('user_profile','sporjo_coach_user_profile');
			
		else
			
  			insert into labbsc_dev.labbsc_dev_client_web_cust_model(custom_module_id, module_name, client_mod_json, created_date, updated_date,
															user_guid, profile_completion,status)
			select nextval('labbsc_dev.seq_labbsc_dev_custom_module_id'), v_module_name, p_json, v_current_timestamp, v_current_timestamp, v_user_guid,
					v_profile_completion_percentage,v_status;
			
		end if;
		
		p_user_profile := p_json;
		p_user_profile := jsonb_set(p_user_profile,'{success_flag}',('"'||'1'||'"')::jsonb,true);
		p_result := 1;
		
	else
		
		p_user_profile := jsonb_set(p_user_profile,'{success_flag}',('"'||'0'||'"')::jsonb,true);
		
	end if;
	
	p_user_profile := jsonb_set(p_user_profile,'{sporjo_code}',('"'||coalesce(v_code,'')||'"')::jsonb,true);
	
/*exception
	
	when others then
		p_result := -1;
		p_user_profile := '{"success_flag": "-1", "data": null}'::jsonb;
	
	when no_data_found then
		p_result := -2;
		p_user_profile := '{"success_flag": "-2", "data": null}'::jsonb;*/
	
end;
$$;


--
