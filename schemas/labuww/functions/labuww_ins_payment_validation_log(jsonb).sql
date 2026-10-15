-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: labuww_ins_payment_validation_log(jsonb)
-- Type: FUNCTION

-- Name: labuww_ins_payment_validation_log(jsonb); Type: FUNCTION; Schema: labuww; Owner: -
--

CREATE FUNCTION labuww.labuww_ins_payment_validation_log(p_in_json jsonb, OUT p_out_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_log_id BIGINT;
    v_data JSONB;
BEGIN
    -- Extract inner data object
    v_data := p_in_json->'data';

    INSERT INTO labuww.labuww_payment_validation_log (
        user_name,
        user_email,
        user_country,
        platform,
        app_version,
        item_id,
        item_type,
        access_fee_id,
        payment_receipt,
        purchase_datetime,
        store_validation_status,
        inplayer_validation_status
    )
    VALUES (
        v_data->>'user_name',
        v_data->>'user_email',
        v_data->>'user_country',
        v_data->>'platform',
        v_data->>'app_version',
        v_data->>'item_id',
        v_data->>'item_type',
        v_data->>'access_fee_id',
        v_data->>'payment_receipt',
        (v_data->>'purchase_datetime')::timestamp,
        v_data->>'store_validation_status',
        v_data->>'inplayer_validation_status'
    )
    RETURNING log_id INTO v_log_id;

    -- Assign to OUT param
    p_out_json := jsonb_build_object(
        'status', 'success',
        'log_id', v_log_id
    );

EXCEPTION WHEN OTHERS THEN
    p_out_json := jsonb_build_object(
        'status', 'error',
        'message', SQLERRM
    );
END;
$$;


--
