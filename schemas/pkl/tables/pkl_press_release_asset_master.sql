-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: pkl_press_release_asset_master
-- Type: TABLE

-- Name: pkl_press_release_asset_master; Type: TABLE; Schema: pkl; Owner: -
--

CREATE TABLE pkl.pkl_press_release_asset_master (
    asset_id numeric NOT NULL,
    asset_type_id numeric NOT NULL,
    asset_name character varying(256) NOT NULL,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric
);


--
