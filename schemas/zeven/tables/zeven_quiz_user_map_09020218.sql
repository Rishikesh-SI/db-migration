-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_quiz_user_map_09020218
-- Type: TABLE

-- Name: zeven_quiz_user_map_09020218; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_quiz_user_map_09020218 (
    qum_id numeric,
    quiz_id numeric,
    user_id numeric,
    question_id numeric,
    user_answer numeric,
    question_time timestamp without time zone,
    answer_time timestamp without time zone,
    is_correct numeric,
    points numeric,
    is_answered numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    question_srno numeric
);


--
