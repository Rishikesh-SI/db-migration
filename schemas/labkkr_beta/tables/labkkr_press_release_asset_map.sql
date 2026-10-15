-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_beta
-- Object: labkkr_press_release_asset_map
-- Type: TABLE

-- Name: labkkr_press_release_asset_map; Type: TABLE; Schema: labkkr_beta; Owner: -
--

CREATE TABLE labkkr_beta.labkkr_press_release_asset_map (
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
