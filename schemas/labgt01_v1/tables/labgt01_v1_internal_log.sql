-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_internal_log
-- Type: TABLE

-- Name: labgt01_v1_internal_log; Type: TABLE; Schema: labgt01_v1; Owner: -
--

CREATE TABLE labgt01_v1.labgt01_v1_internal_log (
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
