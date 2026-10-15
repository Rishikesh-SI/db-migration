-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: labstlz_client_web_cust_modelbk
-- Type: TABLE

-- Name: labstlz_client_web_cust_modelbk; Type: TABLE; Schema: labstlz; Owner: -
--

CREATE TABLE labstlz.labstlz_client_web_cust_modelbk (
    custom_module_id numeric,
    module_name text,
    client_mod_json jsonb,
    created_date date,
    updated_date date
);


--
