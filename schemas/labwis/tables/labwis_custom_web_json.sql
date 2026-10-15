-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_custom_web_json
-- Type: TABLE

-- Name: labwis_custom_web_json; Type: TABLE; Schema: labwis; Owner: -
--

CREATE TABLE labwis.labwis_custom_web_json (
    custom_id numeric NOT NULL,
    captcha character varying,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    user_guid character varying,
    module_name character varying,
    datajson jsonb
);


--
