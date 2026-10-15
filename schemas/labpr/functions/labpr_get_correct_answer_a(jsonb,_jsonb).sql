-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_get_correct_answer_a(jsonb, jsonb)
-- Type: FUNCTION

-- Name: labpr_get_correct_answer_a(jsonb, jsonb); Type: FUNCTION; Schema: labpr; Owner: -
--

CREATE FUNCTION labpr.labpr_get_correct_answer_a(question_json jsonb, INOUT correct_answer jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    options JSONB;
    answer_id INT;
    correct_ans_id INT;
    answer_display_value TEXT;
    answer_list JSONB := '[]'::JSONB;
BEGIN
    
    correct_ans_id := (question_json->>'correct_ans_id')::INT;

   
    options := question_json->'questions'->1->'options';

   
    correct_answer := '{}'::JSONB;

   
    IF options IS NOT NULL THEN
        
        FOR i IN 0..jsonb_array_length(options) - 1 LOOP
            answer_id := (options->i->>'answer_id')::INT;
            answer_display_value := options->i->>'answer_display_value';

            IF answer_id = correct_ans_id THEN
               
                answer_list := jsonb_insert(answer_list, '{0}', jsonb_build_object('correct_answer', answer_display_value));
            END IF;
        END LOOP;

     
        FOR i IN 0..jsonb_array_length(options) - 1 LOOP
            answer_id := (options->i->>'answer_id')::INT;
            answer_display_value := options->i->>'answer_display_value';

            IF answer_id != correct_ans_id THEN
              
                answer_list := answer_list || jsonb_build_object('answer', answer_display_value);
            END IF;
        END LOOP;

        -- Set the final output
        correct_answer := jsonb_build_object('answers', answer_list);
    ELSE
        -- In case options are not found
        correct_answer := jsonb_build_object('error', 'Options not found');
    END IF;
END;
$$;


--
