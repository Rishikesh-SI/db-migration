-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: labupstox_city_state_fund
-- Type: TABLE

-- Name: labupstox_city_state_fund; Type: TABLE; Schema: labupstox; Owner: -
--

CREATE TABLE labupstox.labupstox_city_state_fund (
    city_state_fund_id numeric,
    city character varying(500),
    state_name character varying(500),
    raised_amount numeric,
    supporter_count numeric,
    created_date timestamp without time zone DEFAULT now(),
    updated_date timestamp without time zone
);


--
