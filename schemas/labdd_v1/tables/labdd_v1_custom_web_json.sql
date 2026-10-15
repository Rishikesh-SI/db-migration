-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1
-- Object: labdd_v1_custom_web_json
-- Type: TABLE

-- Name: labdd_v1_custom_web_json; Type: TABLE; Schema: labdd_v1; Owner: -
--

CREATE TABLE labdd_v1.labdd_v1_custom_web_json (
    custom_id numeric NOT NULL,
    captcha character varying,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    user_guid character varying,
    module_name character varying,
    datajson jsonb
);


--
