-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labirao
-- Object: labirao_overall_fund
-- Type: TABLE

-- Name: labirao_overall_fund; Type: TABLE; Schema: labirao; Owner: -
--

CREATE TABLE labirao.labirao_overall_fund (
    overall_fund_id numeric,
    raised_amount numeric,
    supporter_count numeric,
    campaign_count numeric,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_date timestamp without time zone,
    last_updated_date timestamp without time zone
);


--
