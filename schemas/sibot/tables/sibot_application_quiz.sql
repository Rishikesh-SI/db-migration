-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_application_quiz
-- Type: TABLE

-- Name: sibot_application_quiz; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_application_quiz (
    quiz_id numeric,
    quiz_title text,
    quiz_sub_title text,
    image_url text,
    payload_text text,
    question_limit numeric,
    answer_time_in_seconds numeric,
    points numeric,
    points_per_second numeric,
    quiz_order numeric,
    is_contest numeric,
    sport_id numeric,
    is_active numeric,
    application_id numeric,
    quiz_type text
);


--
