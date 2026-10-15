-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_webstory_asset_map
-- Type: TABLE

-- Name: labwis_webstory_asset_map; Type: TABLE; Schema: labwis; Owner: -
--

CREATE TABLE labwis.labwis_webstory_asset_map (
    webstory_asset_map_id numeric NOT NULL,
    webstory_id numeric,
    webstory_slide_id numeric,
    slide_title character varying,
    slide_desc character varying,
    mediatype character varying,
    vedio_url character varying,
    thumbnail_url character varying,
    cta_text character varying,
    cta_link character varying,
    is_active numeric,
    is_delete numeric,
    photoimagdata jsonb,
    asset_type_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_published numeric
);


--
