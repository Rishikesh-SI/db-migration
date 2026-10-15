-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_transaction_logs
-- Type: TABLE

-- Name: labrr_transaction_logs; Type: TABLE; Schema: labrr_beta_08042024; Owner: -
--

CREATE TABLE labrr_beta_08042024.labrr_transaction_logs (
    client_name character varying,
    user_id numeric,
    servicetype character varying,
    email_id character varying,
    eventtype character varying,
    user_guid character varying,
    input_json character varying,
    error text,
    created_date timestamp without time zone,
    operational_id character varying,
    country_code character varying,
    mobile_no character varying,
    ref_id character varying,
    status boolean,
    method character varying
);


--
