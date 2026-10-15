-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_bib_nomination
-- Type: TABLE

-- Name: tmm_bib_nomination; Type: TABLE; Schema: tmm; Owner: -
--

CREATE TABLE tmm.tmm_bib_nomination (
    bib_nomination_id numeric NOT NULL,
    first_name character varying(100),
    last_name character varying(100),
    date_of_birth character varying,
    gender character varying(10),
    tc_link character varying(500),
    tc_event_name character varying(100),
    tc_race character varying(100),
    tc_bib_no numeric,
    email_id character varying(100),
    contact_number character varying(20),
    address character varying(500),
    nationality character varying(100),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric,
    bib_surrender_id numeric
);


--
