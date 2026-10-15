-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: labpkl_press_release_map_20180919
-- Type: TABLE

-- Name: labpkl_press_release_map_20180919; Type: TABLE; Schema: labpkl; Owner: -
--

CREATE TABLE labpkl.labpkl_press_release_map_20180919 (
    press_release_map_id numeric,
    press_release_id numeric,
    title character varying(2000),
    short_title character varying(2000),
    description text,
    lang_id numeric,
    lang_name character varying(200),
    attachments json,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    published_date timestamp without time zone
);


--
