-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_v1_bkp_29012025
-- Object: labecn_v1_press_release_asset_map
-- Type: TABLE

-- Name: labecn_v1_press_release_asset_map; Type: TABLE; Schema: labecn_v1_bkp_29012025; Owner: -
--

CREATE TABLE labecn_v1_bkp_29012025.labecn_v1_press_release_asset_map (
    press_release_asset_map_id numeric NOT NULL,
    press_release_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    pdf_link character varying(4000),
    pdf_name character varying(2000),
    pdf_size character varying(256),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    pramap_guid character varying(256)
);


--
