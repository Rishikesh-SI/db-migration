-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: labstlz_paytm_code_master
-- Type: TABLE

-- Name: labstlz_paytm_code_master; Type: TABLE; Schema: labstlz; Owner: -
--

CREATE TABLE labstlz.labstlz_paytm_code_master (
    code_id numeric NOT NULL,
    code_name text,
    code text,
    category_id numeric,
    status numeric
);


--
