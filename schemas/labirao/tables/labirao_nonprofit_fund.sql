-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labirao
-- Object: labirao_nonprofit_fund
-- Type: TABLE

-- Name: labirao_nonprofit_fund; Type: TABLE; Schema: labirao; Owner: -
--

CREATE TABLE labirao.labirao_nonprofit_fund (
    nonprofit_fund_id numeric,
    nonprofit text,
    raised_amount numeric,
    supporter_count numeric,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_date timestamp without time zone
);


--
