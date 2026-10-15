-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: labhkind_client_web_cust_model
-- Type: TABLE

-- Name: labhkind_client_web_cust_model; Type: TABLE; Schema: labhkind; Owner: -
--

CREATE TABLE labhkind.labhkind_client_web_cust_model (
    custom_module_id numeric NOT NULL,
    module_name text,
    client_mod_json jsonb,
    created_date date,
    updated_date date
);


--
