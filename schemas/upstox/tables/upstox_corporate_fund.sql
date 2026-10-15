-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_corporate_fund
-- Type: TABLE

-- Name: upstox_corporate_fund; Type: TABLE; Schema: upstox; Owner: -
--

CREATE TABLE upstox.upstox_corporate_fund (
    corporate_fund_id numeric,
    group_name character varying(500),
    raised_amount numeric,
    supporter_count numeric,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_date timestamp without time zone
);


--
