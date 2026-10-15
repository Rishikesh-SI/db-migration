-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_30012024
-- Object: labkkr_transaction_logs
-- Type: TABLE

-- Name: labkkr_transaction_logs; Type: TABLE; Schema: labkkr_30012024; Owner: -
--

CREATE TABLE labkkr_30012024.labkkr_transaction_logs (
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
    status boolean,
    ref_id character varying,
    method character varying
);


--
