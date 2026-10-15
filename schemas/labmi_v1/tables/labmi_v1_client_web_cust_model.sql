-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_client_web_cust_model
-- Type: TABLE

-- Name: labmi_v1_client_web_cust_model; Type: TABLE; Schema: labmi_v1; Owner: -
--

CREATE TABLE labmi_v1.labmi_v1_client_web_cust_model (
    custom_module_id numeric,
    module_name text,
    client_mod_json jsonb,
    created_date date,
    updated_date date
);


--
