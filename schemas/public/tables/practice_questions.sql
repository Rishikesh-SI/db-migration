-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: practice_questions
-- Type: TABLE

-- Name: practice_questions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.practice_questions (
    q_id integer NOT NULL,
    question_text text NOT NULL,
    correct_ans_id integer NOT NULL,
    answer_id integer,
    answer_display_value text
);


--
