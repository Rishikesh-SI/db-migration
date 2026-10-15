-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_client_web_cust_model
-- Type: TABLE

-- Name: labtcs_client_web_cust_model; Type: TABLE; Schema: labtcs; Owner: -
--

CREATE TABLE labtcs.labtcs_client_web_cust_model (
    custom_module_id numeric NOT NULL,
    module_name text,
    client_mod_json jsonb,
    created_date date,
    updated_date date
);


--
