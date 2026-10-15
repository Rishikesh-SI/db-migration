-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: labmao_nonprofit_fund
-- Type: TABLE

-- Name: labmao_nonprofit_fund; Type: TABLE; Schema: labmao; Owner: -
--

CREATE TABLE labmao.labmao_nonprofit_fund (
    nonprofit_fund_id numeric,
    nonprofit text,
    raised_amount numeric,
    supporter_count numeric,
    created_date timestamp without time zone DEFAULT now(),
    updated_date timestamp without time zone
);


--
