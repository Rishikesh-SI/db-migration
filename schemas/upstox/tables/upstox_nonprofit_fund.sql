-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_nonprofit_fund
-- Type: TABLE

-- Name: upstox_nonprofit_fund; Type: TABLE; Schema: upstox; Owner: -
--

CREATE TABLE upstox.upstox_nonprofit_fund (
    nonprofit_fund_id numeric,
    nonprofit text,
    raised_amount numeric,
    supporter_count numeric,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_date timestamp without time zone
);


--
