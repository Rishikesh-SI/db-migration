-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_del_whatsapp_bot_data(date)
-- Type: FUNCTION

-- Name: labmi_del_whatsapp_bot_data(date); Type: FUNCTION; Schema: labmi; Owner: -
--

CREATE FUNCTION labmi.labmi_del_whatsapp_bot_data(p_date date, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

DECLARE

    v_log_guid varchar := gen_random_uuid()::varchar;
    
    v_insert_count numeric := 0;
    v_delete_count numeric := 0;

BEGIN

    ----------------------------------------------------------------
    -- START LOG
    ----------------------------------------------------------------
    INSERT INTO siwaf.siwaf_client_logs
    (
        api_error_log_id,
        log_method_name,
        log_error_message,
        log_guid,
        log_type,
        client_name,
        created_date
    )
    VALUES
    (
        nextval('siwaf.siwaf_client_logs_api_error_log_id_seq'),
        'labmi_del_whatsapp_bot_data',
        'SP Started. Input p_date = ' || p_date::text,
        v_log_guid,
        'INFO',
        'labmi',
        now()
    );

    ----------------------------------------------------------------
    -- INSERT INTO HISTORY
    ----------------------------------------------------------------
    INSERT INTO labmi.labmi_whatsapp_bot_quiz_ans_history
    SELECT *
    FROM labmi.labmi_whatsapp_bot_quiz_ans
    WHERE (created_date + interval '5.50 hour')::date < p_date::date;

    GET DIAGNOSTICS v_insert_count = ROW_COUNT;

    ----------------------------------------------------------------
    -- INSERT COUNT LOG
    ----------------------------------------------------------------
    INSERT INTO siwaf.siwaf_client_logs
    (
        api_error_log_id,
        log_method_name,
        log_error_message,
        log_guid,
        log_type,
        client_name,
        created_date
    )
    VALUES
    (
        nextval('siwaf.siwaf_client_logs_api_error_log_id_seq'),
        'labmi_del_whatsapp_bot_data',
        'Records inserted into history table = ' || v_insert_count::text,
        v_log_guid,
        'INFO',
        'labmi',
        now()
    );

    ----------------------------------------------------------------
    -- DELETE FROM MAIN TABLE
    ----------------------------------------------------------------
    DELETE FROM labmi.labmi_whatsapp_bot_quiz_ans
    WHERE (created_date + interval '5.50 hour')::date < p_date::date;

    GET DIAGNOSTICS v_delete_count = ROW_COUNT;

    ----------------------------------------------------------------
    -- DELETE COUNT LOG
    ----------------------------------------------------------------
    INSERT INTO siwaf.siwaf_client_logs
    (
        api_error_log_id,
        log_method_name,
        log_error_message,
        log_guid,
        log_type,
        client_name,
        created_date
    )
    VALUES
    (
        nextval('siwaf.siwaf_client_logs_api_error_log_id_seq'),
        'labmi_del_whatsapp_bot_data',
        'Records deleted from main table = ' || v_delete_count::text,
        v_log_guid,
        'INFO',
        'labmi',
        now()
    );

    ----------------------------------------------------------------
    -- SUCCESS LOG
    ----------------------------------------------------------------
    p_result = 1;

    INSERT INTO siwaf.siwaf_client_logs
    (
        api_error_log_id,
        log_method_name,
        log_error_message,
        log_guid,
        log_type,
        client_name,
        created_date
    )
    VALUES
    (
        nextval('siwaf.siwaf_client_logs_api_error_log_id_seq'),
        'labmi_del_whatsapp_bot_data',
        'SP Completed Successfully. Output p_result = ' || p_result::text,
        v_log_guid,
        'SUCCESS',
        'labmi',
        now()
    );

EXCEPTION
WHEN OTHERS THEN

    p_result = 0;

    ----------------------------------------------------------------
    -- ERROR LOG
    ----------------------------------------------------------------
    INSERT INTO siwaf.siwaf_client_logs
    (
        api_error_log_id,
        log_method_name,
        log_error_message,
        log_guid,
        log_type,
        client_name,
        created_date
    )
    VALUES
    (
        nextval('siwaf.siwaf_client_logs_api_error_log_id_seq'),
        'labmi_del_whatsapp_bot_data',
        'ERROR: ' || SQLERRM,
        v_log_guid,
        'ERROR',
        'WHATSAPP_BOT',
        now()
    );

END;

$$;


--
