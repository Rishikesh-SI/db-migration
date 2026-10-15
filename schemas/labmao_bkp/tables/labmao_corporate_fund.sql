-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao_bkp
-- Object: labmao_corporate_fund
-- Type: TABLE

-- Name: labmao_corporate_fund; Type: TABLE; Schema: labmao_bkp; Owner: -
--

CREATE TABLE labmao_bkp.labmao_corporate_fund (
    corporate_fund_id numeric,
    group_name character varying(500),
    raised_amount numeric,
    supporter_count numeric,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_date timestamp without time zone
);


--
