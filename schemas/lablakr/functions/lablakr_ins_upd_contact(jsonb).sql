-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablakr
-- Object: lablakr_ins_upd_contact(jsonb)
-- Type: FUNCTION

-- Name: lablakr_ins_upd_contact(jsonb); Type: FUNCTION; Schema: lablakr; Owner: -
--

CREATE FUNCTION lablakr.lablakr_ins_upd_contact(p_connect_us_json jsonb, OUT p_result numeric, OUT p_contactjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_sysdate              timestamp;
    v_full_name            text;
    v_first_name           varchar;
    v_last_name            varchar;
    v_subject              text;
    v_message              text;
    v_api_flag             numeric;
    v_email_id             varchar(2000);
    v_cnt                  numeric;
    v_dob                  timestamp;
    v_designation          varchar(2000);
    v_oragnisation         varchar(200);
    v_mobile_no        varchar(200);
    
    v_gender               varchar(100);
    v_address              varchar(2000);
    v_contact_id           numeric;
    v_state                varchar(200);
    v_city                 varchar(200);
    v_user_guid            text;
    v_campaign_name        text;
    v_page_flag            numeric;
    v_attachment           text;
    v_unique_id            text;
    v_formatted_unique_id  text;
BEGIN
    -- Set current timestamp
    SELECT current_timestamp AT TIME ZONE 'utc' INTO v_sysdate;

    -- Extract page_flag and campaign_name
    SELECT 
    p_connect_us_json->'data'->>'page_flag',
    p_connect_us_json->'data'->>'campaign_name'
	INTO 
		v_api_flag,
		v_campaign_name;

    -- Check if user_guid already exists
--     SELECT p_connect_us_json->'data'->>'user_guid' INTO v_user_guid;
--     IF EXISTS(SELECT 1 FROM lablakr.lablakr_contact WHERE user_guid = v_user_guid) THEN
--         p_result := 2;
--         p_contactjson := '{ "message":"You have already submitted form"}';
--         RETURN;
--     END IF;
	if v_email_id = '' then
                v_email_id:=null;
            end if;

    -- Extract common data
    SELECT
        p_connect_us_json->'data'->>'first_name',
        p_connect_us_json->'data'->>'subject',
        p_connect_us_json->'data'->>'message',
        p_connect_us_json->'data'->>'email_id',
        p_connect_us_json->'data'->>'mobile',
        
        p_connect_us_json->'data'->>'dob',
        p_connect_us_json->'data'->>'gender',
        p_connect_us_json->'data'->>'address',
        p_connect_us_json->'data'->>'user_guid'
    INTO
        v_full_name,
        v_subject,
        v_message,
        v_email_id,
        v_mobile_no,
        
        v_dob,
        v_gender,
        v_address,
        v_user_guid;

    -- Handle lakr_campaign
    IF v_campaign_name = 'lakr_campaign' THEN
        -- Extract additional data for lakr_campaign
        SELECT
            p_connect_us_json->'data'->>'full_name',
            p_connect_us_json->'data'->'user_info'->>'state',
            p_connect_us_json->'data'->'user_info'->>'city',
            p_connect_us_json->'data'->>'designation',
            p_connect_us_json->'data'->>'organisation',
            p_connect_us_json->'data'->'user_info'->>'mobile_no',
            p_connect_us_json->'data'->'user_info'->>'dob',
            p_connect_us_json->'data'->'user_info'->>'gender',
            p_connect_us_json->'data'->>'address'
        INTO
            v_full_name,
            v_state,
            v_city,
            v_designation,
            v_oragnisation,
            v_mobile_no,
            v_dob,
            v_gender,
            v_address;

        -- Generate unique_id
        SELECT upper(translate(substring(gen_random_uuid()::text FROM 1 FOR 7), '-', '')) INTO v_unique_id;
        v_formatted_unique_id := 'LAKR-' || v_unique_id;

        -- Insert into lablakr.lablakr_contact
        v_contact_id := nextval('lablakr.seq_lablakr_contact_id');
        INSERT INTO lablakr.lablakr_contact (
            contact_id,
            name,
            email_address,
            mobile_no,
            address,
            created_date,
            updated_date,
            created_by,
            updated_by,
            is_active,
            is_deleted,
            feedback,
            subject,
            page_flag,
            state,
            city,
            designation,
            oragnisation,
            dob,
            gender,
            attachment,
            contact_json,
            user_guid,
            unique_id
        ) VALUES (
            v_contact_id,
            v_full_name,
            v_email_id,
            v_mobile_no,
            v_address,
            v_sysdate,
            v_sysdate,
            1,
            1,
            1,
            0,
            v_message,
            v_subject,
            v_page_flag,
            v_state,
            v_city,
            v_designation,
            v_oragnisation,
            v_dob,
            v_gender,
            NULL,
            p_connect_us_json,
            v_user_guid,
            v_formatted_unique_id
        );

        -- Update p_connect_us_json with unique_id
        p_connect_us_json := jsonb_set(p_connect_us_json, '{data,unique_id}', ('"' || v_formatted_unique_id || '"')::text::jsonb, true);
        p_result := 1;
        p_contactjson := p_connect_us_json;
    ELSE
        -- Insert into lablakr.lablakr_contact
        v_contact_id := nextval('lablakr.seq_lablakr_contact_id');
        INSERT INTO lablakr.lablakr_contact(
            contact_id,
            name,
            email_address,
            mobile_no,
            address,
            created_date,
            updated_date,
            created_by,
            updated_by,
            is_active,
            is_deleted,
            feedback,
            subject,
            page_flag,
            city,
            designation,
            oragnisation,
            dob,
            gender,
            attachment,
            contact_json
        ) VALUES (
            v_contact_id,
            v_full_name,
            v_email_id,
            v_mobile_no,
            v_address,
            v_sysdate,
            v_sysdate,
            1,
            1,
            1,
            0,
            v_message,
            v_subject,
            v_api_flag,
            v_city,
            v_designation,
            v_oragnisation,
            v_dob,
            v_gender,
            NULL,
            p_connect_us_json
        );

        -- Update p_connect_us_json with contact_id and email_address
        p_connect_us_json := jsonb_set(p_connect_us_json, '{data,email_address}', ('"' || v_email_id || '"')::text::jsonb, true);
        p_connect_us_json := jsonb_set(p_connect_us_json, '{data,contact_id}', ('"' || v_contact_id || '"')::text::jsonb, true);
        p_result := 1;
        p_contactjson := p_connect_us_json;
    END IF;
END;
$$;


--
