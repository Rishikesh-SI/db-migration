-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: get_correct_answer(jsonb, text)
-- Type: PROCEDURE

-- Name: get_correct_answer(jsonb, text); Type: PROCEDURE; Schema: labpr; Owner: -
--

CREATE PROCEDURE labpr.get_correct_answer(IN question_json jsonb, INOUT correct_answer text)
    LANGUAGE plpgsql
    AS $$
DECLARE
    options JSONB;
    answer_id INT;
    correct_ans_id INT;
BEGIN
    -- Extract the correct answer ID from the JSON
    correct_ans_id := (question_json->>'correct_ans_id')::INT;

    -- Extract the options array from the JSON
    options := question_json->'questions'->1->'options';

    -- Loop through the options to find the correct answer
    FOR i IN 0..jsonb_array_length(options) - 1 LOOP
        answer_id := (options->i->>'answer_id')::INT;
        IF answer_id = correct_ans_id THEN
            correct_answer := options->i->>'answer_display_value';
            EXIT;
        END IF;
    END LOOP;
END;
$$;


--
