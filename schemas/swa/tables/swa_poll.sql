-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_poll
-- Type: TABLE

-- Name: swa_poll; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.swa_poll (
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
    show_in_app numeric,
    show_in_web numeric,
    show_in_mobile numeric,
    slug_url character varying(4000),
    is_trashed numeric,
    checked_out_by numeric,
    checked_out_date timestamp without time zone
);


--
