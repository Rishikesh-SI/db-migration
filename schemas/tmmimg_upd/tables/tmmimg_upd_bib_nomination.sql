-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: tmmimg_upd_bib_nomination
-- Type: TABLE

-- Name: tmmimg_upd_bib_nomination; Type: TABLE; Schema: tmmimg_upd; Owner: -
--

CREATE TABLE tmmimg_upd.tmmimg_upd_bib_nomination (
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
