-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_ins_branded_survey(jsonb)
-- Type: FUNCTION

-- Name: labrr_ins_branded_survey(jsonb); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_ins_branded_survey(p_input jsonb, OUT p_output jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_user_guid   text  := p_input ->> 'user_guid';
    v_survey_id   text  := p_input ->> 'survey_id';
    v_activity_id text  := p_input ->> 'activity_id';
    v_answers     jsonb := p_input -> 'answers';
    v_inserted    int   := 0;
BEGIN
    -- Mandatory field check before attempting insert
    IF v_user_guid IS NULL OR v_survey_id IS NULL THEN
        p_output := jsonb_build_object(
            'status',  '0',
            'is_new',  false,
            'message', 'user_guid and survey_id are required'
        );
        RETURN;
    END IF;

    -- ON CONFLICT DO NOTHING means a duplicate row is silently skipped,
    -- no error is raised, and ROW_COUNT will be 0 instead of 1
    INSERT INTO labrr.labrr_branded_survey_response
        (user_guid, survey_id, activity_id, answers)
    VALUES
        (v_user_guid, v_survey_id, v_activity_id, v_answers)
    ON CONFLICT (user_guid, survey_id) DO NOTHING;

    -- ROW_COUNT = 1 means fresh insert, 0 means it was a duplicate
    GET DIAGNOSTICS v_inserted = ROW_COUNT;

    IF v_inserted = 1 THEN
        -- New submission — .NET will proceed to credit FLRP points
        p_output := jsonb_build_object(
            'status',  '1',
            'is_new',  true,
            'message', 'inserted'
        );
    ELSE
        -- Duplicate — .NET will skip reward crediting
        p_output := jsonb_build_object(
            'status',  '1',
            'is_new',  false,
            'message', 'duplicate'
        );
    END IF;

/*
-- Case 1: Fresh insert (new submission)
SELECT labrr.labrr_ins_branded_survey(
    '{
        "user_guid": "abc123-xyz-456",
        "survey_id": "survey_moengage_001",
        "activity_id": "flare_act_789",
        "answers": {
            "q1": "Jaipur",
            "q2": "Sanju Samson",
            "q3": "Yes"
        }
    }'::jsonb
);
-- Expected: {"status": "1", "is_new": true, "message": "inserted"}

-- Case 2: Duplicate insert (same user_guid + survey_id)
SELECT labrr.labrr_ins_branded_survey(
    '{
        "user_guid": "abc123-xyz-456",
        "survey_id": "survey_moengage_001",
        "activity_id": "flare_act_789",
        "answers": {
            "q1": "Jaipur",
            "q2": "Sanju Samson",
            "q3": "Yes"
        }
    }'::jsonb
);
-- Expected: {"status": "1", "is_new": false, "message": "duplicate"}

-- Case 3: Missing user_guid
SELECT labrr.labrr_ins_branded_survey(
    '{
        "survey_id": "survey_moengage_001",
        "activity_id": "flare_act_789",
        "answers": {"q1": "Jaipur"}
    }'::jsonb
);
-- Expected: {"status": "0", "is_new": false, "message": "user_guid and survey_id are required"}

-- Case 4: Missing survey_id
SELECT labrr.labrr_ins_branded_survey(
    '{
        "user_guid": "abc123-xyz-456",
        "activity_id": "flare_act_789",
        "answers": {"q1": "Jaipur"}
    }'::jsonb
);
-- Expected: {"status": "0", "is_new": false, "message": "user_guid and survey_id are required"}

-- Case 5: No activity_id (optional field — should still insert fine)
SELECT labrr.labrr_ins_branded_survey(
    '{
        "user_guid": "def456-abc-789",
        "survey_id": "survey_moengage_002",
        "answers": {"q1": "Blue", "q2": "Option A"}
    }'::jsonb
);
-- Expected: {"status": "1", "is_new": true, "message": "inserted"}

-- Case 6: No answers (optional field — should still insert fine)
SELECT labrr.labrr_ins_branded_survey(
    '{
        "user_guid": "ghi789-def-000",
        "survey_id": "survey_moengage_003",
        "activity_id": "flare_act_999"
    }'::jsonb
);
-- Expected: {"status": "1", "is_new": true, "message": "inserted"}
*/

EXCEPTION WHEN OTHERS THEN
    p_output := jsonb_build_object(
        'status',  '0',
        'is_new',  false,
        'message', SQLERRM
    );
END;
$$;


--
