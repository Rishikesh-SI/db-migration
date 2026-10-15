-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_upd_moengage_fields(jsonb)
-- Type: FUNCTION

-- Name: labkc_v1_upd_moengage_fields(jsonb); Type: FUNCTION; Schema: labkc_v1; Owner: -
--

CREATE FUNCTION labkc_v1.labkc_v1_upd_moengage_fields(p_input jsonb, OUT p_output jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_dob text;
    v_city text;
    v_gender text;
    v_first_name text;
    v_last_name text;
    v_jersey_number numeric;
    v_social_user_image text;
    v_social_user_name text;
    v_pincode text;
    v_user_guid character varying;
    v_favourite_player_id character varying;
    v_jersey_name character varying;
    v_subscribe_for_email boolean;
    v_membership_code character varying;
    v_created_date timestamp without time zone;
    v_updated_date timestamp without time zone;
    v_accept_tnc boolean;
    v_accept_disclaimer boolean;
    v_token character varying;
    v_epoch_timestamp character varying;
    v_user_id numeric;
    v_email_id character varying;
    v_status numeric;
    v_message character varying;
    v_peppo_id character varying;
    v_platform_version character varying;
    v_device_name character varying;
    v_platform_type numeric;
    v_mobile_verified numeric;
    v_email_verified numeric;
    v_referal_user_guid character varying;
    v_is_referred numeric;
    v_internal_referral_code character varying;
    v_mobile_no character varying;
    v_user_full_name character varying;
    v_country_id numeric;
    v_state_id numeric;
    v_city_id numeric;
    v_country_name text;
    v_state_name text;
    v_favourite_club character varying;
    v_edition character varying;
    v_profile_picture_url character varying;
    v_old_profile_image_url character varying;
    v_country_code numeric;
    v_favourite_player_name character varying;
    v_is_app numeric;
    v_is_custom_image numeric;
    v_pass_type numeric;
    v_ext_info jsonb;
    v_current_timestamp timestamp without time zone := current_timestamp at time zone 'utc';
BEGIN
    SELECT 
        p_input->>'favourite_player_id',
        p_input->>'subscribe_for_email',
        p_input->>'created_date',
        p_input->>'updated_date',
        p_input->>'accept_tnc',
        p_input->>'accept_disclaimer',
        p_input->>'jersey_number',
        p_input->>'country_id',
        p_input->>'waf_user_guid',
        p_input->'user_info'->>'dob',
        p_input->'user_info'->>'city',
        p_input->'user_info'->>'gender',
        p_input->'user_info'->>'first_name',
        p_input->'user_info'->>'last_name',
        p_input->'user_info'->>'social_user_image',
        p_input->'user_info'->>'social_user_name',
        p_input->'user_info'->>'pincode',
        p_input->'user_info'->>'jersey_name',
        p_input->'user_info'->>'membership_code',
        p_input->'user_info'->>'mobile_no',
        p_input->'user_info'->>'email_id'
    INTO
        v_favourite_player_id,
        v_subscribe_for_email,
        v_created_date,
        v_updated_date,
        v_accept_tnc,
        v_accept_disclaimer,
        v_jersey_number,
        v_country_id,
        v_user_guid,
        v_dob,
        v_city,
        v_gender,
        v_first_name,
        v_last_name,
        v_social_user_image,
        v_social_user_name,
        v_pincode,
        v_jersey_name,
        v_membership_code,
        v_mobile_no,
        v_email_id;

    IF NOT EXISTS (
        SELECT 1 FROM labkc_v1.labkc_v1_web_user WHERE user_guid = v_user_guid
    ) THEN
        v_status := 0;
        v_message := 'Unable to locate user information.'; 
    ELSIF EXISTS (
        SELECT 1 FROM labkc_v1.labkc_v1_web_user 
        WHERE user_guid = v_user_guid
          AND mobile_no <> v_mobile_no
          AND v_mobile_no IS NOT NULL
          AND v_mobile_no <> ''
    ) THEN
        v_status := 0;
        v_message := 'Mobile Number already exists with different account';
    ELSE
	        UPDATE labkc_v1.labkc_v1_web_user
	        SET
	            dob = COALESCE(NULLIF(v_dob, ''), dob),
	            city = COALESCE(NULLIF(v_city, ''), city),
	            gender = COALESCE(NULLIF(v_gender, ''), gender),
	            first_name = COALESCE(NULLIF(v_first_name, ''), first_name),
	            last_name = COALESCE(NULLIF(v_last_name, ''), last_name),
	            jersey_number = COALESCE(v_jersey_number, jersey_number),
	            country_id = COALESCE(v_country_id, country_id),
	            profile_picture_url = COALESCE(NULLIF(v_social_user_image, ''), profile_picture_url),
	            social_user_name = COALESCE(NULLIF(v_social_user_name, ''), social_user_name),
	            pincode = COALESCE(NULLIF(v_pincode, ''), pincode),
	            favourite_player_id = COALESCE(NULLIF(v_favourite_player_id, ''), favourite_player_id),
	            jersey_name = COALESCE(NULLIF(v_jersey_name, ''), jersey_name),
	            subscribe_for_email = COALESCE(NULLIF(v_subscribe_for_email, NULL), subscribe_for_email),
	            membership_code = COALESCE(NULLIF(v_membership_code, ''), membership_code),
	            --created_date = COALESCE(NULLIF(v_created_date, NULL), created_date),
	            updated_date = v_current_timestamp,
	            accept_tnc = COALESCE(NULLIF(v_accept_tnc, NULL), accept_tnc),
	            accept_disclaimer = COALESCE(NULLIF(v_accept_disclaimer, NULL), accept_disclaimer),
				email_id = COALESCE(NULLIF(v_email_id, NULL), v_email_id)
	        WHERE user_guid = v_user_guid;
	
	        SELECT
	            user_guid, user_id, email_id, email_verified, first_name, last_name, user_full_name, dob, gender, pincode, city, country_id,
	            jersey_number, jersey_name, favourite_player_id, token, epoch_timestamp, mobile_verified,
	            referal_user_guid, is_referred, internal_referral_code, mobile_no, edition, favourite_club,
	            subscribe_for_email, profile_picture_url, is_custom_image, membership_code, accept_disclaimer, accept_tnc, country_code,
	            (CASE WHEN first_name IS NOT NULL AND last_name IS NOT NULL THEN 1 ELSE 2 END), peppo_id, created_date
	        INTO
	            v_user_guid, v_user_id, v_email_id, v_email_verified, v_first_name, v_last_name, v_user_full_name, v_dob,
	            v_gender, v_pincode, v_city, v_country_id, v_jersey_number, v_jersey_name,
	            v_favourite_player_id, v_token, v_epoch_timestamp, v_mobile_verified,
	            v_referal_user_guid, v_is_referred, v_internal_referral_code, v_mobile_no, v_edition, v_favourite_club,
	            v_subscribe_for_email, v_profile_picture_url, v_is_custom_image, v_membership_code, v_accept_disclaimer, v_accept_tnc, v_country_code, v_pass_type, v_peppo_id, v_created_date
	        FROM labkc_v1.labkc_v1_web_user
	        WHERE user_guid = v_user_guid;
	
	        SELECT name INTO v_country_name FROM waf_master.waf_countries WHERE country_id = v_country_id;
	
	        SELECT em.entity_name INTO v_favourite_player_name
	        FROM labkc_v1.labkc_v1_entity_role_map erm
	        JOIN labkc_v1.labkc_v1_entity_master em USING (entity_master_id)
	        WHERE source_object_id = COALESCE(v_favourite_player_id::text, '0');
	
	        INSERT INTO labkc_v1.labkc_v1_user_moengage_audit
	        VALUES (
	            nextval('labkc_v1.seq_labkc_v1_web_user_audit_id'),
	            v_user_id, v_user_guid, 9, v_current_timestamp, 0, NULL, 0, 'web', NULL, 'labkc_v1', p_input
	        );
	
	        v_status := 1; 
	        v_message := 'Profile updated successfully.';
    END IF;

    p_output := '{
        "data": {
            "user_guid": "' || COALESCE(v_user_guid, '') || '",
            "waf_user_guid": "' || COALESCE(v_user_guid, '') || '",
            "token": "' || COALESCE(v_token, '') || '",
            "epoch_timestamp": "' || COALESCE(v_epoch_timestamp, '') || '",
            "user_id": "' || COALESCE(v_user_id, 0) || '",
            "email_id": "' || COALESCE(v_email_id, '') || '",
            "status": ' || COALESCE(v_status, 0) || ',
            "message": "' || COALESCE(v_message, '') || '",
            "peppo_id": "' || COALESCE(v_peppo_id, '') || '",
            "platform_version": "' || COALESCE(v_platform_version, '') || '",
            "device_name": "' || COALESCE(v_device_name, '') || '",
            "platform_type": "' || COALESCE(v_platform_type, 0) || '",
            "mobile_verified": "' || COALESCE(v_mobile_verified, 0) || '",
            "email_verified": "' || COALESCE(v_email_verified, 0) || '",
            "option_type": "9",
            "updated_date": "' || COALESCE(v_current_timestamp, current_timestamp) || '",
            "created_date": "' || COALESCE(v_created_date, current_timestamp) || '",
            "user": {
                "referal_user_guid": "' || COALESCE(v_referal_user_guid, '') || '",
                "is_referred": "' || COALESCE(v_is_referred, 0) || '",    
                "internal_referral_code": "' || COALESCE(v_internal_referral_code, '') || '" ,
                "mobile_no": "' || COALESCE(v_mobile_no, '') || '" ,
                "name": "' || COALESCE(v_user_full_name, '') || '",
                "first_name": "' || COALESCE(v_first_name, '') || '",
                "last_name": "' || COALESCE(v_last_name, '') || '",
                "social_user_name": "' || COALESCE(v_social_user_name, '') || '",
                "dob": "' || COALESCE(v_dob::varchar, '') || '",
                "gender": "' || COALESCE(v_gender, '') || '",
                "city": "' || COALESCE(v_city, '') || '",
                "city_id": "' || COALESCE(v_city_id::varchar, '') || '",
                "state_name": "' || COALESCE(v_state_name, '') || '",
                "state_id": "' || COALESCE(v_state_id::varchar, '') || '",
                "country_name": "' || COALESCE(v_country_name, '') || '",
                "country_id": "' || COALESCE(v_country_id::varchar, '') || '",
                "favourite_club": "' || COALESCE(v_favourite_club, '') || '",
                "edition": "' || COALESCE(v_edition, '') || '",
                "subscribe_for_email": "' || COALESCE(v_subscribe_for_email::varchar, 'false') || '",
                "favourite_player_id": "' || COALESCE(v_favourite_player_id, '') || '",
                "jersey_name": "' || COALESCE(v_jersey_name, '') || '",
                "social_user_image": "' || COALESCE(v_profile_picture_url, v_old_profile_image_url, '') || '" ,
                "jersey_number": "' || COALESCE(v_jersey_number, 0) || '",
                "membership_code": "' || COALESCE(v_membership_code, '') || '",
                "country_code": "' || COALESCE(v_country_code, 91) || '",
                "favourite_player_name": "' || COALESCE(v_favourite_player_name, '') || '",
                "pincode": "' || COALESCE(v_pincode, '') || '",
                "accept_disclaimer": "' || COALESCE(v_accept_disclaimer, 'false') || '",
                "accept_tnc": "' || COALESCE(v_accept_tnc, 'false') || '"
            },
            "is_first_login": 0,
            "is_app": ' || COALESCE(v_is_app, 0) || ' ,
            "is_custom_image": "' || COALESCE(v_is_custom_image, '0') || '" ,
            "old_profile_img_url": "' || COALESCE(v_old_profile_image_url, '') || '",
            "pass_type": "' || COALESCE(v_pass_type, '0') || '"
        }
    }';

    p_output := jsonb_set(p_output, '{data,ext_info}', COALESCE(v_ext_info, 'null'), true);
END;
$$;


--
