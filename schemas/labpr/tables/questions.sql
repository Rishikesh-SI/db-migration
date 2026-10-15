-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: questions
-- Type: TABLE

-- Name: questions; Type: TABLE; Schema: labpr; Owner: -
--

CREATE TABLE labpr.questions (
    q_id integer NOT NULL,
    question_text text NOT NULL,
    correct_ans_id integer NOT NULL,
    options jsonb NOT NULL
);


--
