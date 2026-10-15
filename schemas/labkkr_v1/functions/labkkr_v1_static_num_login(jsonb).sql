-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_v1
-- Object: labkkr_v1_static_num_login(jsonb)
-- Type: FUNCTION

-- Name: labkkr_v1_static_num_login(jsonb); Type: FUNCTION; Schema: labkkr_v1; Owner: -
--

CREATE FUNCTION labkkr_v1.labkkr_v1_static_num_login(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Input/identity
    v_mobile_no                 varchar(1000);
    v_email_id                  varchar(1000);
    v_opt_type                  numeric;
    v_is_app                    numeric;
    v_country_code              numeric;
    v_accept_tnc                boolean;
    v_accept_disclaimer         boolean;
    v_membership_code           varchar;
    v_platform_version          numeric;
    v_device_name               varchar;
    v_platform_type             numeric;
    v_ipaddress                 varchar;
    v_mobile_with_countrycode   varchar;
    v_country_flag_id           numeric;
    v_subscribe_for_email       boolean;
    v_ext_info                  jsonb;

    -- Optional user inputs
    v_first_name                varchar;
    v_last_name                 varchar;
    v_pincode                   varchar;
    v_city_id                   numeric;
    v_city_name_in              varchar;
    v_state_id                  numeric;
    v_state_name_in             varchar;
    v_country_id_in             numeric;
    v_country_name_in           varchar;
    v_social_user_name          varchar;
    v_gender                    varchar;
    v_dob                       varchar;
    v_favourite_player_id_in    varchar;
    v_favourite_player_name_in  varchar;
    v_jersey_number_in          numeric;
    v_jersey_name_in            varchar;

    -- Runtime / DB
    v_current_timestamp         timestamp without time zone := current_timestamp;
    v_failed_attempts           numeric;
    v_unlock_date               timestamp;
    v_is_verified               numeric;
    v_user_guid                 varchar;
    v_user_full_name            varchar;
    v_verification_key          varchar;
    v_favourite_club            varchar;
    v_edition                   varchar;
    v_is_deleted                numeric;
    v_is_active                 numeric;
    v_profile_picture_url       varchar;
    v_is_custom_image           numeric;
    v_city                      varchar;
    v_favourite_player_id       varchar;
    v_created_date_1            timestamp;
    v_web_user_id               numeric;
    v_email_verified            numeric;
    v_jersey_number             numeric;
    v_jersey_name               varchar;
    v_mobile_verified           numeric;
    v_interest_ids              jsonb;
    v_interest_complete         boolean;
    v_state_name                text;
    v_state_id_db               numeric;
    v_country_id                numeric;
    v_country_name              text;
    v_country_flag_id_out       numeric;
    v_token                     varchar;
    v_epoch_timestamp           varchar;
    v_option_type               numeric;
    v_is_login                  numeric;
    v_is_custom_image_tab       numeric;
    v_old_profile_image_url     varchar;
    v_favourite_player_name     varchar;

    -- Response helpers
    v_status                    numeric;
    v_message                   varchar;
    v_is_first_login            numeric := 0;
    v_attempts                  varchar := '';

    v_addtional_info            jsonb := '{}';
BEGIN
    -- Read required top-level inputs
    SELECT p_inputjson->'data'->>'mobile_no',
           p_inputjson->'data'->>'email_id',
           p_inputjson->'data'->>'opt_type',
           p_inputjson->'data'->>'is_app',
           p_inputjson->'data'->>'country_code',
           p_inputjson->'data'->>'accept_tnc',
           p_inputjson->'data'->>'accept_disclaimer',
           p_inputjson->'data'->'user'->>'membership_code',
           p_inputjson->'data'->>'platform_version',
           p_inputjson->'data'->>'device_name',
           p_inputjson->'data'->>'platform_type',
           p_inputjson->'data'->>'ipaddress',
           p_inputjson->'data'->>'mobile_with_countrycode',
           p_inputjson->'data'->'user'->>'country_flag_id',
           p_inputjson->'data'->>'subscribe_for_email',
           p_inputjson->'data'->'user'->'ext_info'
    INTO   v_mobile_no,
           v_email_id,
           v_opt_type,
           v_is_app,
           v_country_code,
           v_accept_tnc,
           v_accept_disclaimer,
           v_membership_code,
           v_platform_version,
           v_device_name,
           v_platform_type,
           v_ipaddress,
           v_mobile_with_countrycode,
           v_country_flag_id,
           v_subscribe_for_email,
           v_ext_info;

    -- Read optional user nodes from input
    v_first_name               := p_inputjson->'data'->'user'->>'first_name';
    v_last_name                := p_inputjson->'data'->'user'->>'last_name';
    v_pincode                  := p_inputjson->'data'->'user'->>'pincode';
    v_city_id                  := NULLIF(p_inputjson->'data'->'user'->>'city_id','')::numeric;
    v_city_name_in             := p_inputjson->'data'->'user'->>'city';
    v_state_id                 := NULLIF(p_inputjson->'data'->'user'->>'state_id','')::numeric;
    v_state_name_in            := p_inputjson->'data'->'user'->>'state_name';
    v_country_id_in            := NULLIF(p_inputjson->'data'->'user'->>'country_id','')::numeric;
    v_country_name_in          := p_inputjson->'data'->'user'->>'country_name';
    v_social_user_name         := p_inputjson->'data'->'user'->>'social_user_name';
    v_gender                   := p_inputjson->'data'->'user'->>'gender';
    v_dob                      := p_inputjson->'data'->'user'->>'dob';
    v_favourite_player_id_in   := p_inputjson->'data'->'user'->>'favourite_player_id';
    v_favourite_player_name_in := p_inputjson->'data'->'user'->>'favourite_player_name';
    v_jersey_number_in         := NULLIF(p_inputjson->'data'->'user'->>'jersey_number','')::numeric;
    v_jersey_name_in           := p_inputjson->'data'->'user'->>'jersey_name';

    RAISE NOTICE 'inputs mobile=% country_code=%', v_mobile_no, v_country_code;

    -- Trace log
    INSERT INTO siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
        log_error_message,log_guid,error_json,created_date,client_name,log_type)
    VALUES (nextval('siwaf.seq_siwaf_api_error_log_id'),
        'country_input-labkkr_v1.labkkr_v1_static_num_login','logs',
        uuid_generate_v4(),p_inputjson,current_timestamp,'labkkr_v1','logs');

    IF v_accept_tnc = 'true' AND v_accept_disclaimer = 'true' AND v_country_code IS NOT NULL THEN
        -- Existing user?
        IF EXISTS (
            SELECT 1 FROM labkc_v1.labkc_v1_web_user
            WHERE mobile_no = v_mobile_no AND country_code = v_country_code
        ) THEN
            RAISE NOTICE 'existing user path';
            SELECT failed_attempts , unlock_date, is_verified, user_guid, user_full_name , verification_key,
                   favourite_club, edition, wu.is_deleted, wu.is_active, profile_picture_url , is_custom_image,
                   first_name,last_name,mobile_no,membership_code,email_id,dob,gender,
                   wu.city,favourite_player_id,wu.created_date,user_id,country_code,email_id,email_verified,
                   jersey_number,jersey_name,subscribe_for_email,pincode,mobile_verified,accept_tnc,
                   accept_disclaimer,subscribe_for_email,--mobile_no_cc,
				   --interest_ids,interest_complete,
                   state_id,--state_name,
				   country_id--,country_flag_id
            INTO v_failed_attempts,  v_unlock_date, v_is_verified, v_user_guid, v_user_full_name, v_verification_key,
                 v_favourite_club, v_edition, v_is_deleted, v_is_active , v_profile_picture_url, v_is_custom_image,
                 v_first_name,v_last_name,v_mobile_no,v_membership_code,v_email_id,v_dob,v_gender,
                 v_city,v_favourite_player_id,v_created_date_1,v_web_user_id,v_country_code,v_email_id,
                 v_email_verified,v_jersey_number,v_jersey_name,v_subscribe_for_email,
                 v_pincode,v_mobile_verified,v_accept_tnc,v_accept_disclaimer,v_subscribe_for_email,
                 --v_mobile_with_countrycode,
				 --v_interest_ids,v_interest_complete,
				 v_state_id_db,--v_state_name,
                 v_country_id--,v_country_flag_id_out
            FROM labkc_v1.labkc_v1_web_user wu
            WHERE mobile_no = v_mobile_no AND country_code = v_country_code;

            IF v_mobile_verified <> 1 THEN
                UPDATE labkc_v1.labkc_v1_web_user
                SET mobile_verified = 1
                WHERE mobile_no = v_mobile_no AND country_code = v_country_code;
                v_mobile_verified := 1;
            END IF;

            SELECT em.entity_name INTO v_favourite_player_name
            FROM labkkr_v1.labkkr_v1_entity_role_map erm
            JOIN labkkr_v1.labkkr_v1_entity_master em USING (entity_master_id)
            WHERE source_object_id = COALESCE(v_favourite_player_id,'0');

            SELECT name INTO v_country_name
            FROM labkc_v1.labkc_v1_web_user wu
            LEFT JOIN waf_master.waf_countries c ON wu.country_id = c.country_id
            WHERE wu.user_guid = v_user_guid AND wu.is_active = 1 AND wu.is_deleted = 0;

            IF v_is_deleted = 1 THEN
                v_status := 500;
                v_message := 'Login Successful.';
            ELSIF v_is_active = 1 THEN
                IF v_first_name IS NULL OR v_last_name IS NULL THEN
                    v_status := 2;
                    v_message := 'Incomplete Profile.';
                ELSE
                    v_status := 1;
                    v_message := 'Login Successful';
                END IF;
            END IF;

             INSERT INTO labkc_v1.labkc_v1_web_user_audit
            (audit_id, user_id, user_guid, ipaddress, audit_date, is_app,
             platform_version,platform_type,device_name,option_type,client_code)
            SELECT nextval('labdd_v1.seq_labdd_v1_web_user_audit_id'), v_web_user_id,
                   v_user_guid, v_ipaddress, v_current_timestamp, COALESCE(v_is_app,0),
                   v_platform_version, v_platform_type, v_device_name, 4, 'labkc_v1';
        ELSE
            -- New user registration
            RAISE NOTICE 'new user path';
            v_web_user_id := nextval('labkc_v1.seq_labkc_v1_web_users_id');
            v_user_guid := uuid_generate_v4();
            v_is_active := 1;
            v_is_deleted := 0;
            v_mobile_verified := 1;
            v_created_date_1 := current_timestamp;
            v_epoch_timestamp := EXTRACT(EPOCH FROM NOW())::bigint;
            v_is_login := 0;

            INSERT INTO labkc_v1.labkc_v1_web_user
            (user_id, client_id, user_guid, is_active, is_deleted, created_date, updated_date,
             is_registered, mobile_verified, epoch_timestamp, is_login, created_by ,updated_by,
             mobile_no, country_code, 
accept_tnc, accept_disclaimer, membership_code,
              state_id)
            SELECT v_web_user_id, 5, v_user_guid, v_is_active, v_is_deleted,
                   v_created_date_1, v_created_date_1, 1, v_mobile_verified,
                   v_epoch_timestamp, v_is_login, 1 ,1, v_mobile_no, v_country_code,
                   v_accept_tnc, v_accept_disclaimer, v_membership_code,
                    COALESCE(v_state_id, v_state_id_db);

            v_is_first_login := 1;
            v_status := 2;
            v_message := 'User registered successfully.';

            INSERT INTO labkc_v1.labkc_v1_web_user_audit
            (audit_id, user_id, user_guid, ipaddress, audit_date, is_app,
             platform_version,platform_type,device_name,option_type,client_code)
            SELECT nextval('labkc_v1.seq_labkc_v1_web_user_audit_id'), v_web_user_id,
                   v_user_guid, v_ipaddress, v_current_timestamp, COALESCE(v_is_app,0),
                   v_platform_version, v_platform_type, v_device_name, 2, 'labkc_v1';
        END IF;

        -- build response
        p_data := '{
          "data": {
            "user_guid": "'||COALESCE(v_user_guid,'')||'",
            "waf_user_guid": "'||COALESCE(v_user_guid,'')||'",
            "token": "'|| COALESCE(v_token,'') ||'",
            "epoch_timestamp": "'|| COALESCE(v_epoch_timestamp,'') ||'",
            "failed_attempt":"'||COALESCE(v_failed_attempts,0)::text||'",
            "email_id": "'|| COALESCE(v_email_id,'') ||'",
            "status": '||COALESCE(v_status,0) ||',
            "message": "'|| COALESCE(v_message,'')||'",
            "attempts": "'|| COALESCE(v_attempts,'')||'",
            "max_attempts": "3",
            "platform_version": "'|| COALESCE(v_platform_version,0)||'",
            "device_name": "'|| COALESCE(v_device_name,'')||'",
            "platform_type": "'|| COALESCE(v_platform_type,0)||'",
            "option_type": "'|| COALESCE(v_option_type,0)||'",
            "user_id":"'|| COALESCE(v_web_user_id,0)||'",
            "subscribe_for_email":"'|| COALESCE(v_subscribe_for_email,'false')||'",
            "mobile_verified": "'|| COALESCE(v_mobile_verified,0)||'",
            "email_verified": "'|| COALESCE(v_email_verified,0)||'",
            "created_date": "'|| COALESCE(v_created_date_1::varchar,'')||'",
            "user": {
              "mobile_no": "'|| COALESCE(v_mobile_no,'') ||'" ,
              "mobile_with_countrycode": "'|| COALESCE(v_mobile_with_countrycode,'') ||'" ,
              "name": "'||COALESCE(v_user_full_name,'') ||'",
              "first_name": "'||COALESCE(v_first_name,'') ||'",
              "last_name": "'||COALESCE(v_last_name,'') ||'",
              "social_user_name": "'|| COALESCE(v_social_user_name,'') ||'",
              "dob": "'|| COALESCE(v_dob::varchar,'') ||'",
              "gender": "'|| COALESCE(v_gender,'') ||'",
              "city": "'|| COALESCE(v_city, v_city_name_in,'')||'",
              "city_id": "'|| COALESCE(v_city_id::varchar,'')||'",
              "state_name": "'|| COALESCE(v_state_name, v_state_name_in,'')||'",
              "state_id": "'|| COALESCE(v_state_id_db::varchar, v_state_id::varchar,'')||'",
              "country_name": "'|| COALESCE(v_country_name, v_country_name_in,'')||'",
              "country_flag_id": "'|| COALESCE(v_country_flag_id_out::varchar, v_country_flag_id::varchar,'')||'",
              "country_id": "'|| COALESCE(v_country_id::varchar, v_country_id_in::varchar,'')||'",
              "favourite_club": "'||COALESCE(v_favourite_club,'') ||'",
              "country_code": "'|| COALESCE(v_country_code,0)||'",
              "favourite_player_id": "'||COALESCE(v_favourite_player_id, v_favourite_player_id_in,'') ||'",
              "edition": "'|| COALESCE(v_edition,'') ||'",
              "jersey_number": "'|| COALESCE(v_jersey_number, v_jersey_number_in,0)||'",
              "jersey_name": "'|| COALESCE(v_jersey_name, v_jersey_name_in,'')||'",
              "social_user_image": "'|| COALESCE(v_profile_picture_url,v_old_profile_image_url,'') ||'" ,
              "membership_code": "'||COALESCE(v_membership_code,'') ||'",
              "favourite_player_name":"'|| COALESCE(v_favourite_player_name, v_favourite_player_name_in,'')||'",
              "pincode":"'|| COALESCE(v_pincode,'')||'",
              "accept_disclaimer":"'|| COALESCE(v_accept_disclaimer,'false')||'",
              "subscribe_for_email":"'|| COALESCE(v_subscribe_for_email,'false')||'",
              "accept_tnc":"'|| COALESCE(v_accept_tnc,'false')||'"
            },
            "is_first_login": '|| COALESCE(v_is_first_login ,0) ||' ,
            "is_app": '|| COALESCE(v_is_app,0) ||' ,
            "is_custom_image": "'|| COALESCE(v_is_custom_image,'0') ||'" ,
            "old_profile_img_url" : "'|| COALESCE(v_old_profile_image_url,'') ||'"
          }
        }';

    ELSE
        v_status := 0;
        v_message := 'Terms and Conditions not accepted';

        p_data := '{
          "data": {
            "user_guid": "'||COALESCE(v_user_guid,'')||'",
            "waf_user_guid": "'||COALESCE(v_user_guid,'')||'",
            "token": "'|| COALESCE(v_token,'') ||'",
            "epoch_timestamp": "'|| COALESCE(v_epoch_timestamp,'') ||'",
            "failed_attempt":"'||COALESCE(v_failed_attempts,0)::text||'",
            "email_id": "'|| COALESCE(v_email_id,'') ||'",
            "status": '||COALESCE(v_status,0) ||',
            "message": "'|| COALESCE(v_message,'')||'",
            "attempts": "'|| COALESCE(v_attempts,'')||'",
            "max_attempts": "3",
            "platform_version": "'|| COALESCE(v_platform_version,0)||'",
            "device_name": "'|| COALESCE(v_device_name,'')||'",
            "platform_type": "'|| COALESCE(v_platform_type,0)||'",
            "option_type": "'|| COALESCE(v_option_type,0)||'",
            "user_id":"'|| COALESCE(v_web_user_id,0)||'",
            "subscribe_for_email":"'|| COALESCE(v_subscribe_for_email,'false')||'",
            "mobile_verified": "'|| COALESCE(v_mobile_verified,0)||'",
            "email_verified": "'|| COALESCE(v_email_verified,0)||'",
            "created_date": "'|| COALESCE(v_created_date_1::varchar,'')||'",
            "user": {
              "mobile_no": "'|| COALESCE(v_mobile_no,'') ||'" ,
              "mobile_with_countrycode": "'|| COALESCE(v_mobile_with_countrycode,'') ||'" ,
              "name": "'||COALESCE(v_user_full_name,'') ||'",
              "first_name": "'||COALESCE(v_first_name,'') ||'",
              "last_name": "'||COALESCE(v_last_name,'') ||'",
              "social_user_name": "'|| COALESCE(v_social_user_name,'') ||'",
              "dob": "'|| COALESCE(v_dob::varchar,'') ||'",
              "gender": "'|| COALESCE(v_gender,'') ||'",
              "country_flag_id": "'|| COALESCE(v_country_flag_id_out::varchar, v_country_flag_id::varchar,'')||'",
              "city": "'|| COALESCE(v_city, v_city_name_in,'')||'",
              "city_id": "'|| COALESCE(v_city_id::varchar,'')||'",
              "country_id": "'|| COALESCE(v_country_id::varchar, v_country_id_in::varchar,'')||'",
              "state_name": "'|| COALESCE(v_state_name, v_state_name_in,'')||'",
              "state_id": "'|| COALESCE(v_state_id_db::varchar, v_state_id::varchar,'')||'",
              "country_name": "'|| COALESCE(v_country_name, v_country_name_in,'')||'",
              "favourite_club": "'||COALESCE(v_favourite_club,'') ||'",
              "country_code": "'|| COALESCE(v_country_code,0)||'",
              "favourite_player_id": "'||COALESCE(v_favourite_player_id, v_favourite_player_id_in,'') ||'",
              "edition": "'|| COALESCE(v_edition,'') ||'",
              "jersey_number": "'|| COALESCE(v_jersey_number, v_jersey_number_in,0)||'",
              "jersey_name": "'|| COALESCE(v_jersey_name, v_jersey_name_in,'')||'",
              "social_user_image": "'|| COALESCE(v_profile_picture_url,v_old_profile_image_url,'') ||'" ,
              "membership_code": "'||COALESCE(v_membership_code,'') ||'",
              "favourite_player_name":"'|| COALESCE(v_favourite_player_name, v_favourite_player_name_in,'')||'",
              "pincode":"'|| COALESCE(v_pincode,'')||'",
              "accept_disclaimer":"'|| COALESCE(v_accept_disclaimer,'false')||'",
              "accept_tnc":"'|| COALESCE(v_accept_tnc,'false')||'"
            },
            "is_first_login": '|| COALESCE(v_is_first_login ,0) ||' ,
            "is_app": '|| COALESCE(v_is_app,0) ||' ,
            "is_custom_image": "'|| COALESCE(v_is_custom_image,'0') ||'" ,
            "old_profile_img_url" : "'|| COALESCE(v_old_profile_image_url,'') ||'"
          }
        }';
    END IF;

    -- additional info payload
    v_addtional_info := '{
        
        "install_id": "",
        "push_token": "",
        "push_flag": "",
        "web_subs_id": "",
        "web_attributes": "",
        "device_attributes": "",
        "service_type_status":""
    }';

    v_addtional_info := jsonb_set(v_addtional_info, '{interest_ids}', to_jsonb(coalesce((v_interest_ids),'[]'::jsonb)), true);
    v_addtional_info := jsonb_set(v_addtional_info, '{interest_complete}', to_jsonb(coalesce(v_interest_complete,'false')));
    p_data := jsonb_set(p_data, '{data,addtional_info}', coalesce(v_addtional_info,'null'), true);
    p_data := jsonb_set(p_data, '{data,user,ext_info}', coalesce(v_ext_info,'null'), true);

    RAISE NOTICE 'p_data:%', p_data;

-- EXCEPTION WHEN OTHERS THEN
--     p_data := NULL;
--     INSERT INTO siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
--         log_error_message,log_guid,error_json,created_date,client_name,log_type)
--     VALUES (nextval('siwaf.seq_siwaf_api_error_log_id'),
--         'exception-input-labkc_v1.labkc_v1_static_num_login','logs',
--         uuid_generate_v4(),p_inputjson,current_timestamp,'labkc_v1','logs');
--     RAISE NOTICE 'p_data:%', p_data;
END;
$$;


--
