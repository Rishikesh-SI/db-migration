-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_ad
-- Type: TABLE

-- Name: yho_ad; Type: TABLE; Schema: yho; Owner: -
--

CREATE TABLE yho.yho_ad (
    ad_id numeric NOT NULL,
    ad_type numeric NOT NULL,
    ad_code text,
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
    ad_title character varying(4000)
);


--
