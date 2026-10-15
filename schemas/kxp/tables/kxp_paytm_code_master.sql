-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: kxp_paytm_code_master
-- Type: TABLE

-- Name: kxp_paytm_code_master; Type: TABLE; Schema: kxp; Owner: -
--

CREATE TABLE kxp.kxp_paytm_code_master (
    code_id numeric NOT NULL,
    code_name text,
    code text,
    category_id numeric,
    status numeric
);


--
