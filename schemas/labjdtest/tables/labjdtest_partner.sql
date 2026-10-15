-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjdtest
-- Object: labjdtest_partner
-- Type: TABLE

-- Name: labjdtest_partner; Type: TABLE; Schema: labjdtest; Owner: -
--

CREATE TABLE labjdtest.labjdtest_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
