-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp
-- Object: labkxp_client_web_cust_modelbk
-- Type: TABLE

-- Name: labkxp_client_web_cust_modelbk; Type: TABLE; Schema: labkxp; Owner: -
--

CREATE TABLE labkxp.labkxp_client_web_cust_modelbk (
    custom_module_id numeric,
    module_name text,
    client_mod_json jsonb,
    created_date date,
    updated_date date
);


--
