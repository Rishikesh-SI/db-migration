-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: upy_client_web_cust_model
-- Type: TABLE

-- Name: upy_client_web_cust_model; Type: TABLE; Schema: upy; Owner: -
--

CREATE TABLE upy.upy_client_web_cust_model (
    custom_module_id numeric NOT NULL,
    module_name text,
    client_mod_json jsonb,
    created_date date,
    updated_date date
);


--
