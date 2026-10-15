-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_quiz_question_master_09022018
-- Type: TABLE

-- Name: zeven_quiz_question_master_09022018; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_quiz_question_master_09022018 (
    qqm_id numeric,
    quiz_id numeric,
    question_id numeric,
    question_text text,
    answer_a text,
    answer_b text,
    answer_c text,
    answer_d text,
    correct_answer numeric,
    quiz_status numeric,
    quiz_date timestamp without time zone,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
