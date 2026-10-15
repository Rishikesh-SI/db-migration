-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpvl
-- Object: labpvl_assets_view
-- Type: TABLE

-- Name: labpvl_assets_view; Type: TABLE; Schema: labpvl; Owner: -
--

CREATE TABLE labpvl.labpvl_assets_view (
    assets_view_id numeric NOT NULL,
    asset_id numeric,
    asset_type_id numeric,
    view_date timestamp without time zone,
    view_count numeric
);


--
