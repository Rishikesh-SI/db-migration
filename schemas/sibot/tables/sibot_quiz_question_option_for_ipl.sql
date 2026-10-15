-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_quiz_question_option_for_ipl
-- Type: TABLE

-- Name: sibot_quiz_question_option_for_ipl; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_quiz_question_option_for_ipl (
    quiz_question_option_id numeric,
    quiz_id numeric,
    question_id numeric,
    option_id numeric,
    option_text text
);


--
