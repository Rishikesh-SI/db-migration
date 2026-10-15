-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_poll
-- Type: TABLE

-- Name: waf_poll; Type: TABLE; Schema: waf_master; Owner: -
--

CREATE TABLE waf_master.waf_poll (
    poll_id numeric NOT NULL,
    alias character varying(300) NOT NULL,
    title character varying(300),
    poll_desc character varying(300),
    poll_type numeric NOT NULL,
    start_date timestamp without time zone,
    end_date timestamp without time zone,
    meta_info jsonb,
    image_url character varying(3000),
    published_version_number numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    poll_guid character varying(256) NOT NULL,
    slug_url character varying(4000),
    is_trashed numeric
);


--
