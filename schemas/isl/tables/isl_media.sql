-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_media
-- Type: TABLE

-- Name: isl_media; Type: TABLE; Schema: isl; Owner: -
--

CREATE TABLE isl.isl_media (
    media_id numeric(38,0) NOT NULL,
    media_type character varying(10) NOT NULL,
    media_caption character varying(100),
    media_desc character varying(500),
    media_path character varying(100),
    media_copyright_text character varying(100),
    media_file_name character varying(100),
    media_order_number numeric(38,0),
    media_title_alias character varying(100),
    media_guid character varying(256),
    is_active numeric(38,0) DEFAULT 1 NOT NULL,
    is_deleted numeric(38,0) DEFAULT 0 NOT NULL,
    created_by numeric(38,0) DEFAULT 1 NOT NULL,
    updated_by numeric(38,0) DEFAULT 1 NOT NULL,
    created_date timestamp(6) without time zone,
    updated_date timestamp(6) without time zone,
    is_desktop character(1),
    media_unique_id character varying(15)
);


--
