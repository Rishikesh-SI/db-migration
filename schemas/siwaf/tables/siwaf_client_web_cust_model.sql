-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: siwaf_client_web_cust_model
-- Type: TABLE

-- Name: siwaf_client_web_cust_model; Type: TABLE; Schema: siwaf; Owner: -
--

CREATE TABLE siwaf.siwaf_client_web_cust_model (
    custom_module_id numeric NOT NULL,
    client_id numeric,
    model_name text,
    client_mod_json jsonb,
    created_date date,
    updated_date date
);


--
