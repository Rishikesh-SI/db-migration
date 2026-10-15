-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsfcc
-- Object: labsfcc_contest
-- Type: TABLE

-- Name: labsfcc_contest; Type: TABLE; Schema: labsfcc; Owner: -
--

CREATE TABLE labsfcc.labsfcc_contest (
    contest_id numeric NOT NULL,
    southampton_homeground character varying(300),
    southampton_mainsponsor character varying(300),
    southampton_nickname character varying(300),
    firstname character varying(300),
    lastname character varying(300),
    sportsbetusername character varying(300),
    email character varying(300),
    postal_address character varying(500),
    agree_tc boolean,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
