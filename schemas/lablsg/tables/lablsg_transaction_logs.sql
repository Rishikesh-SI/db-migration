-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg
-- Object: lablsg_transaction_logs
-- Type: TABLE

-- Name: lablsg_transaction_logs; Type: TABLE; Schema: lablsg; Owner: -
--

CREATE TABLE lablsg.lablsg_transaction_logs (
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
