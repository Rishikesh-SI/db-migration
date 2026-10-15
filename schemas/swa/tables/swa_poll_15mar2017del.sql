-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_poll_15mar2017del
-- Type: TABLE

-- Name: swa_poll_15mar2017del; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.swa_poll_15mar2017del (
    poll_id numeric,
    alias character varying(300),
    title character varying(300),
    poll_desc character varying(300),
    poll_type numeric,
    start_date timestamp without time zone,
    end_date timestamp without time zone,
    meta_info jsonb,
    image_url character varying(3000),
    published_version_number numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    poll_guid character varying(256),
    show_in_app numeric,
    show_in_web numeric,
    show_in_mobile numeric,
    slug_url character varying(4000),
    is_trashed numeric
);


--
