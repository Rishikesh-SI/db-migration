-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp1
-- Object: labkxp_paytm_code_user_map
-- Type: TABLE

-- Name: labkxp_paytm_code_user_map; Type: TABLE; Schema: labkxp1; Owner: -
--

CREATE TABLE labkxp1.labkxp_paytm_code_user_map (
    code_user_map_id numeric,
    category_id numeric,
    code_id numeric,
    email_id text,
    created_date timestamp without time zone,
    status numeric
);


--
