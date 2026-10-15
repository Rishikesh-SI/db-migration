-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_get_custom_web_model_r(jsonb)
-- Type: FUNCTION

-- Name: labgt01_v1_get_custom_web_model_r(jsonb); Type: FUNCTION; Schema: labgt01_v1; Owner: -
--

CREATE FUNCTION labgt01_v1.labgt01_v1_get_custom_web_model_r(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_user_guid   varchar(2000);
    v_module_name text;
BEGIN

    SELECT
        p_json->>'user_guid',
        p_json->>'module_name'
    INTO
        v_user_guid,
        v_module_name;

    IF lower(v_module_name) <> 'auction_activation_2026' THEN
        IF EXISTS (
            SELECT 1
            FROM labgt01_v1.labgt01_v1_custom_web_json
            WHERE user_guid = v_user_guid
            AND lower(module_name) = lower(v_module_name)
        ) THEN
            p_data := jsonb_build_object(
                'data', jsonb_build_object(
                    'status','1',
                    'message','Already Exists'
                )
            );
        ELSE
            p_data := jsonb_build_object(
                'data', jsonb_build_object(
                    'status','0',
                    'message','Not Exists'
                )
            );
        END IF;
        RETURN;
    END IF;

    -- For auction_activation_2026, check if user exists
    IF NOT EXISTS (
        SELECT 1
        FROM labgt01_v1.labgt01_v1_custom_web_json
        WHERE user_guid = v_user_guid
        AND lower(module_name) = 'auction_activation_2026'
    ) THEN
        p_data := jsonb_build_object(
            'data', jsonb_build_object(
                'status','0',
                'message','Not Exists'
            )
        );
        RETURN;
    END IF;

    -- If user exists, fetch and return scenarios
    BEGIN
    SELECT jsonb_build_object(
    'data', jsonb_build_object(
        'status','1',
        'module','auction_activation_2026',
        'scenarios',
            (
                SELECT jsonb_agg(
                    jsonb_build_object(
                        'scenario_id',   scenario_id,
                        'scenario_text', scenario_text,
                        'position',      "position"  -- Return as string
                    )
                )
                FROM labgt01_v1.labgt01_v1_auction_activation_2026
                WHERE user_guid = v_user_guid
            ),
        'user_guid', v_user_guid
    )
)
INTO p_data;

    EXCEPTION WHEN NO_DATA_FOUND THEN
        -- Fallback: Return a valid JSON object if no data is found
        p_data := jsonb_build_object(
            'data', jsonb_build_object(
                'status','0',
                'message','No scenarios found'
            )
        );
    END;
END;
$$;


--
