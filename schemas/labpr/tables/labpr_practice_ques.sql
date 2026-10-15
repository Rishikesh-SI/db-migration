-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_practice_ques
-- Type: TABLE

-- Name: labpr_practice_ques; Type: TABLE; Schema: labpr; Owner: -
--

CREATE TABLE labpr.labpr_practice_ques (
    q_id integer NOT NULL,
    question_text text,
    options jsonb,
    correct_ans_id integer
);


--
