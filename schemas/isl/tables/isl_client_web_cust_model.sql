-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_client_web_cust_model
-- Type: TABLE

-- Name: isl_client_web_cust_model; Type: TABLE; Schema: isl; Owner: -
--

CREATE TABLE isl.isl_client_web_cust_model (
    custom_module_id numeric NOT NULL,
    module_name text,
    client_mod_json jsonb,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
