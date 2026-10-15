-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_tigertrack_data
-- Type: TABLE

-- Name: tmm_tigertrack_data; Type: TABLE; Schema: tmm; Owner: -
--

CREATE TABLE tmm.tmm_tigertrack_data (
    tigertrack_data_id numeric NOT NULL,
    bib_number numeric NOT NULL,
    social_user_id character varying(500),
    msg_text character varying(1000),
    pubisher character varying(250),
    msg_id character varying(500),
    created_date timestamp without time zone,
    user_json jsonb
);


--
