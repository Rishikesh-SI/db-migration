-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_upd_branded_survey_reward(jsonb)
-- Type: FUNCTION

-- Name: labrr_upd_branded_survey_reward(jsonb); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_upd_branded_survey_reward(p_input jsonb, OUT p_output jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_user_guid text := p_input ->> 'user_guid';
    v_survey_id text := p_input ->> 'survey_id';
    v_rows      int  := 0;
BEGIN

/*
-- Case 1: Mark reward sent for an existing submission
SELECT labrr.labrr_upd_branded_survey_reward(
    '{"user_guid": "abc123-xyz-456", "survey_id": "survey_moengage_001"}'::jsonb
);
-- Expected: {"status": "1", "updated": 1}

-- Case 2: No matching row (already marked, or user/survey not present)
SELECT labrr.labrr_upd_branded_survey_reward(
    '{"user_guid": "no-such-user", "survey_id": "no-such-survey"}'::jsonb
);
-- Expected: {"status": "1", "updated": 0}
*/

    -- Mandatory field check before attempting update
    IF v_user_guid IS NULL OR v_survey_id IS NULL THEN
        p_output := jsonb_build_object(
            'status',  '0',
            'updated', 0,
            'message', 'user_guid and survey_id are required'
        );
        RETURN;
    END IF;

    -- Flip is_reward_sent only after FLARE has confirmed the credit.
    -- Rows left at FALSE remain eligible for the retry sweeper.
    UPDATE labrr.labrr_branded_survey_response
    SET    is_reward_sent = TRUE
    WHERE  user_guid = v_user_guid
    AND    survey_id = v_survey_id;

    GET DIAGNOSTICS v_rows = ROW_COUNT;

    p_output := jsonb_build_object(
        'status',  '1',
        'updated', v_rows
    );

EXCEPTION WHEN OTHERS THEN
    -- Return the actual Postgres error message so .NET can log it
    p_output := jsonb_build_object(
        'status',  '0',
        'updated', 0,
        'message', SQLERRM
    );
END;
$$;


--
