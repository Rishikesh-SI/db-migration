-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_log
-- Type: TABLE

-- Name: ss_log; Type: TABLE; Schema: eks; Owner: -
--

CREATE TABLE eks.ss_log (
    cf_logid integer DEFAULT nextval('eks.ss_log_cf_logid_seq'::regclass) NOT NULL,
    cf_source_typeid numeric(30,0),
    cf_userid numeric(30,0),
    social_id character varying(4000),
    client_id numeric(30,0),
    procedure_name character varying(75),
    ret_type numeric(25,0),
    error_message character varying(4000),
    varchar_value1 character varying(4000),
    varchar_value2 character varying(4000),
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL
);


--
