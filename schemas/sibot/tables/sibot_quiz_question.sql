-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_quiz_question
-- Type: TABLE

-- Name: sibot_quiz_question; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_quiz_question (
    quiz_question_id numeric,
    quiz_id numeric,
    question_id numeric,
    question_text text,
    question_image_url text,
    question_image_attachement_id text,
    option_count numeric,
    question_type character(1),
    correct_answer numeric,
    correct_answer_text text,
    correct_answer_image_url text,
    correct_answer_attachement_id text,
    wrong_answer_text text,
    wrong_answer_image_url text,
    wrong_answer_attachement_id text,
    created_date timestamp without time zone
);


--
