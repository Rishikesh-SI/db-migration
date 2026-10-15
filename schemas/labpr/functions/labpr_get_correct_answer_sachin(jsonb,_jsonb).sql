-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_get_correct_answer_sachin(jsonb, jsonb)
-- Type: FUNCTION

-- Name: labpr_get_correct_answer_sachin(jsonb, jsonb); Type: FUNCTION; Schema: labpr; Owner: -
--

CREATE FUNCTION labpr.labpr_get_correct_answer_sachin(question_json jsonb, INOUT correct_answer jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    options JSONB;
    answer_id INT;
    correct_ans_id INT;
    answer_display_value TEXT;
BEGIN
    correct_ans_id := (question_json->>'correct_ans_id')::INT;
    options := question_json->'questions'->1->'options';
    correct_answer := '{}'::JSONB;
    IF options IS NOT NULL THEN
        for i in 0..jsonb_array_length(options) - 1 LOOP
            answer_id := (options->i->>'answer_id')::INT;
            IF answer_id = correct_ans_id THEN
                answer_display_value := options->i->>'answer_display_value';
                correct_answer := jsonb_build_object('correct_answer', answer_display_value);
                EXIT;
            END IF;
        END LOOP;
    ELSE
        correct_answer := jsonb_build_object('error', 'Options not found');
    END IF;
END;
$$;


--
