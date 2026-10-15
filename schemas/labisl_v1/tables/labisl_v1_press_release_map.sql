-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: labisl_v1_press_release_map
-- Type: TABLE

-- Name: labisl_v1_press_release_map; Type: TABLE; Schema: labisl_v1; Owner: -
--

CREATE TABLE labisl_v1.labisl_v1_press_release_map (
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
