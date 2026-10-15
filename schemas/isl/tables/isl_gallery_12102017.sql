-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_gallery_12102017
-- Type: TABLE

-- Name: isl_gallery_12102017; Type: TABLE; Schema: isl; Owner: -
--

CREATE TABLE isl.isl_gallery_12102017 (
    gallery_id numeric,
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
