-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp
-- Object: labkxp_paytm_code_user_map
-- Type: TABLE

-- Name: labkxp_paytm_code_user_map; Type: TABLE; Schema: labkxp; Owner: -
--

CREATE TABLE labkxp.labkxp_paytm_code_user_map (
    code_user_map_id numeric,
    category_id numeric,
    code_id numeric,
    email_id text,
    created_date timestamp without time zone,
    status numeric
);


--
