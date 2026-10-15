-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_press_release_asset_map
-- Type: TABLE

-- Name: dhm_press_release_asset_map; Type: TABLE; Schema: dhm; Owner: -
--

CREATE TABLE dhm.dhm_press_release_asset_map (
    press_release_asset_map_id numeric NOT NULL,
    press_release_id numeric NOT NULL,
    asset_id numeric NOT NULL,
    asset_type_id numeric NOT NULL,
    pdf_link character varying(4000),
    pdf_name character varying(2000),
    pdf_size character varying(256),
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    pramap_guid character varying(256) NOT NULL
);


--
