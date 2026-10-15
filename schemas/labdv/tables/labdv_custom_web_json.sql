-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: labdv_custom_web_json
-- Type: TABLE

-- Name: labdv_custom_web_json; Type: TABLE; Schema: labdv; Owner: -
--

CREATE TABLE labdv.labdv_custom_web_json (
    custom_id numeric NOT NULL,
    captcha character varying,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    user_guid character varying,
    module_name character varying,
    datajson jsonb
);


--
