-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_calculate_score_anshu(jsonb, jsonb)
-- Type: FUNCTION

-- Name: labpr_calculate_score_anshu(jsonb, jsonb); Type: FUNCTION; Schema: labpr; Owner: -
--

CREATE FUNCTION labpr.labpr_calculate_score_anshu(user_answer jsonb, correct_answer jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
    total_score int := 0;
    answer_record record;
    answer_id text;
begin
    for answer_record in select * from jsonb_each(user_answer) loop
        answer_id := answer_record.value->>'answer_id'; -- Extract the answer_id as text
        if (correct_answer->>answer_id) is not null then
            total_score := total_score + 1;
        end if;
    end loop;

    return jsonb_build_object('score', total_score);
end;
$$;


--
