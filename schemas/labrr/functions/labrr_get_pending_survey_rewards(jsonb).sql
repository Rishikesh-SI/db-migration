-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_get_pending_survey_rewards(jsonb)
-- Type: FUNCTION

-- Name: labrr_get_pending_survey_rewards(jsonb); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_get_pending_survey_rewards(p_input jsonb, OUT p_output jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_max_rows int := COALESCE(NULLIF(p_input ->> 'max_rows', '')::int, 100);
    v_min_age  int := COALESCE(NULLIF(p_input ->> 'older_than_minutes', '')::int, 5);
    v_rows     jsonb;
BEGIN

/*
-- Case 1: Fetch a batch of pending rewards (defaults: 100 rows, older than 5 minutes)
SELECT labrr.labrr_get_pending_survey_rewards('{}'::jsonb);
-- Expected: {"status": "1", "rows": [ {"user_guid": "...", "survey_id": "...", "activity_id": "..."} , ... ]}

-- Case 2: Explicit limits
SELECT labrr.labrr_get_pending_survey_rewards(
    '{"max_rows": 50, "older_than_minutes": 10}'::jsonb
);
-- Expected: {"status": "1", "rows": [ ... up to 50 rows older than 10 minutes ... ]}

-- Case 3: Nothing pending
SELECT labrr.labrr_get_pending_survey_rewards('{}'::jsonb);
-- Expected: {"status": "1", "rows": []}
*/

    -- Rows whose FLARE credit was never acknowledged (is_reward_sent = false).
    -- older_than_minutes avoids racing the inline fire-and-forget on a just-inserted row;
    -- max_rows bounds the batch. Oldest first so retries drain in submission order.
    SELECT COALESCE(jsonb_agg(t), '[]'::jsonb)
    INTO   v_rows
    FROM (
        SELECT user_guid, survey_id, activity_id
        FROM   labrr.labrr_branded_survey_response
        WHERE  is_reward_sent = FALSE
        AND    created_date <= ((now() AT TIME ZONE 'UTC') - make_interval(mins => v_min_age))
        ORDER  BY created_date ASC
        LIMIT  v_max_rows
    ) t;

    p_output := jsonb_build_object(
        'status', '1',
        'rows',   v_rows
    );

EXCEPTION WHEN OTHERS THEN
    -- Return the actual Postgres error message so .NET can log it
    p_output := jsonb_build_object(
        'status',  '0',
        'rows',    '[]'::jsonb,
        'message', SQLERRM
    );
END;
$$;


--
