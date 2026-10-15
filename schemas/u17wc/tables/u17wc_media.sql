-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: u17wc_media
-- Type: TABLE

-- Name: u17wc_media; Type: TABLE; Schema: u17wc; Owner: -
--

CREATE TABLE u17wc.u17wc_media (
    media_id numeric NOT NULL,
    media_type character varying(10),
    media_caption character varying(100),
    media_desc character varying(500),
    media_path character varying(100),
    media_copyright_text character varying(100),
    media_file_name character varying(100),
    media_order_number numeric,
    media_title_alias character varying(100),
    media_guid character varying(256),
    is_active numeric,
    is_deleted numeric,
    created_by numeric,
    updated_by numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_desktop character(1),
    media_unique_id character varying(15)
);


--
