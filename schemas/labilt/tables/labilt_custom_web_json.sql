-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labilt
-- Object: labilt_custom_web_json
-- Type: TABLE

-- Name: labilt_custom_web_json; Type: TABLE; Schema: labilt; Owner: -
--

CREATE TABLE labilt.labilt_custom_web_json (
    custom_id numeric NOT NULL,
    student_id text,
    school_name text,
    captcha character varying,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    user_guid character varying,
    module_name character varying,
    datajson jsonb
);


--
