-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: labfih_custom_signin(jsonb)
-- Type: FUNCTION

-- Name: labfih_custom_signin(jsonb); Type: FUNCTION; Schema: labfih; Owner: -
--

CREATE FUNCTION labfih.labfih_custom_signin(p_user_json jsonb, OUT p_ures_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_current_timestamp TIMESTAMP WITHOUT TIME ZONE;
    v_client_id NUMERIC;
    v_social_user_name VARCHAR;
    v_user_full_name VARCHAR;
    v_email_id VARCHAR;
    v_user_password VARCHAR;
    v_social_id VARCHAR;
    v_upper_email_id VARCHAR;
    v_web_user_id NUMERIC;
    v_user_guid VARCHAR;
    v_is_active NUMERIC;
    v_is_deleted NUMERIC;
    v_created_by NUMERIC;
    v_updated_by NUMERIC;
    v_created_date TIMESTAMP WITHOUT TIME ZONE;
    v_updated_date TIMESTAMP WITHOUT TIME ZONE;
    v_reset_key VARCHAR;
    v_key_expiry_date TIMESTAMP WITHOUT TIME ZONE;
    v_reset_key_status NUMERIC;
    v_dob VARCHAR;
    v_profile_picture_url VARCHAR;
    v_city VARCHAR;
    v_mobile_no VARCHAR;
    v_gender VARCHAR;
    v_sport_skill JSON;
    v_sport_skill_map JSON;
    v_sport_id NUMERIC;
    v_skill_level NUMERIC;
    v_result NUMERIC;
    v_is_verified NUMERIC;
    v_is_custom NUMERIC;
    v_userjson JSONB;
    v_favourite_club VARCHAR;
    v_edition VARCHAR;
    v_status NUMERIC;
    v_is_first_login NUMERIC := 0;
    v_token VARCHAR;
    v_epoch_timestamp VARCHAR;
    v_confirm_password VARCHAR;
    v_old_password VARCHAR;
    v_failed_attempts NUMERIC;
    v_unlock_date TIMESTAMP;
    v_is_registered NUMERIC;
    v_ipaddress VARCHAR;
    v_message VARCHAR;
    v_is_app NUMERIC;
    v_user_id NUMERIC;
    v_img_url VARCHAR;
    v_is_login NUMERIC;
    v_verification_key VARCHAR;
    v_err_code VARCHAR;
    v_err_msg VARCHAR;
    v_emailid_ex VARCHAR;
    v_is_custom_image NUMERIC;
    v_old_profile_image_url VARCHAR;
    v_is_custom_image_tab NUMERIC;
    v_country_id NUMERIC;
    v_state_id NUMERIC;
    v_city_id NUMERIC;
    v_country_name TEXT;
    v_state_name TEXT;
    v_city_name TEXT;
    v_email_social TEXT;
    v_profile_image_social TEXT;
    v_profile_completion_percentage NUMERIC;
    v_is_new_reg NUMERIC := 0;
    v_reg_cnt NUMERIC := 0;
    v_gift_id NUMERIC := 0;
    v_gift_url TEXT;
    v_gift_name VARCHAR(500) := 'NO GIFT';
    v_available_quantity NUMERIC;
    v_gratification_value NUMERIC;
    v_profile_complete NUMERIC;
    v_better_luck_value NUMERIC;
    v_first_name VARCHAR;
    v_last_name VARCHAR;
    v_membership_code VARCHAR;
    v_favourite_player_id VARCHAR;
    v_platform_version VARCHAR;
    v_device_name VARCHAR;
    v_platform_type NUMERIC;
    v_option_type NUMERIC;
    v_email_verified NUMERIC;
    v_mobile_verified NUMERIC;
    v_jersey_number NUMERIC;
    v_country_code VARCHAR;
    v_asc_with_hockey JSONB;
    v_ext_info JSONB;
    v_age_group VARCHAR;
    v_accept_tnc BOOLEAN;

BEGIN
    v_current_timestamp := CURRENT_TIMESTAMP AT TIME ZONE 'UTC';

    SELECT
        p_user_json->'data'->>'user_guid',
        p_user_json->'data'->>'token',
        p_user_json->'data'->>'epoch_timestamp',
        p_user_json->'data'->>'social_id',
        p_user_json->'data'->>'client_id',
        p_user_json->'data'->>'email_id',
        p_user_json->'data'->>'status',
        p_user_json->'data'->>'reset_key',
        p_user_json->'data'->>'key_expiry_date',
        p_user_json->'data'->>'password',
        p_user_json->'data'->>'confirm_password',
        p_user_json->'data'->>'old_password',
        p_user_json->'data'->>'failed_attempts',
        p_user_json->'data'->>'unlock_date',
        p_user_json->'data'->>'is_registered',
        p_user_json->'data'->>'is_verified',
        p_user_json->'data'->>'ipaddress',
        p_user_json->'data'->'user'->>'mobile_no',
        p_user_json->'data'->'user'->>'name',
        p_user_json->'data'->'user'->>'social_user_name',
        p_user_json->'data'->'user'->>'dob',
        p_user_json->'data'->'user'->>'gender',
        p_user_json->'data'->'user'->>'city',
        p_user_json->'data'->'user'->>'favourite_club',
        p_user_json->'data'->'user'->>'edition',
        p_user_json->'data'->'user'->>'social_user_image',
        p_user_json->'data'->'user'->>'asc_with_hockey',
        p_user_json->'data'->'user'->>'ext_info',
        p_user_json->'data'->'user'->>'age_group',
        p_user_json->'data'->>'is_app',
        p_user_json->'data'->>'verification_key',
        p_user_json->'data'->>'is_deleted',
        p_user_json->'data'->>'is_active',
        p_user_json->'data'->>'is_custom_image',
        p_user_json->'data'->'user'->>'country_id',
        p_user_json->'data'->'user'->>'state_id',
        p_user_json->'data'->'user'->>'city_id',
        p_user_json->'data'->>'platform_version',
        p_user_json->'data'->>'device_name',
        p_user_json->'data'->>'platform_type',
        p_user_json->'data'->>'option_type',
        p_user_json->'data'->>'accept_tnc'
		
		/*  
      "mobile_no": null,
      "name": "abc",
      "social_user_name": null,
      "dob": null,
      "gender": null,
      "city": null,
      "favourate_club": null,
      "edition": null
    }
    */
    INTO
        v_user_guid,
        v_token,
        v_epoch_timestamp,
        v_social_id,
        v_client_id,
        v_email_id,
        v_is_active,
        v_reset_key,
        v_key_expiry_date,
        v_user_password,
        v_confirm_password,
        v_old_password,
        v_failed_attempts,
        v_unlock_date,
        v_is_registered,
        v_is_verified,
        v_ipaddress,
        v_mobile_no,
        v_user_full_name,
        v_social_user_name,
        v_dob,
        v_gender,
        v_city,
        v_favourite_club,
        v_edition,
        v_profile_picture_url,
        v_asc_with_hockey,
        v_ext_info,
        v_age_group,
        v_is_app,
        v_verification_key,
        v_is_deleted,
        v_is_active,
        v_is_custom_image,
        v_country_id,
        v_state_id,
        v_city_id,
        v_platform_version,
        v_device_name,
        v_platform_type,
        v_option_type,
        v_accept_tnc;

    v_upper_email_id := upper(v_email_id);
    v_created_date := v_current_timestamp;
    v_updated_date := v_current_timestamp;
    v_option_type := 4;
   -- v_client_id := 5;

    /* ****************************************
      Client_id     Client
      2   			Facebook
      3             Twitter
      4 			Google+
      5				Custom
    ****************************************  */

    INSERT INTO siwaf.siwaf_client_logs(api_error_log_id, log_method_name, log_error_message, log_guid, error_json, created_date, client_name, log_type)
    VALUES (nextval('siwaf.seq_siwaf_api_error_log_id'), 'labfih_custom_signin', 'logs', uuid_generate_v4(), p_user_json, CURRENT_TIMESTAMP, 'labfih', 'logs');

    v_user_guid := uuid_generate_v4();

IF EXISTS (
    SELECT 1
    FROM labfih.labfih_web_user
    WHERE email_id = v_email_id
      AND user_password = v_user_password
      AND is_deleted = 1
) THEN
    SELECT
        failed_attempts, unlock_date, is_verified, user_guid, user_full_name, verification_key,
        favourite_club, edition, is_deleted, is_active, profile_picture_url, is_custom_image,
        first_name, last_name, mobile_no, membership_code, email_id, dob, gender, country_id,
        city, favourite_player_id, user_guid, user_id, mobile_verified, email_verified,
        country_code, asc_with_hockey, ext_info, age_group, accept_tnc
    INTO
        v_failed_attempts, v_unlock_date, v_is_verified, v_user_guid, v_user_full_name, v_verification_key,
        v_favourite_club, v_edition, v_is_deleted, v_is_active, v_profile_picture_url, v_is_custom_image,
        v_first_name, v_last_name, v_mobile_no, v_membership_code, v_email_id, v_dob, v_gender, v_country_id,
        v_city, v_favourite_player_id, v_user_guid, v_user_id, v_mobile_verified, v_email_verified,
        v_country_code, v_asc_with_hockey, v_ext_info, v_age_group, v_accept_tnc
    FROM labfih.labfih_web_user
    WHERE email_id = v_email_id
      ;

    v_status := 500;
    v_message := 'Login Successful';

ELSE

raise notice 'v_client_id:%',v_client_id;
raise notice 'v_email_id:%',v_email_id;
raise notice 'v_client_id:%',v_user_password;

    IF EXISTS (
        select 1 from labfih.labfih_web_user 
		where email_id=v_email_id
		
    ) THEN
	
	update labfih.labfih_web_user
	set user_password =v_user_password where email_id=v_email_id;
		
	-------
	IF v_failed_attempts >= 3 THEN
            v_unlock_date := v_current_timestamp + INTERVAL '24 hours';

            UPDATE labfih.labfih_web_user
            SET
                failed_attempts = failed_attempts + 1,
                unlock_date = v_unlock_date,
                updated_date = v_current_timestamp,
                ipaddress = v_ipaddress
            WHERE
                upper_email_id = v_upper_email_id
              ;

            v_status := 0;
            v_message := 'Account locked due to multiple failed attempts. Please try again after 24 hours.';
        ELSE
	-------------

		raise notice '222v_email_id:%',v_email_id;
        SELECT
            failed_attempts, unlock_date, is_verified, user_guid, user_full_name, verification_key,
            favourite_club, edition, is_deleted, is_active, profile_picture_url, is_custom_image,
            first_name, last_name, mobile_no, membership_code, email_id, dob, gender, country_id,
            city, favourite_player_id, user_guid, user_id, mobile_verified, email_verified,
            country_code, asc_with_hockey, ext_info, age_group, accept_tnc
        INTO
            v_failed_attempts, v_unlock_date, v_is_verified, v_user_guid, v_user_full_name, v_verification_key,
            v_favourite_club, v_edition, v_is_deleted, v_is_active, v_profile_picture_url, v_is_custom_image,
            v_first_name, v_last_name, v_mobile_no, v_membership_code, v_email_id, v_dob, v_gender, v_country_id,
            v_city, v_favourite_player_id, v_user_guid, v_user_id, v_mobile_verified, v_email_verified,
            v_country_code, v_asc_with_hockey, v_ext_info, v_age_group, v_accept_tnc
        FROM labfih.labfih_web_user
        WHERE email_id = v_email_id
          ;

        IF COALESCE(v_is_deleted, 0) = 1 AND v_is_active = 0 THEN
            v_status := 7;
            v_message := 'Account delete request is pending. To cancel this request, restore your account.';
        ELSIF v_user_full_name IS NULL OR v_email_id IS NULL THEN
            v_status := 2;
            v_message := 'Your profile is incomplete';
        ELSIF COALESCE(v_unlock_date, v_current_timestamp) <= v_current_timestamp THEN
		
	raise notice '3222v_email_id:%',v_email_id;
	
            UPDATE labfih.labfih_web_user
            SET failed_attempts = 0,
                unlock_date = NULL,
                updated_date = v_current_timestamp,
                ipaddress = v_ipaddress,
				 user_password =v_user_password 
            WHERE email_id = v_email_id;
              

            v_status := 1;
            v_message := 'Login Successful';
        ELSE
            v_status := 0;
            v_message := 'This account has been locked. Please try again after 24 hours.';
            v_user_guid := '';
            v_user_full_name := '';
        END IF;
		end if;

    else 
	
		raise notice '4222v_email_id:%',v_email_id;
		
		IF not EXISTS (
			select 1 from labfih.labfih_web_user 
			where email_id=v_email_id) 
			then 	
			insert into labfih.labfih_web_user (
                user_id, client_id, user_guid, email_id, upper_email_id, user_password,
                user_full_name, mobile_no, dob, gender, city,
                favourite_club, edition, profile_picture_url, is_custom_image,
                country_id, state_id, city_id, created_date, updated_date,
                failed_attempts, unlock_date, is_verified, ipaddress,
                is_deleted, is_active, verification_key, first_name, last_name,
                membership_code, mobile_verified, email_verified, country_code,
                asc_with_hockey, ext_info, age_group, accept_tnc
            ) VALUES (
                nextval('labfih.seq_labfih_user_id'),
                v_client_id, v_user_guid, v_email_id, UPPER(v_email_id), v_user_password,
                v_user_full_name, v_mobile_no, v_dob, v_gender, v_city,
                v_favourite_club, v_edition, v_profile_picture_url, v_is_custom_image,
                v_country_id, v_state_id, v_city_id, v_created_date, v_updated_date,
                0, NULL, 0, v_ipaddress,
                0, 1, v_verification_key, v_first_name, v_last_name,
                v_membership_code, v_mobile_verified, v_email_verified, v_country_code,
                v_asc_with_hockey, v_ext_info, v_age_group, v_accept_tnc
            );

            v_status := 1;
            v_message := 'Register successfully';
		end if;
        
    END IF;
	
	
  		
			
			
END IF;

    INSERT INTO labfih.labfih_web_user_audit (
        audit_id, user_id, user_guid, ipaddress, audit_date, is_app, platform_version, device_name, platform_type, option_type
    ) VALUES (
        nextval('labfih.seq_labfih_web_user_audit_id'), v_user_id, v_user_guid, v_ipaddress, v_current_timestamp, COALESCE(v_is_app, 0), v_platform_version, v_device_name, v_platform_type, v_option_type
    );

    p_ures_json := '{
        "data": {
            "password": "' || COALESCE(v_user_password, '') || '",
            "pass_type": "ph pass",
            "user_guid": "' || COALESCE(v_user_guid, '') || '",
            "waf_user_guid": "' || COALESCE(v_user_guid, '') || '",
            "token": "' || COALESCE(v_token, '') || '",
            "epoch_timestamp": "' || COALESCE(v_epoch_timestamp, '') || '",
            "email_id": "' || COALESCE(v_email_id, '') || '",
            "status": ' || COALESCE(v_status, 0) || ',
            "message": "' || COALESCE(v_message, '') || '",
            "platform_version": "' || COALESCE(v_platform_version, '') || '",
            "device_name": "' || COALESCE(v_device_name, '') || '",
            "platform_type": "' || COALESCE(v_platform_type, 0) || '",
            "mobile_verified": "' || COALESCE(v_mobile_verified, 0) || '",
            "email_verified": "' || COALESCE(v_email_verified, 0) || '",
            "option_type": "' || COALESCE(v_option_type, 0) || '",
            "user": {
                "mobile_no": "' || COALESCE(v_mobile_no, '') || '",
                "name": "' || COALESCE(v_user_full_name, '') || '",
                "first_name": "' || COALESCE(v_first_name, '') || '",
                "last_name": "' || COALESCE(v_last_name, '') || '",
                "social_user_name": "' || COALESCE(v_social_user_name, '') || '",
                "dob": "' || COALESCE(v_dob::VARCHAR, '') || '",
                "gender": "' || COALESCE(v_gender, '') || '",
                "city": "' || COALESCE(v_city_name, '') || '",
                "city_id": "' || COALESCE(v_city_id::VARCHAR, '') || '",
                "state_name": "' || COALESCE(v_state_name, '') || '",
                "state_id": "' || COALESCE(v_state_id::VARCHAR, '') || '",
                "country_name": "' || COALESCE(v_country_name, '') || '",
                "country_id": "' || COALESCE(v_country_id::VARCHAR, '') || '",
                "favourite_club": "' || COALESCE(v_favourite_club, '') || '",
                "favourite_player_id": "' || COALESCE(v_favourite_player_id, '') || '",
                "accept_tnc": ' || COALESCE(v_accept_tnc, 'false') || ',
                "edition": "' || COALESCE(v_edition, '') || '",
                "social_user_image": "' || COALESCE(v_profile_picture_url, v_old_profile_image_url, '') || '",
                "membership_code": "' || COALESCE(v_membership_code, '') || '",
                "country_code": "' || COALESCE(v_country_code, '') || '",
                "age_group": "' || COALESCE(v_age_group, '') || '"
            },
            "is_first_login": 0,
            "is_app": ' || COALESCE(v_is_app, 0) || ',
            "is_custom_image": "' || COALESCE(v_is_custom_image, '0') || '",
            "old_profile_img_url": "' || COALESCE(v_old_profile_image_url, '') || '"
        }
    }';

    p_ures_json := jsonb_set(p_ures_json, '{data,user,ext_info}', COALESCE(v_ext_info, 'null'), true);
    p_ures_json := jsonb_set(p_ures_json, '{data,user,asc_with_hockey}', COALESCE(v_asc_with_hockey, 'null'), true);

END;
$$;


--
