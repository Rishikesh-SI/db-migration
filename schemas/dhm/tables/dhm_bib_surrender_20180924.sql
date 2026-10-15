-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_bib_surrender_20180924
-- Type: TABLE

-- Name: dhm_bib_surrender_20180924; Type: TABLE; Schema: dhm; Owner: -
--

CREATE TABLE dhm.dhm_bib_surrender_20180924 (
    bib_surrender_id numeric,
    app_id numeric,
    first_name character varying(100),
    last_name character varying(100),
    date_of_birth character varying,
    gender character varying(10),
    race character varying(100),
    surrender_reason character varying(500),
    bib_no numeric,
    is_nominating character varying(3),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric
);


--
