-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_user_quiz_play
-- Type: TABLE

-- Name: sibot_user_quiz_play; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_user_quiz_play (
    user_quiz_play_id numeric,
    user_id numeric,
    quiz_id numeric,
    question_id numeric,
    is_answered numeric,
    user_answer numeric,
    is_answer_correct numeric,
    include_in_scorecard numeric,
    question_time timestamp without time zone,
    answer_time timestamp without time zone,
    points numeric
);


--
