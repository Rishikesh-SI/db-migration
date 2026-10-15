-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_rating_week_12apr2017
-- Type: TABLE

-- Name: swa_rating_week_12apr2017; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.swa_rating_week_12apr2017 (
    rating_week_id numeric,
    start_date timestamp without time zone,
    end_date timestamp without time zone,
    rating_year numeric,
    week_of_year numeric,
    week_number numeric,
    show_in_web numeric,
    show_in_mobile numeric,
    show_in_app numeric,
    published_version_number numeric,
    is_trashed numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    published_date timestamp without time zone,
    asset_guid character varying(256),
    language_id numeric
);


--
