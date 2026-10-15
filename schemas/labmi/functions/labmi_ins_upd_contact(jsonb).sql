-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_ins_upd_contact(jsonb)
-- Type: FUNCTION

-- Name: labmi_ins_upd_contact(jsonb); Type: FUNCTION; Schema: labmi; Owner: -
--

CREATE FUNCTION labmi.labmi_ins_upd_contact(p_connect_us_json jsonb, OUT p_result numeric, OUT p_contactjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

DECLARE
    v_sysdate timestamp;
    v_full_name text;
    v_state varchar(200);
    v_city varchar(200);
    v_subject text;
    v_message text;    
    v_api_flag numeric;
    v_email_id varchar(200);   
    v_cnt numeric;
    v_dob date;
    v_designation varchar(200);
    v_oragnisation varchar(200);
    v_mobile_number varchar(20);
    v_telephone varchar(20);
    v_gender varchar(1);
    v_alabmiress varchar(2000);
    v_contact_id numeric;
    v_attachment text;

    v_campaign_name text;
    v_campaign_id numeric;

    v_unique_id bigint;
    v_formatted_unique_id text;

BEGIN

    SELECT current_timestamp AT TIME ZONE 'utc' INTO v_sysdate;

    SELECT
        COALESCE(
            p_connect_us_json->'data'->>'full_name',
            (p_connect_us_json->'data'->'user_info'->>'first_name') || ' ' ||
            (p_connect_us_json->'data'->'user_info'->>'last_name')
        ),
        p_connect_us_json->'data'->>'state',
        COALESCE(
            p_connect_us_json->'data'->>'city',
            p_connect_us_json->'data'->'user_info'->>'city'
        ),
        p_connect_us_json->'data'->>'subject',
        p_connect_us_json->'data'->>'message',
        COALESCE(
            p_connect_us_json->'data'->>'email_id',
            p_connect_us_json->'data'->'user_info'->>'email_id'
        ),
        p_connect_us_json->'data'->>'designation',
        p_connect_us_json->'data'->>'organisation',
        COALESCE(
            p_connect_us_json->'data'->>'mobile',
            p_connect_us_json->'data'->'user_info'->>'mobile_no'
        ),
        p_connect_us_json->'data'->>'telephone',

        CASE 
            WHEN p_connect_us_json->'data'->>'dob' IS NOT NULL 
            THEN TO_DATE(p_connect_us_json->'data'->>'dob', 'DD-MM-YYYY')
        END,

        CASE 
            WHEN lower(COALESCE(
                p_connect_us_json->'data'->>'gender',
                p_connect_us_json->'data'->'user_info'->>'gender'
            )) = 'male' THEN 'M'
            WHEN lower(COALESCE(
                p_connect_us_json->'data'->>'gender',
                p_connect_us_json->'data'->'user_info'->>'gender'
            )) = 'female' THEN 'F'
            ELSE NULL
        END,

        p_connect_us_json->'data'->>'alabmiress',
        p_connect_us_json->'data'->>'attachments'
    INTO
        v_full_name,
        v_state,
        v_city,
        v_subject,
        v_message,
        v_email_id,
        v_designation,
        v_oragnisation,
        v_mobile_number,
        v_telephone,
        v_dob,
        v_gender,
        v_alabmiress,
        v_attachment;

    v_campaign_name := trim(p_connect_us_json->'data'->>'campaign_name');
    v_campaign_id   := (p_connect_us_json->'data'->>'campaign_id')::numeric;

    SELECT (p_connect_us_json->'data'->>'page_flag')::numeric INTO v_api_flag;

    v_email_id := trim(lower(v_email_id));

    v_contact_id := nextval('labmi.seq_labmi_contact_id');

    IF v_campaign_name = 'ipl-2026-season-campaign' THEN
        v_unique_id := nextval('labmi.seq_labmi_unique_id_ipl_ticketing_campaign');
        v_formatted_unique_id := 'MI-' || v_unique_id;
    END IF;

    INSERT INTO labmi.labmi_contact
    (
        contact_id, name, email_alabmiress, mobile_number, alabmiress,
        created_date, updated_date, created_by, updated_by,
        is_active, is_deleted, feedback, subject, page_flag,
        state, city, designation, oragnisation, dob, gender,
        telephone_number, attachment, contact_json,
        campaign_id, campaign_name,  
        unique_id
    )
    VALUES
    (
        v_contact_id, v_full_name, v_email_id, v_mobile_number, v_alabmiress,
        v_sysdate, v_sysdate, 1, 1,
        1, 0, v_message, v_subject, v_api_flag,
        v_state, v_city, v_designation, v_oragnisation, v_dob, v_gender,
        v_telephone, v_attachment, p_connect_us_json,
        v_campaign_id, v_campaign_name, 
        v_formatted_unique_id
    );

    p_result := 1;
    p_contactjson := jsonb_build_object(
        'data',
        jsonb_strip_nulls(
            jsonb_build_object(
                'status', '1',
                'message', 'Success',
                'unique_id', v_formatted_unique_id
            )
        )
    );

    RETURN;

END;
$$;


--
