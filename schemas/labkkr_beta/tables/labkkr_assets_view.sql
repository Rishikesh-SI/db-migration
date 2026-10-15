-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_beta
-- Object: labkkr_assets_view
-- Type: TABLE

-- Name: labkkr_assets_view; Type: TABLE; Schema: labkkr_beta; Owner: -
--

CREATE TABLE labkkr_beta.labkkr_assets_view (
    assets_view_id numeric NOT NULL,
    asset_id numeric,
    asset_type_id numeric,
    view_date timestamp without time zone,
    view_count numeric
);


--
