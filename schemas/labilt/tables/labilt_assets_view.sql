-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labilt
-- Object: labilt_assets_view
-- Type: TABLE

-- Name: labilt_assets_view; Type: TABLE; Schema: labilt; Owner: -
--

CREATE TABLE labilt.labilt_assets_view (
    assets_view_id numeric NOT NULL,
    asset_id numeric,
    asset_type_id numeric,
    view_date timestamp without time zone,
    view_count numeric
);


--
