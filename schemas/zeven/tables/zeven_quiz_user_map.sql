-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_quiz_user_map
-- Type: TABLE

-- Name: zeven_quiz_user_map; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_quiz_user_map (
    qum_id numeric NOT NULL,
    quiz_id numeric NOT NULL,
    user_id numeric NOT NULL,
    question_id numeric NOT NULL,
    user_answer numeric,
    question_time timestamp without time zone,
    answer_time timestamp without time zone,
    is_correct numeric,
    points numeric,
    is_answered numeric,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    question_srno numeric
);


--
