-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_quiz_question_master
-- Type: TABLE

-- Name: zeven_quiz_question_master; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_quiz_question_master (
    qqm_id numeric NOT NULL,
    quiz_id numeric NOT NULL,
    question_id numeric NOT NULL,
    question_text text NOT NULL,
    answer_a text NOT NULL,
    answer_b text NOT NULL,
    answer_c text NOT NULL,
    answer_d text NOT NULL,
    correct_answer numeric NOT NULL,
    quiz_status numeric NOT NULL,
    quiz_date timestamp without time zone NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL
);


--
