-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_old
-- Object: labbsc_client_web_cust_model
-- Type: TABLE

-- Name: labbsc_client_web_cust_model; Type: TABLE; Schema: labbsc_old; Owner: -
--

CREATE TABLE labbsc_old.labbsc_client_web_cust_model (
    custom_module_id numeric NOT NULL,
    module_name text,
    client_mod_json jsonb,
    created_date timestamp with time zone,
    updated_date timestamp with time zone,
    user_guid character varying(100)
);


--
