-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_video
-- Type: TABLE

-- Name: waf_video; Type: TABLE; Schema: waf_master; Owner: -
--

CREATE TABLE waf_master.waf_video (
    video_id numeric NOT NULL,
    content_source_id numeric NOT NULL,
    title character varying(4000),
    title_alias character varying(4000),
    short_title character varying(2000),
    video_meta jsonb,
    video_desc character varying(1000),
    duration character varying(1000),
    partner_id numeric,
    show_in_web numeric,
    show_in_mobile numeric,
    show_in_app numeric,
    published_version_number numeric NOT NULL,
    video_url character varying(4000),
    is_trashed numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    video_guid character varying(256) NOT NULL,
    published_date timestamp without time zone,
    slug_url character varying(4000)
);


--
