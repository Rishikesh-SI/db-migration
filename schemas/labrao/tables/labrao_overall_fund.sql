-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: labrao_overall_fund
-- Type: TABLE

-- Name: labrao_overall_fund; Type: TABLE; Schema: labrao; Owner: -
--

CREATE TABLE labrao.labrao_overall_fund (
    overall_fund_id numeric,
    raised_amount numeric,
    supporter_count numeric,
    campaign_count numeric,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_date timestamp without time zone,
    last_updated_date timestamp without time zone
);


--
