-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_get_custom_web_model_r_backup_03september2026(jsonb)
-- Type: FUNCTION

-- Name: labrr_get_custom_web_model_r_backup_03september2026(jsonb); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_get_custom_web_model_r_backup_03september2026(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
	declare
	
		/*
		{
		  "user_guid": "7d9599b7-ef18-4f68-a805-ac433a09f65f",
		  "module_name": "power_score",
		  "is_app": "1"
		}
		*/
		
		v_user_guid text;
		v_module_name text;
		v_user_exists boolean;
		v_data_exists boolean;

	begin
	
		select p_json->>'user_guid',
			   p_json->>'module_name'
		into   v_user_guid,
			   v_module_name;

		-- check if user exists
		select exists(
			select 1 from labrr.labrr_web_user
			where user_guid = v_user_guid
		) into v_user_exists;

		-- check if campaign data exists for this user + module
		select exists(
			select 1 from labrr.labrr_custom_web_json
			where user_guid = v_user_guid
			and lower(module_name) = lower(v_module_name)
		) into v_data_exists;

		-- ======================== USER DOES NOT EXIST ========================
		if not v_user_exists then

			p_data := jsonb_build_object(
				'data', jsonb_build_object(
					'status', '0',
					'message', 'Invalid user_guid — no matching user found'
				)
			);

		-- ======================== POWER_SCORE ========================
		elsif lower(v_module_name) = 'power_score' then

			if v_data_exists then

				select jsonb_build_object(
					'data', jsonb_build_object(
						'status', '1',
						'message', 'Data Found',
						'module_name', v_module_name,
						'submission_date', to_char(created_date, 'YYYY-MM-DD HH24:MI:SS'),
						'last_updated_date', to_char(updated_date, 'YYYY-MM-DD HH24:MI:SS'),
						'form_input', datajson->'data'->'form_input',
						'results', datajson->'data'->'results',
						'user_info', datajson->'data'->'user_info',
						'platform', datajson->'data'->>'platform'
					)
				)
				into p_data
				from labrr.labrr_custom_web_json
				where user_guid = v_user_guid
				and lower(module_name) = 'power_score';

			else

				p_data := jsonb_build_object(
					'data', jsonb_build_object(
						'status', '0',
						'message', 'No power_score data found for this user'
					)
				);

			end if;

		-- ======================== COMETCHATFANCLUB ========================
		elsif lower(v_module_name) = 'cometchatfanclub' then

			if v_data_exists then

				select jsonb_build_object(
					'data', json_agg(row)
				)
				into p_data
				from (
					select 
						datajson->'data'->>'club_name' as club_name,
						status,
						remark 
					from labrr.labrr_custom_web_json
					where user_guid = v_user_guid
					and lower(module_name) = lower(v_module_name)
				) row;

			else

				p_data := jsonb_build_object(
					'data', jsonb_build_object(
						'status', '0',
						'message', 'No fanclub data found for this user'
					)
				);

			end if;

		-- ======================== ALL OTHER MODULES ========================
		else

			if v_data_exists then

				p_data := jsonb_build_object(
					'data', jsonb_build_object(
						'status', '1',
						'message', 'Already Exists'
					)
				);

			else

				p_data := jsonb_build_object(
					'data', jsonb_build_object(
						'status', '0',
						'message', 'Not Exists'
					)
				);

			end if;

		end if;

	end;

$$;


--
