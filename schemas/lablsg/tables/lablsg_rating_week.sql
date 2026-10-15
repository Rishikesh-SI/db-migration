-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg
-- Object: lablsg_rating_week
-- Type: TABLE

-- Name: lablsg_rating_week; Type: TABLE; Schema: lablsg; Owner: -
--

CREATE TABLE lablsg.lablsg_rating_week (
    rating_week_id numeric NOT NULL,
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
