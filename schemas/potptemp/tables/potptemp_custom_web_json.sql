-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: potptemp
-- Object: potptemp_custom_web_json
-- Type: TABLE

-- Name: potptemp_custom_web_json; Type: TABLE; Schema: potptemp; Owner: -
--

CREATE TABLE potptemp.potptemp_custom_web_json (
    custom_id numeric NOT NULL,
    captcha character varying,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    user_guid character varying,
    module_name character varying,
    datajson jsonb
);


--
