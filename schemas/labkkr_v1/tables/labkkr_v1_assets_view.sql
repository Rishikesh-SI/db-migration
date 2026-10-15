-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_v1
-- Object: labkkr_v1_assets_view
-- Type: TABLE

-- Name: labkkr_v1_assets_view; Type: TABLE; Schema: labkkr_v1; Owner: -
--

CREATE TABLE labkkr_v1.labkkr_v1_assets_view (
    assets_view_id numeric NOT NULL,
    asset_id numeric,
    asset_type_id numeric,
    view_date timestamp without time zone,
    view_count numeric
);


--
