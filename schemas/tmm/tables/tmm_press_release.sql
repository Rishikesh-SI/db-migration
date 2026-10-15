-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_press_release
-- Type: TABLE

-- Name: tmm_press_release; Type: TABLE; Schema: tmm; Owner: -
--

CREATE TABLE tmm.tmm_press_release (
    press_release_id numeric NOT NULL,
    title character varying(4000) NOT NULL,
    short_title character varying(4000),
    image_id numeric,
    image_zip_path character varying(4000),
    image_zip_name character varying(2000),
    image_zip_file_name character varying(2000),
    image_zip_size character varying(2000),
    published_version_number numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    press_release_date timestamp without time zone,
    published_date timestamp without time zone,
    is_trashed numeric NOT NULL,
    press_release_guid character varying(256) NOT NULL
);


--
