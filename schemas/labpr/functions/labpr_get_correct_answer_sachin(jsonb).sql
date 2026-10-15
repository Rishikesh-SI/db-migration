-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_get_correct_answer_sachin(jsonb)
-- Type: FUNCTION

-- Name: labpr_get_correct_answer_sachin(jsonb); Type: FUNCTION; Schema: labpr; Owner: -
--

CREATE FUNCTION labpr.labpr_get_correct_answer_sachin(question_json jsonb, OUT p_result integer, OUT p_correct_answer jsonb) RETURNS record
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
    p_result := 0; 
----correct_answer := '{}'::JSONB;
	p_correct_answer := question_json; 

    IF options IS NOT NULL THEN
        for i in 0..jsonb_array_length(options) - 1 LOOP
            answer_id := (options->i->>'answer_id')::INT;
			answer_display_value := options->i->>'answer_display_value';

           IF answer_id = correct_ans_id THEN
                p_correct_answer := jsonb_set(
                    p_correct_answer, 
                    '{answer_display_value}',  
                    to_jsonb(answer_display_value) 
                );
                p_result := 1;  
                EXIT;
            END IF;
        END LOOP;
    ELSE
        p_correct_answer := '{"error": "Options not found"}'::JSONB;
        p_result := -1; 
    END IF;
END;
$$;


--
