-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: labmao_corporate_fund_23082021
-- Type: TABLE

-- Name: labmao_corporate_fund_23082021; Type: TABLE; Schema: labmao; Owner: -
--

CREATE TABLE labmao.labmao_corporate_fund_23082021 (
    corporate_fund_id numeric,
    group_name character varying(500),
    raised_amount numeric,
    supporter_count numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
