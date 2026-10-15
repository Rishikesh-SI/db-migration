-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labspz_v1
-- Object: labspz_v1_custom_web_json
-- Type: TABLE

-- Name: labspz_v1_custom_web_json; Type: TABLE; Schema: labspz_v1; Owner: -
--

CREATE TABLE labspz_v1.labspz_v1_custom_web_json (
    custom_id numeric NOT NULL,
    captcha character varying,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    user_guid character varying,
    module_name character varying,
    datajson jsonb,
    email_id character varying
);


--
