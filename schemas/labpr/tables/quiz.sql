-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: quiz
-- Type: TABLE

-- Name: quiz; Type: TABLE; Schema: labpr; Owner: -
--

CREATE TABLE labpr.quiz (
    q_id integer,
    question_text text NOT NULL,
    answer_id integer NOT NULL,
    answer_display_value text NOT NULL
);


--
