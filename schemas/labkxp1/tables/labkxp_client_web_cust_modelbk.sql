-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp1
-- Object: labkxp_client_web_cust_modelbk
-- Type: TABLE

-- Name: labkxp_client_web_cust_modelbk; Type: TABLE; Schema: labkxp1; Owner: -
--

CREATE TABLE labkxp1.labkxp_client_web_cust_modelbk (
    custom_module_id numeric,
    module_name text,
    client_mod_json jsonb,
    created_date date,
    updated_date date
);


--
