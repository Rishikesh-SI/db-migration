-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_media_11112017
-- Type: TABLE

-- Name: isl_media_11112017; Type: TABLE; Schema: isl; Owner: -
--

CREATE TABLE isl.isl_media_11112017 (
    media_id numeric(38,0),
    media_type character varying(10),
    media_caption character varying(100),
    media_desc character varying(500),
    media_path character varying(100),
    media_copyright_text character varying(100),
    media_file_name character varying(100),
    media_order_number numeric(38,0),
    media_title_alias character varying(100),
    media_guid character varying(256),
    is_active numeric(38,0),
    is_deleted numeric(38,0),
    created_by numeric(38,0),
    updated_by numeric(38,0),
    created_date timestamp(6) without time zone,
    updated_date timestamp(6) without time zone,
    is_desktop character(1),
    media_unique_id character varying(15)
);


--
