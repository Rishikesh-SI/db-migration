-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: labupstox_overall_fund
-- Type: TABLE

-- Name: labupstox_overall_fund; Type: TABLE; Schema: labupstox; Owner: -
--

CREATE TABLE labupstox.labupstox_overall_fund (
    overall_fund_id numeric,
    raised_amount numeric,
    supporter_count numeric,
    campaign_count numeric,
    created_date timestamp without time zone DEFAULT now(),
    updated_date timestamp without time zone,
    last_updated_date timestamp without time zone
);


--
