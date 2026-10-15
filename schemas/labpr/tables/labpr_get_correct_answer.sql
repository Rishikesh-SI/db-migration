-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_get_correct_answer
-- Type: TABLE

-- Name: labpr_get_correct_answer; Type: TABLE; Schema: labpr; Owner: -
--

CREATE TABLE labpr.labpr_get_correct_answer (
    q_id integer NOT NULL,
    question_text text,
    options jsonb,
    correct_ans_id integer
);


--
