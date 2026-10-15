-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_client_web_cust_model
-- Type: TABLE

-- Name: labmi_client_web_cust_model; Type: TABLE; Schema: labmi_beta_22042024; Owner: -
--

CREATE TABLE labmi_beta_22042024.labmi_client_web_cust_model (
    custom_module_id numeric NOT NULL,
    module_name text,
    client_mod_json jsonb,
    created_date date,
    updated_date date
);


--
