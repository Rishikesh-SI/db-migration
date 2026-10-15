-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: labbr_site_master
-- Type: TABLE

-- Name: labbr_site_master; Type: TABLE; Schema: labbr; Owner: -
--

CREATE TABLE labbr.labbr_site_master (
    site_master_id numeric NOT NULL,
    url_scheme character varying(3000),
    site_title character varying(300),
    meta_info jsonb,
    favicon_url character varying(3000),
    ga_code text,
    time_zone character varying(300),
    daylight_saving numeric,
    custom_meta jsonb,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    site_guid character varying(256)
);


--
