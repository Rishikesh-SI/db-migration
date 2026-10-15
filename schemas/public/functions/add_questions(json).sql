-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: add_questions(json)
-- Type: FUNCTION

-- Name: add_questions(json); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.add_questions(json_input json) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO labpr_LSG(ans_id, ans_display_value)
    SELECT
        emp->>'ans-id' AS ans_id,
        emp->>'ans_dispaly_value' AS ans_dispaly_value
    FROM
        json_array_elements(json_input) AS emp;
END;
$$;


--
