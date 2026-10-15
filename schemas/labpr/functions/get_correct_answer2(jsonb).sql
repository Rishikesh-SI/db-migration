-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: get_correct_answer2(jsonb)
-- Type: FUNCTION

-- Name: get_correct_answer2(jsonb); Type: FUNCTION; Schema: labpr; Owner: -
--

CREATE FUNCTION labpr.get_correct_answer2(p_input_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_correct_ans_id int;
    v_question jsonb;
    v_answer jsonb;
    v_ext_info text; 
BEGIN
    v_correct_ans_id := (p_input_json->>'correct_ans_id')::int;

    v_question := p_input_json->'questions'->1;
    raise notice '1';
    raise notice 'v_question:%',v_question;

    v_answer := (
        SELECT option
        FROM jsonb_array_elements(v_question->'options') AS option
        WHERE (option->>'answer_id')::int = v_correct_ans_id
    );
    
    
    p_input_json := jsonb_set(p_input_json, '{answer_display_value}', to_jsonb(v_answer->>'answer_display_value'), true);

    RETURN p_input_json::jsonb;
END;
$$;


--
