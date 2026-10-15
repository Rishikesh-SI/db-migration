-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg
-- Object: lablsg_custom_web_json
-- Type: TABLE

-- Name: lablsg_custom_web_json; Type: TABLE; Schema: lablsg; Owner: -
--

CREATE TABLE lablsg.lablsg_custom_web_json (
    custom_id numeric,
    captcha character varying,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    user_guid character varying,
    module_name character varying,
    datajson jsonb,
    mobile_no character varying
);


--
