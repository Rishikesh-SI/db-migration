-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: tcs_bib_surrender
-- Type: TABLE

-- Name: tcs_bib_surrender; Type: TABLE; Schema: tcs; Owner: -
--

CREATE TABLE tcs.tcs_bib_surrender (
    bib_surrender_id numeric NOT NULL,
    app_id numeric NOT NULL,
    first_name character varying(100),
    last_name character varying(100),
    date_of_birth character varying,
    gender character varying(10),
    race character varying(100),
    surrender_reason character varying(500),
    bib_no numeric NOT NULL,
    is_nominating character varying(3),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric
);


--
