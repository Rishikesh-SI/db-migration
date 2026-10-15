-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cli_stp_v1
-- Object: cli_stp_v1_custom_web_json
-- Type: TABLE

-- Name: cli_stp_v1_custom_web_json; Type: TABLE; Schema: cli_stp_v1; Owner: -
--

CREATE TABLE cli_stp_v1.cli_stp_v1_custom_web_json (
    custom_id numeric NOT NULL,
    captcha character varying,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    user_guid character varying,
    module_name character varying,
    datajson jsonb
);


--
