-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_webstory_asset_map
-- Type: TABLE

-- Name: labgt01_v1_webstory_asset_map; Type: TABLE; Schema: labgt01_v1; Owner: -
--

CREATE TABLE labgt01_v1.labgt01_v1_webstory_asset_map (
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
    is_published numeric,
    order_number numeric,
    is_cover numeric,
    asset_id numeric,
    tooltip_text character varying,
    tooltip_link character varying
);


--
