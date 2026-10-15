-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: upy_assets_viewbk
-- Type: TABLE

-- Name: upy_assets_viewbk; Type: TABLE; Schema: upy; Owner: -
--

CREATE TABLE upy.upy_assets_viewbk (
    assets_view_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    view_date timestamp without time zone,
    view_count numeric
);


--
