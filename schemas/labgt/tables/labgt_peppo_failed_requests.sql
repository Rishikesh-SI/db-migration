-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_peppo_failed_requests
-- Type: TABLE

-- Name: labgt_peppo_failed_requests; Type: TABLE; Schema: labgt; Owner: -
--

CREATE TABLE labgt.labgt_peppo_failed_requests (
    id integer DEFAULT nextval('labgt.labgt_peppo_failed_requests_id_seq'::regclass) NOT NULL,
    waf_user_guid character varying(100),
    request_payload character varying,
    processing_status character varying(20) DEFAULT 'pending'::character varying,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    event_type character varying(50),
    api_type character varying(100),
    request_url character varying(500),
    response_status_code integer,
    response_body text,
    attempt_no integer,
    max_attempts integer,
    is_final_failure boolean DEFAULT false
);


--
