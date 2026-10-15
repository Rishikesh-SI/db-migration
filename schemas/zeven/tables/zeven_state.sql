-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_state
-- Type: TABLE

-- Name: zeven_state; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_state (
    stateid numeric NOT NULL,
    state_name character varying(100) NOT NULL,
    state_short_code character varying(5),
    countryid numeric NOT NULL,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
