-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: u17wc_gallery
-- Type: TABLE

-- Name: u17wc_gallery; Type: TABLE; Schema: u17wc; Owner: -
--

CREATE TABLE u17wc.u17wc_gallery (
    gallery_id numeric NOT NULL,
    gallery_name character varying(100),
    gallery_path character varying(500),
    gallery_type numeric,
    thumbnail character varying(100),
    season_id numeric,
    status numeric,
    gallery_guid character varying(256),
    is_active numeric,
    is_deleted numeric,
    created_by numeric,
    updated_by numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
