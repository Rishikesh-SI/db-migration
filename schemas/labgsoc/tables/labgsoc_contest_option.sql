-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: labgsoc_contest_option
-- Type: TABLE

-- Name: labgsoc_contest_option; Type: TABLE; Schema: labgsoc; Owner: -
--

CREATE TABLE labgsoc.labgsoc_contest_option (
    contest_option_id numeric NOT NULL,
    contest_id numeric,
    option character varying,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    contest_option_guid character varying(256),
    option_order numeric,
    is_ans text,
    answer_type text
);


--
