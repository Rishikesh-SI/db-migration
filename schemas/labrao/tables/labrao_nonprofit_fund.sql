-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: labrao_nonprofit_fund
-- Type: TABLE

-- Name: labrao_nonprofit_fund; Type: TABLE; Schema: labrao; Owner: -
--

CREATE TABLE labrao.labrao_nonprofit_fund (
    nonprofit_fund_id numeric,
    nonprofit text,
    raised_amount numeric,
    supporter_count numeric,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_date timestamp without time zone
);


--
