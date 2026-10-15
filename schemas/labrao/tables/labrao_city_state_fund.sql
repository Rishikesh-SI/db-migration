-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: labrao_city_state_fund
-- Type: TABLE

-- Name: labrao_city_state_fund; Type: TABLE; Schema: labrao; Owner: -
--

CREATE TABLE labrao.labrao_city_state_fund (
    city_state_fund_id numeric,
    city character varying(500),
    state_name character varying(500),
    raised_amount numeric,
    supporter_count numeric,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_date timestamp without time zone
);


--
