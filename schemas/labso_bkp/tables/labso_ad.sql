-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labso_bkp
-- Object: labso_ad
-- Type: TABLE

-- Name: labso_ad; Type: TABLE; Schema: labso_bkp; Owner: -
--

CREATE TABLE labso_bkp.labso_ad (
    ad_id numeric NOT NULL,
    ad_type numeric,
    ad_code text,
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
    ad_title character varying(4000)
);


--
