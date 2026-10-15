-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp
-- Object: labkxp_paytm_code_master
-- Type: TABLE

-- Name: labkxp_paytm_code_master; Type: TABLE; Schema: labkxp; Owner: -
--

CREATE TABLE labkxp.labkxp_paytm_code_master (
    code_id numeric NOT NULL,
    code_name text,
    code text,
    category_id numeric,
    status numeric
);


--
