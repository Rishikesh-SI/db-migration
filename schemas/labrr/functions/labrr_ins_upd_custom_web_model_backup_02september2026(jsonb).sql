-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_ins_upd_custom_web_model_backup_02september2026(jsonb)
-- Type: FUNCTION

-- Name: labrr_ins_upd_custom_web_model_backup_02september2026(jsonb); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_ins_upd_custom_web_model_backup_02september2026(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
v_custom_id numeric;
v_captcha character varying;
v_module_name character varying;
v_mobile_no character varying;
v_user_guid character varying;
v_email_id character varying;
v_datajson jsonb;
v_login numeric;
v_multiple_response numeric;
v_page_flag numeric;

begin
/*
{
  "data": {
    "module": "luckydraw",
    "user_info": {
      "first_name": "Abu",
      "last_name": "Dan",
      "email_id": "ab@gmail.com",
      "mobile_no": ""
    },
    "captcha": ""
  }
}
*/

 select    p_json->'data'->>'module',
		   p_json->'data'->>'user_guid',
		   p_json->'data'->>'captcha',
		   p_json->'data'->>'is_login',
		   p_json->'data'->>'multiple_response',
		   p_json->'data'->'user_info'->>'email_id',
		   p_json->'data'->'user_info'->>'mobile_no',
		   p_json->'data'->>'page_flag'
         
into 
	v_module_name,
	v_user_guid,
	v_captcha,
	v_login,
	v_multiple_response,
	v_email_id,
	v_mobile_no,
	v_page_flag;
	
	
-- insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
-- log_error_message,log_guid,error_json,created_date,client_name,log_type)
-- values (nextval('siwaf.seq_siwaf_api_error_log_id'),'insert-custom_web_model','logs',uuid_generate_v4(),p_json,current_timestamp,'labrr','logs');

if v_page_flag = 10 and coalesce(v_mobile_no, '') <> '' and exists (select 1 from labrr.labrr_custom_web_json where lower(module_name) = lower(v_module_name) and datajson->'data'->'user_info'->>'mobile_no' = v_mobile_no) then
    
	p_data := '{
        "data": {
            "status": "0",
            "message": "This mobile number has already been used for this campaign"
        }
    }'::jsonb;
    return;

end if;

if v_login=1 and v_module_name not in ('ipl_2025_contest_1','ipl_2025_contest_2','alan_walker_ticket_contest','send_a_wish_2','send_a_wish_3',
'send_a_wish_4','send_a_wish_5','send_a_wish_6','sign_up_matchday_jersey','lucky_draw_1','royalsmatchdayscoop','newsletter','poll','power_score','rakshabandhan_campaign') then
raise notice ' v_login=1 ';
select coalesce(user_guid,null) into v_user_guid from labrr.labrr_web_user where user_guid=v_user_guid;

if v_user_guid is not null and v_user_guid<>'' then

if v_multiple_response=0 then

	if not exists(select 1 from labrr.labrr_custom_web_json where user_guid=v_user_guid and module_name=lower(v_module_name)) then
--raise notice ' 2v_module_name %',v_module_name;
						v_custom_id:=nextval('labrr.seq_labrr_custom_id');

						insert into labrr.labrr_custom_web_json
						values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

							
				p_data := jsonb_build_object('data', jsonb_build_object('status', 1,
				'message', 'successful'));

	else
	--raise notice ' 2v_module_name %',v_module_name;
				p_data:='{
					"data": {
					"status":"0",
					"message":"only single entry Allowed"
					}
					}';	

	end if;
	
else 

				v_custom_id:=nextval('labrr.seq_labrr_custom_id');

				insert into labrr.labrr_custom_web_json
				values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

							
				p_data := jsonb_build_object('data', jsonb_build_object('status', 1,
				'message', 'successful'));

end if;

else 

					p_data:='{
						"data": {
							"status":"0",
							"message":"Unable to locate user information"
						}
					}';	

end if;

elsif v_login=0 and v_module_name not in ('ipl_2025_contest_1','ipl_2025_contest_2','alan_walker_ticket_contest','send_a_wish_2','send_a_wish_3',
'send_a_wish_4','send_a_wish_5','send_a_wish_6','sign_up_matchday_jersey','lucky_draw_1','royalsmatchdayscoop','newsletter','fan_memories_campaign', 'tickets_early_access_2026','rakshabandhan_campaign') THEN
raise notice ' v_login=0 ';

if not exists(select 1 from labrr.labrr_custom_web_json where module_name=lower(v_module_name) and datajson->'data'->'user_info'->>'mobile_no'=v_mobile_no) AND
not exists(select 1 from labrr.labrr_custom_web_json where module_name=lower(v_module_name) and datajson->'data'->'user_info'->>'email_id'=v_email_id) and v_multiple_response=0 then
--raise notice ' 2v_module_name %',v_module_name;
						v_custom_id:=nextval('labrr.seq_labrr_custom_id');

						insert into labrr.labrr_custom_web_json
						values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

							
				p_data := jsonb_build_object('data', jsonb_build_object('status', 1,
				'message', 'successful'));
				
elsif v_multiple_response=1 THEN

						v_custom_id:=nextval('labrr.seq_labrr_custom_id');

						insert into labrr.labrr_custom_web_json
						values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

							
				p_data := jsonb_build_object('data', jsonb_build_object('status', 1,
				'message', 'successful'));

else

	p_data:='{
						"data": {
						"status":"0", 
						"message":"Duplicate entry"}
						}';					
				
end if;

else
raise notice ' elseeeeee  ';
if v_module_name in ('ipl_2025_contest_1','ipl_2025_contest_2','alan_walker_ticket_contest','send_a_wish_2','send_a_wish_3',
'send_a_wish_4','send_a_wish_5','send_a_wish_6','sign_up_matchday_jersey','lucky_draw_1','royalsmatchdayscoop','newsletter','rr_sponsors','fan_memories_campaign','tickets_early_access_2026','poll','power_score','rakshabandhan_campaign') then
raise notice 'v_module_name:%',v_module_name;
	--raise notice 'v_module_name %',v_module_name;
	if lower(v_module_name) = 'royalsmatchdayscoop' then
   
	if not exists(select 1 from labrr.labrr_custom_web_json where user_guid=v_user_guid and module_name=lower('royalsmatchdayscoop')) then
						v_custom_id:=nextval('labrr.seq_labrr_custom_id');

				insert into labrr.labrr_custom_web_json
						values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

							
				p_data := jsonb_build_object('data', jsonb_build_object('status', 1,
				'message', 'successful'));

	else
				p_data:='{
					"data": {
					"status":"0",
					"message":"only single entry Allowed"
					}
					}';	

	end if;
	------------------------------------------------------------------
	elsif lower(v_module_name) = 'power_score' then
		raise notice 'here 111';
			if not exists (
				select 1 
				from labrr.labrr_custom_web_json 
				where user_guid = v_user_guid 
				  and lower(module_name) = lower('power_score')
			) then

				v_custom_id := nextval('labrr.seq_labrr_custom_id');

				insert into labrr.labrr_custom_web_json
				values (
					v_custom_id,
					v_captcha,
					current_timestamp,
					current_timestamp,
					v_user_guid,
					'power_score',
					p_json
				);

				p_data := jsonb_build_object(
					'data', jsonb_build_object(
						'status', 1,
						'message', 'successful'
					)
				);

			else

				update labrr.labrr_custom_web_json
				set updated_date = current_timestamp,
					datajson = p_json
				where user_guid = v_user_guid
				  and lower(module_name) = lower('power_score');

				p_data := jsonb_build_object(
					'data', jsonb_build_object(
						'status', 2,
						'message', 'Data Updated Successfully!'
					)
				);

			end if;
	-------------------------------------------------------------------
	elsif lower(v_module_name) = 'rakshabandhan_campaign' then
		if coalesce(v_mobile_no, '') = '' then
				p_data := '{
					"data": {
					"status":"0",
					"message":"Mobile number is required"
					}
					}';
		elsif exists (
				select 1
				from labrr.labrr_custom_web_json
				where lower(module_name) = 'rakshabandhan_campaign'
				  and datajson->'data'->'user_info'->>'mobile_no' = v_mobile_no
			) then
				p_data := '{
					"data": {
					"status":"0",
					"message":"This mobile number has already been used for this campaign"
					}
					}';
		else
				v_custom_id := nextval('labrr.seq_labrr_custom_id');
				insert into labrr.labrr_custom_web_json
				values (
					v_custom_id,
					v_captcha,
					current_timestamp,
					current_timestamp,
					v_user_guid,
					'rakshabandhan_campaign',
					p_json
				);
				p_data := jsonb_build_object('data', jsonb_build_object('status', 1,
				'message', 'successful'));
		end if;
	---------------------------------------------------------------------------------------
	elsif lower(v_module_name) in ('newsletter','rr_sponsors') then
				
								v_custom_id:=nextval('labrr.seq_labrr_custom_id');
				
								insert into labrr.labrr_custom_web_json
								values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

								p_data:='{
								"data": {
								"status":"1"
								}}';	

	elsif lower(v_module_name) in ('ipl_2025_contest_1','ipl_2025_contest_2','alan_walker_ticket_contest','send_a_wish_2','send_a_wish_3',
'send_a_wish_4','send_a_wish_5','send_a_wish_6','sign_up_matchday_jersey','lucky_draw_1','fan_memories_campaign', 'tickets_early_access_2026','poll') then
--raise notice 'v_module_name %',v_module_name;
	if not exists(select 1 from labrr.labrr_custom_web_json where user_guid=v_user_guid and module_name=lower(v_module_name)) then
--raise notice ' 2v_module_name %',v_module_name;
						v_custom_id:=nextval('labrr.seq_labrr_custom_id');

						insert into labrr.labrr_custom_web_json
						values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

							
				p_data := jsonb_build_object('data', jsonb_build_object('status', 1,
				'message', 'successful'));
				
		
	---------------------------------------------------
	
	-- ================= POLL INSERT (FINAL WORKING) =================

-- -- normalize module name
-- v_module_name := trim(coalesce(v_module_name, ''));

-- RAISE NOTICE 'MODULE VALUE = [%]', v_module_name;

-- IF lower(v_module_name) = 'poll' THEN

--     RAISE NOTICE 'POLL BLOCK HIT';

--     -- A. Validate login
--     IF coalesce(v_user_guid, '') = '' THEN
--         p_data := jsonb_build_object(
--             'data', jsonb_build_object(
--                 'status', '0',
--                 'message', 'User not authenticated'
--             )
--         );
--         RETURN;
--     END IF;

--     -- B. Validate poll_id & option_id
--     IF coalesce(p_json->'data'->>'poll_id', '') = '' 
--        OR coalesce(p_json->'data'->>'option_id', '') = '' THEN

--         p_data := jsonb_build_object(
--             'data', jsonb_build_object(
--                 'status', '0',
--                 'message', 'Invalid poll data'
--             )
--         );
--         RETURN;
--     END IF;

--     -- C. Prevent duplicate vote
--     IF EXISTS (
--         SELECT 1
--         FROM labrr.labrr_poll_response
--         WHERE poll_id = (p_json->'data'->>'poll_id')::numeric
--           AND poll_response_guid = v_user_guid
--           AND is_deleted = 0
--     ) THEN
--         p_data := jsonb_build_object(
--             'data', jsonb_build_object(
--                 'status', '0',
--                 'message', 'User already voted on this poll'
--             )
--         );
--         RETURN;
--     END IF;

--     -- D. Insert vote
--     INSERT INTO labrr.labrr_poll_response
--     (
--         poll_response_id,
--         poll_id,
--         response_option_id,
--         created_date,
--         updated_date,
--         is_active,
--         is_deleted,
--         poll_response_guid
--     )
--     VALUES
--     (
--         nextval('labrr.seq_labrr_poll_response_id'),
--         (p_json->'data'->>'poll_id')::numeric,
--         (p_json->'data'->>'option_id')::numeric,
--         current_timestamp,
--         current_timestamp,
--         1,
--         0,
--         v_user_guid
--     );

--     -- E. Success
--     p_data := jsonb_build_object(
--         'data', jsonb_build_object(
--             'status', '1',
--             'message', 'Vote submitted successfully'
--         )
--     );

--     RETURN;

-- END IF;

-------------------------------------------------------
	else
	--raise notice ' 2v_module_name %',v_module_name;
				p_data:='{
					"data": {
					"status":"0",
					"message":"only single entry Allowed"
					}
					}';	

	--end if;
	
	end if;

end if;

end if;						  
end if;
end;
$$;


--
