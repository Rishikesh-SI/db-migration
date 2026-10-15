-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_internal_log
-- Type: TABLE

-- Name: labgt_internal_log; Type: TABLE; Schema: labgt; Owner: -
--

CREATE TABLE labgt.labgt_internal_log (
    id numeric NOT NULL,
    user_guid character varying,
    mobile_no character varying,
    input_json jsonb,
    created_date timestamp without time zone,
    device_name character varying,
    platform_type numeric,
    platform_version character varying
);


--
