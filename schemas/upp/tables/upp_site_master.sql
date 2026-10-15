-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: upp_site_master
-- Type: TABLE

-- Name: upp_site_master; Type: TABLE; Schema: upp; Owner: -
--

CREATE TABLE upp.upp_site_master (
    site_master_id numeric NOT NULL,
    url_scheme character varying(3000) NOT NULL,
    site_title character varying(300) NOT NULL,
    meta_info jsonb,
    favicon_url character varying(3000),
    ga_code text,
    time_zone character varying(300),
    daylight_saving numeric NOT NULL,
    custom_meta jsonb,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    site_guid character varying(256) NOT NULL
);


--
