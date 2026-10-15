-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_rating_week
-- Type: TABLE

-- Name: yho_rating_week; Type: TABLE; Schema: yho; Owner: -
--

CREATE TABLE yho.yho_rating_week (
    rating_week_id numeric NOT NULL,
    start_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone NOT NULL,
    rating_year numeric NOT NULL,
    week_of_year numeric NOT NULL,
    week_number numeric NOT NULL,
    show_in_web numeric,
    show_in_mobile numeric,
    show_in_app numeric,
    published_version_number numeric NOT NULL,
    is_trashed numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    published_date timestamp without time zone,
    asset_guid character varying(256),
    language_id numeric
);


--
