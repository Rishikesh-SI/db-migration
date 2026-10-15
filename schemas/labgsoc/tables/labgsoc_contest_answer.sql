-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: labgsoc_contest_answer
-- Type: TABLE

-- Name: labgsoc_contest_answer; Type: TABLE; Schema: labgsoc; Owner: -
--

CREATE TABLE labgsoc.labgsoc_contest_answer (
    contest_answer_id numeric NOT NULL,
    contest_id numeric,
    contest_option_id numeric,
    answer character varying(300),
    is_correct_answer boolean,
    is_deleted numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
